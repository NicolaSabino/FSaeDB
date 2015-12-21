-- MySQL dump 10.16  Distrib 10.1.8-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: PoliMarcheRT
-- ------------------------------------------------------
-- Server version	10.1.8-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Attivita`
--

DROP TABLE IF EXISTS `Attivita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Attivita` (
  `Id` int(11) NOT NULL,
  `Nome` varchar(70) NOT NULL,
  `NomeSequenza` varchar(20) NOT NULL,
  `Costo` decimal(10,2) DEFAULT NULL,
  `Precedenza` int(11) DEFAULT NULL,
  `Inizio` date DEFAULT NULL,
  `Fine` date DEFAULT NULL,
  `Durata` int(11) DEFAULT NULL,
  `Perc` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attivita`
--

LOCK TABLES `Attivita` WRITE;
/*!40000 ALTER TABLE `Attivita` DISABLE KEYS */;
INSERT INTO `Attivita` VALUES (1,'Simulazioni','Seq1',NULL,NULL,'2015-09-11','2016-03-12',91,NULL),(2,'Portamozzi Posteriori','Seq1',NULL,NULL,'2015-09-11','2016-02-15',70,NULL),(3,'Mozzi Posteriori','Seq1',NULL,NULL,'2015-09-11','2016-02-15',70,NULL),(4,'Triangoli Anteriori e Posteriori','Seq1',NULL,NULL,'2015-09-11','2016-02-16',70,NULL),(5,'Vari attacchi a telaio','Seq1',NULL,NULL,'2015-11-17','2015-12-07',15,NULL),(6,'Rocker in Carbonio','Seq1',NULL,NULL,'2015-11-17','2016-02-09',60,NULL),(7,'Barra anti-rollio(BASE)','Seq1',NULL,NULL,'2015-11-30','2016-02-22',60,NULL),(8,'Ridimensionamento impianto frenante','Seq1',NULL,NULL,'2015-11-16','2016-02-08',60,NULL),(9,'Programmazione Taglio Laser','Seq2',NULL,11,'2015-12-07','2015-12-25',14,NULL),(10,'Simulazione FEM','Seq2',NULL,NULL,'2015-11-05','2015-12-07',22,NULL),(11,'Acquisto Tubi','Seq2',NULL,NULL,'2015-11-20','2015-12-10',14,NULL),(12,'Piega Tubi','Seq2',NULL,12,'2015-12-10','2015-12-21',7,NULL),(13,'Taglio e Saldatura tubi','Seq2',NULL,12,'2015-12-10','2015-12-21',7,NULL),(14,'Tglio Laser Attacchi vari','Seq2',NULL,NULL,'2015-12-21','2015-12-30',7,NULL),(15,'Saldatura Attacchi vari','Seq2',NULL,NULL,'2016-01-07','2016-01-27',14,NULL),(16,'Acquisto materiale Sandwich','Seq2',NULL,NULL,NULL,NULL,14,NULL),(17,'Realizzazione pannelli Sandwich','Seq2',NULL,NULL,NULL,NULL,14,NULL),(18,'Flangia coppa con varie soluzioni','Seq3',NULL,NULL,'2015-11-05','2015-11-16',7,NULL),(19,'Progettazione e realizzazione dima branco prova','Seq3',NULL,NULL,'2015-11-05','2015-11-19',10,NULL),(20,'Scegliere termocoppie e sensori di pressione','Seq3',NULL,NULL,'2015-11-05','2015-11-16',8,NULL),(21,'Costruzione boccaglio/venturimetro','Seq3',NULL,NULL,'2015-11-05','2015-11-30',17,NULL),(22,'Analisi comportamento motore con olio nuovo','Seq3',NULL,NULL,'2015-10-05','2015-10-16',9,NULL),(23,'Stadio plenum','Seq3',NULL,NULL,'2015-11-05','2016-02-01',62,NULL),(24,'Sponsorizzazione azienda per tubazioni siliconiche','Seq3',NULL,NULL,NULL,NULL,7,NULL),(25,'Corpo farfallato slider o barrel','Seq3',NULL,NULL,'2015-11-05','2016-01-07',45,NULL),(26,'Contattare Mivv per studio scarico','Seq3',NULL,NULL,'2015-11-09','2015-11-18',7,NULL),(27,'Sistemazione banco prova','Seq3',NULL,NULL,'2015-11-05','2015-12-15',28,NULL),(28,'Sensore pressione olio','Seq3',NULL,NULL,'2015-11-05','2015-11-16',7,NULL),(29,'Rettifica motore','Seq3',NULL,NULL,'2015-11-05','2015-11-25',14,NULL),(30,'Ricambi motore','Seq3',NULL,NULL,'2015-11-05','2015-11-25',14,NULL),(31,'Simulazione GT-Suite','Seq3',NULL,NULL,'2015-10-15','2016-05-12',150,NULL),(32,'Scelta frizione anti saltellamento','Seq4',NULL,NULL,NULL,NULL,7,NULL),(33,'Frizione sul cruscotto','Seq4',NULL,NULL,NULL,NULL,7,NULL),(34,'Controllare regolazione cambio','Seq4',NULL,NULL,NULL,NULL,2,NULL),(35,'Trattamento interni del cambio','Seq4',NULL,NULL,NULL,NULL,NULL,NULL),(36,'Ricablaggio banco prova','Seq5',NULL,NULL,'2015-11-07','2015-12-11',26,NULL),(37,'Ricerca nuovo Starter','Seq5',NULL,NULL,'2015-11-03','2015-12-19',16,NULL),(38,'Monitoraggio Starter','Seq5',NULL,NULL,'2015-12-21','2015-12-25',5,NULL),(39,'Caratterizazzione alternatore e consumi elett.p2','Seq5',NULL,NULL,'2015-11-09','2015-11-14',6,NULL),(40,'Progettazione alternatore','Seq5',NULL,NULL,'2015-11-16','2015-12-05',16,NULL),(41,'Relazione alternatore','Seq5',NULL,NULL,'2015-12-17','2015-12-25',15,NULL),(42,'Montaggio e verifica alternatore al banco','Seq5',NULL,NULL,'2015-12-28','2016-01-16',16,NULL),(43,'Cablaggio autovettura','Seq5',NULL,NULL,'2016-01-11','2016-02-12',25,NULL),(44,'Studio LC e TC','Seq5',NULL,NULL,'2015-12-07','2015-12-25',15,NULL),(45,'Realizzazione LC e TC','Seq5',NULL,NULL,'2016-02-15','2016-02-26',10,NULL),(46,'Configurazione LC e TC','Seq5',NULL,NULL,'2016-02-29','2016-03-19',16,NULL),(47,'Studio sistema acquisizione dati motore','Seq5',NULL,NULL,'2015-11-16','2015-12-18',25,NULL),(48,'Implementazione sist. acquisizione dati motore','Seq5',NULL,NULL,'2015-12-21','2016-01-01',10,NULL),(49,'Training labView nuovi ragazzi','Seq5',NULL,NULL,'2015-11-02','2015-11-13',10,NULL),(50,'Riposizionamento antenna P2','Seq5',NULL,NULL,'2015-11-09','2015-11-20',10,NULL),(51,'Configurazione Antennone','Seq5',NULL,NULL,'2015-11-23','2015-12-04',10,NULL),(52,'Riconfigurazione Canale P2','Seq5',NULL,NULL,'2015-11-09','2015-11-20',20,NULL),(53,'Test P2 con telemetria','Seq5',NULL,NULL,'2015-12-07','2015-12-11',5,NULL),(54,'Riprogrammazione Sbrion fuori macchina','Seq5',NULL,NULL,'2015-12-14','2016-01-15',25,NULL),(55,'Programmazione Sbrio su P3','Seq5',NULL,54,'2016-01-18','2016-02-19',25,NULL),(56,'Training Solidworks','Seq5',NULL,NULL,'2015-11-09','2015-12-04',20,NULL),(57,'Progettazione Supporti','Seq5',NULL,56,'2015-12-07','2015-12-25',15,NULL),(58,'Realizzazione supporti','Seq5',NULL,57,'2015-12-28','2016-01-16',15,NULL),(59,'Ricerca nuovi sensori automobile','Seq5',NULL,NULL,'2015-11-16','2015-11-30',10,NULL),(60,'Schemi elettrici P3','Seq5',NULL,59,'2015-11-30','2015-12-15',15,NULL),(61,'Cablaggio al computer','Seq5',NULL,60,'2015-12-15','2016-01-11',15,NULL),(62,'Studio per cambio','Seq5',NULL,NULL,'2015-11-09','2015-12-14',25,NULL),(63,'Attuazione per cambio','Seq5',NULL,62,'2015-12-14','2015-12-28',10,NULL),(64,'Progettazione cruscotto','Seq5',NULL,NULL,'2015-11-30','2016-01-04',25,NULL),(65,'Realizzazione cruscotto','Seq5',NULL,64,'2016-01-04','2016-01-16',10,NULL),(66,'Programmazione cruscotto','Seq5',NULL,65,'2016-01-16','2016-02-08',15,NULL),(67,'Montaggio cruscotto','Seq5',NULL,66,'2016-02-08','2016-02-15',5,NULL),(68,'Simulazione configurazione muso 2015 e 2016 con ala.','Seq6',NULL,NULL,'2015-10-04','2015-10-04',0,NULL),(69,'Selezione nuovi membri','Seq6',NULL,NULL,'2015-10-22','2015-10-22',1,NULL),(70,'Valutazione piano di lavoro 2016(con i nuovi membri)','Seq6',NULL,NULL,'2015-11-09','2015-11-09',1,NULL),(71,'Apprendimento software ai nuovi','Seq6',NULL,NULL,'2015-11-08','2015-11-22',12,NULL),(72,'Inizio progettazione ala inferiore','Seq6',NULL,NULL,'2015-11-09','2015-12-20',31,NULL),(73,'Realizzazione ala anteriore','Seq6',NULL,NULL,'2016-01-10','2016-01-28',14,NULL),(74,'Valutazione mirata ad una riduzione del peso dei componenti esistenti','Seq6',NULL,NULL,'2016-01-28','2016-02-08',8,NULL);
/*!40000 ALTER TABLE `Attivita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Incontro`
--

DROP TABLE IF EXISTS `Incontro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Incontro` (
  `Id` int(11) NOT NULL,
  `Associazione` int(11) DEFAULT NULL,
  `Giorno` date DEFAULT NULL,
  `Ora` varchar(5) DEFAULT NULL,
  `Relazione` varchar(60) DEFAULT NULL,
  `Tipo` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Incontro`
--

LOCK TABLES `Incontro` WRITE;
/*!40000 ALTER TABLE `Incontro` DISABLE KEYS */;
/*!40000 ALTER TABLE `Incontro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Progetto`
--

DROP TABLE IF EXISTS `Progetto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Progetto` (
  `Nome` varchar(20) NOT NULL,
  `Costo` decimal(10,2) DEFAULT NULL,
  `DeadLine` date DEFAULT NULL,
  `Perc` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Progetto`
--

LOCK TABLES `Progetto` WRITE;
/*!40000 ALTER TABLE `Progetto` DISABLE KEYS */;
INSERT INTO `Progetto` VALUES ('P3',NULL,'2016-03-01',NULL);
/*!40000 ALTER TABLE `Progetto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SAttivita`
--

DROP TABLE IF EXISTS `SAttivita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SAttivita` (
  `Nome` varchar(20) NOT NULL,
  `IdAttivita` int(11) NOT NULL,
  `Costo` decimal(10,2) DEFAULT NULL,
  `fatto` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SAttivita`
--

LOCK TABLES `SAttivita` WRITE;
/*!40000 ALTER TABLE `SAttivita` DISABLE KEYS */;
/*!40000 ALTER TABLE `SAttivita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sequenza`
--

DROP TABLE IF EXISTS `Sequenza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sequenza` (
  `Nome` varchar(20) NOT NULL,
  `NomeProgetto` varchar(20) DEFAULT NULL,
  `Costo` decimal(10,2) DEFAULT NULL,
  `SFine` date DEFAULT NULL,
  `Fine` date DEFAULT NULL,
  `Perc` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sequenza`
--

LOCK TABLES `Sequenza` WRITE;
/*!40000 ALTER TABLE `Sequenza` DISABLE KEYS */;
INSERT INTO `Sequenza` VALUES ('Seq1','P3',NULL,NULL,NULL,NULL),('Seq2','P3',NULL,NULL,NULL,NULL),('Seq3','P3',NULL,NULL,NULL,NULL),('Seq4','P3',NULL,NULL,NULL,NULL),('Seq5','P3',NULL,NULL,NULL,NULL),('Seq6','P3',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `Sequenza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Utente`
--

DROP TABLE IF EXISTS `Utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Utente` (
  `Matricola` int(11) NOT NULL,
  `Nome` varchar(20) NOT NULL,
  `Cognome` varchar(20) NOT NULL,
  `Ruolo` varchar(20) NOT NULL,
  `Cellulare` int(11) DEFAULT NULL,
  `Mail` varchar(30) DEFAULT NULL,
  `Corso` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Matricola`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Utente`
--

LOCK TABLES `Utente` WRITE;
/*!40000 ALTER TABLE `Utente` DISABLE KEYS */;
/*!40000 ALTER TABLE `Utente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-16 18:48:49
