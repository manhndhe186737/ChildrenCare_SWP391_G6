CREATE DATABASE  IF NOT EXISTS `swp391_fix` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `swp391_fix`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: swp391_fix
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
-- Table structure for table `blog_details`
--

DROP TABLE IF EXISTS `blog_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_details` (
  `detail_id` int NOT NULL AUTO_INCREMENT,
  `blog_id` int NOT NULL,
  `content` text NOT NULL,
  `section_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`detail_id`),
  KEY `blog_id` (`blog_id`),
  CONSTRAINT `blog_details_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`blog_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_details`
--

LOCK TABLES `blog_details` WRITE;
/*!40000 ALTER TABLE `blog_details` DISABLE KEYS */;
INSERT INTO `blog_details` VALUES (1,1,'Nothing here',NULL),(2,2,'Nothing here',NULL),(3,3,'Nothing here',NULL),(4,4,'Nothing here',NULL),(5,5,'Nothing here',NULL),(6,6,'Nothing here',NULL);
/*!40000 ALTER TABLE `blog_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogs` (
  `blog_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `author_id` int NOT NULL,
  `status` tinyint(1) DEFAULT '1',
  `featured_image` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`blog_id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `blogs_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogs`
--

LOCK TABLES `blogs` WRITE;
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
INSERT INTO `blogs` VALUES (1,'The Benefits of Regular Massage','Regular massage therapy offers numerous heal','2025-02-11 03:44:31','2025-02-12 14:49:51',28,1,'01.jpg',NULL,NULL,NULL),(2,'Skincare Tips for Winter','Winter weather can be harsh on your skin','2025-02-08 03:45:33','2025-02-12 10:59:26',28,1,'02.jpg',NULL,NULL,NULL),(3,'The Benefits of Regular Massage','Winter weather can be harsh on your skin','2025-02-08 03:46:33','2025-02-12 10:59:26',28,1,'03.jpg',NULL,NULL,NULL),(4,'Skincare Tips for Winter','Winter weather can be harsh on your skin','2025-02-08 03:47:33','2025-02-12 10:59:26',28,1,'04.jpg',NULL,NULL,NULL),(5,'The Benefits of Regular Massage','The Benefits of Regular Massage','2025-02-08 03:48:33','2025-02-12 10:59:26',28,1,'05.jpg',NULL,NULL,NULL),(6,'Skincare Tips for Winter','Winter weather can be harsh on your skin','2025-02-09 03:44:33','2025-02-12 10:59:26',28,1,'06.jpg',NULL,NULL,NULL),(7,'Skincare Tips for Winter','Winter weather can be harsh on your skin','2025-02-10 03:44:33','2025-02-12 10:59:26',28,1,'07.jpg',NULL,NULL,NULL),(8,'Skincare Tips for Winter','Winter weather can be harsh on your skin','2025-02-08 03:44:33','2025-02-09 11:53:08',28,1,'08.jpg',NULL,NULL,NULL),(9,'Skincare Tips for Winter','Winter weather can be harsh on your skin','2025-02-08 03:44:33','2025-02-09 11:53:08',28,1,'09.jpg',NULL,NULL,NULL);
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` VALUES (1,'Service List','/service/list'),(2,'Service Detail','/service/detail'),(3,'User List','/user/list'),(4,'User Detail','/user/detail'),(5,'Reservation List','/reservation/list'),(6,'Reservation Detail','/reservation/detail'),(7,'Post List','/post/list'),(8,'Post Detail','/post/detail'),(9,'Customer List','/admin/customers'),(10,'Customer Detail','/customer/detail'),(11,'Add Customer','/admin/add-customer'),(12,'Edit Customer','/admin/editCustomer'),(13,'Remove Customer','/admin/removeCustomer'),(14,'List Staff','/admin/staff'),(15,'Staff Profile','/admin/staff-profile'),(16,'Staff Dashboard','/c/staff-dashboard'),(17,'Admin Dashboard','/admin/dashboard'),(18,'Add Staff','/admin/add-staff'),(19,'Update Staff','/admin/update-staff'),(20,'Post List','/post-list'),(21,'Post View','/post-view'),(22,'Post Edit','/post-edit'),(23,'Post Add','/post-add'),(24,'Slider List Manage','/slider'),(25,'Slider Edit','/slider-edit'),(26,'Delete Staff','/admin/delete-staff'),(27,'Booking Service','/booking-reserv');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'New Massage Services','Introducing our new massage services','2025-02-12',1,28,'2025-01-17','uploads/gettinghome.jpg','Services'),(2,'Skincare Tips','Essential skincare tips for winter','2025-02-12',1,28,'2025-01-17','uploads/wintercare.jpg','Beauty Tips'),(3,'New 1','ff','2025-02-13',1,28,'2025-02-08','uploads/hero.png','Beauty Tips'),(4,'EE','rr','2025-02-11',1,28,'2025-02-09','uploads/kidharcut.jpg','Services'),(5,'Getting home','Getting home..','2025-02-12',1,28,'2025-02-10','uploads/gettinghome.jpg','Beauty Tips'),(6,'Teaching','Teaching....','2025-02-12',0,28,'2025-02-10','uploads/sporting.jpg','Services'),(7,'Kid Haircut','Hair cut....','2025-02-12',1,28,'2025-02-11','uploads/kidharcut.jpg','Services');
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
  `starttime` time DEFAULT NULL,
  `endtime` time DEFAULT NULL,
  PRIMARY KEY (`reserv_id`),
  KEY `FK_Reservation_User` (`user_id`),
  KEY `FK_Reservation_User1` (`staff_id`),
  KEY `FK_Reservations_Service` (`service_id`),
  CONSTRAINT `FK_Reservation_User` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK_Reservation_User1` FOREIGN KEY (`staff_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK_Reservations_Service` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (1,'2024-10-01',1,1,NULL,3,'2024-10-01',NULL,NULL,'10:00:00','12:00:00'),(3,'2024-10-01',2,2,NULL,3,'2024-10-01',NULL,NULL,'13:00:00','14:00:00'),(4,'2024-10-01',4,1,NULL,8,'2024-10-01',NULL,NULL,'08:00:00','10:00:00'),(5,'2024-10-01',5,2,NULL,7,'2024-10-01',NULL,NULL,'07:00:00','08:00:00'),(6,'2024-10-01',6,2,NULL,10,'2024-10-01',NULL,NULL,'11:00:00','13:00:00'),(7,'2024-10-01',9,1,NULL,3,'2024-10-01',NULL,NULL,'07:00:00','09:00:00');
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
INSERT INTO `rolefeatures` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(2,7),(1,8),(2,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(3,16),(1,17),(1,18),(1,19),(2,20),(2,21),(2,22),(2,23),(2,24),(2,25),(1,26),(4,27);
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
INSERT INTO `servicecategories` VALUES (1,'Massage Therapy','Various massage techniques for relaxation'),(2,'Facial Treatment','Facial care and skin treatments'),(3,'Massage & Therapy','Relaxing massages and therapy services'),(4,'Facial & Skincare','Professional skincare treatments'),(5,'Babysitting Services','Safe and reliable babysitting services'),(6,'Kids Haircuts','Haircuts designed for children'),(7,'Special Skin Treatments','Special skincare for sensitive skin');
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
  `img` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`service_id`),
  KEY `FK_Service_ServiceCategories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Massage','Full body relaxation massage',80,1,NULL),(2,'Babysitting','Basic facial treatment',65,2,NULL),(3,'Gentle Kids Massage','Soothing full-body massage for kids',50,3,NULL),(4,'Aromatherapy for Kids','Relaxing essential oil therapy for children',55,3,NULL),(5,'Hydrating Facial','Moisturizing facial treatment for young skin',40,4,NULL),(6,'Acne Care for Teens','Special acne treatment for teenagers',60,4,NULL),(7,'Evening Babysitting','Reliable babysitting services for evenings',30,5,NULL),(8,'Weekend Babysitting','Weekend babysitting services at your convenience',35,5,NULL),(9,'Quick Kids Haircut','Fast and stylish haircut for kids',20,6,NULL),(10,'Deluxe Kids Haircut','Includes styling and gentle scalp massage',30,6,NULL),(11,'Sensitive Skin Care','Special skincare treatment for sensitive skin',45,7,NULL),(12,'Sun Protection Facial','SPF-based facial care for kids',50,7,NULL);
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
  `backlink` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`slider_id`),
  KEY `FK_Sliders_User` (`author_id`),
  CONSTRAINT `FK_Sliders_User` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sliders`
--

LOCK TABLES `sliders` WRITE;
/*!40000 ALTER TABLE `sliders` DISABLE KEYS */;
INSERT INTO `sliders` VALUES (1,'Welcome to Our Spa','uploads/kidharcut.jpg',1,'2025-01-17','2025-02-12',2,1,NULL),(2,'Special Winter Offers','uploads/gettinghome.jpg',1,'2025-01-17','2025-02-13',3,1,NULL),(3,'Welcome to Our Spa','uploads/wintercare.jpg',1,'2025-01-17','2025-02-13',2,1,NULL),(4,'Special Winter Offers1','/sliders/winter.jpg',0,'2025-01-17','2025-02-10',3,1,NULL),(5,'Getting Home 1 - Manh Nguyen','/assets/images/posts/gettinghome.jpg',0,'2025-02-08','2025-02-11',1,1,NULL),(6,'Kid Haircut','/assets/images/posts/kidhaircut.jpg',0,'2025-02-08','2025-02-08',1,1,NULL),(7,'Massage','/assets/images/posts/massage.jpg',0,'2025-02-08','2025-02-08',2,1,NULL),(8,'New Massage','/assets/images/posts/newmassage.jpg',0,'2025-02-08','2025-02-08',2,1,NULL),(9,'Sporting','/assets/images/posts/sporting.jpg',0,'2025-02-08','2025-02-08',3,1,NULL),(10,'Teaching','/assets/images/posts/teaching.jpg',0,'2025-02-08','2025-02-08',3,1,NULL),(11,'Winter Care','/assets/images/posts/wintercare.jpg',0,'2025-02-08','2025-02-08',3,1,NULL),(12,'Getting Home','/assets/images/posts/gettinghome.jpg',0,'2025-02-08','2025-02-08',1,1,NULL),(13,'Kid Haircut','/assets/images/posts/kidhaircut.jpg',0,'2025-02-08','2025-02-08',1,1,NULL),(14,'Massage','/assets/images/posts/massage.jpg',0,'2025-02-08','2025-02-08',2,1,NULL),(15,'New Massage','/assets/images/posts/newmassage.jpg',0,'2025-02-08','2025-02-08',2,1,NULL),(16,'Sporting','uploads/teaching.jpg',0,'2025-02-08','2025-02-12',3,1,NULL),(17,'Teaching','/assets/images/posts/teaching.jpg',0,'2025-02-08','2025-02-08',3,1,NULL),(18,'Winter Care','/assets/images/posts/wintercare.jpg',0,'2025-02-08','2025-02-08',3,1,NULL);
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
  `exp_start` varchar(55) DEFAULT NULL,
  `exp_end` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`staff_profile_id`),
  KEY `FK_StaffProfiles_Users` (`staff_id`),
  CONSTRAINT `FK_StaffProfiles_Users` FOREIGN KEY (`staff_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staffprofiles`
--

LOCK TABLES `staffprofiles` WRITE;
/*!40000 ALTER TABLE `staffprofiles` DISABLE KEYS */;
INSERT INTO `staffprofiles` VALUES (1,'Massage therapy','Licensed Massage Therapist','Swedish, Deep Tissue',2,'2018','2019'),(2,'Skincare','Licensed Esthetician','Anti-aging, Acne Treatment',3,'2018','2019'),(5,'Massage therapy','Licensed Massage Therapist','Anti-aging, Acne Treatment',8,'2018','2019'),(6,'Massage therapy','Licensed Esthetician','Swedish, Deep Tissue',10,'2018','2019'),(7,'Massage therapy','Licensed Massage Therapist','Swedish, Deep Tissue',7,'2018','2019'),(8,'Haircut','Licensed','Haircut',3,'2018','2019'),(9,'Massage','Massage','Massage',3,'2018','2019');
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
  CONSTRAINT `FK_UserRoles_Roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`),
  CONSTRAINT `fk_userroles_users` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userroles`
--

LOCK TABLES `userroles` WRITE;
/*!40000 ALTER TABLE `userroles` DISABLE KEYS */;
INSERT INTO `userroles` VALUES (3,'davidbrown@gmail.com'),(3,'emilydavid@gmail.com'),(4,'ethancarter@example.com'),(2,'hoangnl1811@gmail.com'),(4,'hoangnlhe186662@fpt.edu.vn'),(4,'isabellacollins@example.com'),(3,'jamestayler@gmail.com'),(3,'jeniferwhite@gmail.com'),(4,'liammitchell@example.com'),(4,'lisaandreson@gmail.com'),(4,'manhndhe186737@fpt.edu.vn'),(4,'manhnguyenduc153@gmail.com'),(1,'manhvipyb1@gmail.com'),(2,'maryjohnson@gmail.com'),(4,'masonhughes@example.com'),(4,'michaellee@gmail.com'),(4,'robertmiler@gmail.com'),(4,'sarahwilson@gmail.com'),(4,'sophiabennett@example.com'),(4,'vucongthang2101@gmail.com');
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
  `is_verified` tinyint DEFAULT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'John Smithh','123 Main St, Boston','1990-01-15','123-456-7890','man-02.jpg',1,1,1,NULL,'johnsmith@gmail.com','123456'),(2,'Mary Johnson','456 Oak Ave, Chicago','1985-03-22','234-567-8901','wm-07.jpg',1,1,NULL,NULL,'maryjohnson@gmail.com','123'),(3,'David BrownNN','14 Cedar CourtT','2025-02-19','1234567890','staff/staff10.jpg',1,1,NULL,'Nothing here.....h','davidbrown@gmail.com','123'),(4,'Sarah WilsonNN','321 Elm St, Denver','1992-11-20','456-789-0126','client/01.jpg',0,1,NULL,NULL,'sarahwilson@gmail.com','123'),(5,'Michael Lee','654 Maple Dr, Austin','1987-09-18','567-890-1234','client/03.jpg',0,1,NULL,NULL,'michaellee@gmail.com','123'),(6,'Lisa Anderson','987 Cedar Ln, Portland','1993-04-25','678-901-2345','client/02.jpg',0,1,NULL,NULL,'lisaandreson@gmail.com','123'),(7,'James Taylor','147 Birch Rd, Miami','1986-12-08','789-012-3456','staff/staff03.jpg',0,1,NULL,NULL,'jamestayler@gmail.com','123'),(8,'Emily Davis','258 Walnut St, Houston','1991-06-14','890-123-4567','staff/staff04.jpg',0,1,NULL,NULL,'emilydavid@gmail.com','123'),(9,'Robert Miller','369 Pine Ave, Phoenix','1989-02-28','901-234-5678','client/03.jpg',1,1,NULL,NULL,'robertmiler@gmail.com','123'),(10,'Jennifer WhiteE','741 Oak Rd, Atlanta','1994-08-11','012-345-6789','staff/staff01.jpg',1,1,NULL,'','jeniferwhite@gmail.com','123'),(11,'Manh','741 Oak Rd, Atlanta','1994-08-11','012-345-6789','x',1,1,1,NULL,'manh@gmail.com','123'),(12,'Manh','X','1990-09-11','012-345-6789','x',1,1,1,NULL,NULL,NULL),(13,'John Michael','HN','1990-04-20','123-456-7891','x',1,1,NULL,NULL,NULL,NULL),(14,'John Michael','HN','1990-04-20','123-456-7891','x',NULL,1,NULL,NULL,NULL,NULL),(16,'Ethan Carter','125 Maple Street, Springfield','2025-02-06','901-234-5678','client/05.jpg',1,0,NULL,NULL,'ethancarter@example.com','123'),(17,'Sophia Bennett','42 Elm Avenue, Los Angeles','1998-02-05',NULL,'client/06.jpg',1,1,NULL,NULL,'sophiabennett@example.com','123'),(18,'Liam Mitchell','78 Oak Lane, Austin',NULL,NULL,'client/10.jpg',1,1,NULL,NULL,'liammitchell@example.com','123'),(19,'Isabella Collins','301 Birch Road, Denver',NULL,NULL,'client/06.jpg',0,1,NULL,NULL,'isabellacollins@example.com','123'),(20,'Mason Hughes','14 Cedar Court, Seattle','2025-02-01',NULL,'client/09.jpg',0,0,NULL,NULL,'masonhughes@example.com','123'),(26,'Nguyen Manh','Yen Bai','2025-02-01','123','client/08.jpg',1,1,1,NULL,'manhvipyb1@gmail.com','y9+6lWNO8KV31kJNRTveQA==$/EKfggqXUdVupwL/C7h1TUzT3SFibbefKzze442yCeHPXvax5bGpxaMxhNAWJeMi5mWWrRUWKYOUNTG1ZmfshA=='),(27,'Staff','yb','2025-02-01','12345','staff/staff02.jpg',NULL,NULL,1,NULL,'',''),(28,'Hoang','BG','2025-02-07','12345','staff/staff04.jpg',NULL,NULL,1,NULL,'hoangnl1811@gmail.com','e9JQeikN8Hi/HUfqtGfbkQ==$EJsljB/wUqVDd2utLr0scWtgIX1dPuI2Oa57IF4cKGBi5G+VzKm07pDriTr2ibcta+eX2ZQtWArzeQrv9UuqcA=='),(29,'Thang','Me Linh, Hanoi','2025-02-01','0372362911','/assets/images/avatar.jpg',NULL,NULL,1,NULL,'vucongthang2101@gmail.com','AYjGku/6cYVBP4zesS49BQ==$cqtXPM+kSUpwF6gY478qbi7aZgXKbVvkq56UEC504c9uaJM+vqQUTCdKAN+iN0Ri4Dr9ilFq2bdSNIQaDZB1bw=='),(30,'Thang','Me Linh, Hanoi','2025-02-01','0372362911','/assets/images/avatar.jpg',NULL,NULL,0,NULL,NULL,NULL),(31,'Johnson Nguyen','789 Pine Rd, SeattleE','2025-02-01','12345',NULL,NULL,NULL,1,NULL,'hoangnlhe186662@fpt.edu.vn','MI9tCV2tDXyp0JUpiyU6+A==$42HNYwxVwhbk8eYaTepO6WBTgUUhtATzv3B8suD5qY52xlEsICb32iZxNTmmemTKJ6de8ybhJkz5mICl3cs8rw=='),(32,'Nguyen Duc Manh (K18 HL)','14 Cedar Court','2025-02-01','12345','/assets/images/avatar.jpg',NULL,NULL,0,NULL,'manhndhe186737@fpt.edu.vn','DGulGSPdINrOc/LH+hBhmg==$EtjNO2j3FuRRh5t2cgQarYAfiqjWe0TCIE6kXxQbKbT5C8NnvVVY+hc7KcGOc7eN4cy2MC4+4fss+L9fMEguow=='),(38,'Manh Nguyen Duc','Me Linh, Hanoi','2025-02-01','1234381689',NULL,NULL,NULL,1,NULL,'manhnguyenduc153@gmail.com','tJ/Vdpr+SxxNqPg2gM2Ttw==$4aCK8J3gIhk8TTn4YGNQP8m0ErystvbmTJAoJ7fz7oQUNsFVRIsJMZs2UYpIXWUNvHRxD7rwjB7Bsp+57z5/cQ==');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verification_tokens`
--

DROP TABLE IF EXISTS `verification_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verification_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `expiry_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verification_tokens`
--

LOCK TABLES `verification_tokens` WRITE;
/*!40000 ALTER TABLE `verification_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `verification_tokens` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-16 21:01:51
