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



/* DATI RELATIVI AGLI UTENTI */

INSERT INTO datianagrafici(nome,cognome) VALUES 
('Nicola','Sabino'),	
('Filippo','Mengarelli'),	
('Stefano','Perpetuini'),	
('Eugenio','Marchese'),
('Alessandro','Maurizi'),	
('Framcesco','Codovilli'),	
('Matteo','Farella'),	
('Mauro','Bottiglione'),	
('Carmine','Sborgia'),	
('Francesco','Bosco'),	
('Francesca','Pacella'),	
('Pierpaolo','Salvatore'),	
('Luca','Strozzeri'),	
('Miky','Di Pumpo'),
('Niko','Pelusi'),	
('Marco','Boni'),	
('Alessandro','Marollo'),	
('Luca',"D'Isidoro"),
('Denny','Roccabella'),	
('Davide','Cao'),	
('Davide','Venditti'),	
('Giacomo','Svampa'),	
('Daniele','Vesprini'),	
('Ilario','Buglioni'),	
('Michael','Minnoni'),	
('Alessandro','Torresi'),	
('Giorgio','Moskwa'),	
('Giulio','Di Nardo'),
('Marouane','Zarfaoui'),	
('Alessandro','Angioletti'),	
('Francesco','Picconi'),	
('Antonio','Cucco'),	
('Matteo','Angelini'),	
('Alessio','Cupido'),	
('Nicola','Forconi'),	
('Marco','Papa'),	
('Paolo','Ingargiola'),	
('Alberto','Fiorani'),	
('Samuele','Bordi'),	
('Martino','Taffetani'),	
('Riccardo','Tamagnini'),	
('Dolce','Luna'),	
('Francesco','Di Bianco'),
('Sofia','Santilli'),	
('Vittorio',"D'Alleva"),	
('Lorenzo','Mosconi'),	
('Matteo','Agostinone'),	
('Luca','Caproli'),	
('Alssandro','Orazi'),	
('Andrea','Tittii'),	
('Mattia','Utzer'),	
('Emanuele','Ranciaro'),	
('Stefano','Vallese'),	
('Enrico','Moreschi'),	
('Francesco','Querques'),	
('Luca','Girelli'),	
('Cecilia','Scoccia'),	
('Fabio','Lametti'),
('Claudio','Carbonari'),	
('Floriano','Piersanti'),	
('Miki','Tamburo'),	
('Enrico','Cappanera'),	
('Laura','Filipponi'),	
('Marco','Pandolfi'),	
('Antony','Colasante'),	
('Chiara','Bozza'),	
('Andrea','Tarabù'),	
('Francesco','Romagnoli'),	
('Gianluca','Ciattaglia');


/* CREAZIONE DEL PROGETTO */

INSERT INTO progetto(nome,deadline) values ('P2','2016-05-15');

/* INSERIMENTO DELLE SEQUENZE */

INSERT INTO sequenza(nome,nomeprogetto)values
('Seq1','P2'),
('Seq2','P2'),
('Seq3','P2'),
('Seq4','P2'),
('Seq5','P2'),
('Seq6','P2');

/* INSERIMENTO DELLE ATTIVITÀ */

INSERT INTO attività(descrizione,nomesequenza,datainizio,datafineprevista) VALUES
('Simulazioni','Seq1','2015-09-11','2016-03-12'),
('Portamozzi Posteriori','Seq1','2015-09-11','2016-02-15'),
('Mozzi Posteriori','Seq1','2015-09-11','2016-02-15'),
('Triangoli Anteriori e Posteriori','Seq1','2015-09-11','2016-02-16'),
('Vari attacchi a telaio','Seq1','2015-11-17','2015-12-07'),
('Rocker in Carbonio','Seq1','2015-11-17','2016-02-09'),
('Barra anti-rollio(BASE)','Seq1','2015-11-30','2016-02-22'),
('Ridimensionamento impianto frenante','Seq1','2015-11-16','2016-02-08'),
('Programmazione Taglio Laser','Seq2','2015-12-07','2015-12-25'),
('Simulazione FEM','Seq2','2015-11-05','2015-12-07'),
('Acquisto Tubi','Seq2','2015-11-20','2015-12-10'),
('Piega Tubi','Seq2','2015-12-10','2015-12-21'),
('Taglio e Saldatura tubi','Seq2','2015-12-10','2015-12-21'),
('Tglio Laser Attacchi vari','Seq2','2015-12-21','2015-12-30'),
('Saldatura Attacchi vari','Seq2','2016-01-07','2016-01-27'),
('Acquisto materiale Sandwich','Seq2','2016-01-07','2016-01-27'),
('Realizzazione pannelli Sandwich','Seq2','2016-01-07','2016-01-27'),
('Flangia coppa con varie soluzioni','Seq3','2015-11-05','2015-11-16'),
('Progettazione e realizzazione dima branco prova','Seq3','2015-11-05','2015-11-19'),
('Scegliere termocoppie e sensori di pressione','Seq3','2015-11-05','2015-11-16'),
('Costruzione boccaglio/venturimetro','Seq3','2015-11-05','2015-11-30'),
('Analisi comportamento motore con olio nuovo','Seq3','2015-10-05','2015-10-16'),
('Stadio plenum','Seq3','2015-11-05','2016-02-01'),
('Corpo farfallato slider o barrel','Seq3','2015-11-05','2016-01-07'),
('Contattare Mivv per studio scarico','Seq3','2015-11-09','2015-11-18'),
('Sistemazione banco prova','Seq3','2015-11-05','2015-12-15'),
('Sensore pressione olio','Seq3','2015-11-05','2015-11-16'),
('Rettifica motore','Seq3','2015-11-05','2015-11-25'),
('Ricambi motore','Seq3','2015-11-05','2015-11-25'),
('Simulazione GT-Suite','Seq3','2015-10-15','2016-05-12'),
('Ricablaggio banco prova','Seq5','2015-11-07','2015-12-11'),
('Ricerca nuovo Starter','Seq5','2015-11-03','2015-12-19'),
('Monitoraggio Starter','Seq5','2015-12-21','2015-12-25'),
('Caratterizazzione alternatore e consumi elett.p2','Seq5','2015-11-09','2015-11-14'),
('Progettazione alternatore','Seq5','2015-11-16','2015-12-05'),
('Relazione alternatore','Seq5','2015-12-17','2015-12-25'),
('Montaggio e verifica alternatore al banco','Seq5','2015-12-28','2016-01-16'),
('Cablaggio autovettura','Seq5','2016-01-11','2016-02-12'),
('Studio LC e TC','Seq5','2015-12-07','2015-12-25'),
('Realizzazione LC e TC','Seq5','2016-02-15','2016-02-26'),
('Configurazione LC e TC','Seq5','2016-02-29','2016-03-19'),
('Studio sistema acquisizione dati motore','Seq5','2015-11-16','2015-12-18'),
('Implementazione sist. acquisizione dati motore','Seq5','2015-12-21','2016-01-01'),
('Training labView nuovi ragazzi','Seq5','2015-11-02','2015-11-13'),
('Riposizionamento antenna P2','Seq5','2015-11-09','2015-11-20'),
('Configurazione Antennone','Seq5','2015-11-23','2015-12-04'),
('Riconfigurazione Canale P2','Seq5','2015-11-09','2015-11-20'),
('Test P2 con telemetria','Seq5','2015-12-07','2015-12-11'),
('Riprogrammazione Sbrion fuori macchina','Seq5','2015-12-14','2016-01-15'),
('Programmazione Sbrio su P3','Seq5','2016-01-18','2016-02-19'),
('Training Solidworks','Seq5','2015-11-09','2015-12-04'),
('Progettazione Supporti','Seq5','2015-12-07','2015-12-25'),
('Realizzazione supporti','Seq5','2015-12-28','2016-01-16'),
('Ricerca nuovi sensori automobile','Seq5','2015-11-16','2015-11-30'),
('Schemi elettrici P3','Seq5','2015-11-30','2015-12-15'),
('Cablaggio al computer','Seq5','2015-12-15','2016-01-11'),
('Studio per cambio','Seq5','2015-11-09','2015-12-14'),
('Attuazione per cambio','Seq5','2015-12-14','2015-12-28'),
('Progettazione cruscotto','Seq5','2015-11-30','2016-01-04'),
('Realizzazione cruscotto','Seq5','2016-01-04','2016-01-16'),
('Programmazione cruscotto','Seq5','2016-01-16','2016-02-08'),
('Montaggio cruscotto','Seq5','2016-02-08','2016-02-15'),
('Simulazione configurazione muso 2015 e 2016 con ala.','Seq6','2015-10-04','2015-10-04'),
('Selezione nuovi membri','Seq6','2015-10-22','2015-10-22'),
('Valutazione piano di lavoro 2016(con i nuovi membri)','Seq6','2015-11-09','2015-11-09'),
('Apprendimento software ai nuovi','Seq6','2015-11-08','2015-11-22'),
('Inizio progettazione ala inferiore','Seq6','2015-11-09','2015-12-20'),
('Realizzazione ala anteriore','Seq6','2016-01-10','2016-01-28'),
('DEMO ERRORE','Seq8','2016-01-28',NULL),
('Valutazione mirata ad una riduzione del peso dei componenti esistenti','Seq6','2016-01-28','2016-02-08');

INSERT INTO attività(descrizione,nomesequenza) VALUES
('Sponsorizzazione azienda per tubazioni siliconiche','Seq3'),
('Scelta frizione anti saltellamento','Seq4'),
('Frizione sul cruscotto','Seq4'),
('Controllare regolazione cambio','Seq4'),
('Trattamento interni del cambio','Seq4');

/* INSERIMENTO DELLE PRECEDENZE*/

update attività set precedenza='10' where id='9';
update attività set precedenza='11' where id='12';
update attività set precedenza='11' where id='13';
update attività set precedenza='49' where id='50';
update attività set precedenza='51' where id='52';
update attività set precedenza='54' where id='55';
update attività set precedenza='55' where id='56';
update attività set precedenza='57' where id='58';
update attività set precedenza='58' where id='59';
update attività set precedenza='59' where id='60';
update attività set precedenza='60' where id='61';
update attività set precedenza='61' where id='62';



/* CREAZIONE DI UN INCONTRO */
INSERT INTO incontro(data,luogo) values ('2016-08-01','polifunzionale');

/* MODIFICA DI ALCUNE ATTIVITÀ*/

update attività set datafine='2015-10-24',  costo='50.5'    where id='64';
update attività set datafine='2015-11-10',  costo='15.65'   where id='65';
update attività set datafine='2015-10-24',  costo='20'      where id='68';
update attività set datafine='2015-10-15',  costo='49.50'   where id='138';
update attività set datafine='2015-11-09',  costo='0'       where id='140';


insert into partecipazione values
('1','milestone','2016-01-22 13:30:00'),
('2','milestone','2016-01-22 13:30:00'),
('1','checkpoint','2016-01-22 15:30:00'),
('3','checkpoint','2016-01-22 15:30:00');

insert into incontro values
('milestone','2016-01-22 13:30:00','Officina',NULL),
('checkpoint','2016-01-22 15:30:00','Officina',NULL),
('checkpoint','2016-02-01 11:15:00','AulaStudio',NULL);

/* ASSEGNAZIONE DELLE ATTIVITÀ AD DEGLI UTENTI */
insert into incarichi values
('2','65'),
('5','48'),
('9','61');

/* MODIFICA DELLE INFORMAZIONI LAVORATIVE DI ALCUNI UTENTI */
update  datilavorativi set ruolo='TL', pwd='22366' where datilavorativi.matricola=2;
update  datilavorativi set ruolo='GL', pwd='22366' where datilavorativi.matricola=1;


/* CALCOLO DELLA FINE DELLE SEQUENZE */

call finesequenza('Seq1');
call finesequenza('Seq2');
call finesequenza('Seq3');
call finesequenza('Seq4');
call finesequenza('Seq5');
call finesequenza('Seq6');


/* FINE */
