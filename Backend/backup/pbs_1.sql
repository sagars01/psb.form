-- MySQL dump 10.13  Distrib 5.7.20, for osx10.13 (x86_64)
--
-- Host: localhost    Database: pbs_project
-- ------------------------------------------------------
-- Server version	5.7.20

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
-- Table structure for table `Login`
--

DROP TABLE IF EXISTS `Login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Login` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Login`
--

LOCK TABLES `Login` WRITE;
/*!40000 ALTER TABLE `Login` DISABLE KEYS */;
INSERT INTO `Login` VALUES (1,'arijit','xyz',0),(2,'sohom','abc',0),(3,'sagar','def',1);
/*!40000 ALTER TABLE `Login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `map_key_to_milestone`
--

DROP TABLE IF EXISTS `map_key_to_milestone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_key_to_milestone` (
  `table_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key_id` int(10) unsigned NOT NULL,
  `mile_id` int(10) unsigned NOT NULL,
  `date` varchar(20) NOT NULL,
  PRIMARY KEY (`table_id`),
  KEY `mile_id` (`mile_id`),
  KEY `key_id` (`key_id`),
  CONSTRAINT `map_key_to_milestone_ibfk_2` FOREIGN KEY (`mile_id`) REFERENCES `milestone` (`mile_id`),
  CONSTRAINT `map_key_to_milestone_ibfk_3` FOREIGN KEY (`key_id`) REFERENCES `version` (`version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `map_key_to_milestone`
--

LOCK TABLES `map_key_to_milestone` WRITE;
/*!40000 ALTER TABLE `map_key_to_milestone` DISABLE KEYS */;
INSERT INTO `map_key_to_milestone` VALUES (24,1,1,'abcd'),(25,1,2,'NULL'),(26,1,3,'NULL'),(27,1,4,'NULL'),(28,1,5,'NULL'),(29,1,6,'NULL'),(30,1,7,'NULL'),(31,1,8,'NULL'),(32,1,9,'NULL'),(33,1,10,'yyyy'),(34,1,11,'madar'),(35,8,1,'NULL'),(36,8,2,'NULL'),(37,8,3,'NULL'),(38,8,4,'NULL'),(39,8,5,'NULL'),(40,8,6,'NULL'),(41,8,7,'NULL'),(42,8,8,'NULL'),(43,8,9,'NULL'),(44,8,10,'NULL'),(45,8,11,'NULL'),(46,5,1,'NULL'),(47,5,2,'NULL'),(48,5,3,'NULL'),(49,5,4,'NULL'),(50,5,5,'NULL'),(51,5,6,'NULL'),(52,5,7,'NULL'),(53,5,8,'NULL'),(54,5,9,'NULL'),(55,5,10,'NULL'),(56,5,11,'NULL'),(57,4,1,'NULL'),(58,4,2,'NULL'),(59,4,3,'NULL'),(60,4,4,'NULL'),(61,4,5,'NULL'),(62,4,6,'NULL'),(63,4,7,'NULL'),(64,4,8,'NULL'),(65,4,9,'NULL'),(66,4,10,'NULL'),(67,4,11,'NULL'),(68,7,1,'NULL'),(69,7,2,'NULL'),(70,7,3,'NULL'),(71,7,4,'NULL'),(72,7,5,'NULL'),(73,7,6,'NULL'),(74,7,7,'NULL'),(75,7,8,'NULL'),(76,7,9,'NULL'),(77,7,10,'NULL'),(78,7,11,'NULL');
/*!40000 ALTER TABLE `map_key_to_milestone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `map_key_to_pre`
--

DROP TABLE IF EXISTS `map_key_to_pre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_key_to_pre` (
  `table_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key_id` int(10) unsigned NOT NULL,
  `question_id` int(10) unsigned NOT NULL,
  `response` varchar(10000) NOT NULL,
  PRIMARY KEY (`table_id`),
  KEY `question_id` (`question_id`),
  KEY `key_id` (`key_id`),
  CONSTRAINT `map_key_to_pre_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `prequestions` (`question_id`),
  CONSTRAINT `map_key_to_pre_ibfk_3` FOREIGN KEY (`key_id`) REFERENCES `version` (`version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `map_key_to_pre`
--

LOCK TABLES `map_key_to_pre` WRITE;
/*!40000 ALTER TABLE `map_key_to_pre` DISABLE KEYS */;
INSERT INTO `map_key_to_pre` VALUES (15,1,1,'xyzw'),(16,1,2,'NULL'),(17,1,3,'NULL'),(18,1,4,'NULL'),(19,1,5,'zzzzzz'),(20,8,1,'NULL'),(21,8,2,'NULL'),(22,8,3,'NULL'),(23,8,4,'NULL'),(24,8,5,'NULL'),(25,5,1,'NULL'),(26,5,2,'NULL'),(27,5,3,'NULL'),(28,5,4,'NULL'),(29,5,5,'NULL'),(30,4,1,'NULL'),(31,4,2,'NULL'),(32,4,3,'NULL'),(33,4,4,'NULL'),(34,4,5,'NULL'),(35,7,1,'NULL'),(36,7,2,'NULL'),(37,7,3,'NULL'),(38,7,4,'NULL'),(39,7,5,'NULL');
/*!40000 ALTER TABLE `map_key_to_pre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `map_key_to_psb`
--

DROP TABLE IF EXISTS `map_key_to_psb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_key_to_psb` (
  `table_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key_id` int(10) unsigned NOT NULL,
  `psb_id` varchar(10) NOT NULL,
  `status` varchar(20) NOT NULL,
  `justification` varchar(10000) DEFAULT NULL,
  PRIMARY KEY (`table_id`),
  KEY `psb_id` (`psb_id`),
  KEY `key_id` (`key_id`),
  CONSTRAINT `map_key_to_psb_ibfk_2` FOREIGN KEY (`psb_id`) REFERENCES `psb` (`psb_id`),
  CONSTRAINT `map_key_to_psb_ibfk_3` FOREIGN KEY (`key_id`) REFERENCES `version` (`version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `map_key_to_psb`
--

LOCK TABLES `map_key_to_psb` WRITE;
/*!40000 ALTER TABLE `map_key_to_psb` DISABLE KEYS */;
INSERT INTO `map_key_to_psb` VALUES (14,1,'ASR-1','APPLICABLE','abcd'),(15,1,'ASR-10','BACKLOG','tyuk');
/*!40000 ALTER TABLE `map_key_to_psb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `milestone`
--

DROP TABLE IF EXISTS `milestone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `milestone` (
  `mile_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `milestone` varchar(50) NOT NULL,
  PRIMARY KEY (`mile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milestone`
--

LOCK TABLES `milestone` WRITE;
/*!40000 ALTER TABLE `milestone` DISABLE KEYS */;
INSERT INTO `milestone` VALUES (1,'SDL Deck Walkthru'),(2,'Go for SDL - from all POC'),(3,'Requirement Gathering Phase'),(4,'Threat Modelling'),(5,'Secure Coding best practices walkthru'),(6,'Coverity run'),(7,'Nessus run'),(8,'Newparker run'),(9,'Review results'),(10,'Next sign off stage, date'),(11,'Current Phase');
/*!40000 ALTER TABLE `milestone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prequestions`
--

DROP TABLE IF EXISTS `prequestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prequestions` (
  `question_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` varchar(1000) NOT NULL,
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prequestions`
--

LOCK TABLES `prequestions` WRITE;
/*!40000 ALTER TABLE `prequestions` DISABLE KEYS */;
INSERT INTO `prequestions` VALUES (1,'Ascertain development tools, language, IDE, team size and release cadence?'),(2,'Gather information on how testing is being performed for non-security related requirements. This will help us to find optimal integration points for SDL without much disruption to current workflow [ProdOps Security SDL team member to drive this discussion'),(3,'How compliance related requirements are currently being driven?'),(4,'How ecosystem dependencies (i.e. components that this product is dependent on) are coordinated in relation to planned set features in this product?'),(5,'How security related requirements are tracked, considered and worked in current releases?');
/*!40000 ALTER TABLE `prequestions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_name` varchar(20) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'ONTAP'),(2,'WFA'),(3,'OCUM'),(4,'WFA API'),(9,'KITKAT'),(10,'Text'),(11,'Android');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `psb`
--

DROP TABLE IF EXISTS `psb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `psb` (
  `psb_id` varchar(10) NOT NULL,
  `req` varchar(1000) NOT NULL,
  `reason` varchar(10000) NOT NULL,
  PRIMARY KEY (`psb_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `psb`
--

LOCK TABLES `psb` WRITE;
/*!40000 ALTER TABLE `psb` DISABLE KEYS */;
INSERT INTO `psb` VALUES ('ASR-1','The system must monitor and record successful and unsuccessful login attempts','The system must monitor and record login attempts to assist with investigating an intrusion. If an attacker gains access to a NetApp product in the field, the Customer Security department needs to retrieve a list of when accounts logged in to identify compromised accounts.'),('ASR-10','For command-line authentication, the root account should not be permitted to login remotely','The root account is the highest privileged account within our product. We need to provide multiple layers of protection to insulate the root account from being compromised.');
/*!40000 ALTER TABLE `psb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `version_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned DEFAULT NULL,
  `version` int(11) NOT NULL,
  `minutes_of_meeting` varchar(1000) DEFAULT 'NULL',
  `Phase_details` varchar(10000) DEFAULT 'NULL',
  PRIMARY KEY (`version_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `version_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (1,1,1,'xx','ss'),(4,1,2,'NULL','NULL'),(5,2,2,'NULL','NULL'),(6,2,3,'NULL','NULL'),(7,3,1,'NULL','NULL'),(8,3,4,'NULL','NULL'),(12,9,1,'NULL','NULL'),(13,10,0,'NULL','NULL'),(14,11,4,'NULL','NULL');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-19  9:49:11
