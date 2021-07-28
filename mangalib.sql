-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: mangalib
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `announcements`
--
DROP DATABASE IF EXISTS mangalib;
CREATE DATABASE mangalib;
USE mangalib;

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcements` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Mangalib.me website announcements';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aut_art_mangas`
--

DROP TABLE IF EXISTS `aut_art_mangas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aut_art_mangas` (
  `aut_art_id` int unsigned NOT NULL,
  `manga_id` int unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_aut_art_mangas_manga_id_idx` (`manga_id`),
  KEY `fk_aut_art_mangas_aut_art_id_idx` (`aut_art_id`),
  CONSTRAINT `fk_aut_art_mangas_aut_art_id` FOREIGN KEY (`aut_art_id`) REFERENCES `authors_and_artists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_aut_art_mangas_manga_id` FOREIGN KEY (`manga_id`) REFERENCES `mangas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='connections between authors_and_artists and mangas tables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aut_art_mangas`
--

LOCK TABLES `aut_art_mangas` WRITE;
/*!40000 ALTER TABLE `aut_art_mangas` DISABLE KEYS */;
/*!40000 ALTER TABLE `aut_art_mangas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authors_and_artists`
--

DROP TABLE IF EXISTS `authors_and_artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors_and_artists` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('Author','Artist') NOT NULL DEFAULT 'Author',
  `avatar` varchar(255) NOT NULL DEFAULT 'https://mangalib.me/uploads/no-image.png',
  `nickname` varchar(32) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='authors and artists of mangas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors_and_artists`
--

LOCK TABLES `authors_and_artists` WRITE;
/*!40000 ALTER TABLE `authors_and_artists` DISABLE KEYS */;
/*!40000 ALTER TABLE `authors_and_artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chapters`
--

DROP TABLE IF EXISTS `chapters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chapters` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `tom` int unsigned NOT NULL,
  `chapter` int unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chapters`
--

LOCK TABLES `chapters` WRITE;
/*!40000 ALTER TABLE `chapters` DISABLE KEYS */;
/*!40000 ALTER TABLE `chapters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chapters_pages`
--

DROP TABLE IF EXISTS `chapters_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chapters_pages` (
  `chapter_id` int unsigned NOT NULL,
  `page_id` int unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_mangas_chapters_page_id_idx` (`page_id`),
  KEY `fk_chapters_pages_chapter_id` (`chapter_id`),
  CONSTRAINT `fk_chapters_pages_chapter_id` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_chapters_pages_page_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='connection between chapters and pages tables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chapters_pages`
--

LOCK TABLES `chapters_pages` WRITE;
/*!40000 ALTER TABLE `chapters_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `chapters_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `content` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_comments_user_id_idx` (`user_id`),
  CONSTRAINT `fk_comments_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='comments for everything\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments_to_announcements`
--

DROP TABLE IF EXISTS `comments_to_announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments_to_announcements` (
  `comment_id` int unsigned NOT NULL,
  `announcement_id` int unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_comments_to_announcements_comment_id_idx` (`comment_id`),
  KEY `fk_comments_to_announcements_announcement_id_idx` (`announcement_id`),
  CONSTRAINT `fk_comments_to_announcements_announcement_id` FOREIGN KEY (`announcement_id`) REFERENCES `announcements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_to_announcements_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='comments to announcements';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_to_announcements`
--

LOCK TABLES `comments_to_announcements` WRITE;
/*!40000 ALTER TABLE `comments_to_announcements` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments_to_announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments_to_forums`
--

DROP TABLE IF EXISTS `comments_to_forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments_to_forums` (
  `comment_id` int unsigned NOT NULL,
  `forum_id` int unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_comments_to_forums_comment_id_idx` (`comment_id`),
  KEY `fk_comments_to_forums_forum_id_idx` (`forum_id`),
  CONSTRAINT `fk_comments_to_forums_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_to_forums_forum_id` FOREIGN KEY (`forum_id`) REFERENCES `forums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='comments to forums';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_to_forums`
--

LOCK TABLES `comments_to_forums` WRITE;
/*!40000 ALTER TABLE `comments_to_forums` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments_to_forums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments_to_manga`
--

DROP TABLE IF EXISTS `comments_to_manga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments_to_manga` (
  `comment_id` int unsigned NOT NULL,
  `manga_id` int unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_comments_to_manga_comment_id_idx` (`comment_id`),
  KEY `fk_comments_to_manga_manga_id_idx` (`manga_id`),
  CONSTRAINT `fk_comments_to_manga_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_to_manga_manga_id` FOREIGN KEY (`manga_id`) REFERENCES `mangas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='comments to manga';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_to_manga`
--

LOCK TABLES `comments_to_manga` WRITE;
/*!40000 ALTER TABLE `comments_to_manga` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments_to_manga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments_to_pages`
--

DROP TABLE IF EXISTS `comments_to_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments_to_pages` (
  `comment_id` int unsigned NOT NULL,
  `page_id` int unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_comments_to_pages_comment_id_idx` (`comment_id`),
  KEY `fk_comments_to_pages_page_id_idx` (`page_id`),
  CONSTRAINT `fk_comments_to_pages_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_to_pages_page_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='comments to pages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_to_pages`
--

LOCK TABLES `comments_to_pages` WRITE;
/*!40000 ALTER TABLE `comments_to_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments_to_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forums`
--

DROP TABLE IF EXISTS `forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forums` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `master_id` int unsigned NOT NULL,
  `title` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_forums_master_id_idx` (`master_id`),
  CONSTRAINT `fk_forums_master_id` FOREIGN KEY (`master_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='forums\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forums`
--

LOCK TABLES `forums` WRITE;
/*!40000 ALTER TABLE `forums` DISABLE KEYS */;
/*!40000 ALTER TABLE `forums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libraries`
--

DROP TABLE IF EXISTS `libraries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libraries` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `manga_id` int unsigned NOT NULL,
  `status` enum('Reading','Planning','Not reading yet','Going to read','Done','Lovely') NOT NULL DEFAULT 'Reading',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_library_manga_id_idx` (`manga_id`),
  CONSTRAINT `fk_library_manga_id` FOREIGN KEY (`manga_id`) REFERENCES `mangas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='profile''s manga libraries';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libraries`
--

LOCK TABLES `libraries` WRITE;
/*!40000 ALTER TABLE `libraries` DISABLE KEYS */;
/*!40000 ALTER TABLE `libraries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mangas`
--

DROP TABLE IF EXISTS `mangas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mangas` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ru_title` varchar(64) NOT NULL,
  `en_title` varchar(64) NOT NULL,
  `genres` set('art','action','martial arts','vampires','harem','gender intrigue','heroic fantasy','detective','jōsei','drama','game','isekai','history','cyberpunk','kodomo','comedy','maho-shojo','mecha','mysticism','science fiction','everyday life','post-apocalyptic','adventure','psychology','romance','samurai','supernatural','sport','seinen','shōjo','shōnen','thriller','shōnō-ai','tragedy','horror','fantasy','school','erotica',' etti','yuri') NOT NULL,
  `tags` set('gambling','alchemy','amnesia','angels','anti-hero','war','magicians','magical creatures','memories from another world','MC woman','MC imba','MC man','gamers','guilds','stupid MC','time travel','sentient races','power ranks','reincarnation','robots','knights','samurai','system','identity hiding','saving the world','sports body','middle ages','steampunk','superheroes','traditional games','smart MC',' teacher','philosophy','hikigomori','edged weapons','blackmail','elves','yakuza','japan') NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `cover` varchar(255) NOT NULL,
  `type` enum('Manga','Manhva','Manihuva','OEL-manga','Rumanga','Eestern comics') NOT NULL DEFAULT 'Manga',
  `release_year` int DEFAULT NULL,
  `format` set('Enkoma','Dodzinsi','Single','Colorful','Kit','Web') DEFAULT NULL,
  `title_status` enum('Ongoing','Announcement','Finished','Discontinued','Stoped') NOT NULL DEFAULT 'Announcement',
  `translation_status` enum('Finished','Discontinued','Continued','Freezed') NOT NULL DEFAULT 'Continued',
  `age_limit` enum('16+','18+','None') NOT NULL DEFAULT 'None',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='mangas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mangas`
--

LOCK TABLES `mangas` WRITE;
/*!40000 ALTER TABLE `mangas` DISABLE KEYS */;
/*!40000 ALTER TABLE `mangas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `mangas_BEFORE_INSERT` BEFORE INSERT ON `mangas` FOR EACH ROW BEGIN
	IF new.release_year IS NULL THEN
		set new.release_year = YEAR(NOW());
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `mangas_chapters`
--

DROP TABLE IF EXISTS `mangas_chapters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mangas_chapters` (
  `manga_id` int unsigned NOT NULL,
  `chapter_id` int unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_mangas_chapters_manga_id_idx` (`manga_id`),
  KEY `fk_mangas_chapters_chapter_id_idx` (`chapter_id`),
  CONSTRAINT `fk_mangas_chapters_chapter_id` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mangas_chapters_manga_id` FOREIGN KEY (`manga_id`) REFERENCES `mangas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='connection between mangas and chapters tables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mangas_chapters`
--

LOCK TABLES `mangas_chapters` WRITE;
/*!40000 ALTER TABLE `mangas_chapters` DISABLE KEYS */;
/*!40000 ALTER TABLE `mangas_chapters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mangas_translators`
--

DROP TABLE IF EXISTS `mangas_translators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mangas_translators` (
  `manga_id` int unsigned NOT NULL,
  `translators_id` int unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_mangas_translators_manga_id_idx` (`manga_id`),
  KEY `fk_mangas_translators_translators_id_idx` (`translators_id`),
  CONSTRAINT `fk_mangas_translators_manga_id` FOREIGN KEY (`manga_id`) REFERENCES `mangas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mangas_translators_translators_id` FOREIGN KEY (`translators_id`) REFERENCES `translators_profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='connection between mangas and translators_profiles tables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mangas_translators`
--

LOCK TABLES `mangas_translators` WRITE;
/*!40000 ALTER TABLE `mangas_translators` DISABLE KEYS */;
/*!40000 ALTER TABLE `mangas_translators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `page_num` int unsigned NOT NULL,
  `content` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='manga''s pages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `library_id` int unsigned NOT NULL,
  `level` int unsigned NOT NULL DEFAULT '1',
  `rank` int unsigned DEFAULT NULL,
  `status` enum('Online','Offline') NOT NULL DEFAULT 'Offline',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_profile_user_id_idx` (`user_id`),
  KEY `fk_profile_library_id_idx` (`library_id`),
  CONSTRAINT `fk_profile_library_id` FOREIGN KEY (`library_id`) REFERENCES `libraries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_profile_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='user''s profiles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translators_profiles`
--

DROP TABLE IF EXISTS `translators_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `translators_profiles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='manga''s translator profiles\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translators_profiles`
--

LOCK TABLES `translators_profiles` WRITE;
/*!40000 ALTER TABLE `translators_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `translators_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translators_profiles_profiles`
--

DROP TABLE IF EXISTS `translators_profiles_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `translators_profiles_profiles` (
  `translators_id` int unsigned NOT NULL,
  `profile_id` int unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_translators_profiles_users_profile_id_idx` (`profile_id`),
  KEY `fk_translators_profiles_users_translators_id_idx` (`translators_id`),
  CONSTRAINT `fk_translators_profiles_users_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_translators_profiles_users_translators_id` FOREIGN KEY (`translators_id`) REFERENCES `translators_profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='connection between translators_profilse and profiles tables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translators_profiles_profiles`
--

LOCK TABLES `translators_profiles_profiles` WRITE;
/*!40000 ALTER TABLE `translators_profiles_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `translators_profiles_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) NOT NULL DEFAULT 'https://mangalib.me/uploads/no-image.png',
  `background` varchar(255) DEFAULT NULL,
  `nickname` varchar(32) NOT NULL,
  `role` enum('Reader','Artist','Mangaka') NOT NULL DEFAULT 'Reader',
  `gender` enum('Male','Female','not specified') NOT NULL DEFAULT 'not specified',
  `place of residense` varchar(64) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `theme` enum('Light','Dark') NOT NULL DEFAULT 'Light',
  `skype` varchar(32) DEFAULT NULL,
  `about_myself` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
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

-- Dump completed on 2021-07-26 10:28:38
