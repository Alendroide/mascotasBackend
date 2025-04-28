-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: mascotas
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `_prisma_migrations`
--

DROP TABLE IF EXISTS `_prisma_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_prisma_migrations`
--

LOCK TABLES `_prisma_migrations` WRITE;
/*!40000 ALTER TABLE `_prisma_migrations` DISABLE KEYS */;
INSERT INTO `_prisma_migrations` VALUES ('163ab001-af90-4354-b523-28dcea63f81e','48a1da69ee318aff028152c71bcca18e978791d81bb976f2a60fc0aab453c7ce','2025-04-21 12:58:23.665','20250421125823_init',NULL,NULL,'2025-04-21 12:58:23.466',1),('5c0c2b4d-fd58-40b0-957d-9bf9979f5971','8a24a49c13d457bfdfd7052c79aacdd53a9a5cbf2edf8df657414546ea502cbd','2025-04-21 15:09:18.589','20250421150918_pet_status_added',NULL,NULL,'2025-04-21 15:09:18.481',1),('844c01e3-f4ab-4172-a2f7-1b5e42d59277','2f9008521dc2fb0acf274300fa3c9d40a9d6d310d892f9f861e1460e241d0c97','2025-04-21 15:18:18.523','20250421151818_category_has_races_now',NULL,NULL,'2025-04-21 15:18:18.444',1),('ac80118b-183f-48e9-9cc2-92756092be2a','5ae76c78381ff9080a84515f1fbf3594ba7e5af874c5844a1e2690d6e5cd5503','2025-04-21 13:27:40.758','20250421132740_email_now_unique',NULL,NULL,'2025-04-21 13:27:40.722',1);
/*!40000 ALTER TABLE `_prisma_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'perro'),(2,'gato');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gender`
--

DROP TABLE IF EXISTS `gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gender` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gender`
--

LOCK TABLES `gender` WRITE;
/*!40000 ALTER TABLE `gender` DISABLE KEYS */;
INSERT INTO `gender` VALUES (1,'macho'),(2,'hembra');
/*!40000 ALTER TABLE `gender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet`
--

DROP TABLE IF EXISTS `pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `photo` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `race_id` int NOT NULL,
  `gender_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('adopted','stray') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'stray',
  PRIMARY KEY (`id`),
  KEY `pet_race_id_fkey` (`race_id`),
  KEY `pet_gender_id_fkey` (`gender_id`),
  KEY `pet_user_id_fkey` (`user_id`),
  CONSTRAINT `pet_gender_id_fkey` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pet_race_id_fkey` FOREIGN KEY (`race_id`) REFERENCES `race` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pet_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet`
--

LOCK TABLES `pet` WRITE;
/*!40000 ALTER TABLE `pet` DISABLE KEYS */;
INSERT INTO `pet` VALUES (1,'pets/photo-sm-1.svg',5,1,NULL,'karsten','stray'),(2,'pets/photo-sm-2.svg',6,2,NULL,'Alban','stray'),(3,'pets/photo-sm-3.svg',5,1,NULL,'Reigner','stray'),(4,'pets/photo-sm-4.svg',3,2,NULL,'Alex','stray'),(5,'pets/photo-sm-5.svg',7,2,NULL,'Ariana','stray'),(6,'pets/unknown.png',1,1,1,'Tony','adopted');
/*!40000 ALTER TABLE `pet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `race`
--

DROP TABLE IF EXISTS `race`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `race` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `race_category_id_fkey` (`category_id`),
  CONSTRAINT `race_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `race`
--

LOCK TABLES `race` WRITE;
/*!40000 ALTER TABLE `race` DISABLE KEYS */;
INSERT INTO `race` VALUES (1,'husky',1),(2,'golden retriever',1),(3,'siamese',2),(4,'persa',2),(5,'bulldog',1),(6,'corgi',1),(7,'graycat',2);
/*!40000 ALTER TABLE `race` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_email_key` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Alejandro Bonilla','alendroideyt@gmail.com','$2b$10$7ZkFVZ7got6PW.U3kZIjQ.CxPvAydD93PTh0ZcNUXM6MMSzyFp2iq');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-28 11:31:37
