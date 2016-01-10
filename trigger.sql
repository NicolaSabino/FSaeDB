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

        /* da inserire */


/* tutte le sequenze devono avere scadenza inferiore o uguale alla DeadLine 
 * la fine di una sequenza è data dall'attività avente datafine maggiore 
 */

create procedure finesequenza(in seq varchar(20))
    begin
        update sequenza set sequenza.fine=
            ( select datafineprevista from attività where attività.nomesequenza=seq order by datafineprevista desc limit 1)
        where sequenza.nome=seq;
    end$$

create function controllo_sequenza(nome_sequenza varchar(20))
    returns integer
    begin
        declare fine_seq date;
        declare fine_prog date;
        declare num integer;
        
        select sequenza.fine into fine_seq from sequenza where sequenza.nome=nome_sequenza;
        select progetto.deadline into fine_prog from progetto join sequenza on sequenza.nomeprogetto=progetto.nome and sequenza.nome=nome_sequenza;
        if(fine_seq>fine_prog)
            then
                set num=1;
            else
                set num=0;
        end if;
        return num;
    end$$

create trigger modifica_fine_sequenza
    after update on sequenza
    for each row
    begin
        if((select controllo_Sequenza(new.nome))=1)
            then
                call errore(concat(new.nome,' ha una fine non coerente con la relativa deadline di progetto!'));
        end if;
    end$$
