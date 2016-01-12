/* TRIGGER PER LA MANUTENZIONE DEL DB   */


DELIMITER $$

/*PROCEDURA DI ERRORE*/
create procedure errore(IN messaggio VARCHAR(128))
  begin
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = messaggio;
  end$$



/* se inserisco una tupla in dati anagrafici ne genero una nuova in automatico in dati lavorativi */
create trigger inserimento_datianagrafici
    after insert ON datianagrafici
    for each row
        insert into datilavorativi(matricola) values (new.matricola);


/* se elimino una tupla in dati anagrafici ne elimino automaticamente la controparte in dati lavorativi */
create trigger eliminazione_datianagafici
    before delete on datianagrafici
    for each row
    delete from datilavorativi where datilavorativi.matricola=old.matricola;

/* se elimino una sequenza elimino anche tutte le sequenze e le relative attività ad esse connesse */
create trigger eliminazione_sequenza
    before delete on sequenza
    for each row
    delete from attività where attività.nomesequenza=old.nome;

/* se elimino un progetto elimino tutte le sequenze e le relative attività ad esse collegate */
create trigger eliminazione_progetto
    before delete on progetto
    for each row
    delete from sequenza where sequenza.nomeprogetto=old.nome;



/* due incontri non possono essere nello stesso posto e nella stessa data */

/*create trigger controllo_incontri
    before inser on incontri*/


/* tutte le sequenze devono avere scadenza inferiore o uguale alla DeadLine 
 * la fine di una sequenza è data dall'attività avente datafine maggiore 
 */

 /******************************/

create procedure finesequenza(in seq varchar(20))
    begin

        update sequenza set sequenza.fine=
            ( select datafineprevista from attività where attività.nomesequenza=seq order by datafineprevista desc limit 1)
        where sequenza.nome=seq;
    end$$


create trigger modifica_fine_sequenza
    before update on sequenza
    for each row 
    begin
    declare fine_seq date default NULL;
    declare fine_prog date;

    select datafineprevista into fine_seq from attività where attività.nomesequenza=old.nome order by datafineprevista desc limit 1;
    select p.deadline into fine_prog from progetto p join sequenza s on s.nomeprogetto=p.nome and s.nome=old.nome;

       if(fine_seq='NULL')
            then
                call errore(concat(new.nome,' ha fine indeterminata!una fine stimata non coerente con la relativa deadline di progetto!'));
        end if;
        if(fine_seq>fine_prog)
            then
                call errore(concat(new.nome,' ha una fine stimata non coerente con la relativa deadline di progetto!'));
        end if;
    end$$

    create function perc_Sequenza(nom varchar(20))
        returns decimal(6,1)
        begin
        
            declare tutte integer;
            declare completate integer;
            declare ris decimal(6,2);


            select count(datafine)          into completate     from  attività where nomesequenza='Seq6';
            select count(datafineprevista)  into tutte          from  attività where nomesequenza='Seq6';
            
            
            
            set ris=((completate / tutte)*100);

            return ris;
        end$$

    create function perc_Progetto( Progetto varchar(20))
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
