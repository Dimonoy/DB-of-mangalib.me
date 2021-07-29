-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)

-- Host: localhost    Database: mangalib
-- ------------------------------------------------------
-- Server version	8.0.25

DROP DATABASE IF EXISTS mangalib;
CREATE DATABASE mangalib;
USE mangalib;




--
-- Table structure for table `mangas`
--

DROP TABLE IF EXISTS `mangas`;
CREATE TABLE `mangas` (
  `id` 					int unsigned NOT NULL AUTO_INCREMENT,
  `ru_title` 			varchar(64) NOT NULL UNIQUE,
  `en_title` 			varchar(64) NOT NULL UNIQUE,
  `genres` 				set('art','action','martial arts','vampires','harem','gender intrigue','heroic fantasy','detective','jōsei','drama','game','isekai','history','cyberpunk','kodomo','comedy','maho-shojo','mecha','mysticism','science fiction','everyday life','post-apocalyptic','adventure','psychology','romance','samurai','supernatural','sport','seinen','shōjo','shōnen','thriller','shōnō-ai','tragedy','horror','fantasy','school','erotica',' etti','yuri') NOT NULL,
  `tags` 				set('gambling','alchemy','amnesia','angels','anti-hero','war','magicians','magical creatures','memories from another world','MC woman','MC imba','MC man','gamers','guilds','stupid MC','time travel','sentient races','power ranks','reincarnation','robots','knights','samurai','system','identity hiding','saving the world','sports body','middle ages','steampunk','superheroes','traditional games','smart MC',' teacher','philosophy','hikigomori','edged weapons','blackmail','elves','yakuza','japan') NOT NULL,
  `description` 		varchar(255) DEFAULT NULL,
  `cover` 				varchar(255) NOT NULL,
  `type` 				enum('Manga','Manhva','Manihuva','OEL-manga','Rumanga','Eestern comics') NOT NULL DEFAULT 'Manga',
  `release_year` 		int DEFAULT NULL,
  `format` 				set('Enkoma','Dodzinsi','Single','Colorful','Kit','Web') DEFAULT NULL,
  `title_status` 		enum('Ongoing','Announcement','Finished','Discontinued','Stoped') NOT NULL DEFAULT 'Announcement',
  `translation_status` 	enum('Finished','Discontinued','Continued','Freezed') NOT NULL DEFAULT 'Continued',
  `age_limit` 			enum('16+','18+','None') NOT NULL DEFAULT 'None',
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='mangas';




--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) NOT NULL DEFAULT 'https://mangalib.me/uploads/no-image.png',
  `background` varchar(255) DEFAULT NULL,
  `nickname` varchar(32) NOT NULL UNIQUE,
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




--
-- Table structure for table `libraries`
--

DROP TABLE IF EXISTS `libraries`;
CREATE TABLE `libraries` (
  `id` 					int unsigned NOT NULL AUTO_INCREMENT,
  `manga_id` 			int unsigned NOT NULL,
  `status` 				enum('Reading','Planning','Not reading yet','Going to read','Done','Lovely') NOT NULL DEFAULT 'Reading',
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_library_manga_id_idx` (`manga_id`),
  CONSTRAINT `fk_library_manga_id` FOREIGN KEY (`manga_id`) REFERENCES `mangas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='profile\'s manga libraries';




--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
  `id` 					int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` 			int unsigned NOT NULL,
  `library_id` 			int unsigned NOT NULL,
  `level` 				int unsigned NOT NULL DEFAULT '1',
  `rank` 				int unsigned DEFAULT NULL,
  `status` 				enum('Online','Offline') NOT NULL DEFAULT 'Offline',
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_profile_user_id_idx` (`user_id`),
  KEY `fk_profile_library_id_idx` (`library_id`),
  CONSTRAINT `fk_profile_library_id` FOREIGN KEY (`library_id`) REFERENCES `libraries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_profile_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='user\'s profiles';




--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements` (
  `id` 					int unsigned NOT NULL AUTO_INCREMENT,
  `title`				varchar(64) NOT NULL,
  `description` 		varchar(255) NOT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Mangalib.me website announcements';




--
-- Table structure for table `authors_and_artists`
--

DROP TABLE IF EXISTS `authors_and_artists`;
CREATE TABLE `authors_and_artists` (
  `id` 					int unsigned NOT NULL AUTO_INCREMENT,
  `type` 				enum('Author','Artist') NOT NULL DEFAULT 'Author',
  `avatar` 				varchar(255) NOT NULL DEFAULT 'https://mangalib.me/uploads/no-image.png',
  `nickname` 			varchar(32) NOT NULL,
  `description` 		varchar(255) DEFAULT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='authors and artists of mangas';




--
-- Table structure for table `aut_art_mangas`
--

DROP TABLE IF EXISTS `aut_art_mangas`;
CREATE TABLE `aut_art_mangas` (
  `aut_art_id` 			int unsigned NOT NULL,
  `manga_id` 			int unsigned NOT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_aut_art_mangas_manga_id_idx` (`manga_id`),
  KEY `fk_aut_art_mangas_aut_art_id_idx` (`aut_art_id`),
  CONSTRAINT `fk_aut_art_mangas_aut_art_id` FOREIGN KEY (`aut_art_id`) REFERENCES `authors_and_artists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_aut_art_mangas_manga_id` FOREIGN KEY (`manga_id`) REFERENCES `mangas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='connections between authors_and_artists and mangas tables';




--
-- Table structure for table `chapters`
--

DROP TABLE IF EXISTS `chapters`;
CREATE TABLE `chapters` (
  `id` 					int unsigned NOT NULL AUTO_INCREMENT,
  `tom` 				int unsigned NOT NULL,
  `chapter` 			int unsigned NOT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='manga\'s chapters';




--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages` (
  `id` 					int unsigned NOT NULL AUTO_INCREMENT,
  `page_num` 			int unsigned NOT NULL,
  `content` 			varchar(255) NOT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='manga\'s pages';




--
-- Table structure for table `chapters_pages`
--

DROP TABLE IF EXISTS `chapters_pages`;
CREATE TABLE `chapters_pages` (
  `chapter_id` 			int unsigned NOT NULL,
  `page_id` 			int unsigned NOT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_mangas_chapters_page_id_idx` (`page_id`),
  KEY `fk_chapters_pages_chapter_id` (`chapter_id`),
  CONSTRAINT `fk_chapters_pages_chapter_id` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_chapters_pages_page_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='connection between chapters and pages tables';




--
-- Table structure for table `forums`
--

DROP TABLE IF EXISTS `forums`;
CREATE TABLE `forums` (
  `id` 					int unsigned NOT NULL AUTO_INCREMENT,
  `master_id` 			int unsigned NOT NULL,
  `title` 				varchar(32) NOT NULL,
  `description` 		varchar(255) NOT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_forums_master_id_idx` (`master_id`),
  CONSTRAINT `fk_forums_master_id` FOREIGN KEY (`master_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='forums';




--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` 					int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` 			int unsigned NOT NULL,
  `content` 			varchar(255) NOT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_comments_user_id_idx` (`user_id`),
  CONSTRAINT `fk_comments_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='comments for everything';




--
-- Table structure for table `comments_to_announcements`
--

DROP TABLE IF EXISTS `comments_to_announcements`;
CREATE TABLE `comments_to_announcements` (
  `comment_id` 			int unsigned NOT NULL,
  `announcement_id` 	int unsigned NOT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_comments_to_announcements_comment_id_idx` (`comment_id`),
  KEY `fk_comments_to_announcements_announcement_id_idx` (`announcement_id`),
  CONSTRAINT `fk_comments_to_announcements_announcement_id` FOREIGN KEY (`announcement_id`) REFERENCES `announcements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_to_announcements_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='comments to announcements';




--
-- Table structure for table `comments_to_forums`
--

DROP TABLE IF EXISTS `comments_to_forums`;
CREATE TABLE `comments_to_forums` (
  `comment_id` 			int unsigned NOT NULL,
  `forum_id` 			int unsigned NOT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_comments_to_forums_comment_id_idx` (`comment_id`),
  KEY `fk_comments_to_forums_forum_id_idx` (`forum_id`),
  CONSTRAINT `fk_comments_to_forums_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_to_forums_forum_id` FOREIGN KEY (`forum_id`) REFERENCES `forums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='comments to forums';




--
-- Table structure for table `comments_to_manga`
--

DROP TABLE IF EXISTS `comments_to_manga`;
CREATE TABLE `comments_to_manga` (
  `comment_id` 			int unsigned NOT NULL,
  `manga_id` 			int unsigned NOT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_comments_to_manga_comment_id_idx` (`comment_id`),
  KEY `fk_comments_to_manga_manga_id_idx` (`manga_id`),
  CONSTRAINT `fk_comments_to_manga_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_to_manga_manga_id` FOREIGN KEY (`manga_id`) REFERENCES `mangas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='comments to manga';




--
-- Table structure for table `comments_to_pages`
--

DROP TABLE IF EXISTS `comments_to_pages`;
CREATE TABLE `comments_to_pages` (
  `comment_id` 			int unsigned NOT NULL,
  `page_id` 			int unsigned NOT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_comments_to_pages_comment_id_idx` (`comment_id`),
  KEY `fk_comments_to_pages_page_id_idx` (`page_id`),
  CONSTRAINT `fk_comments_to_pages_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_to_pages_page_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='comments to pages';



--
-- Table structure for table `mangas_chapters`
--

DROP TABLE IF EXISTS `mangas_chapters`;
CREATE TABLE `mangas_chapters` (
  `manga_id` 			int unsigned NOT NULL,
  `chapter_id` 			int unsigned NOT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_mangas_chapters_manga_id_idx` (`manga_id`),
  KEY `fk_mangas_chapters_chapter_id_idx` (`chapter_id`),
  CONSTRAINT `fk_mangas_chapters_chapter_id` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mangas_chapters_manga_id` FOREIGN KEY (`manga_id`) REFERENCES `mangas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='connection between mangas and chapters tables';




--
-- Table structure for table `translators_profiles`
--

DROP TABLE IF EXISTS `translators_profiles`;
CREATE TABLE `translators_profiles` (
  `id` 					int unsigned NOT NULL AUTO_INCREMENT,
  `nickname` 			varchar(255) NOT NULL,
  `description` 		varchar(255) DEFAULT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='manga\'s translator profiles';




--
-- Table structure for table `mangas_translators`
--

DROP TABLE IF EXISTS `mangas_translators`;
CREATE TABLE `mangas_translators` (
  `manga_id` 			int unsigned NOT NULL,
  `translators_id` 		int unsigned NOT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_mangas_translators_manga_id_idx` (`manga_id`),
  KEY `fk_mangas_translators_translators_id_idx` (`translators_id`),
  CONSTRAINT `fk_mangas_translators_manga_id` FOREIGN KEY (`manga_id`) REFERENCES `mangas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mangas_translators_translators_id` FOREIGN KEY (`translators_id`) REFERENCES `translators_profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='connection between mangas and translators_profiles tables';




--
-- Table structure for table `translators_profiles_profiles`
--

DROP TABLE IF EXISTS `translators_profiles_profiles`;
CREATE TABLE `translators_profiles_profiles` (
  `translators_id` 		int unsigned NOT NULL,
  `profile_id` 			int unsigned NOT NULL,
  `created_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` 			datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_translators_profiles_users_profile_id_idx` (`profile_id`),
  KEY `fk_translators_profiles_users_translators_id_idx` (`translators_id`),
  CONSTRAINT `fk_translators_profiles_users_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_translators_profiles_users_translators_id` FOREIGN KEY (`translators_id`) REFERENCES `translators_profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='connection between translators_profilse and profiles tables';
