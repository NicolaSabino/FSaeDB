
use polimarchert;

/* dati anagrafici relativi ai membri del team */

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

/* dati relativi al gantt */
INSERT INTO sequenza(nome,nomeprogetto)values
('Seq1','P2'),
('Seq2','P2'),
('Seq3','P2'),
('Seq4','P2'),
('Seq5','P2'),
('Seq6','P2');





INSERT INTO progetto(nome,deadline) values ('P2','2016-04-01');


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

call finesequenza('Seq1');
call finesequenza('Seq2');
call finesequenza('Seq3');
call finesequenza('Seq4');
call finesequenza('Seq5');
call finesequenza('Seq6');


INSERT INTO incontro(data,luogo) values ('2016-08-01','polifunzionale');

insert into partecipazione values
('1','milestone','2016-01-22 13:30:00'),
('2','milestone','2016-01-22 13:30:00'),
('1','checkpoint','2016-01-22 15:30:00'),
('3','checkpoint','2016-01-22 15:30:00');

insert into incontro values
('milestone','2016-01-22 13:30:00','Officina',NULL),
('checkpoint','2016-01-22 15:30:00','Officina',NULL),
('checkpoint','2016-02-01 11:15:00','AulaStudio',NULL);

insert into incarichi values
('2','65'),
('5','48'),
('9','61');

update  datilavorativi set ruolo='TL', pwd='22366' where datilavorativi.matricola=2;
update  datilavorativi set ruolo='GL', pwd='22366' where datilavorativi.matricola=1;

/*inserisco le precedenze */

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

/* ultimo alcune attività per calcolare le percentuali su seq6 */

update attività set datafine='2015-10-24',  costo='50.5'    where id='64';
update attività set datafine='2015-11-10',  costo='15.65'   where id='65';
update attività set datafine='2015-10-24',  costo='20'      where id='68';
update attività set datafine='2015-10-15',  costo='48.50'   where id='138';
update attività set datafine='2015-11-09',  costo='0'      where id='140';





