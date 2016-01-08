/* TRIGGER PER LA MANUTENZIONE DEL DB   */
/*          controllo dei dati          */


/*aggiornamento datilavorativi datianagrafici*/

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

delimiter //
create trigger controllo_incontro
    before insert on incontro
    for each row
    begin
        DECLARE risultato int;
        select count(*) from incontro i where (i.data=new.data and i.luogo=new.luogo) into risultato;

        if(risultato>0) then
        signal sqlstate'45000' set
        message_text='impossibile inserire due incontri nello stesso luogo alla stessa ora';
        end if;
    end
    //

delimiter;
