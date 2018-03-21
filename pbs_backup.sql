-- MySQL dump 10.13  Distrib 5.7.21, for Linux (x86_64)
--
-- Host: localhost    Database: data_db
-- ------------------------------------------------------
-- Server version	5.7.21-0ubuntu0.16.04.1

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
  `password` varchar(20) DEFAULT 'default',
  `is_admin` int(2) NOT NULL,
  `is_manager` tinyint(1) NOT NULL,
  `is_user` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Login`
--

LOCK TABLES `Login` WRITE;
/*!40000 ALTER TABLE `Login` DISABLE KEYS */;
INSERT INTO `Login` VALUES (1,'arijit','xyz',0,0,1),(2,'sohom','abc',0,1,0),(3,'sagar','def',2,0,0),(21,'b','default',0,0,1),(22,'c','default',1,0,0),(23,'a','default',0,1,0),(24,'','default',0,0,1),(25,'varsha','default',1,0,0),(26,'engineer1','default',0,0,1),(27,'manager1','default',0,1,0),(28,'soham','default',0,0,1),(29,'srinath','default',0,1,0),(30,'bbb','default',0,0,1),(31,'ccc','default',1,0,0),(32,'aaa','default',0,1,0),(33,'def','default',0,0,1),(34,'xyz','default',1,0,0),(35,'abc','default',0,1,0),(36,'gaurav','default',1,0,0),(37,'yamini','default',1,0,0);
/*!40000 ALTER TABLE `Login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_table`
--

DROP TABLE IF EXISTS `file_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_table` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key_id` int(10) unsigned NOT NULL,
  `file_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `key_id` (`key_id`),
  CONSTRAINT `file_table_ibfk_1` FOREIGN KEY (`key_id`) REFERENCES `version` (`version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_table`
--

LOCK TABLES `file_table` WRITE;
/*!40000 ALTER TABLE `file_table` DISABLE KEYS */;
INSERT INTO `file_table` VALUES (3,5,'flask-backup.txt'),(4,1,'flask-backup.txt'),(5,24,'Frontend.zip'),(6,20,'Frontend.zip'),(7,25,'Frontend.zip'),(8,26,'Frontend.zip');
/*!40000 ALTER TABLE `file_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `first_table`
--

DROP TABLE IF EXISTS `first_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `first_table` (
  `key_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `outcome` varchar(30) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `justification` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `first_table`
--

LOCK TABLES `first_table` WRITE;
/*!40000 ALTER TABLE `first_table` DISABLE KEYS */;
INSERT INTO `first_table` VALUES (1,'PASS','The product meets the requirement in its entirety with no additional development required.','The product does not meet this requirement, and the product team plans to comply in the future'),(2,'FAIL','List the evidence that causes you to draw this conclusion.','Document when the functionality to meet this requirement will be integrated into a release.'),(3,'BACKLOG','The product does not meet this requirement, and the product team has no plans for compliance.','Document when the functionality to meet this requirement will be integrated into a release.'),(4,'NOT APPLICABLE','Document why you have no plans for compliance.','Describe why this requirement is not applicable to your product. Provide enough detail for a member of the Security Team to draw the same conclusion.'),(5,'NOT YET ANSWERED','',''),(11,'Sohom','Definition','Title');
/*!40000 ALTER TABLE `first_table` ENABLE KEYS */;
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
  `date` varchar(20) DEFAULT 'NULL',
  PRIMARY KEY (`table_id`),
  KEY `mile_id` (`mile_id`),
  KEY `key_id` (`key_id`),
  CONSTRAINT `map_key_to_milestone_ibfk_2` FOREIGN KEY (`mile_id`) REFERENCES `milestone` (`mile_id`),
  CONSTRAINT `map_key_to_milestone_ibfk_3` FOREIGN KEY (`key_id`) REFERENCES `version` (`version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `map_key_to_milestone`
--

LOCK TABLES `map_key_to_milestone` WRITE;
/*!40000 ALTER TABLE `map_key_to_milestone` DISABLE KEYS */;
INSERT INTO `map_key_to_milestone` VALUES (25,1,2,'NULL'),(26,1,3,'NULL'),(27,1,4,'NULL'),(28,1,5,'NULL'),(29,1,6,'NULL'),(30,1,7,'NULL'),(31,1,8,'NULL'),(32,1,9,'NULL'),(33,1,10,'yyyy'),(34,1,11,'madar'),(36,4,2,'NULL'),(37,4,3,'NULL'),(38,4,4,'NULL'),(39,4,5,'NULL'),(40,4,6,'NULL'),(41,4,7,'NULL'),(42,4,8,'NULL'),(43,4,9,'NULL'),(44,4,10,'yyyy'),(45,4,11,'madar'),(50,6,2,'NULL'),(51,6,3,'NULL'),(52,6,4,'NULL'),(53,6,5,'NULL'),(54,6,6,'NULL'),(55,6,7,'NULL'),(56,6,8,'NULL'),(57,6,9,'NULL'),(58,6,10,'NULL'),(59,6,11,'NULL'),(63,15,2,'NULL'),(64,15,3,'NULL'),(65,15,4,'NULL'),(66,15,5,'NULL'),(67,15,6,'NULL'),(68,15,7,'NULL'),(69,15,8,'NULL'),(70,15,9,'NULL'),(71,15,10,'NULL'),(72,15,11,'NULL'),(76,5,2,'NULL'),(77,5,3,'NULL'),(78,5,4,'NULL'),(79,5,5,'NULL'),(80,5,6,'NULL'),(81,5,7,'NULL'),(82,5,8,'NULL'),(83,5,9,'NULL'),(84,5,10,'NULL'),(85,5,11,'NULL'),(89,17,2,'NULL'),(90,17,3,'NULL'),(91,17,4,'NULL'),(92,17,5,'NULL'),(93,17,6,'NULL'),(94,17,7,'NULL'),(95,17,8,'NULL'),(96,17,9,'NULL'),(97,17,10,'NULL'),(98,17,11,'NULL'),(102,7,2,'NULL'),(103,7,3,'NULL'),(104,7,4,'NULL'),(105,7,5,'NULL'),(106,7,6,'NULL'),(107,7,7,'NULL'),(108,7,8,'NULL'),(109,7,9,'NULL'),(110,7,10,'NULL'),(111,7,11,'NULL'),(115,19,2,'NULL'),(116,19,3,'NULL'),(117,19,4,'NULL'),(118,19,5,'NULL'),(119,19,6,'NULL'),(120,19,7,'NULL'),(121,19,8,'NULL'),(122,19,9,'NULL'),(123,19,10,'NULL'),(124,19,11,'NULL'),(128,1,22,'NULL'),(129,4,22,'NULL'),(130,5,22,'NULL'),(131,6,22,'NULL'),(132,7,22,'NULL'),(133,15,22,'NULL'),(134,17,22,'NULL'),(135,19,22,'NULL');
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
  `response` varchar(10000) DEFAULT 'NULL',
  PRIMARY KEY (`table_id`),
  KEY `question_id` (`question_id`),
  KEY `key_id` (`key_id`),
  CONSTRAINT `map_key_to_pre_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `prequestions` (`question_id`),
  CONSTRAINT `map_key_to_pre_ibfk_3` FOREIGN KEY (`key_id`) REFERENCES `version` (`version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `map_key_to_pre`
--

LOCK TABLES `map_key_to_pre` WRITE;
/*!40000 ALTER TABLE `map_key_to_pre` DISABLE KEYS */;
INSERT INTO `map_key_to_pre` VALUES (16,1,2,'soham'),(17,1,3,''),(18,1,4,''),(19,1,5,''),(21,4,2,'soham'),(22,4,3,''),(23,4,4,''),(24,4,5,''),(30,6,2,'something'),(31,6,3,''),(32,6,4,''),(33,6,5,''),(36,15,2,'Soham'),(37,15,3,'Chatterjee'),(38,15,4,''),(39,15,5,''),(42,5,2,''),(43,5,3,''),(44,5,4,''),(45,5,5,''),(48,17,2,'Something'),(49,17,3,''),(50,17,4,''),(51,17,5,''),(54,7,2,'qw'),(55,7,3,''),(56,7,4,''),(57,7,5,''),(60,19,2,''),(61,19,3,''),(62,19,4,''),(63,19,5,'');
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
  `status` varchar(20) DEFAULT 'Yet to be answered',
  `justification` varchar(10000) DEFAULT '',
  `manager_response` varchar(10) DEFAULT 'processing',
  PRIMARY KEY (`table_id`),
  KEY `psb_id` (`psb_id`),
  KEY `key_id` (`key_id`),
  CONSTRAINT `map_key_to_psb_ibfk_2` FOREIGN KEY (`psb_id`) REFERENCES `psb` (`psb_id`),
  CONSTRAINT `map_key_to_psb_ibfk_3` FOREIGN KEY (`key_id`) REFERENCES `version` (`version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `map_key_to_psb`
--

LOCK TABLES `map_key_to_psb` WRITE;
/*!40000 ALTER TABLE `map_key_to_psb` DISABLE KEYS */;
INSERT INTO `map_key_to_psb` VALUES (14,1,'ASR-1','Not_Answered','DEFd','processing'),(16,4,'ASR-1','Yet to be answered','haram','rejected'),(34,5,'ASR-1','Not_Answered','20','approved'),(38,14,'ASR-1','PASS','NULL','approved'),(42,1,'ASR-101','PASS','hjjh','processing'),(43,4,'ASR-101','Yet to be answered','','processing'),(44,5,'ASR-101','PASS','soham','approved'),(45,14,'ASR-101','Yet to be answered','','processing'),(46,19,'ASR-1','PASS','NULL','approved'),(48,19,'ASR-101','APPLICABLE','Name','approved'),(49,24,'ASR-1','Yet to be answered','NULL','approved'),(51,24,'ASR-101','Yet to be answered','NULL','approved'),(52,20,'ASR-1','Not_Answered','NULL','approved'),(54,20,'ASR-101','PASS','NULL','approved'),(55,25,'ASR-1','PASS','NULL','approved'),(57,25,'ASR-101','PASS','NULL','approved'),(58,26,'ASR-1','FAIL','hgh`jhjk','approved'),(59,26,'ASR-101','PASS','3434','approved'),(60,27,'ASR-1','PASS','s','approved'),(61,27,'ASR-101','Not_Answered','s','approved'),(62,28,'ASR-1','Not_Answered','NULL','rejected'),(63,28,'ASR-101','PASS','NULL','rejected'),(64,29,'ASR-1','FAIL','sadas','approved'),(65,29,'ASR-101','Not_Answered','hgf','approved'),(66,30,'ASR-1','Not_Answered','NULL','approved'),(67,30,'ASR-101','FAIL','NULL','approved'),(68,31,'ASR-1','PASS','srinath1','approved'),(69,31,'ASR-101','PASS','soham1','approved'),(70,1,'ASR-110','Yet to be answered','','processing'),(71,4,'ASR-110','Yet to be answered','','processing'),(72,5,'ASR-110','Yet to be answered','','processing'),(73,14,'ASR-110','Yet to be answered','','processing'),(74,19,'ASR-110','Yet to be answered','','processing'),(75,20,'ASR-110','Yet to be answered','','processing'),(76,24,'ASR-110','Yet to be answered','','processing'),(77,25,'ASR-110','Yet to be answered','','processing'),(78,26,'ASR-110','Yet to be answered','','processing'),(79,27,'ASR-110','Yet to be answered','','processing'),(80,28,'ASR-110','Yet to be answered','','processing'),(81,29,'ASR-110','Yet to be answered','','processing'),(82,30,'ASR-110','Yet to be answered','','processing'),(83,31,'ASR-110','Yet to be answered','','processing'),(84,32,'ASR-1','PASS','NULL','approved'),(85,32,'ASR-101','PASS','NULL','approved'),(86,32,'ASR-110','PASS','anything','approved'),(87,1,'ASR-121','Yet to be answered','','processing'),(88,4,'ASR-121','Yet to be answered','','processing'),(89,5,'ASR-121','Yet to be answered','','processing'),(90,14,'ASR-121','Yet to be answered','','processing'),(91,19,'ASR-121','Yet to be answered','','processing'),(92,20,'ASR-121','Yet to be answered','','processing'),(93,24,'ASR-121','Yet to be answered','','processing'),(94,25,'ASR-121','Yet to be answered','','processing'),(95,26,'ASR-121','Yet to be answered','','processing'),(96,27,'ASR-121','Yet to be answered','','processing'),(97,28,'ASR-121','Yet to be answered','','processing'),(98,29,'ASR-121','Yet to be answered','','processing'),(99,30,'ASR-121','Yet to be answered','','processing'),(100,31,'ASR-121','Yet to be answered','','processing'),(101,32,'ASR-121','Yet to be answered','','processing'),(102,33,'ASR-1','PASS','soham','approved'),(103,33,'ASR-101','FAIL','NULL','approved'),(104,33,'ASR-110','APPLICABLE','NULL','approved'),(105,33,'ASR-121','FAIL','varsha','approved');
/*!40000 ALTER TABLE `map_key_to_psb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `map_user_to_product`
--

DROP TABLE IF EXISTS `map_user_to_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_user_to_product` (
  `table_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` smallint(5) unsigned NOT NULL,
  `version_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`table_id`),
  KEY `user_id` (`user_id`),
  KEY `version_id` (`version_id`),
  CONSTRAINT `map_user_to_product_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Login` (`id`),
  CONSTRAINT `map_user_to_product_ibfk_2` FOREIGN KEY (`version_id`) REFERENCES `version` (`version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `map_user_to_product`
--

LOCK TABLES `map_user_to_product` WRITE;
/*!40000 ALTER TABLE `map_user_to_product` DISABLE KEYS */;
INSERT INTO `map_user_to_product` VALUES (1,1,1),(2,1,4),(3,2,5),(4,2,6),(5,2,7),(6,1,5),(7,3,5),(17,21,5),(18,22,5),(19,23,5),(20,24,5),(21,25,5),(22,26,5),(23,27,5),(24,28,19),(25,24,19),(26,29,19),(27,30,5),(28,31,5),(29,32,5),(30,33,1),(31,34,1),(32,35,1),(33,33,24),(34,34,24),(35,35,24),(36,33,20),(37,34,20),(38,35,20),(39,33,25),(40,34,25),(41,35,25),(42,28,26),(43,25,26),(44,29,26),(45,1,26),(46,24,26),(47,2,26),(48,28,25),(49,25,25),(50,29,25),(51,28,27),(52,25,27),(53,29,27),(54,24,28),(55,25,28),(56,28,28),(57,29,28),(58,28,29),(59,25,29),(60,29,29),(61,28,30),(62,25,30),(63,29,30),(64,28,31),(65,25,31),(66,29,31),(67,24,31),(68,36,31),(69,37,31),(70,28,32),(71,25,32),(72,29,32),(73,28,33),(74,25,33),(75,29,33);
/*!40000 ALTER TABLE `map_user_to_product` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milestone`
--

LOCK TABLES `milestone` WRITE;
/*!40000 ALTER TABLE `milestone` DISABLE KEYS */;
INSERT INTO `milestone` VALUES (2,'abcd'),(3,'Requirement Gathering Phase'),(4,'Threat Modelling'),(5,'Secure Coding best practices walkthru'),(6,'Coverity run'),(7,'Nessus run'),(8,'Newparker run'),(9,'Review results'),(10,'Next sign off stage, date'),(11,'Current Phase'),(22,'test');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prequestions`
--

LOCK TABLES `prequestions` WRITE;
/*!40000 ALTER TABLE `prequestions` DISABLE KEYS */;
INSERT INTO `prequestions` VALUES (2,'Gather information on how testing is being performed for non-security related requirements. This will help us to find optimal integration points for SDL without much disruption to current workflow [ProdOps Security SDL team member to drive this discussion'),(3,'How compliance related requirements are currently being driven?'),(4,'How ecosystem dependencies (i.e. components that this product is dependent on) are coordinated in relation to planned set features in this product?'),(5,'How security related requirements are tracked, considered and worked in current releases?');
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'ONTAP'),(2,'WFA'),(3,'OCUM'),(4,'WFA API'),(9,'KITKAT'),(10,'Netxsdsa'),(11,'ABC'),(12,'ABCD'),(13,'SOham'),(14,'Something'),(16,'WFA-API'),(17,'system manager'),(18,'API SERVICES'),(19,'Occum'),(20,'Product1'),(21,'Product2'),(22,'Product3'),(23,'Product4'),(24,'product5'),(25,'product6'),(26,'product7'),(27,'product8'),(28,'product9'),(29,'product10'),(30,'product11'),(31,'product20');
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
INSERT INTO `psb` VALUES ('ASR-1','The system must monitor and record successful and unsuccessful login attempts','The system must monitor and record login attempts to assist with investigating an intrusion. If an attacker gains access to a NetApp product in the field, the Customer Security department needs to retrieve a list of when accounts logged in to identify compromised accounts.'),('ASR-101','Something','Something'),('ASR-110','something','anything'),('ASR-121','SomeThing','Anything');
/*!40000 ALTER TABLE `psb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `second_table`
--

DROP TABLE IF EXISTS `second_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `second_table` (
  `key_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language` varchar(30) NOT NULL,
  `defination` varchar(10000) DEFAULT NULL,
  PRIMARY KEY (`key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `second_table`
--

LOCK TABLES `second_table` WRITE;
/*!40000 ALTER TABLE `second_table` DISABLE KEYS */;
INSERT INTO `second_table` VALUES (1,'MUST','This word, or the terms \'REQUIRED\' or \'SHALL\', mean that the definition is an absolute requirement of the specification.'),(2,'MUST NOT','This phrase, or the phrase \'SHALL NOT\', mean that the definition is an absolute prohibition of the specification.'),(3,'SHOULD','This word, or the adjective \'RECOMMENDED\', mean that there may exist valid reasons in particular circumstances to ignore a particular item, but the full implications must be understood and carefully weighed before choosing a different course.'),(4,'SHOULD NOT','This phrase, or the phrase \'NOT RECOMMENDED\' mean that there may exist valid reasons in particular circumstances when the particular behavior is acceptable or even useful, but the full implications should be understood and the case carefully weighed before implementing any behavior described with this label.'),(5,'MAY','This word, or the adjective \'OPTIONAL\', mean that an item is truly optional. One vendor may choose to include the item because a particular marketplace requires it or because the vendor feels that it enhances the product while another vendor may omit the same item. An implementation which does not include a particular option MUST be prepared to interoperate with another implementation which does include the option, though perhaps with reduced functionality. In the same vein an implementation which does include a particular option MUST be prepared to interoperate with another implementation which does not include the option (except, of course, for the feature the option provides.');
/*!40000 ALTER TABLE `second_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `third_table`
--

DROP TABLE IF EXISTS `third_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `third_table` (
  `key_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `outcome` varchar(40) NOT NULL,
  `description` varchar(10000) DEFAULT NULL,
  PRIMARY KEY (`key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `third_table`
--

LOCK TABLES `third_table` WRITE;
/*!40000 ALTER TABLE `third_table` DISABLE KEYS */;
INSERT INTO `third_table` VALUES (1,'Attack Surface Reduction','Attack surface is the total of all the interfaces a bad person could use to attack a NetApp product. These requirements provide methods to close interfaces that are not in use, and limit the number of ways an attacker could reach a NetApp product.'),(2,'Cryptography','Cryptography is the computerized encoding and decoding of information. These requirements govern what forms of cryptography to use in NetApp products and the various details about how to implement.'),(3,'System and Information Integrity','System and information integrity is the protection of data wherever it exists inside a NetApp product. These requirements provide guidance about securing protocols and other areas of the system.'),(4,'Audit','Audit is a record of all the actions that occur on a NetApp product. Audit is crucial when performing a security investigation, to uncover what exactly happened, and in what order events occurred. These requirements determine where and how much audit data must be stored.'),(5,'Third-Party Software','Third-party software (open source) is included in almost all NetApp products. 3rd party software has vulnerabilities, and these requirements govern the Black Duck process to ensure that old 3rd party software is not allowed to continue to place NetApp products and customers at risk.'),(6,'Security Assurance','Security assurance includes the various requirements dictated to NetApp by the US Federal Government and other global governments.');
/*!40000 ALTER TABLE `third_table` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (1,1,1,'dd','aa'),(4,1,2,'ddddd','aasssss'),(5,2,2,'Something','Something'),(6,2,3,'something','something'),(7,3,1,'',''),(8,3,4,'',''),(12,9,1,'',''),(13,10,1,'',''),(14,11,1,'NULL','NULL'),(15,12,1,'NULL','NULL'),(16,13,1,'NULL','NULL'),(17,14,1,'NULL','NULL'),(18,16,1,'NULL','NULL'),(19,17,1,'NULL','Something'),(20,18,1,'NULL','NULL'),(21,19,1,'NULL','NULL'),(22,20,1,'NULL','NULL'),(23,21,1,'NULL','NULL'),(24,22,1,'NULL','NULL'),(25,23,1,'NULL','NULL'),(26,24,1,'NULL','NULL'),(27,25,1,'NULL','NULL'),(28,26,1,'NULL','NULL'),(29,27,1,'NULL','NULL'),(30,28,1,'NULL','NULL'),(31,29,1,'NULL','NULL'),(32,30,1,'NULL','NULL'),(33,31,1,'NULL','NULL');
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

-- Dump completed on 2018-03-21 10:19:47
