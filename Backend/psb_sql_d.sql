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
  `password` varchar(20) DEFAULT 'default',
  `is_admin` tinyint(1) NOT NULL,
  `is_manager` tinyint(1) NOT NULL,
  `is_user` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Login`
--

LOCK TABLES `Login` WRITE;
/*!40000 ALTER TABLE `Login` DISABLE KEYS */;
INSERT INTO `Login` VALUES (1,'arijit','xyz',0,0,1),(2,'sohom','abc',0,1,0),(3,'sagar','def',1,0,0),(4,'sanu','default',0,0,1),(5,'sayan','default',0,0,1),(6,'Sayann','default',0,0,1),(7,'arijit','default',0,0,1),(8,'arijit','default',0,0,1),(9,'rohit','default',0,0,1);
/*!40000 ALTER TABLE `Login` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `map_key_to_milestone`
--

LOCK TABLES `map_key_to_milestone` WRITE;
/*!40000 ALTER TABLE `map_key_to_milestone` DISABLE KEYS */;
INSERT INTO `map_key_to_milestone` VALUES (25,1,2,'NULL'),(26,1,3,'NULL'),(27,1,4,'NULL'),(28,1,5,'NULL'),(29,1,6,'NULL'),(30,1,7,'NULL'),(31,1,8,'NULL'),(32,1,9,'NULL'),(33,1,10,'yyyy'),(34,1,11,'madar'),(36,4,2,'NULL'),(37,4,3,'NULL'),(38,4,4,'NULL'),(39,4,5,'NULL'),(40,4,6,'NULL'),(41,4,7,'NULL'),(42,4,8,'NULL'),(43,4,9,'NULL'),(44,4,10,'yyyy'),(45,4,11,'madar'),(46,1,20,'NULL'),(47,4,20,'NULL'),(48,1,21,'NULL'),(49,4,21,'NULL');
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `map_key_to_pre`
--

LOCK TABLES `map_key_to_pre` WRITE;
/*!40000 ALTER TABLE `map_key_to_pre` DISABLE KEYS */;
INSERT INTO `map_key_to_pre` VALUES (16,1,2,'NULL'),(17,1,3,'NULL'),(18,1,4,'NULL'),(19,1,5,'zzzzzz'),(21,4,2,'NULL'),(22,4,3,'NULL'),(23,4,4,'NULL'),(24,4,5,'zzzzzz'),(25,1,12,'NULL'),(26,4,12,'NULL'),(28,1,13,'NULL'),(29,4,13,'NULL');
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `map_key_to_psb`
--

LOCK TABLES `map_key_to_psb` WRITE;
/*!40000 ALTER TABLE `map_key_to_psb` DISABLE KEYS */;
INSERT INTO `map_key_to_psb` VALUES (14,1,'ASR-1','Yet to be answered','DEFd','approved'),(15,1,'ASR-10','Yet to be answered','xyzw','approved'),(16,4,'ASR-1','Yet to be answered','haram','processing'),(17,4,'ASR-10','answered','nini','processing'),(18,1,'ASR-90','Yet to be answered','','processing'),(19,4,'ASR-90','Yet to be answered','','processing'),(20,1,'ASR-110','Yet to be answered','','processing'),(21,4,'ASR-110','Yet to be answered','','processing'),(34,5,'ASR-1','Not_Answered','2','approved'),(35,5,'ASR-10','PASS','4','approved'),(36,5,'ASR-110','FAIL','5','approved'),(37,5,'ASR-90','APPLICABLE','3','approved');
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `map_user_to_product`
--

LOCK TABLES `map_user_to_product` WRITE;
/*!40000 ALTER TABLE `map_user_to_product` DISABLE KEYS */;
INSERT INTO `map_user_to_product` VALUES (1,1,1),(2,1,4),(3,2,5),(4,2,6),(5,2,7),(6,1,5),(7,3,5),(8,6,1),(9,9,13);
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milestone`
--

LOCK TABLES `milestone` WRITE;
/*!40000 ALTER TABLE `milestone` DISABLE KEYS */;
INSERT INTO `milestone` VALUES (2,'abcd'),(3,'Requirement Gathering Phase'),(4,'Threat Modelling'),(5,'Secure Coding best practices walkthru'),(6,'Coverity run'),(7,'Nessus run'),(8,'Newparker run'),(9,'Review results'),(10,'Next sign off stage, date'),(11,'Current Phase'),(14,'abcd'),(20,'hjfdkjnkjw'),(21,'hjfdkjnkjwaaaaaaaa');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prequestions`
--

LOCK TABLES `prequestions` WRITE;
/*!40000 ALTER TABLE `prequestions` DISABLE KEYS */;
INSERT INTO `prequestions` VALUES (2,'Gather information on how testing is being performed for non-security related requirements. This will help us to find optimal integration points for SDL without much disruption to current workflow [ProdOps Security SDL team member to drive this discussion'),(3,'How compliance related requirements are currently being driven?'),(4,'How ecosystem dependencies (i.e. components that this product is dependent on) are coordinated in relation to planned set features in this product?'),(5,'How security related requirements are tracked, considered and worked in current releases?'),(12,'abcd'),(13,'sagarmoy');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'ONTAP'),(2,'WFA'),(3,'OCUM'),(4,'WFA API'),(9,'KITKAT'),(10,'Netxsdsa');
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
INSERT INTO `psb` VALUES ('ASR-1','The system must monitor and record successful and unsuccessful login attempts','The system must monitor and record login attempts to assist with investigating an intrusion. If an attacker gains access to a NetApp product in the field, the Customer Security department needs to retrieve a list of when accounts logged in to identify compromised accounts.'),('ASR-10','kjhkjdsahfkjeshfi','fhvija vnvgeyoioihyuhveoiuo'),('ASR-110','California','asadasdasm,c,mvncxvvcxnv013&^&^&'),('ASR-90','Philadelphia','dadsadxcxzcnasdijqweipqwe');
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
INSERT INTO `second_table` VALUES (1,'MUST','This word, or the terms \'REQUIRED\' or \'SHALL\', mean that the definition is an absolute requirement of the specification.'),(2,'MUST NOT','This phrase, or the phrase \'SHALL NOT\', mean that the definition is an absolute prohibition of the specification.'),(3,'SHOULD','This word, or the adjective \'RECOMMENDED\', mean that there may exist valid reasons in particular circumstances to ignore a particular item, but the full implications must be understood and carefully weighed before choosing a different course.'),(4,'SHOULD NOT','This phrase, or the phrase \'NOT RECOMMENDED\' mean that there may exist valid reasons in particular circumstances when the particular behavior is acceptable or even useful, but the full implications should be understood and the case carefully weighed before implementing any behavior described with this label.'),(5,'MAY','This word, or the adjective \'OPTIONAL\', mean that an item is truly optional. One vendor may choose to include the item because a particular marketplace requires it or because the vendor feels that it enhances the product while another vendor may omit the same item. An implementation which does not include a particular option MUST be prepared to interoperate with another implementation which does include the option, though perhaps with reduced functionality. In the same vein an implementation which does include a particular option MUST be prepared to interoperate with another implementation which does not include the option (except, of course, for the feature the option provides.'),(6,'Maybe','Some thing');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (1,1,1,'dd','aa'),(4,1,2,'ddddd','aasssss'),(5,2,2,'NULL','NULL'),(6,2,3,'NULL','NULL'),(7,3,1,'NULL','NULL'),(8,3,4,'NULL','NULL'),(12,9,1,'NULL','NULL'),(13,10,1,'NULL','NULL');
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

-- Dump completed on 2018-02-26  3:09:47
