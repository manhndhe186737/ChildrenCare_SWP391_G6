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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `service_id` int NOT NULL,
  `quantity` int DEFAULT '1',
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (24,38,3,1,'2025-03-09 16:19:08'),(25,38,6,1,'2025-03-28 10:42:45'),(27,50,3,1,'2025-03-28 14:05:50'),(28,50,2,1,'2025-03-28 14:05:53');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
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
  `active` tinyint DEFAULT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` VALUES (1,'Service List','/service/list',1),(2,'Service Detail','/service/detail',1),(3,'User List','/user/list',1),(4,'User Detail','/user/detail',1),(5,'Reservation List','/reservation/list',1),(6,'Reservation Detail','/reservation/detail',1),(7,'Post List','/post/list',1),(8,'Post Detail','/post/detail',1),(9,'Customer List','/admin/customers',1),(10,'Customer Detail','/customer/detail',1),(11,'Add Customer','/admin/add-customer',1),(12,'Edit Customer','/admin/editCustomer',1),(13,'Remove Customer','/admin/removeCustomer',1),(14,'List Staff','/admin/staff',1),(15,'Staff Profile','/admin/staff-profile',1),(16,'Staff Dashboard','/c/staff-dashboard',1),(17,'Admin Dashboard','/admin/dashboard',1),(18,'Add Staff','/admin/add-staff',1),(19,'Update Staff','/admin/update-staff',1),(20,'Post List','/post-list',1),(21,'Post View','/post-view',1),(22,'Post Edit','/post-edit',1),(23,'Post Add','/post-add',1),(24,'Slider List Manage','/slider',1),(25,'Slider Edit','/slider-edit',1),(26,'Delete Staff','/admin/delete-staff',1),(27,'Booking Service','/c/booking-reserv',1),(28,'Booking Staff','/c/BookingStaff',1),(29,'Cart','/c/Cart',1),(30,'Add To Cart','/AddToCart',1),(31,'Delete Cart','/c/deleteCart',1),(32,'My Reservation','/myreservation',1),(33,'Service List Manager','/admin/ServiceListServlet',1),(34,'Service Detail','/admin/serviceDetails',1),(35,'Add Slider','/slider-add',1),(36,'Reservation Infor','/reserv-infor',1),(39,'Staff Reservation','/c/staff-reserv',1),(40,'Feedback List','/feedbacklist',1),(41,'Staff Feedback','/c/staff-feedback',1),(42,'Setting','/admin/settings',1),(43,'Access Granting','/admin/authorization',1),(44,'Post Setting','/admin/settings-postcategory',1),(45,'Service Setting','/admin/settings-servicecategory',1);
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
  `img` varchar(255) DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `reply` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`feedback_id`),
  KEY `FK_Feedback_Reservation` (`reserv_id`),
  CONSTRAINT `FK_Feedback_Reservation` FOREIGN KEY (`reserv_id`) REFERENCES `reservations` (`reserv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedbacks`
--

LOCK TABLES `feedbacks` WRITE;
/*!40000 ALTER TABLE `feedbacks` DISABLE KEYS */;
INSERT INTO `feedbacks` VALUES (1,'2025-03-19','4',88,'ok',NULL,1,'Heheheh'),(2,'2025-03-15','1',97,'Dich vu qua te, nhan vien khong lich su','uploads/Unlock Your Child’s Potential with Early Intervention.jpg',1,'cam on vi da den'),(3,'2025-03-18','1',98,'Dich vu nay khong ra gi, toi khong thoai mai',NULL,1,'Ke ban'),(4,'2025-03-23','5',109,'ddddfffffffffffffffffffffffffddddffffffffff',NULL,1,'ccc'),(5,'2025-03-23','4',86,'Cung tam on, khong ok lam, rat ok','uploads/10.jpg',1,'Khong tot lam'),(6,'2025-03-23','2',54,'Dich vu rat tuyet voi','uploads/Father\'s success after quitting banking for children\'s hairdressing.jpg',1,'toi rat vui vi ban thay tuyet voi'),(7,'2025-03-27','3',112,'','uploads/04.jpg',1,'ok dayyyyyyhhh'),(8,'2025-03-27','5',110,'',NULL,1,NULL);
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
  `amount` float DEFAULT NULL,
  `method` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `FK_Payment_Reservation` (`reserv_id`),
  CONSTRAINT `FK_Payment_Reservation` FOREIGN KEY (`reserv_id`) REFERENCES `reservations` (`reserv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,34,'2025-03-09',1880000,'COD','Paid'),(7,41,'2025-03-09',1410000,'COD','Paid'),(9,54,'2025-03-09',705000,'COD','Paid'),(10,65,'2025-03-09',1527500,'Online banking','Paid'),(11,66,'2025-03-09',822500,'COD','Paid'),(12,67,'2025-03-09',1410000,'Online banking','Paid'),(13,68,'2025-03-09',705000,'COD','Paid'),(14,69,'2025-03-09',1410000,'Online banking','Paid'),(31,86,'2025-03-10',1880000,'Online banking','Paid'),(33,88,'2025-03-12',940000,'COD','Paid'),(34,89,'2025-03-12',1880000,'Online banking','Paid'),(35,90,'2025-03-13',1527500,'COD','Unpaid'),(36,91,'2025-03-13',1880000,'COD','Unpaid'),(37,92,'2025-03-15',1410000,'COD','Unpaid'),(38,93,'2025-03-15',1880000,'Online banking','Paid'),(39,94,'2025-03-19',1410000,'Online banking','Paid'),(40,95,'2025-03-19',1880000,'COD','Unpaid'),(41,96,'2025-03-19',1410000,'Online banking','Paid'),(42,97,'2025-03-19',1880000,'Online banking','Paid'),(43,98,'2025-03-19',1880000,'COD','Paid'),(44,99,'2025-03-20',822500,'Online banking','Paid'),(45,100,'2025-03-23',1880000,'Online banking','Paid'),(46,101,'2025-03-23',1410000,'COD','Unpaid'),(47,102,'2025-03-23',1410000,'COD','Unpaid'),(48,103,'2025-03-23',1410000,'COD','Unpaid'),(49,104,'2025-03-23',1410000,'COD','Unpaid'),(50,105,'2025-03-23',1410000,'COD','Unpaid'),(51,106,'2025-03-23',1410000,'COD','Unpaid'),(52,107,'2025-03-23',705000,'Online banking','Paid'),(53,108,'2025-03-23',1880000,'Online banking','Paid'),(54,109,'2025-03-23',1880000,'COD','Paid'),(55,110,'2025-03-23',1880000,'COD','Paid'),(56,111,'2025-03-24',1880000,'Online banking','Paid'),(57,112,'2025-03-24',1880000,'Online banking','Paid'),(58,113,'2025-03-27',1880000,'COD','Unpaid'),(59,114,'2025-03-27',940000,'Online banking','Paid'),(60,115,'2025-03-27',1880000,'Online banking','Paid'),(61,116,'2025-03-28',940000,'Online banking','Paid'),(62,117,'2025-03-28',940000,'COD','Paid'),(63,118,'2025-03-28',1880000,'Online banking','Paid'),(64,119,'2025-03-28',1880000,'COD','Unpaid'),(65,120,'2025-03-29',1880000,'Online banking','Paid'),(66,121,'2025-03-29',1880000,'COD','Unpaid'),(67,122,'2025-03-29',1880000,'Online banking','Paid'),(68,123,'2025-03-29',1880000,'COD','Paid');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postcategories`
--

DROP TABLE IF EXISTS `postcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `postcategories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postcategories`
--

LOCK TABLES `postcategories` WRITE;
/*!40000 ALTER TABLE `postcategories` DISABLE KEYS */;
INSERT INTO `postcategories` VALUES (1,'Massage & Therapy','',1),(2,'Facial & Skincare',NULL,1),(3,'Babysitting Services',NULL,1),(4,'Kids Haircuts',NULL,1),(5,'Special Skin Treatments',NULL,1);
/*!40000 ALTER TABLE `postcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` longtext,
  `updatedate` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  `createdate` date DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `FK_Post_User` (`author_id`),
  KEY `FK_Posts_PostCategories` (`category_id`),
  CONSTRAINT `FK_Post_User` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK_Posts_PostCategories` FOREIGN KEY (`category_id`) REFERENCES `postcategories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'New Massage Services','','2025-03-27',1,28,'2025-01-17','uploads/newmassage.jpg',3),(2,'Skincare Tips','<h3 class=\"\" data-start=\"0\" data-end=\"47\"><strong>Skin Care Tips for Healthy and Glowing Skin</strong></h3>\r\n<p class=\"\" data-start=\"49\" data-end=\"208\">Taking care of your skin is essential for maintaining its health and radiance. Here are some key skin care tips to keep your skin looking youthful and glowing.</p>\r\n<ol data-start=\"210\" data-end=\"1561\">\r\n<li class=\"\" data-start=\"210\" data-end=\"361\">\r\n<p class=\"\" data-start=\"213\" data-end=\"361\"><strong data-start=\"213\" data-end=\"226\">Cleansing</strong>: Always start your skincare routine with a gentle cleanser to remove dirt, oil, and makeup. This helps prevent clogged pores and acne.</p>\r\n</li>\r\n<li class=\"\" data-start=\"366\" data-end=\"517\">\r\n<p class=\"\" data-start=\"369\" data-end=\"517\"><strong data-start=\"369\" data-end=\"385\">Moisturizing</strong>: Keep your skin hydrated by using a good moisturizer. Choose one that suits your skin type, whether it\'s oily, dry, or combination.</p>\r\n</li>\r\n<li class=\"\" data-start=\"519\" data-end=\"669\">\r\n<p class=\"\" data-start=\"522\" data-end=\"669\"><strong data-start=\"522\" data-end=\"540\">Sun Protection</strong>: Never skip sunscreen, even on cloudy days. Apply a broad-spectrum SPF of at least 30 to protect your skin from harmful UV rays.</p>\r\n</li>\r\n<li class=\"\" data-start=\"671\" data-end=\"856\">\r\n<p class=\"\" data-start=\"674\" data-end=\"856\"><strong data-start=\"674\" data-end=\"690\">Healthy Diet</strong>: Eating a balanced diet rich in antioxidants, vitamins, and minerals can improve your skin&rsquo;s appearance from within. Include plenty of fruits, vegetables, and water.</p>\r\n</li>\r\n<li class=\"\" data-start=\"858\" data-end=\"1002\">\r\n<p class=\"\" data-start=\"861\" data-end=\"1002\"><strong data-start=\"861\" data-end=\"876\">Exfoliation</strong>: Gently exfoliate your skin once or twice a week to remove dead skin cells, which helps promote cell renewal and smooth skin.</p>\r\n</li>\r\n<li class=\"\" data-start=\"1004\" data-end=\"1140\">\r\n<p class=\"\" data-start=\"1007\" data-end=\"1140\"><strong data-start=\"1007\" data-end=\"1025\">Adequate Sleep</strong>: Quality sleep is crucial for skin repair. Aim for 7-9 hours of sleep each night to allow your skin to rejuvenate.</p>\r\n</li>\r\n<li class=\"\" data-start=\"1142\" data-end=\"1298\">\r\n<p class=\"\" data-start=\"1145\" data-end=\"1298\"><strong data-start=\"1145\" data-end=\"1162\">Avoid Smoking</strong>: Smoking accelerates skin aging and reduces blood flow, leading to dull, dry skin. Quitting smoking can improve your skin\'s appearance.</p>\r\n</li>\r\n<li class=\"\" data-start=\"1300\" data-end=\"1407\">\r\n<p class=\"\" data-start=\"1303\" data-end=\"1407\"><strong data-start=\"1303\" data-end=\"1316\">Hydration</strong>: Drink plenty of water throughout the day to keep your skin hydrated and flush out toxins.</p>\r\n</li>\r\n<li class=\"\" data-start=\"1409\" data-end=\"1561\">\r\n<p class=\"\" data-start=\"1412\" data-end=\"1561\"><strong data-start=\"1412\" data-end=\"1433\">Stress Management</strong>: High levels of stress can lead to skin issues like acne and eczema. Practice relaxation techniques such as yoga or meditation.</p>\r\n</li>\r\n</ol>\r\n<p class=\"\" data-start=\"1563\" data-end=\"1656\">By following these simple skin care tips, you can achieve and maintain healthy, glowing skin.</p>','2025-03-28',1,28,'2025-01-17','uploads/gettinghome.jpg',2),(6,'The Power of Teaching','<h3 class=\"\" data-start=\"0\" data-end=\"56\"><strong>The Power of Teaching: Why It\'s More Than Just a Job</strong></h3>\r\n<p class=\"\" data-start=\"58\" data-end=\"374\">Teaching is one of the most rewarding professions, offering the chance to shape minds, inspire growth, and make a lasting impact on students&rsquo; lives. Whether you&rsquo;re teaching children or adults, the role of a teacher goes far beyond imparting knowledge. Here&rsquo;s why teaching is such a powerful and important profession.</p>\r\n<ol data-start=\"376\" data-end=\"1419\">\r\n<li class=\"\" data-start=\"376\" data-end=\"597\">\r\n<p class=\"\" data-start=\"379\" data-end=\"597\"><strong data-start=\"379\" data-end=\"402\">Empowering Students</strong>: Teaching is about helping students realize their potential. By encouraging curiosity and fostering a love of learning, teachers empower students to believe in themselves and strive for success.</p>\r\n</li>\r\n<li class=\"\" data-start=\"599\" data-end=\"803\">\r\n<p class=\"\" data-start=\"602\" data-end=\"803\"><strong data-start=\"602\" data-end=\"633\">Building Strong Foundations</strong>: Teachers provide students with the tools and skills they need to succeed in life. They lay the foundation for critical thinking, problem-solving, and lifelong learning.</p>\r\n</li>\r\n<li class=\"\" data-start=\"805\" data-end=\"987\">\r\n<p class=\"\" data-start=\"808\" data-end=\"987\"><strong data-start=\"808\" data-end=\"836\">Creating Positive Change</strong>: Through education, teachers can break the cycle of poverty and inequality, providing opportunities for people to improve their lives and communities.</p>\r\n</li>\r\n<li class=\"\" data-start=\"989\" data-end=\"1210\">\r\n<p class=\"\" data-start=\"992\" data-end=\"1210\"><strong data-start=\"992\" data-end=\"1020\">Developing Relationships</strong>: Teaching isn&rsquo;t just about delivering lessons; it&rsquo;s about connecting with students on a personal level. Teachers build meaningful relationships that help students feel valued and supported.</p>\r\n</li>\r\n<li class=\"\" data-start=\"1212\" data-end=\"1419\">\r\n<p class=\"\" data-start=\"1215\" data-end=\"1419\"><strong data-start=\"1215\" data-end=\"1247\">Personal Growth for Teachers</strong>: Teaching is a journey of constant learning. Teachers often learn just as much from their students as their students learn from them, making it a deeply fulfilling career.</p>\r\n</li>\r\n</ol>\r\n<p class=\"\" data-start=\"1421\" data-end=\"1629\">In conclusion, teaching is more than a job&mdash;it&rsquo;s a chance to change lives, foster growth, and make a real difference in the world. Every teacher plays a vital role in shaping the future, one student at a time.</p>','2025-03-28',1,28,'2025-02-10','uploads/2896e0e7-d268-4017-bb77-fe26a92f5384.jpg',3),(8,'Massage Tips For Your Children','<p>&nbsp; &nbsp; Massage is a great way to bond with your child while promoting relaxation and overall well-being. Choose a quiet time, like after a bath or before bedtime, and use gentle, rhythmic strokes with child-safe oils such as coconut or almond oil. Focus on areas like the back, arms, and legs, using soft circular motions. Pay attention to your child\'s reactions and adjust if they seem uncomfortable. Adding a soothing voice or a lullaby can make the experience more enjoyable. Regular massage helps improve sleep, circulation, and emotional security, making it a wonderful addition to your child\'s routine.</p>','2025-03-16',1,28,'2025-03-16','uploads/Top 5 Benefits Of Massage For Kids.jpg',2),(9,'Massage Service','<h3 class=\"\" data-start=\"0\" data-end=\"59\">Benefits of Massage Therapy: Why You Should Consider It</h3>\r\n<p class=\"\" data-start=\"61\" data-end=\"381\">Massage therapy is a relaxing and therapeutic treatment that offers numerous physical and mental health benefits. Whether you\'re looking to relieve stress or ease muscle tension, massage can be an effective solution. Here are some reasons why you should consider incorporating massage therapy into your wellness routine.</p>\r\n<ol data-start=\"383\" data-end=\"2305\">\r\n<li class=\"\" data-start=\"383\" data-end=\"610\">\r\n<p class=\"\" data-start=\"386\" data-end=\"610\"><strong data-start=\"386\" data-end=\"403\">Stress Relief</strong>: One of the most common reasons people get massages is to reduce stress. Massage helps to trigger the relaxation response, lowering the levels of cortisol, the stress hormone, and promoting a sense of calm.</p>\r\n</li>\r\n<li class=\"\" data-start=\"612\" data-end=\"860\">\r\n<p class=\"\" data-start=\"615\" data-end=\"860\"><strong data-start=\"615\" data-end=\"630\">Pain Relief</strong>: Regular massages can help alleviate chronic pain, especially in areas like the back, neck, and shoulders. Massages can also reduce the intensity of headaches and migraines by relaxing the muscles and improving blood circulation.</p>\r\n</li>\r\n<li class=\"\" data-start=\"862\" data-end=\"1068\">\r\n<p class=\"\" data-start=\"865\" data-end=\"1068\"><strong data-start=\"865\" data-end=\"889\">Improved Circulation</strong>: Massage helps to enhance blood flow throughout the body, which can boost oxygen and nutrient delivery to cells, improve tissue health, and promote faster recovery from injuries.</p>\r\n</li>\r\n<li class=\"\" data-start=\"1070\" data-end=\"1294\">\r\n<p class=\"\" data-start=\"1073\" data-end=\"1294\"><strong data-start=\"1073\" data-end=\"1089\">Better Sleep</strong>: If you suffer from insomnia or poor sleep quality, massage therapy can help. It encourages the release of endorphins and promotes a feeling of relaxation, making it easier to fall asleep and stay asleep.</p>\r\n</li>\r\n<li class=\"\" data-start=\"1296\" data-end=\"1516\">\r\n<p class=\"\" data-start=\"1299\" data-end=\"1516\"><strong data-start=\"1299\" data-end=\"1323\">Enhanced Flexibility</strong>: Massage can help improve joint mobility and flexibility by stretching the muscles and reducing tension. This is particularly beneficial for athletes or individuals with a sedentary lifestyle.</p>\r\n</li>\r\n<li class=\"\" data-start=\"1518\" data-end=\"1716\">\r\n<p class=\"\" data-start=\"1521\" data-end=\"1716\"><strong data-start=\"1521\" data-end=\"1539\">Mental Clarity</strong>: Along with its physical benefits, massage also supports mental well-being. The calming effect of massage can help clear your mind, reduce anxiety, and promote a positive mood.</p>\r\n</li>\r\n<li class=\"\" data-start=\"1718\" data-end=\"1880\">\r\n<p class=\"\" data-start=\"1721\" data-end=\"1880\"><strong data-start=\"1721\" data-end=\"1739\">Detoxification</strong>: By stimulating the lymphatic system, massage can help remove toxins from the body, boosting the immune system and improving overall health.</p>\r\n</li>\r\n<li class=\"\" data-start=\"1882\" data-end=\"2090\">\r\n<p class=\"\" data-start=\"1885\" data-end=\"2090\"><strong data-start=\"1885\" data-end=\"1900\">Skin Health</strong>: Regular massages can improve skin tone and texture by increasing blood flow and nourishing the skin&rsquo;s surface. It also helps to improve the appearance of scars and stretch marks over time.</p>\r\n</li>\r\n<li class=\"\" data-start=\"2092\" data-end=\"2305\">\r\n<p class=\"\" data-start=\"2095\" data-end=\"2305\"><strong data-start=\"2095\" data-end=\"2115\">Increased Energy</strong>: A massage can help rejuvenate both your body and mind, leading to an increase in overall energy levels. The relief of muscle tension and stress often results in a better sense of vitality.</p>\r\n</li>\r\n</ol>\r\n<p class=\"\" data-start=\"2307\" data-end=\"2640\">Massage therapy is not just a luxury; it\'s an investment in your health and well-being. Whether you\'re looking to relieve stress, improve circulation, or simply relax, massage can be a valuable addition to your self-care routine. Treat yourself to a massage and experience the numerous benefits it offers for both your body and mind.</p>','2025-03-28',1,28,'2025-03-13','uploads/Babysitting in Jackson Hole - Jackson Hole Reservations Blog.jpg',1),(11,'New HairCut','<h3 class=\"\" data-start=\"0\" data-end=\"69\">The Impact of a New Haircut: Why It Can Change Your Look and Mood</h3>\r\n<p class=\"\" data-start=\"71\" data-end=\"341\">Getting a new haircut is more than just a change in appearance&mdash;it&rsquo;s an opportunity to refresh your style, boost your confidence, and even improve your mood. Whether it&rsquo;s a drastic transformation or a subtle trim, here&rsquo;s why a new haircut can have such a powerful impact.</p>\r\n<ol data-start=\"343\" data-end=\"1352\">\r\n<li class=\"\" data-start=\"343\" data-end=\"550\">\r\n<p class=\"\" data-start=\"346\" data-end=\"550\"><strong data-start=\"346\" data-end=\"366\">Confidence Boost</strong>: A fresh haircut often brings a sense of renewal. Whether you&rsquo;re going for a bold change or just a tidy up, a new look can make you feel more confident and ready to take on the world.</p>\r\n</li>\r\n<li class=\"\" data-start=\"552\" data-end=\"763\">\r\n<p class=\"\" data-start=\"555\" data-end=\"763\"><strong data-start=\"555\" data-end=\"572\">A Fresh Start</strong>: A haircut can symbolize a new beginning. It&rsquo;s a great way to mark a change in your life, whether you&rsquo;re starting a new job, entering a new season, or simply looking for a fresh perspective.</p>\r\n</li>\r\n<li class=\"\" data-start=\"765\" data-end=\"982\">\r\n<p class=\"\" data-start=\"768\" data-end=\"982\"><strong data-start=\"768\" data-end=\"794\">Enhances Your Features</strong>: A good haircut can accentuate your best features, whether it&rsquo;s framing your face, adding volume to your hair, or highlighting your natural texture. It&rsquo;s an easy way to enhance your look.</p>\r\n</li>\r\n<li class=\"\" data-start=\"984\" data-end=\"1167\">\r\n<p class=\"\" data-start=\"987\" data-end=\"1167\"><strong data-start=\"987\" data-end=\"1007\">Mood Improvement</strong>: A makeover, including a new haircut, can uplift your spirits. The act of changing your hairstyle can help you feel refreshed and more positive about yourself.</p>\r\n</li>\r\n<li class=\"\" data-start=\"1169\" data-end=\"1352\">\r\n<p class=\"\" data-start=\"1172\" data-end=\"1352\"><strong data-start=\"1172\" data-end=\"1197\">Show Your Personality</strong>: Your hairstyle is a reflection of your personality. Whether you choose something edgy, classic, or trendy, a new haircut is a way to express who you are.</p>\r\n</li>\r\n</ol>\r\n<p class=\"\" data-start=\"1354\" data-end=\"1576\">A new haircut can make a big difference in how you feel about yourself. It&rsquo;s a simple yet effective way to refresh your look and add a little extra confidence to your day. So, why not take the plunge and try something new?</p>','2025-03-28',0,28,'2025-03-28','uploads/kidharcut.jpg',3),(12,'Facial Treatments for Kids: A Healthy Start to Skincare','<p class=\"\" data-start=\"493\" data-end=\"859\"><strong data-start=\"493\" data-end=\"533\">Gentle Treatments for Delicate Skin:</strong> Facial treatments for kids are specifically designed to be mild and non-irritating. They help address concerns like dryness, acne, or sensitivity without causing harm to their tender skin. The treatments usually include a mild cleanse, a hydrating mask, and gentle soothing steps to leave the skin feeling soft and refreshed.</p>\r\n<p class=\"\" data-start=\"861\" data-end=\"1128\"><strong data-start=\"861\" data-end=\"888\">Safe Products for Kids:</strong> When choosing a facial treatment for children, it\'s crucial to use products that are safe and free from harsh chemicals. Specially formulated products for kids are made to nourish and protect the skin without causing irritation or dryness.</p>\r\n<p class=\"\" data-start=\"1130\" data-end=\"1427\"><strong data-start=\"1130\" data-end=\"1167\">Building Healthy Skincare Habits:</strong> Introducing facial treatments early can help kids develop healthy skincare habits that last into adulthood. These treatments also encourage children to understand the importance of self-care, boosting their confidence as they learn to take care of themselves.</p>','2025-03-29',1,28,'2025-03-29','uploads/Parents of Kids With Sensitive Skin Say This Is___.jpg',2);
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
  `note` varchar(255) DEFAULT NULL,
  `starttime` time DEFAULT NULL,
  `endtime` time DEFAULT NULL,
  `customer_name` varchar(45) DEFAULT NULL,
  `customer_address` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`reserv_id`),
  KEY `FK_Reservation_User` (`user_id`),
  KEY `FK_Reservation_User1` (`staff_id`),
  KEY `FK_Reservations_Service` (`service_id`),
  CONSTRAINT `FK_Reservation_User` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK_Reservation_User1` FOREIGN KEY (`staff_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK_Reservations_Service` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (34,'2025-03-09',38,1,'Completed',29,'2025-03-09',NULL,'xxxx','09:55:00','10:55:00','Manh','YB'),(41,'2025-03-09',38,6,'Completed',10,'2025-03-09',NULL,'','10:23:00','11:23:00','Manh Nguyen Duc','Me Linh, Hanoi'),(54,'2025-03-09',38,7,'Completed',29,'2025-03-09',NULL,'','11:21:00','12:21:00','Huy','Me Linh, Hanoi'),(65,'2025-03-09',38,2,'Completed',10,'2025-03-09',NULL,'','13:02:00','14:02:00','Manh Nguyen Duc','Me Linh, Hanoi'),(66,'2025-03-09',38,8,'Cancelled',7,'2025-03-09',NULL,'','13:04:00','14:04:00','Manh Nguyen Duc','Me Linh, Hanoi'),(67,'2025-03-09',38,7,'Completed',29,'2025-03-09',NULL,'','20:50:00','22:50:00','Manh Nguyen Duc','Me Linh, Hanoi'),(68,'2025-03-09',38,7,'Completed',10,'2025-03-09',NULL,'','20:03:00','21:03:00','Manh Nguyen Duc','Me Linh, Hanoi'),(69,'2025-03-09',38,6,'Completed',7,'2025-03-09',NULL,'','22:03:00','23:03:00','Trang Quang Huy','Yen Bai'),(86,'2025-03-10',38,3,'Completed',7,'2025-03-10',NULL,'','11:10:00','12:10:00','Manh Nguyen Duc','Ha Noi'),(88,'2025-03-13',38,5,'Completed',8,'2025-03-12',NULL,'','08:33:00','09:33:00','Manh Nguyen Duc','Ha Noi'),(89,'2025-03-13',38,4,'Cancelled',7,'2025-03-12',NULL,'fdfsfdsfsdfvvv','11:43:00','13:43:00','Manh Nguyen','Ha Noi 1'),(90,'2025-03-13',38,2,'Cancelled',7,'2025-03-13',NULL,'','10:05:00','11:05:00','Manh Nguyen Duc','Ha Noi'),(91,'2025-03-13',38,1,'Cancelled',7,'2025-03-13','2025-03-12','','15:08:00','16:08:00','Manh Nguyen Duc','Ha Noi'),(92,'2025-03-15',38,6,'Cancelled',10,'2025-03-15',NULL,'hehe','18:21:00','19:21:00','Manh Vip','Ha Noi'),(93,'2025-03-15',38,4,'Cancelled',10,'2025-03-15',NULL,'','20:21:00','22:21:00','Manh Nguyen Duc','Ha Noi'),(94,'2025-03-19',38,6,'Cancelled',10,'2025-03-19',NULL,'','18:56:00','19:56:00','Manh Nguyen Duc','Ha Noi'),(95,'2025-03-19',38,1,'Cancelled',7,'2025-03-19',NULL,'','20:56:00','21:56:00','Manh Nguyen Duc','Ha Noi'),(96,'2025-03-19',38,6,'Cancelled',44,'2025-03-19',NULL,'','19:12:00','20:12:00','Manh Nguyen Duc','Ha Noi'),(97,'2025-03-19',38,1,'Completed',29,'2025-03-19',NULL,'','19:13:00','20:13:00','Manh Nguyen Duc','Ha Noi'),(98,'2025-03-19',38,1,'Completed',45,'2025-03-19',NULL,'','19:25:00','20:25:00','Manh Nguyen Duc','Ha Noi'),(99,'2025-03-20',38,8,'Cancelled',8,'2025-03-20',NULL,'','08:36:00','09:36:00','Manh Nguyen Duc','Ha Noi'),(100,'2025-03-23',38,3,'Cancelled',8,'2025-03-23',NULL,'','16:00:00','18:00:00','Manh Nguyen Duc','Ha Noi'),(101,'2025-03-23',38,6,'Cancelled',7,'2025-03-23',NULL,'','19:00:00','20:00:00','Manh Nguyen Duc','Ha Noi'),(102,'2025-03-23',38,6,'Cancelled',7,'2025-03-23',NULL,'','19:00:00','20:00:00','Manh Nguyen Duc','Ha Noi'),(103,'2025-03-23',38,6,'Cancelled',7,'2025-03-23',NULL,'','19:00:00','20:00:00','Manh Nguyen Duc','Ha Noi'),(104,'2025-03-23',38,6,'Cancelled',7,'2025-03-23',NULL,'','19:00:00','20:00:00','Manh Nguyen Duc','Ha Noi'),(105,'2025-03-23',38,6,'Cancelled',7,'2025-03-23',NULL,'','19:00:00','20:00:00','Manh Nguyen Duc','Ha Noi'),(106,'2025-03-23',38,6,'Cancelled',45,'2025-03-23',NULL,'','19:06:00','20:06:00','Manh Nguyen Duc','Ha Noi'),(107,'2025-03-23',38,10,'Cancelled',8,'2025-03-23',NULL,'','19:08:00','20:08:00','Manh Nguyen Duc','Ha Noi'),(108,'2025-03-23',38,1,'Cancelled',3,'2025-03-23',NULL,'','19:09:00','20:09:00','Manh Nguyen Duc','Ha Noi'),(109,'2025-03-23',38,1,'Completed',29,'2025-03-23',NULL,'','19:11:00','20:11:00','Manh Nguyen Duc','Ha Noi'),(110,'2025-03-23',38,1,'Completed',29,'2025-03-23',NULL,'','22:35:00','23:35:00','Manh Nguyen Duc','Ha Noi'),(111,'2025-03-24',38,1,'Cancelled',8,'2025-03-24',NULL,'','10:14:00','11:14:00','Manh Nguyen Duc','Ha Noi'),(112,'2025-03-24',38,1,'Completed',29,'2025-03-24',NULL,'','11:23:00','12:23:00','Manh Nguyen Duc','Ha Noi'),(113,'2025-03-27',38,1,'Cancelled',7,'2025-03-27',NULL,'','22:01:00','23:01:00','Manh Nguyen Duc','Ha Noi'),(114,'2025-03-27',38,5,'Cancelled',8,'2025-03-27',NULL,'','22:01:00','23:01:00','Manh Nguyen Duc','Ha Noi'),(115,'2025-03-27',38,1,'Completed',29,'2025-03-27',NULL,'huhu','22:03:00','23:03:00','Manh Nguyen Duc','Ha Noi'),(116,'2025-03-28',38,5,'Cancelled',3,'2025-03-28',NULL,'','18:43:00','19:43:00','Manh Nguyen Duc','Ha NoiX'),(117,'2025-03-28',38,5,'Completed',29,'2025-03-28',NULL,'','18:44:00','19:44:00','Manh Nguyen Duc','Ha Noi'),(118,'2025-03-28',50,1,'Cancelled',45,'2025-03-28',NULL,'','22:09:00','23:09:00','NGUYEN VAN A','Me Linh, Hanoi'),(119,'2025-03-28',50,1,'Cancelled',29,'2025-03-28',NULL,'','22:30:00','23:30:00','Thang','Me Linh, Hanoi'),(120,'2025-03-29',38,1,'Scheduled',8,'2025-03-29',NULL,'huhu','22:42:00','23:42:00','Hoang','Bac Giang'),(121,'2025-03-30',38,4,'Cancelled',8,'2025-03-29',NULL,'','09:43:00','10:43:00','Manh Nguyen Duc','Ha Noi'),(122,'2025-03-29',38,4,'Scheduled',7,'2025-03-29',NULL,'','22:46:00','23:46:00','Manh Nguyen Duc','Ha Noi'),(123,'2025-03-29',38,1,'Completed',29,'2025-03-29',NULL,'','22:50:00','23:50:00','Manh Nguyen Duc','Ha Noi');
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
INSERT INTO `rolefeatures` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(2,7),(1,8),(2,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(3,16),(1,17),(1,18),(1,19),(2,20),(2,21),(2,22),(2,23),(2,24),(2,25),(1,26),(4,27),(4,28),(4,29),(4,30),(4,31),(4,32),(1,33),(1,34),(2,35),(4,36),(3,39),(2,40),(3,41),(1,42),(1,43),(1,44),(1,45);
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
INSERT INTO `roles` VALUES (1,'Admin'),(2,'Marketing Staff'),(3,'Staffs'),(4,'Customer');
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
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicecategories`
--

LOCK TABLES `servicecategories` WRITE;
/*!40000 ALTER TABLE `servicecategories` DISABLE KEYS */;
INSERT INTO `servicecategories` VALUES (3,'Massage & Therapy','Relaxing massages and therapy services',1),(4,'Facial & Skincare','Professional skincare treatments',1),(5,'Babysitting Services','Safe and reliable babysitting services',1),(6,'Kids Haircuts','Haircuts designed for children',1),(7,'Special Skin Treatments','Special skincare for sensitive skin XX',1),(8,'New Category','123456XX',1);
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
  `isActive` tinyint DEFAULT NULL,
  PRIMARY KEY (`service_id`),
  KEY `FK_Service_ServiceCategories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Massage','Full body relaxation massage',80,3,'uploads/Chiropractic Care for Kids and Babies - Elmums.jpg',1),(2,'Quyen','Basic facial treatment',65,5,'uploads/Babysitting in Jackson Hole - Jackson Hole Reservations Blog.jpg',1),(3,'Gentle Kids Massage','Soothing full-body massage for kids',80,3,'uploads/images.jpg',1),(4,'Aromatherapy for Kids','Relaxing essential oil therapy for children',80,3,'uploads/unnamed_f6d68216-61da-43c5-8e59-4979cf6e7603_1024x1024.webp',1),(5,'Hydrating Facial','Moisturizing facial treatment for young skin',40,4,'uploads/Top 10 Tips To Improve Your Child\'s Skin Health.jpg',1),(6,'Acne Care for Teens','Special acne treatment for teenagers',60,4,'uploads/The Best Mineral Sunscreens For Kids — That Go on Practically Clear.jpg',1),(7,'Evening Babysitting','Reliable babysitting services for evenings',30,5,'uploads/How to help baby sit up without rushing their natural development.jpg',1),(8,'Weekend Babysitting','Weekend babysitting services at your convenience',35,5,'uploads/Babysitting in Jackson Hole - Jackson Hole Reservations Blog.jpg',1),(9,'Quick Kids Haircut','Fast and stylish haircut for kids',20,6,'uploads/2896e0e7-d268-4017-bb77-fe26a92f5384.jpg',1),(10,'Deluxe Kids Haircut','Includes styling and gentle scalp massage',30,6,'uploads/Father\'s success after quitting banking for children\'s hairdressing.jpg',1),(11,'Sensitive Skin Care','Special skincare treatment for sensitive skin',45,7,'uploads/Baby Skin Care -- Simple Tips to Keep Your Baby\'s Skin Healthy.jpg',1),(12,'Sun Protection Facial','SPF-based facial care for kids',50,7,'uploads/Parents of Kids With Sensitive Skin Say This Is___.jpg',1),(20,'Man','',100,4,'uploads/08.jpg',1),(21,'Manh','hehe',88,5,'uploads/kidharcut.jpg',1);
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
  `title` varchar(255) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
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
INSERT INTO `sliders` VALUES (1,'Why Facial Treatments Are Important for Children\'s Skin','uploads/eminence-organics-skin-care-preteens-teens.jpg',1,'2025-01-17','2025-03-29',2,1,'../blog-detail?id=12'),(2,'Facial Treatment For Kids','uploads/massage.jpg',0,'2025-01-17','2025-03-29',3,1,'facebook.com'),(3,'Welcome to Our Spa','uploads/gettinghome.jpg',0,'2025-01-17','2025-03-05',2,1,'facebook.com'),(4,'Special Winter Offers1','uploads/kidharcut.jpg',0,'2025-01-17','2025-03-05',3,1,'null'),(5,'Getting Home 1 - Manh Nguyen','uploads/Baby Skin Care -- Simple Tips to Keep Your Baby\'s Skin Healthy.jpg',0,'2025-02-08','2025-03-05',1,1,'null'),(6,'Kid Haircut','/assets/images/posts/kidhaircut.jpg',0,'2025-02-08','2025-02-08',1,1,NULL),(7,'Massage','/assets/images/posts/massage.jpg',0,'2025-02-08','2025-02-08',2,1,NULL),(8,'New Massage','/assets/images/posts/newmassage.jpg',0,'2025-02-08','2025-02-08',2,1,NULL),(9,'Sporting','/assets/images/posts/sporting.jpg',0,'2025-02-08','2025-02-08',3,1,NULL),(10,'Teaching','uploads/2896e0e7-d268-4017-bb77-fe26a92f5384.jpg',1,'2025-02-08','2025-03-16',3,1,'../blog-detail?id=6'),(11,'Winter Care','/assets/images/posts/wintercare.jpg',0,'2025-02-08','2025-02-08',3,1,NULL),(12,'Why Facial Treatments Are Important for Children\'s Skin','uploads/eminence-organics-skin-care-preteens-teens.jpg',1,'2025-02-08','2025-03-29',1,1,'../blog-detail?id=12'),(13,'Kid Haircut','/assets/images/posts/kidhaircut.jpg',0,'2025-02-08','2025-02-08',1,1,NULL),(14,'Massage','/assets/images/posts/massage.jpg',0,'2025-02-08','2025-02-08',2,1,NULL),(15,'New Massage','/assets/images/posts/newmassage.jpg',0,'2025-02-08','2025-02-08',2,1,NULL),(16,'Sporting','uploads/teaching.jpg',0,'2025-02-08','2025-02-12',3,1,NULL),(17,'Teaching','/assets/images/posts/teaching.jpg',0,'2025-02-08','2025-02-08',3,1,NULL),(18,'Winter Care','/assets/images/posts/wintercare.jpg',0,'2025-02-08','2025-02-08',3,1,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staffprofiles`
--

LOCK TABLES `staffprofiles` WRITE;
/*!40000 ALTER TABLE `staffprofiles` DISABLE KEYS */;
INSERT INTO `staffprofiles` VALUES (1,'Massage therapy','Licensed Massage Therapist','Swedish, Deep Tissue',2,'2018','2019'),(2,'Skincare','Licensed Esthetician','Anti-aging, Acne Treatment',3,'2018','2019'),(5,'Massage therapy','Licensed Massage Therapist','Anti-aging, Acne Treatment',8,'2018','2019'),(6,'Massage therapy','Licensed Esthetician','Swedish, Deep Tissue',10,'2018','2019'),(7,'Massage therapy','Licensed Massage Therapist','Swedish, Deep Tissue',7,'2018','2019'),(8,'Haircut','Licensed','Haircut',3,'2018','2019'),(9,'Massage','Licensed Massage Therapist','Massage',3,'2018','2019'),(10,'Massage','Licensed Massage Therapist','Haircut',29,'2018','2018'),(11,'Massage therapy','Licensed Massage Therapist','Swedish, Deep Tissue',44,'2018','2019'),(12,NULL,NULL,NULL,10,NULL,NULL),(13,NULL,NULL,NULL,45,NULL,NULL),(14,NULL,NULL,NULL,51,NULL,NULL),(15,NULL,NULL,NULL,53,NULL,NULL),(16,NULL,NULL,NULL,54,NULL,NULL),(17,NULL,NULL,NULL,58,NULL,NULL);
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
INSERT INTO `userroles` VALUES (3,'cong@gmail.com'),(3,'davidbrown@gmail.com'),(3,'emilydavid@gmail.com'),(4,'ethancarter@example.com'),(4,'hoang18k4@gmail.com'),(4,'hoangnl1104@gmail.com'),(2,'hoangnl1811@gmail.com'),(4,'hoangnlhe186662@fpt.edu.vn'),(4,'isabellacollins@example.com'),(3,'jamestayler@gmail.com'),(3,'jeniferwhite@gmail.com'),(4,'liammitchell@example.com'),(4,'lisaandreson@gmail.com'),(4,'manhndhe186737@fpt.edu.vn'),(4,'manhnguyenduc153@gmail.com'),(1,'manhvipyb1@gmail.com'),(2,'maryjohnson@gmail.com'),(4,'masonhughes@example.com'),(4,'michaellee@gmail.com'),(3,'nguyenvana@gmail.com'),(3,'nguyenvana123bxxx@gmail.com'),(3,'nguyenvana123xxx@gmail.com'),(3,'nguyenvana123xxxxx@gmail.com'),(3,'quanghieu@gmail.com'),(4,'robertmiler@gmail.com'),(4,'sarahwilson@gmail.com'),(4,'sophiabennett@example.com'),(3,'vucongthang2101@gmail.com');
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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'John Smithh','123 Main St, Boston','1990-01-15','123-456-7890','man-02.jpg',1,1,1,NULL,'johnsmith@gmail.com','123456'),(2,'Mary Johnson','456 Oak Ave, Chicago','1985-03-22','234-567-8901','wm-07.jpg',1,1,1,NULL,'maryjohnson@gmail.com','123'),(3,'David Brown','14 Cedar Court','2025-01-01','1234567890','uploads/staff01.jpg',1,1,1,'','davidbrown@gmail.com','123'),(4,'Sarah Wilson','321 Elm St, Denver','1992-11-20','4567890126','uploads/kidharcut.jpg',0,1,1,NULL,'sarahwilson@gmail.com','123'),(5,'Michael Lee','654 Maple Dr, Austin','1987-09-18','5678901234','uploads/02.jpg',0,1,1,NULL,'michaellee@gmail.com','123'),(6,'Lisa Anderson','987 Cedar Ln, Portland','1993-04-25','6789012345','uploads/03.jpg',0,1,1,NULL,'lisaandreson@gmail.com','123'),(7,'James Taylor','147 Birch Rd, Miami','1986-12-08','7890123456','uploads/staff07.jpg',0,1,1,'','jamestayler@gmail.com','123'),(8,'Emily Davis','258 Walnut St, Houston','1991-06-14','8902345671','uploads/staff02.jpg',0,1,1,'','emilydavid@gmail.com','123'),(9,'Robert Miller','369 Pine Ave, PhoenixX','1989-02-02','6789012345','uploads/07.jpg',1,1,1,NULL,'robertmiler@gmail.com','123'),(10,'Jennifer WhiteE','321 Elm St, Denver','1994-08-11','0123456789','uploads/staff08.jpg',1,0,0,'','jeniferwhite@gmail.com','123'),(11,'Manh','741 Oak Rd, Atlanta','1994-08-11','012-345-6789','x',1,1,1,NULL,'manh@gmail.com','123'),(12,'Manh','X','1990-09-11','012-345-6789','x',1,1,1,NULL,NULL,NULL),(13,'John Michael','HN','1990-04-20','123-456-7891','x',1,1,1,NULL,NULL,NULL),(14,'John Michael','HN','1990-04-20','123-456-7891','x',NULL,1,1,NULL,NULL,NULL),(16,'Ethan Carter','125 Maple Street, Springfield','2025-02-06','9012345678','uploads/07.jpg',1,1,1,NULL,'ethancarter@example.com','123'),(17,'Sophia Bennett','42 Elm Avenue, Los Angeles','1998-02-05','0123456789','uploads/09.jpg',1,0,1,NULL,'sophiabennett@example.com','123'),(18,'Liam Mitchell','78 Oak Lane, Austin','2025-03-01','0123456789','uploads/10.jpg',1,0,1,NULL,'liammitchell@example.com','123'),(19,'Isabella Collins','301 Birch Road, Denver',NULL,NULL,'uploads/09.jpg',0,1,1,NULL,'isabellacollins@example.com','123'),(20,'Mason Hughes','14 Cedar Court, Seattle','2025-02-01','0123456789','uploads/default.jpg',0,0,1,NULL,'masonhughes@example.com','123'),(26,'Nguyen Manh','Yen Bai','2025-02-01','123','uploads/Babysitting in Jackson Hole - Jackson Hole Reservations Blog.jpg',1,1,1,NULL,'manhvipyb1@gmail.com','7FMiP5Y2E+RyyS2UQ38GYA==$OoZSP017qyg8JK2eFgeru2dWo0hIQiucUYBbKG/btyj/idXABoH9vhPIVLdwQ1NvFp/gNqk02ttlRJDRXjFWtw=='),(27,'Staff','yb','2025-02-01','12345','staff/staff02.jpg',NULL,1,1,NULL,'',''),(28,'Hoang','BG','2025-02-07','12345','uploads/eminence-organics-skin-care-preteens-teens.jpg',NULL,1,1,NULL,'hoangnl1811@gmail.com','S0baw4WvbMMWYU9PxNcG+Q==$Fd9L9eSqx31Zqxk+m4o3rNDDrvA6cO1gLbtBMd5u1CRhETpyb9YPQOcWPnTofDMktI07U8zZPUjqtTpyhGuqLg=='),(29,'Thang','Ha Noi','2025-02-01','0372362911','uploads/staff10.jpg',NULL,1,1,'','vucongthang2101@gmail.com','xoO5uhCRZLYM0Yb4BBnMsw==$zFMu3+1HaGTV/kTi7hASuwpk1QtjftRTv7BhDjzc1MdyfobvnJ3W6I1hxBeOEfgvcrz3Fg6k+fBIjkI7QVJK7A=='),(30,'Thang','Ha Noi','2025-02-01','0372362911','uploads/avatar.jpg',1,1,0,NULL,NULL,NULL),(31,'Johnson Nguyen','789 Pine Rd, SeattleE','2025-02-01','0123456789','uploads/default.jpg',0,1,1,NULL,'hoangnlhe186662@fpt.edu.vn','MI9tCV2tDXyp0JUpiyU6+A==$42HNYwxVwhbk8eYaTepO6WBTgUUhtATzv3B8suD5qY52xlEsICb32iZxNTmmemTKJ6de8ybhJkz5mICl3cs8rw=='),(38,'Manh Nguyen Duc','Ha Noi','2025-02-01','1234381689','uploads/Top 5 Benefits Of Massage For Kids.jpg',NULL,1,1,NULL,'manhnguyenduc153@gmail.com','iAvn2InaoXS8Fod5xMI12g==$4lNQCEHz9HqSxefQg8fMAiLQgYVfqXjHgvuhFFXtAOJWZdt+y5nLUK/q5y3chpzirtlZDp2zWjCrcTWDkFmWDQ=='),(44,'Thang Nguyen','Me Linh, Hanoi','2025-03-13','1234381689','uploads/staff05.jpg',NULL,1,1,'','cong@gmail.com','lpawXNqxYXTOjZYe9vuavA==$BHLBOBoWMAZBedzYfe2t5fXCwf8wzx+qIVZb3kRaGAojkTwCuTINgqPNVun17/t5pWJjygObnDZgT50pGur3rA=='),(45,'Quang Hieu','Me Linh, Hanoi','2025-03-13','1234381689','uploads/default.jpg',NULL,1,1,NULL,'quanghieu@gmail.com','qPE4y6cb+zqHPBM9Gpt1kg==$T2wbJa3qTd4Esfc9Hplvn8DoajhPVgWqa2AQHZt4GwViiYb73flzjCIoGmT7WwuBYWL8LmWvXviiQjG2abqd2g=='),(50,'Thang','Me Linh, Hanoi','2025-03-13','0372362911','uploads/04.jpg',NULL,1,1,NULL,'hoangnl1104@gmail.com','5Z9XMN5NpUaPlJTGMg9ztQ==$j2iTZU/7PoPXqsVW3l2ua58K8CYGQkAd3FFQTMPBoEFoj2yU4nchdAz3asUJV5ElNVylcKs2svGKcPeVTmMgeQ=='),(51,'NGUYEN VAN A','Me Linh, Hanoi','2025-03-30','0372362911x','uploads/default.jpg',NULL,1,1,NULL,'nguyenvana@gmail.com','y5PgjEh0jwxzxIkUNlaqIQ==$oaroas+bqT0ZJkneiZSbidb/4IpPEq+olJqBzJ/cpzOf5nWoZZ0Qb5aI4tdl/m9gM/HPzIZoklGspKWq02TQbQ=='),(53,'NGUYEN VAN AB','Me Linh, Hanoi','2025-03-29','0372362912','uploads/default.jpg',NULL,1,1,NULL,'nguyenvana123xxx@gmail.com','dQ4LiQbIJjpA0xr5KeqCLQ==$ZIy2DI0PghM4R3gcE7lOruzCHp2yk/yBs0hQxbb40WJNWXOG3orHAMErJKEyp3z/gshO3RQQBOq7pHeIocu1KQ=='),(54,'NGUYEN VAN AB','Me Linh, Hanoi','2025-03-20','0372362912','uploads/default.jpg',NULL,1,1,NULL,'nguyenvana123bxxx@gmail.com','iBPW/ORT14TH4R01TrktRQ==$QWDDxGEAqHEk1HkIa26/bboMb9hu21j86laL9Mar5xNNf6fkDYNOcAeJ9uGzgFnP2YNmAUUvCLUMjpYUPIlAfQ=='),(58,'NGUYEN VAN AB','Me Linh, Hanoi','2025-02-28','0372362912','uploads/kidharcut.jpg',NULL,1,1,'','nguyenvana123xxxxx@gmail.com','ObGArZolEZewCE7jYTWX+A==$E6Kv0KznY+s/OCH8g4MeHBvWuCFQmlU5f8hdsGbUuf6pPrT1xGp/0rN62um3yvnCwYlVix0EcYOSbULxx5spRg=='),(60,'Nguyen Dinh Duc','Me Linh, Hanoi','2025-03-07','0372362911','uploads/default.jpg',NULL,1,0,NULL,'hoang18k4@gmail.com','rjg5EtQ0NKz4UA6umfQdbA==$7Fa4hGQ/zgtFD59pDTK7aN4Q3rqQecnUL/1HdzWAiXKVB6K1jyxZgKnez9QOfWujbB19gflcJ7Vj7zhJxkjlnw=='),(62,'Nguyen Duc Manh (K18 HL)','Me Linh, Hanoi','2025-03-28','0372362911','uploads/default.jpg',NULL,1,1,NULL,'manhndhe186737@fpt.edu.vn','gH29RBw/xnM4EAum70v/mw==$cRGX/Dkwtnqqubi/5pJlPyFUkQEFHsJJMLc+XrigMcRgFCZ4Wb4hkTlIorqgkxbOrM1HFdhS7dMLywHQjg+dcA==');
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verification_tokens`
--

LOCK TABLES `verification_tokens` WRITE;
/*!40000 ALTER TABLE `verification_tokens` DISABLE KEYS */;
INSERT INTO `verification_tokens` VALUES (18,'tuananh19762603@gmail.com','10482d0f-98d0-4c3f-a50b-358cbf121eae','2025-03-25 13:48:05'),(20,'hoang18k4@gmail.com','eea063c4-d6ea-4339-8800-613f134b2699','2025-03-29 16:05:35'),(23,'manhnguyenduc153@gmail.com','77974def-3915-46a0-a63c-0f511c3d9e1a','2025-03-29 17:35:29'),(24,'manhnguyenduc153@gmail.com','91107313-078d-47a4-8d16-d93b9da7fe67','2025-03-29 17:36:58'),(25,'manhnguyenduc153@gmail.com','777a3672-7309-41bf-a308-724f0c2674cf','2025-03-29 17:41:28');
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

-- Dump completed on 2025-03-30  7:31:18
