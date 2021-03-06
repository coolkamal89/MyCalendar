-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: MyDatesDB
-- ------------------------------------------------------
-- Server version	5.6.17

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
-- Table structure for table `dates`
--

DROP TABLE IF EXISTS `dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dates` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(45) COLLATE latin1_general_cs DEFAULT NULL,
  `event_date` datetime DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_on` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dates`
--

LOCK TABLES `dates` WRITE;
/*!40000 ALTER TABLE `dates` DISABLE KEYS */;
INSERT INTO `dates` VALUES (1,'asd','0000-00-00 00:00:00',1,1,'2016-03-24 16:49:31'),(2,'asddddd','0000-00-00 00:00:00',1,1,'2016-03-24 17:43:04'),(3,'asddddd','0000-00-00 00:00:00',1,1,'2016-03-24 17:43:06'),(4,'asddddd','0000-00-00 00:00:00',1,1,'2016-03-24 17:43:07'),(5,'fff','0000-00-00 00:00:00',4,1,'2016-03-24 17:43:18'),(6,'rrr','0000-00-00 00:00:00',0,1,'2016-03-24 17:43:33'),(7,'ggg','0000-00-00 00:00:00',0,1,'2016-03-24 17:45:26'),(8,'ggggg','0000-00-00 00:00:00',0,1,'2016-03-24 17:45:28'),(9,'ggggg222','0000-00-00 00:00:00',0,1,'2016-03-24 17:45:32');
/*!40000 ALTER TABLE `dates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_name` varchar(45) COLLATE latin1_general_cs DEFAULT NULL,
  `starred` char(1) COLLATE latin1_general_cs DEFAULT 'N',
  `created_on` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,1,'Birthdays','Y','2016-03-24 11:38:36'),(4,1,'Anniversaries','N','2016-03-24 11:39:22'),(5,1,'Reminders','Y','2016-03-24 11:47:03'),(6,1,'Work','N','2016-03-24 14:11:53');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `first_name` varchar(45) COLLATE latin1_general_cs DEFAULT NULL,
  `last_name` varchar(45) COLLATE latin1_general_cs DEFAULT NULL,
  `password` varchar(45) COLLATE latin1_general_cs DEFAULT NULL,
  `login_session_id` varchar(45) COLLATE latin1_general_cs DEFAULT NULL,
  `created_on` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`email`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'kamal','Kamal','Relwani','kamal','8788CE0E4D96C00B3388','2016-03-24 11:38:15');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'MyDatesDB'
--

--
-- Dumping routines for database 'MyDatesDB'
--
/*!50003 DROP FUNCTION IF EXISTS `fnDoesGroupBelongToUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnDoesGroupBelongToUser`() RETURNS int(11)
BEGIN

RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fnIsUserLoggedIn` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnIsUserLoggedIn`() RETURNS int(11)
BEGIN

RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spChangePassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spChangePassword`(user_id VARCHAR(50), login_session_id VARCHAR(50), password VARCHAR(50), new_password VARCHAR(50))
BEGIN
	
	DECLARE intUserLogin INT;
	DECLARE intUserLoginPasswordCorrect INT;
	
	SET intUserLogin = 0;
	SET intUserLoginPasswordCorrect = 0;

	SELECT COUNT(*)
	INTO intUserLogin
	FROM users
	WHERE users.user_id = user_id
		AND users.login_session_id = login_session_id
		AND users.login_session_id != '';

	SELECT COUNT(*)
	INTO intUserLoginPasswordCorrect
	FROM users
	WHERE users.user_id = user_id
		AND users.password = password;

	IF intUserLogin = 0 THEN
		SELECT
			false AS success,
			'' AS data,
			'User not logged in!' AS message;
	ELSE
		IF intUserLoginPasswordCorrect = 0 THEN
			SELECT
				false AS success,
				'Incorrect existing password!' AS message,
				'' AS data;
		ELSE
			UPDATE users
				SET users.password = new_password
			WHERE users.user_id = user_id
				AND users.login_session_id = login_session_id;

			SELECT
				true AS success,
				'' AS message,
				'' AS data;
		END IF;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spCheckLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spCheckLogin`(user_id VARCHAR(45), login_session_id VARCHAR(45))
BEGIN

	IF user_id != '' AND login_session_id != '' THEN
		SELECT
			user_id,
			email,
			first_name,
			last_name,
			login_session_id
		FROM users
		WHERE users.user_id = user_id
			AND users.login_session_id = login_session_id;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spCreateEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spCreateEvent`(user_id VARCHAR(50), login_session_id VARCHAR(50), group_id INT, event_name VARCHAR(50), event_date VARCHAR(50))
BEGIN
	
	DECLARE intUserLogin INT;
	DECLARE intGroupBelongsToUser INT;
	
	SET intUserLogin = 0;
	SET intGroupBelongsToUser = 0;

	SELECT COUNT(*)
	INTO intUserLogin
	FROM users
	WHERE user_id = user_id
		AND users.login_session_id = login_session_id
		AND users.login_session_id != '';

	SELECT COUNT(*)
	INTO intGroupBelongsToUser
	FROM groups
	WHERE groups.user_id = user_id
		AND groups.group_id = group_id;

	IF group_id = 0 THEN
		SET intGroupBelongsToUser = 1;
	END IF;

	IF intUserLogin = 0 THEN
		SELECT
			false AS success,
			'' AS data,
			'User not logged in!' AS message;
	ELSE
		IF intGroupBelongsToUser = 0 THEN
			SELECT
				false AS success,
				'' AS data,
				'This group doesn\'nt belong to you!' AS message;
		ELSE
			INSERT INTO dates(user_id, group_id, event_name, event_date)
			VALUES (user_id, group_id, event_name, event_date);

			IF ROW_COUNT() = 1 THEN
				CALL spGetEventsByGroupId(user_id, login_session_id, group_id);
			ELSE
				SELECT
					false AS success,
					'' AS data,
					'Error creating event!' AS message;
			END IF;
		END IF;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spCreateGroup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spCreateGroup`(user_id VARCHAR(50), login_session_id VARCHAR(50), group_name VARCHAR(50), group_star VARCHAR(1))
BEGIN
	
	DECLARE intUserLogin INT;
	DECLARE intGroupUserUnique INT;
	
	SET intUserLogin = 0;
	SET intGroupUserUnique = 0;

	SELECT COUNT(*)
	INTO intUserLogin
	FROM users
	WHERE user_id = user_id
		AND users.login_session_id = login_session_id
		AND users.login_session_id != '';

	SELECT COUNT(*)
	INTO intGroupUserUnique
	FROM groups
	WHERE groups.user_id = user_id
		AND UPPER(TRIM(groups.group_name)) = UPPER(TRIM(group_name));

	IF intUserLogin = 0 THEN
		SELECT
			false AS success,
			'' AS data,
			'User not logged in!' AS message;
	ELSE
		IF intGroupUserUnique != 0 THEN
			SELECT
				false AS success,
				'' AS data,
				'It seems you already have a group with the same name!' AS message;
		ELSE
			INSERT INTO groups(user_id, group_name, starred)
			VALUES (user_id, group_name, group_star);

			IF ROW_COUNT() = 1 THEN
				SELECT
					true AS success,
					'' AS message,
					'' AS data;
				CALL spGetGroups(user_id, login_session_id);
			ELSE
				SELECT
					false AS success,
					'' AS data,
					'Error creating group!' AS message;
			END IF;
		END IF;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spDeleteGroup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDeleteGroup`(user_id VARCHAR(50), login_session_id VARCHAR(50), group_id VARCHAR(50))
BEGIN

	DECLARE intGroupUserUnique INT;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' BEGIN END;
	
	SET intGroupUserUnique = 0;

	SELECT COUNT(*)
	INTO intGroupUserUnique
	FROM groups
	WHERE groups.user_id = user_id
		AND groups.group_id = group_id;

	IF intGroupUserUnique = 0 THEN
		SELECT
			false AS success,
			'' AS data,
			'The group you\'re trying to deleted doesn\'t exists!' AS message;
	ELSE
		DELETE
		FROM groups
		WHERE groups.group_id = group_id
			AND groups.user_id = user_id
			AND group_id != '';

		IF ROW_COUNT() = 1 THEN
			SELECT
				true AS success,
				'' AS message,
				'' AS data;
			CALL spGetGroups(user_id, login_session_id);
		ELSE
			SELECT
				false AS success,
				'' AS data,
				'Error deleting group!' AS message;
		END IF;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spEditGroup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEditGroup`(user_id VARCHAR(50), login_session_id VARCHAR(50), group_id VARCHAR(50), group_name VARCHAR(50), group_star VARCHAR(1))
BEGIN
	
	DECLARE intUserLogin INT;
	DECLARE intGroupUserUnique INT;
	
	SET intUserLogin = 0;
	SET intGroupUserUnique = 0;

	SELECT COUNT(*)
	INTO intUserLogin
	FROM users
	WHERE users.user_id = user_id
		AND users.login_session_id = login_session_id
		AND users.login_session_id != '';

	SELECT COUNT(*)
	INTO intGroupUserUnique
	FROM groups
	WHERE groups.user_id = user_id
		AND groups.group_id != group_id
		AND UPPER(TRIM(groups.group_name)) = UPPER(TRIM(group_name));

	IF intUserLogin = 0 THEN
		SELECT
			false AS success,
			'' AS data,
			'User not logged in!' AS message;
	ELSE
		IF intGroupUserUnique != 0 THEN
			SELECT
				false AS success,
				'' AS data,
				'It seems you already have a group with the same name!' AS message;
		ELSE
			UPDATE groups
				SET groups.group_name = group_name,
					groups.starred = group_star
			WHERE groups.group_id = group_id
				AND groups.user_id = user_id;

			SELECT
				true AS success,
				'' AS message,
				'' AS data;
			CALL spGetGroups(user_id, login_session_id);
		END IF;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGetEventsByGroupId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetEventsByGroupId`(user_id VARCHAR(50), login_session_id VARCHAR(50), group_id INT)
BEGIN

	DECLARE intUserLogin INT;
	DECLARE intGroupBelongsToUser INT;
	
	SET intUserLogin = 0;
	SET intGroupBelongsToUser = 0;

	SELECT COUNT(*)
	INTO intUserLogin
	FROM users
	WHERE user_id = user_id
		AND users.login_session_id = login_session_id
		AND users.login_session_id != '';

	SELECT COUNT(*)
	INTO intGroupBelongsToUser
	FROM groups
	WHERE groups.user_id = user_id
		AND groups.group_id = group_id;

	SELECT COUNT(*)
	INTO intGroupBelongsToUser
	FROM groups
	WHERE groups.user_id = user_id
		AND groups.group_id = group_id OR group_id = 0;

	IF intUserLogin = 0 THEN
		SELECT
			false AS success,
			'' AS data,
			'User not logged in!' AS message;
	ELSE
		IF intGroupBelongsToUser = 0 THEN
			SELECT
				false AS success,
				'' AS data,
				'This group doesn\' belong to you!' AS message;
		ELSE
			SELECT
					true AS success,
					'' AS message,
					'' AS data;

			SELECT *
			FROM dates
			WHERE dates.user_id = user_id
				AND dates.group_id = group_id;
		END IF;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGetGroupDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetGroupDetails`(user_id VARCHAR(50), login_session_id VARCHAR(50), group_id INT)
BEGIN
	
	DECLARE intUserLogin INT;
	DECLARE intGroupBelongsToUser INT;
	
	SET intUserLogin = 0;
	SET intGroupBelongsToUser = 0;

	SELECT COUNT(*)
	INTO intUserLogin
	FROM users
	WHERE user_id = user_id
		AND users.login_session_id = login_session_id
		AND users.login_session_id != '';

	SELECT COUNT(*)
	INTO intGroupBelongsToUser
	FROM groups
	WHERE groups.user_id = user_id
		AND groups.group_id = group_id OR group_id = 0;

	IF intUserLogin = 0 THEN
		SELECT
			false AS success,
			'' AS data,
			'User not logged in!' AS message;
	ELSE
		IF intGroupBelongsToUser = 0 THEN
			SELECT
				false AS success,
				'' AS data,
				'Group doesn\'t belong to you!' AS message;
		ELSE
			SELECT
				true AS success,
				'' AS message,
				'' AS data;
			
			IF group_id = 0 THEN
				SELECT 'Default' as 'group_name';
			ELSE
				SELECT
					group_name,
					starred
				FROM groups
				WHERE groups.group_id = group_id
					AND groups.user_id = user_id;
			END IF;

		END IF;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGetGroups` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetGroups`(user_id VARCHAR(50), login_session_id VARCHAR(50))
BEGIN

	DECLARE intDefaultEventsCount INT;
	
	SET intDefaultEventsCount = 0;

	SELECT COUNT(*)
	INTO intDefaultEventsCount
	FROM dates d
		INNER JOIN users u ON u.user_id = d.user_id
	WHERE d.user_id = user_id
		AND u.login_session_id = login_session_id
		AND u.login_session_id != ''
	AND d.group_id = 0;

	SELECT
		0 AS group_id,
		'Default' AS group_name,
		'' AS created_on,
		'N' AS starred,
		intDefaultEventsCount AS event_count
	UNION
	SELECT
		g.group_id,
		g.group_name,
		g.created_on,
		g.starred,
		COUNT(d.event_id) AS event_count
	FROM groups g
		INNER JOIN users u ON g.user_id = u.user_id
		LEFT OUTER JOIN dates d ON g.group_id = d.group_id
	WHERE g.user_id = user_id
		AND u.login_session_id = login_session_id
		AND u.login_session_id != ''
	GROUP BY g.group_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLogin`(email VARCHAR(45), password VARCHAR(45))
BEGIN
	UPDATE users
		SET users.login_session_id = UPPER(SUBSTRING(MD5(RAND()) FROM 1 FOR 20))
	WHERE users.email = email;

	SELECT
		user_id,
		email,
		first_name,
		last_name,
		login_session_id
	FROM users
	WHERE users.email = email
		AND users.password = password;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLogout` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLogout`(user_id VARCHAR(45), login_session_id VARCHAR(45))
BEGIN

	UPDATE users
		SET users.login_session_id = ''
	WHERE users.user_id = user_id
		AND users.login_session_id = login_session_id;

	IF ROW_COUNT() = 1 THEN
		SELECT 'TRUE';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spRegister` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spRegister`(email VARCHAR(50), password VARCHAR(50), first_name VARCHAR(50), last_name VARCHAR(50))
BEGIN
	
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' BEGIN END;

	INSERT INTO users(email, password, first_name, last_name)
		VALUES (email, password, first_name, last_name);

	IF ROW_COUNT() = 1 THEN
		SELECT
			true AS success,
			'' AS message,
			'' AS data;
		CALL spLogin(email, password);
	ELSE
		SELECT
			false AS success,
			'' AS data,
			'Email address already exists!' AS message;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spUpdateProfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spUpdateProfile`(user_id VARCHAR(50), login_session_id VARCHAR(50), first_name VARCHAR(50), last_name VARCHAR(50))
BEGIN
	
	DECLARE intUserLogin INT;
	
	SET intUserLogin = 0;

	SELECT COUNT(*)
	INTO intUserLogin
	FROM users
	WHERE users.user_id = user_id
		AND users.login_session_id = login_session_id
		AND users.login_session_id != '';

	IF intUserLogin = 0 THEN
		SELECT
			false AS success,
			'' AS data,
			'User not logged in!' AS message;
	ELSE
		UPDATE users
			SET users.first_name = first_name,
				users.last_name = last_name
		WHERE users.user_id = user_id;

		SELECT
			true AS success,
			'' AS message,
			'' AS data;
		CALL spCheckLogin(user_id, login_session_id);
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-24 18:13:02
