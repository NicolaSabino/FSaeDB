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

 /******************************/

create procedure finesequenza(in seq varchar(20))
    begin

        update sequenza set sequenza.fine=
            ( select datafineprevista from attività where attività.nomesequenza=seq order by datafineprevista desc limit 1)
        where sequenza.nome=seq;
    end$$




/*create function controllo_sequenza(nome_sequenza varchar(20))
    returns integer
    begin
        declare fine_seq date;
        declare fine_prog date;
        declare num integer;
        
        select datafineprevista into fine_seq from attività where attività.nomesequenza=nome_sequenza order by datafineprevista desc limit 1;
        select p.deadline into fine_prog from progetto p join sequenza s on s.nomeprogetto=p.nome and s.nome=nome_sequenza;

        if(fine_seq=NULL)
            then
                set num=1;

        end if;

        if(fine_prog<fine_seq)
            then
                set num=2;
            else
                set num=0;
        end if;
        
        return num;
    end$$
*/




create trigger modifica_fine_sequenza
    after update on sequenza
    for each row 
    begin
    declare fine_seq date default NULL;
    declare fine_prog date;

    select datafineprevista into fine_seq from attività where attività.nomesequenza=new.nome order by datafineprevista desc limit 1;
    select p.deadline into fine_prog from progetto p join sequenza s on s.nomeprogetto=p.nome and s.nome=new.nome;

       /* if(fine_seq='NULL')
            then
                call errore(concat(new.nome,' ha fine indeterminata!una fine stimata non coerente con la relativa deadline di progetto!'));
        end if;*/
        if(fine_seq>fine_prog)
            then
                call errore(concat(new.nome,' ha una fine stimata non coerente con la relativa deadline di progetto!'));
        end if;
    end$$

    /***************************/

    /*
    *   Gesione delle priorità
    *   Se una attività deve essere eseguita dopo un altra allora quest'ultima dovrà avere datafine= null finchè quella precedente non sia stata eseguita
    *
    */

    
   /* create trigger controllo_priorità 
        after update on attività
        for each row
        begin
    */

    create function precedenze(in id_att integer)
        return integer
        begin
            declare Att integer
            declare Prec integer
            declare Dfine date
            
            select  id          into Att    from attività where id=id_att;
            select  precedenza  into prec   from attività where id=id_att; 
            select  DFine       into DFine  from attività where id=id_att;
            
            if(precedenza!=NULL)
                then
                return (select precedenze(Att));
                else
                return Att;
            end if;
        end$$
  
  
  /* Nelle parentesi bisognerebbe mettere il nome della sequenza che si inserisce quando inserisci la nuova attività */
  create trigger costosequenza after insert on attivita for each row 
    begin 
        declare costosq numeric (5,3);
        select sum (costo) from attività where nomesequenza=() into costosq;
        update sequenza set costo=costosq where nomesequenza=();
    end &&
        
