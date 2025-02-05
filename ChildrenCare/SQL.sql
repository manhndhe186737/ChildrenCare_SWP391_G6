-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: swp391
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `email` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`email`),
  KEY `FK_Accounts_Users` (`user_id`),
  CONSTRAINT `FK_Accounts_Users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES ('davidbrown@gmail.com','123',3),('emilydavid@gmail.com','123',8),('ethancarter@example.com','123',16),('isabellacollins@example.com','123',19),('jamestayler@gmail.com','123',7),('jeniferwhite@gmail.com','123',10),('johnsmith@gmail.com','123',1),('liammitchell@example.com','123',18),('lisaandreson@gmail.com','123',6),('manh@gmail.com','123',11),('maryjohnson@gmail.com','123',2),('masonhughes@example.com','123',20),('michaellee@gmail.com','123',5),('robertmiler@gmail.com','123',9),('sarahwilson@gmail.com','123',4),('sophiabennett@example.com','123',17);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features`
--

DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `features` (
  `fid` int NOT NULL AUTO_INCREMENT,
  `fname` varchar(50) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` VALUES (1,'Service List','/service/list'),(2,'Service Detail','/service/detail'),(3,'User List','/user/list'),(4,'User Detail','/user/detail'),(5,'Reservation List','/reservation/list'),(6,'Reservation Detail','/reservation/detail'),(7,'Post List','/post/list'),(8,'Post Detail','/post/detail'),(9,'Customer List','/admin/customers'),(10,'Customer Detail','/customer/detail'),(11,'Add Customer','/admin/add-customer'),(12,'Edit Customer','/admin/editCustomer'),(13,'Remove Customer','/admin/removeCustomer');
/*!40000 ALTER TABLE `features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedbacks`
--

DROP TABLE IF EXISTS `feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedbacks` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `rating` varchar(50) DEFAULT NULL,
  `reserv_id` int DEFAULT NULL,
  `comment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`feedback_id`),
  KEY `FK_Feedback_Reservation` (`reserv_id`),
  CONSTRAINT `FK_Feedback_Reservation` FOREIGN KEY (`reserv_id`) REFERENCES `reservations` (`reserv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedbacks`
--

LOCK TABLES `feedbacks` WRITE;
/*!40000 ALTER TABLE `feedbacks` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedbacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `reserv_id` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `amount` char(10) DEFAULT NULL,
  `method` char(10) DEFAULT NULL,
  `status` char(10) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `FK_Payment_Reservation` (`reserv_id`),
  CONSTRAINT `FK_Payment_Reservation` FOREIGN KEY (`reserv_id`) REFERENCES `reservations` (`reserv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `content` varchar(50) DEFAULT NULL,
  `updatedate` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  `createdate` date DEFAULT NULL,
  `image` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `FK_Post_User` (`author_id`),
  CONSTRAINT `FK_Post_User` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'New Massage Services','Introducing our new massage services','2025-01-17',1,2,'2025-01-17','/images/massage.jpg','Services'),(2,'Skincare Tips','Essential skincare tips for winter','2025-01-17',1,3,'2025-01-17','/images/skincare.jpg','Beauty Tips');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `profile_id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `reserv_id` int NOT NULL AUTO_INCREMENT,
  `dateBook` date DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `service_id` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `createDate` date DEFAULT NULL,
  `updateDate` date DEFAULT NULL,
  `note` varchar(150) DEFAULT NULL,
  `starttime` date DEFAULT NULL,
  `endtime` date DEFAULT NULL,
  PRIMARY KEY (`reserv_id`),
  KEY `FK_Reservation_User` (`user_id`),
  KEY `FK_Reservation_User1` (`staff_id`),
  KEY `FK_Reservations_Service` (`service_id`),
  CONSTRAINT `FK_Reservation_User` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK_Reservation_User1` FOREIGN KEY (`staff_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK_Reservations_Service` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rolefeatures`
--

DROP TABLE IF EXISTS `rolefeatures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rolefeatures` (
  `role_id` int NOT NULL,
  `fid` int NOT NULL,
  PRIMARY KEY (`role_id`,`fid`),
  KEY `FK_RoleFeatures_Features` (`fid`),
  CONSTRAINT `FK_RoleFeatures_Features` FOREIGN KEY (`fid`) REFERENCES `features` (`fid`),
  CONSTRAINT `FK_RoleFeatures_Roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rolefeatures`
--

LOCK TABLES `rolefeatures` WRITE;
/*!40000 ALTER TABLE `rolefeatures` DISABLE KEYS */;
INSERT INTO `rolefeatures` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(2,7),(1,8),(2,8),(1,9),(1,10),(1,11),(1,12),(1,13);
/*!40000 ALTER TABLE `rolefeatures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin'),(2,'Marketing Staff'),(3,'Staff'),(4,'Customer');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedules` (
  `schedule_id` int NOT NULL AUTO_INCREMENT,
  `staff_id` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `start` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  `isAvailable` tinyint(1) DEFAULT NULL,
  `reservation_id` int DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`schedule_id`),
  UNIQUE KEY `UQ_Schedule_Reservation` (`reservation_id`),
  KEY `FK_Schedule_User` (`staff_id`),
  CONSTRAINT `FK_Schedule_Reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`reserv_id`),
  CONSTRAINT `FK_Schedule_User` FOREIGN KEY (`staff_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicecategories`
--

DROP TABLE IF EXISTS `servicecategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicecategories` (
  `category_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicecategories`
--

LOCK TABLES `servicecategories` WRITE;
/*!40000 ALTER TABLE `servicecategories` DISABLE KEYS */;
INSERT INTO `servicecategories` VALUES (1,'Massage Therapy','Various massage techniques for relaxation'),(2,'Facial Treatment','Facial care and skin treatments');
/*!40000 ALTER TABLE `servicecategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `service_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`service_id`),
  KEY `FK_Service_ServiceCategories` (`category_id`),
  CONSTRAINT `FK_Service_ServiceCategories` FOREIGN KEY (`category_id`) REFERENCES `servicecategories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Massage','Full body relaxation massage',80,1),(2,'Babysitting','Basic facial treatment',65,2);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sliders`
--

DROP TABLE IF EXISTS `sliders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sliders` (
  `slider_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `image` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `createdate` date DEFAULT NULL,
  `updatedate` date DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  `visibility` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`slider_id`),
  KEY `FK_Sliders_User` (`author_id`),
  CONSTRAINT `FK_Sliders_User` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sliders`
--

LOCK TABLES `sliders` WRITE;
/*!40000 ALTER TABLE `sliders` DISABLE KEYS */;
INSERT INTO `sliders` VALUES (1,'Welcome to Our Spa','/sliders/welcome.jpg',1,'2025-01-17','2025-01-17',2,1),(2,'Special Winter Offers','/sliders/winter.jpg',1,'2025-01-17','2025-01-17',3,1),(3,'Welcome to Our Spa','/sliders/welcome.jpg',1,'2025-01-17','2025-01-17',2,1),(4,'Special Winter Offers','/sliders/winter.jpg',1,'2025-01-17','2025-01-17',3,1);
/*!40000 ALTER TABLE `sliders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staffprofiles`
--

DROP TABLE IF EXISTS `staffprofiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staffprofiles` (
  `staff_profile_id` int NOT NULL AUTO_INCREMENT,
  `experience` varchar(200) DEFAULT NULL,
  `certification` varchar(200) DEFAULT NULL,
  `specialties` varchar(200) DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  PRIMARY KEY (`staff_profile_id`),
  KEY `FK_StaffProfiles_Users` (`staff_id`),
  CONSTRAINT `FK_StaffProfiles_Users` FOREIGN KEY (`staff_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staffprofiles`
--

LOCK TABLES `staffprofiles` WRITE;
/*!40000 ALTER TABLE `staffprofiles` DISABLE KEYS */;
INSERT INTO `staffprofiles` VALUES (1,'5 years in massage therapy','Licensed Massage Therapist','Swedish, Deep Tissue',2),(2,'8 years in skincare','Licensed Esthetician','Anti-aging, Acne Treatment',3),(3,'5 years in massage therapy','Licensed Massage Therapist','Swedish, Deep Tissue',2),(4,'8 years in skincare','Licensed Esthetician','Anti-aging, Acne Treatment',3);
/*!40000 ALTER TABLE `staffprofiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userroles`
--

DROP TABLE IF EXISTS `userroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userroles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`role_id`,`email`),
  KEY `FK_UserRoles_Accounts` (`email`),
  CONSTRAINT `FK_UserRoles_Accounts` FOREIGN KEY (`email`) REFERENCES `accounts` (`email`),
  CONSTRAINT `FK_UserRoles_Roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userroles`
--

LOCK TABLES `userroles` WRITE;
/*!40000 ALTER TABLE `userroles` DISABLE KEYS */;
INSERT INTO `userroles` VALUES (3,'davidbrown@gmail.com'),(3,'emilydavid@gmail.com'),(4,'ethancarter@example.com'),(4,'isabellacollins@example.com'),(3,'jamestayler@gmail.com'),(3,'jeniferwhite@gmail.com'),(4,'liammitchell@example.com'),(4,'lisaandreson@gmail.com'),(1,'manh@gmail.com'),(2,'maryjohnson@gmail.com'),(4,'masonhughes@example.com'),(4,'michaellee@gmail.com'),(4,'robertmiler@gmail.com'),(4,'sarahwilson@gmail.com'),(4,'sophiabennett@example.com');
/*!40000 ALTER TABLE `userroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `avatar` varchar(300) DEFAULT NULL,
  `gender` tinyint DEFAULT NULL,
  `isActive` tinyint DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'John Smith','123 Main St, Boston','1990-01-15','123-456-7890','man-02.jpg',1,1),(2,'Mary Johnson','456 Oak Ave, Chicago','1985-03-22','234-567-8901','wm-07',1,1),(3,'David Brown','789 Pine Rd, Seattle','1988-07-30','345-678-9012','man-01.jpg',1,1),(4,'Sarah Wilson','321 Elm St, Denver','1992-11-06','456-789-0126','01.jpg',1,1),(5,'Michael Lee','654 Maple Dr, Austin','1987-09-18','567-890-1234','03.jpg',0,1),(6,'Lisa Anderson','987 Cedar Ln, Portland','1993-04-25','678-901-2345','wm-02.jpg',0,1),(7,'James Taylor','147 Birch Rd, Miami','1986-12-08','789-012-3456','wm-03.jpg',0,1),(8,'Emily Davis','258 Walnut St, Houston','1991-06-14','890-123-4567','wm-04.jpg',0,1),(9,'Robert Miller','369 Pine Ave, Phoenix','1989-02-28','901-234-5678','man-03.jpg',1,1),(10,'Jennifer White','741 Oak Rd, Atlanta','1994-08-11','012-345-6789','man-04.jpg',1,1),(11,'Manh','741 Oak Rd, Atlanta','1994-08-11','012-345-6789','x',1,1),(12,'Manh','X','1990-09-11','012-345-6789','x',1,1),(13,'John Michael','HN','1990-04-20','123-456-7891','x',1,1),(14,'John Michael','HN','1990-04-20','123-456-7891','x',NULL,1),(16,'Ethan Carter','125 Maple Street, Springfield','2025-02-06','901-234-5678','man-05.jpg',1,1),(17,'Sophia Bennett','42 Elm Avenue, Los Angeles','1998-02-05',NULL,'man-06.jpg',1,1),(18,'Liam Mitchell','78 Oak Lane, Austin',NULL,NULL,'man-07.jpg',1,1),(19,'Isabella Collins','301 Birch Road, Denver',NULL,NULL,'man-06.jpg',0,1),(20,'Mason Hughes','14 Cedar Court, Seattle',NULL,NULL,'wm-05.jpg',0,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-05 19:54:35
