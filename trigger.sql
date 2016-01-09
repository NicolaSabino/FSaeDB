/* TRIGGER PER LA MANUTENZIONE DEL DB   */


DELIMITER $$

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

        /* da inserire */

/* tutte le sequenze devono avere scadenza inferiore o uguale alla DeadLine */
/* la fine di una sequenza è data dall'attività avente datafine maggiore */

/*create trigger fine_sequenza
    before insert on sequenza
    for each row
    update sequenza set fine = (select datafinserineprevista from attività where attività.nomesequenza=new.nome order by datafineprevista desc limit 1) 
    where nome=new.nome;
    */

/* procedura di aggiornamento della fine di una sequenza */

create procedure finesequenza(in seq varchar(20))
        update sequenza set sequenza.fine=
            ( select datafineprevista from attività where attività.nomesequenza=seq order by datafineprevista desc limit 1)
        where sequenza.nome=seq;
