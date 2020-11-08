-- MySQL dump 10.13  Distrib 8.0.22, for Linux (x86_64)
--
-- Host: localhost    Database: cheaptix
-- ------------------------------------------------------
-- Server version	8.0.22-0ubuntu0.20.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Addresses`
--

DROP TABLE IF EXISTS `Addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Addresses` (
  `addressId` int NOT NULL AUTO_INCREMENT,
  `address` varchar(40) NOT NULL,
  `cityId` int NOT NULL,
  `zipCode` int NOT NULL,
  `venueId` int DEFAULT NULL,
  PRIMARY KEY (`addressId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Addresses`
--

INSERT INTO `Addresses` VALUES (1,'1234 2nd Street',3,95112,2),(2,'529 South 10th Street',3,95112,3),(3,'123 Lombart Street',4,95221,4),(4,'2398 Monterey Ave.',16,95221,5),(5,'3242 Bank Terrace Ave.',5,95654,6),(6,'9191 West Honey Creek Court',5,21030,1),(7,'8799 Golf Court',6,50010,7),(8,'86 Grand St.',7,21220,8),(9,'8290 Constitution Court ',8,27502,9),(10,'96 Cobblestone Street',9,28540,10),(11,'9785 East Birch Hill Avenue',10,11010,11),(12,'280 Myrtle St.',11,32068,12),(13,'88 Summit Road',12,32068,13),(14,'498 Main Dr.',13,18062,14),(15,'735 Jackson St.',14,1757,15),(16,'91 Ryan Ave.',17,8861,NULL);

--
-- Table structure for table `Buys`
--

DROP TABLE IF EXISTS `Buys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Buys` (
  `userId` int NOT NULL,
  `ticketId` int NOT NULL,
  `timestamp` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Buys`
--

INSERT INTO `Buys` VALUES (1,1,'2020-10-31 04:30:56'),(1,2,'2020-10-31 04:31:23'),(1,3,'2020-10-31 04:31:27'),(1,4,'2020-10-31 04:31:30'),(5,6,'2020-10-31 04:31:38'),(5,7,'2020-10-31 04:31:43'),(6,8,'2020-10-31 04:31:51'),(2,11,'2020-10-31 04:32:02'),(3,10,'2020-10-31 04:32:08'),(4,9,'2020-10-31 04:32:15'),(11,12,'2020-10-31 04:32:39'),(11,13,'2020-10-31 04:32:42'),(11,14,'2020-10-31 04:32:45'),(15,15,'2020-10-31 04:32:55');

--
-- Table structure for table `Cities`
--

DROP TABLE IF EXISTS `Cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cities` (
  `cityId` int NOT NULL AUTO_INCREMENT,
  `city` varchar(20) NOT NULL,
  `district` varchar(20) NOT NULL,
  `country` varchar(20) NOT NULL,
  PRIMARY KEY (`cityId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cities`
--

INSERT INTO `Cities` VALUES (3,'San Jose','California','United States'),(4,'San Francisco','California','United States'),(5,'New York','New York','United States'),(6,'Austin','Texas','United States'),(7,'Los Angelas','California','United States'),(8,'Philadelphia','Pennsylvania','United States'),(9,'Dothan','Alabama','United States'),(10,'Anaheim','California','United States'),(11,'Sacramento','California','United States'),(12,'Ciudad de México','Mexico City','Mexico'),(13,'Shinjuku City','Tokyo','Japan'),(14,'Beijing','Beijing','China'),(15,'Columbia','South Carolina','United States'),(16,'Stockton','California','United States'),(17,'Reno','Nevada','United States');

--
-- Table structure for table `Events`
--

DROP TABLE IF EXISTS `Events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Events` (
  `eventId` int NOT NULL AUTO_INCREMENT,
  `venueId` int NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`eventId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events`
--

INSERT INTO `Events` VALUES (1,1,'Music Concert','2020-10-30 22:31:56'),(2,2,'Music Concert','2020-10-30 22:32:02'),(3,3,'Music Concert','2020-10-30 22:32:05'),(4,4,'Music Concert','2020-10-30 22:32:08'),(5,5,'Music Concert','2020-10-30 22:32:11'),(6,6,'Music Concert','2020-10-30 22:32:13'),(7,7,'Music Concert','2020-10-30 22:32:16'),(8,9,'Music Concert','2020-10-30 22:32:20'),(9,9,'Sports Event','2020-10-30 22:32:32'),(10,10,'Sports Event','2020-10-30 22:32:35'),(11,11,'Sports Event','2020-10-30 22:32:37'),(12,12,'Sports Event','2020-10-30 22:32:39'),(13,13,'Sports Event','2020-10-30 22:32:40'),(14,14,'Sports Event','2020-10-30 22:32:42'),(15,15,'Sports Event','2020-10-30 22:32:43');

--
-- Table structure for table `Lists`
--

DROP TABLE IF EXISTS `Lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Lists` (
  `userId` int NOT NULL,
  `ticketId` int NOT NULL,
  `timestamp` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lists`
--

INSERT INTO `Lists` VALUES (3,1,'2020-10-31 04:33:47'),(3,2,'2020-10-31 04:33:51'),(3,3,'2020-10-31 04:33:53'),(3,4,'2020-10-31 04:33:55'),(3,5,'2020-10-31 04:33:57'),(3,6,'2020-10-31 04:34:00'),(13,7,'2020-10-31 04:34:08'),(13,8,'2020-10-31 04:34:11'),(13,9,'2020-10-31 04:34:14'),(14,10,'2020-10-31 04:34:20'),(7,11,'2020-10-31 04:34:26'),(7,12,'2020-10-31 04:34:29'),(7,13,'2020-10-31 04:34:31'),(7,14,'2020-10-31 04:34:32'),(7,15,'2020-10-31 04:34:35');

--
-- Table structure for table `PaymentMethod`
--

DROP TABLE IF EXISTS `PaymentMethod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PaymentMethod` (
  `userId` int DEFAULT NULL,
  `name` varchar(20) NOT NULL,
  `cardNum` varchar(16) NOT NULL,
  `expDate` varchar(5) NOT NULL,
  `cardType` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PaymentMethod`
--

INSERT INTO `PaymentMethod` VALUES (2,'Benjamin Foley','1234321432143214','12/23','Visa'),(2,'Sophia Benjamin','1234321432143214','12/23','Visa'),(2,'Ruairidh Tyson','1234321432143214','12/23','Mastercard'),(2,'Manraj Barton','1234321432143214','12/23','Mastercard'),(6,'Krystal Bauer','1234321432143214','12/23','Mastercard'),(10,'Artur Knowles','1234321432143214','12/23','Mastercard'),(9,'Pollyanna House','1234321432143214','12/23','Mastercard'),(11,'Oliwia O\'Connor','3214321432143214','7/21','Visa'),(12,'Tarik Serrano','3214321432143214','7/21','Visa'),(1,'Junior Sosa','3214321432143214','1/24','Visa'),(13,'Aariz Hicks','3214321432143214','1/24','Mastercard'),(15,'Annette Murillo','3214321432143214','5/23','Mastercard'),(14,'Reeva Guy','3214321432143214','5/23','Visa'),(15,'John Smith','1234123412341234','2/22','Visa'),(15,'Johanna Smith','1234123412341234','5/22','Mastercard');

--
-- Table structure for table `Performers`
--

DROP TABLE IF EXISTS `Performers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Performers` (
  `performId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `performerType` varchar(20) NOT NULL,
  `about` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`performId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Performers`
--

INSERT INTO `Performers` VALUES (1,'Ariana Grande','Music','In 2013 Ariana Grande lifted her music career opening for Justin Bieber followed by her first concert tour - The Listening Sessions. From there, Ari launched tour after tour, with the next one being bigger than the last. In 2019 she became the youngest female to headline Coachella. To date, Ariana has performed over 350 concerts across 4 concert tours.'),(2,'Da Baby','Music',NULL),(3,'San Jose Sharks','Sports','The SAP Center is known locally as the Shark Tank. The Sharks were founded in 1991 and were the first NHL franchise based in the San Francisco Bay Area since the California Golden Seals relocated to Cleveland in 1976.'),(4,'Justin Bieber','Music',NULL),(5,'Ken Jeong','Comedy',NULL),(6,'Isaiah Rashad','Music',NULL),(7,'SZA','Music',NULL),(8,'UMI','Music',NULL),(9,'Jhene','Music',NULL),(10,'Cuco','Music',NULL),(11,'21 Savage','Music',NULL),(12,'Noname','Music',NULL),(13,'Saba','Music',NULL),(14,'Domo Genesis','Music',NULL),(15,'Anderson .paak','Music',NULL),(16,'Nelly','Music',NULL);

--
-- Table structure for table `Performs`
--

DROP TABLE IF EXISTS `Performs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Performs` (
  `performId` int NOT NULL,
  `eventId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Performs`
--

INSERT INTO `Performs` VALUES (1,1),(2,2),(3,3),(3,4),(3,5),(3,6),(3,6),(4,6),(5,6),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,15);

--
-- Table structure for table `Tickets`
--

DROP TABLE IF EXISTS `Tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tickets` (
  `ticketId` int NOT NULL AUTO_INCREMENT,
  `price` decimal(15,2) NOT NULL,
  `eventId` int NOT NULL,
  PRIMARY KEY (`ticketId`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tickets`
--

INSERT INTO `Tickets` VALUES (1,32.33,2),(2,123.32,3),(3,400.99,4),(4,88.23,5),(5,88.23,6),(6,130.30,7),(7,233.45,8),(8,100.99,9),(9,10.99,10),(10,100.00,11),(11,500.67,12),(12,100.23,13),(13,55.89,14),(14,55.55,15),(15,55.55,16),(16,55.55,17),(17,55.55,18),(18,55.55,19),(19,200.55,20);

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `addressId` int DEFAULT NULL,
  `adminCode` int DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` VALUES (1,'johnsmith123','banana','john.smith@gmail.com','12099831234',1,NULL),(2,'something3214','banana3214','something.smith@gmail.com','14082345764',2,NULL),(3,'iamnumberthree','number43','number3@gmail.com','12098763546',3,NULL),(4,'anewUser','beginning414','new.user@gmail.com','12099836477',4,NULL),(5,'benfoley1234','typingishard','ben.foley@gmail.com','12091112222',4,NULL),(6,'rachelfoley324','benisdopeaf','rachel.foley@gmail.com','12091112223',4,NULL),(7,'ednamode','qwerty321','ednamode@gmail.com','14072343333',4,NULL),(8,'vforvendetta','somethingidk','vforvendetta@gmail.com','14085673987',5,NULL),(9,'garlicbread','GarlicBreakIsGood','garlicbread@gmail.com','12099814444',6,NULL),(10,'spiritedawaycrackers','CreackersAregood123','spiritedawaycrackers@gmail.com','12099833444',7,NULL),(11,'platoonoctavespider','Asdhgkjfglkwer321','platoonoctavespider@gmail.com','12099814399',8,NULL),(12,'thepianistvealfish','AntoherPassword999','thepianistvealfish@gmail.com','15092342233',8,NULL),(13,'neodownfallmirvenus','cs146Jsdsks','neodownfallmirvenus@gmail.com','12099831322',8,NULL),(14,'leoispectacularearth','AnotherBunny5667','leoispectacularearth@gmail.com','12094063434',8,NULL),(15,'animaltracksroastsea','PhoneNumber4444','animaltracksroastsea@gmail.com','12093213333',8,NULL);

--
-- Table structure for table `Venues`
--

DROP TABLE IF EXISTS `Venues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Venues` (
  `venueId` int NOT NULL AUTO_INCREMENT,
  `venueName` varchar(20) NOT NULL,
  `capacity` int DEFAULT NULL,
  `addressId` int NOT NULL,
  PRIMARY KEY (`venueId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Venues`
--

INSERT INTO `Venues` VALUES (1,'First Ave',1000,6),(2,'The Warfield',900,1),(3,'Hollywood Bowl',2000,2),(4,'Brooklyn Steel',1500,3),(5,'Stubs',NULL,4),(6,'Michigan Stadium',107601,5),(7,'Beaver Stadium',106572,7),(8,'Sanford Stadium',95723,8),(9,'Ohio Stadium',102780,9),(10,'AT&T Stadium',80000,10),(11,'Honda Center',18336,11),(12,'Golden 1 Center',17608,12),(13,'Oracle Park',41915,13),(14,'San Jose Civic',2850,14),(15,'Wells Fargo Arena',3000,15);
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-07 15:03:50
