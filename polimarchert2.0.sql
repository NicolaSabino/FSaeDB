/* Nicola Sabino 16.12.2015 */


drop database polimarchert;

Create database polimarchert;

use 'polimarchert';

/*set autocommit=1;*/

create table datianagrafici (
    matricola int(11) NOT NULL auto_increment,
    nome varchar(30) DEFAULT NULL,
    cognome varchar(30) DEFAULT NULL,
    telefono int(11) DEFAULT NULL,
    mail varchar(30) DEFAULT NULL,
    PRIMARY KEY (matricola)
);

create table datilavorativi (
    matricola int(11) NOT NULL,
    ruolo enum('US','GL','TL') DEFAULT 'US',
    pwd varchar(20) DEFAULT '0000',
    PRIMARY KEY (matricola)
);

create table incarichi (
    matricola int (11) NOT NULL,
    id int(11) NOT NULL,
    PRIMARY KEY (matricola,id)
);

create table attività (
    id int(11) NOT NULL AUTO_INCREMENT,
    nomesequenza varchar(20) NOT NULL,
    precedenta int(11) DEFAULT NULL,
    descrizione varchar(40) DEFAULT NULL,
    datainizio date DEFAULT NULL,
    datafineprevista date DEFAULT NULL,
    datafine date DEFAULT NULL,
    costo decimal(6,2) DEFAULT '0.00',
    PRIMARY KEY (id)
);

create table sequenza (
    nome varchar(20) NOT NULL,
    fine date DEFAULT NULL,
    percentuale decimal(5,2) DEFAULT '0.00',
    nomeprogetto varchar(20),
    PRIMARY KEY (nome)
);

create table progetto (
    nome varchar(20) NOT NULL,
    DeadLine date NOT NULL,
    PRIMARY KEY (nome)
);

create table incontro (
    tipo enum('milestone','checkpoint') DEFAULT 'checkpoint' NOT NULL,
    data datetime NOT NULL, /* variabile contenente data e tempo */
    luogo varchar(20) NOT NULL,
    /* ora time NOT NULL,*/
    verbale varchar(100),
    PRIMARY KEY (tipo,data,luogo)
);

create table partecipazione (
    matricola int(11) NOT NULL,
    tipo enum('milestone','checkpoint') NOT NULL,
    data date NOT NUll,
    PRIMARY KEY(matricola,tipo,data)
);
