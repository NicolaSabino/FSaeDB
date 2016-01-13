/* Nicola Sabino 16.12.2015 */


drop database polimarchert;

Create database polimarchert;

use 'polimarchert';


create table datianagrafici (
    matricola int(11)   NOT NULL    auto_increment,
    nome varchar(30)    DEFAULT NULL,
    cognome varchar(30) DEFAULT NULL,
    telefono int(11)    DEFAULT NULL,
    mail varchar(30)    DEFAULT NULL,
    PRIMARY KEY (matricola)
);

create table datilavorativi (
    matricola int(11)           NOT NULL,
    ruolo enum('US','GL','TL')  DEFAULT 'US',
    pwd varchar(20)             DEFAULT '0000',
    PRIMARY KEY (matricola)
);

create table incarichi (
    matricola int(11)       NOT NULL,
    id int(11)              NOT NULL,
    PRIMARY KEY (matricola,id)
);

create table attività (
    id int(11)                  NOT NULL AUTO_INCREMENT,
    nomesequenza varchar(20)    NOT NULL,
    precedenza int(11)          DEFAULT NULL,
    descrizione varchar(80)     DEFAULT NULL,
    datainizio date             DEFAULT NULL,
    datafineprevista date       DEFAULT NULL,
    datafine date               DEFAULT NULL,
    costo decimal(6,2)          DEFAULT '0.00',
    PRIMARY KEY (id)
);

create table sequenza (
    nome varchar(20)            NOT NULL,
    fine date                   DEFAULT NULL,
    nomeprogetto varchar(20),
    costo decimal(6,2)          DEFAULT '0.00',

    PRIMARY KEY (nome)
);

create table progetto (
    nome varchar(20)            NOT NULL,
    DeadLine date               NOT NULL,
    PRIMARY KEY (nome)
);

create table incontro (
    tipo enum('milestone','checkpoint') DEFAULT 'checkpoint' NOT NULL,
    data datetime                       NOT NULL,
    luogo varchar(20)                   NOT NULL,
    verbale varchar(100),
    PRIMARY KEY (tipo,data,luogo)
);

create table partecipazione (
    matricola int(11)                   NOT NULL,
    tipo enum('milestone','checkpoint') NOT NULL,
    data date                           NOT NUll,
    PRIMARY KEY(matricola,tipo,data)
);

DELIMITER $$


                                /* ________________PROCEDURE________________ */


/*
 *  procedura di errore
 */

create procedure errore(IN messaggio VARCHAR(128))
  begin
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = messaggio;
  end$$


/* 
 *   procedura di aggiornamento
 *   della fine di una sequenza
 */

create procedure finesequenza(in seq varchar(20))
    begin

        update sequenza set 
        sequenza.fine=( select datafineprevista 
        from attività where attività.nomesequenza=seq 
        order by datafineprevista desc limit 1)
        where sequenza.nome=seq;

    end$$



                                /* ________________FUNZIONI________________  */


/* 
 *   funzione per il calcolo della
 *   percentuale di completamento 
 *   di una sequenza
 */

    create function percentuale_Sequenza(nom varchar(20))
        returns decimal(6,1)
        begin
        
            declare tutte integer;
            declare completate integer;
            declare ris decimal(6,2);


            select count(datafine)          into completate     from  attività where nomesequenza=nom;
            select count(datafineprevista)  into tutte          from  attività where nomesequenza=nom;
            
            
            
            set ris=((completate / tutte)*100);

            return ris;
        end$$



/* 
 *   funzione per il calcolo della
 *   percentuale di completamento 
 *   di un progetto
 */

create function percentuale_Progetto( Progetto varchar(20))
        returns decimal(6,1)
        begin
            declare completate      integer;
            declare tutte           integer;
            declare ris             decimal(6,2);
            
            select count(a.datafine)            into completate from attività a join sequenza s join progetto p on a.nomesequenza=s.nome and s.nomeprogetto=p.nome where p.nome=Progetto;
            select count(a.datafineprevista)    into tutte      from attività a join sequenza s join progetto p on a.nomesequenza=s.nome and s.nomeprogetto=p.nome where p.nome=Progetto;

            set ris=((completate/tutte)*100);

            return ris;
        end$$




                                /* ________________TRIGGER_________________  */






/*  
 *   se inserisco una tupla 
 *   in dati anagrafici ne genero
 *   la controparte in dati lavorativi 
 */

create trigger inserimento_datianagrafici
    after insert ON datianagrafici
        for each row
            insert into datilavorativi(matricola) values (new.matricola);


/*  
 *   se elimino una tupla 
 *   in dati anagrafici ne elimino 
 *   la controparte in dati lavorativi 
 */

create trigger eliminazione_datianagafici
    before delete on datianagrafici
        for each row
            delete from datilavorativi where datilavorativi.matricola=old.matricola;

/*  
 *   se elimino una sequenza 
 *   elimino anche tutte le sequenze
 *   e le relative attività ad esse connesse 
 */

create trigger eliminazione_sequenza
    before delete on sequenza
        for each row
            delete from attività where attività.nomesequenza=old.nome;

/*  
 *   se elimino un progetto 
 *   elimino tutte le sequenze
 *   e le relative attività ad esse collegate 
 */

create trigger eliminazione_progetto
    before delete on progetto
        for each row
            delete from sequenza where sequenza.nomeprogetto=old.nome;


/* 
 *   tutte le sequenze devono avere scadenza inferiore o uguale alla DeadLine 
 *   la fine di una sequenza è data dall'attività avente datafine maggiore 
 */

create trigger modifica_fine_sequenza
    after update on sequenza
        for each row 
            begin
                declare fine_seq date ;
                declare fine_prog date;

                select datafineprevista 
                    into fine_seq 
                    from attività where attività.nomesequenza=new.nome 
                    order by datafineprevista 
                    desc limit 1;

                select p.deadline into fine_prog 
                    from progetto p join sequenza s 
                    on s.nomeprogetto=p.nome and s.nome=new.nome;

                if(fine_seq='NULL')
                    then
                        call errore(concat(new.nome,' ha fine indeterminata!una fine stimata non coerente con la relativa deadline di progetto!'));
                end if;
            
                if(fine_seq>fine_prog)
                    then
                        call errore(concat(new.nome,' ha una fine stimata non coerente con la relativa deadline di progetto!'));
                end if;
            end$$

/*
 *   aggiornamento del costo di una sequenza
 *   causato da un attività appena inserita
 */

create trigger costo_sequenzaV1
    after insert  on attività 
     for each row 
        begin 
            declare cost    decimal(6,2);
            declare cost_a  decimal(6,2);

            select costo 
                into cost 
                from sequenza 
                where nome=new.nomesequenza;

            set cost_a=new.costo;
            update sequenza 
                set costo=(cost+cost_a) 
                where nome=new.nomesequenza;
            
        end$$
/*
 *   aggiornamento del costo di una sequenza
 *   causato da un attività aggiornata
 */

create trigger costo_sequenzaV2
    after update on attività 
     for each row 
        begin 
            declare cost    decimal(6,2);
            declare cost_a  decimal(6,2);

            select costo 
                into cost 
                from sequenza 
                where nome=new.nomesequenza;
            
            set cost_a=new.costo;
            
            update sequenza 
                set costo=(cost+cost_a) 
                where nome=new.nomesequenza;

        end$$
/*
 *   due incontri non posso essere
 *   svolti nello stesso luogo
 *   nello stesso giorno
 *   alla stessa ora
 */

create trigger controllo_incotri
    before insert on incontro
        for each row
            begin
                declare LUOGO varchar(20);
                declare DATA datetime;
                
                select i.data   
                    into DATA   
                    from incontro i 
                    where i.luogo=new.luogo and i.data=new.data;
                
                select i.luogo
                    into LUOGO  
                    from incontro i 
                    where i.luogo=new.luogo and i.data=new.data;
                
                if(new.luogo=LUOGO and new.data=DATA)
                    then
                        call errore('impossibile sostenere due incontri nello stesso luogo e nella stessa data ed ora');
                end if;
            
            end$$

            
            /* - - - FINE DELLO SCHEMA - - -*/
