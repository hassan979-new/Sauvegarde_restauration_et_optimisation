-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: universite
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `cours`
--

DROP TABLE IF EXISTS `cours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cours` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credits` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `enseignement`
--

DROP TABLE IF EXISTS `enseignement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enseignement` (
  `cours_id` int NOT NULL,
  `professeur_id` int NOT NULL,
  `semestre` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`cours_id`,`professeur_id`),
  KEY `professeur_id` (`professeur_id`),
  CONSTRAINT `enseignement_ibfk_1` FOREIGN KEY (`cours_id`) REFERENCES `cours` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `enseignement_ibfk_2` FOREIGN KEY (`professeur_id`) REFERENCES `professeur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etudiant`
--

DROP TABLE IF EXISTS `etudiant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etudiant` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `examen`
--

DROP TABLE IF EXISTS `examen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examen` (
  `id` int NOT NULL AUTO_INCREMENT,
  `inscription_etudiant_id` int DEFAULT NULL,
  `inscription_cours_id` int DEFAULT NULL,
  `inscription_professeur_id` int DEFAULT NULL,
  `inscription_date_inscription` date DEFAULT NULL,
  `date_examen` date DEFAULT NULL,
  `score` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inscription_etudiant_id` (`inscription_etudiant_id`,`inscription_cours_id`,`inscription_professeur_id`,`inscription_date_inscription`),
  CONSTRAINT `examen_ibfk_1` FOREIGN KEY (`inscription_etudiant_id`, `inscription_cours_id`, `inscription_professeur_id`, `inscription_date_inscription`) REFERENCES `inscription` (`etudiant_id`, `enseignement_cours_id`, `enseignement_professeur_id`, `date_inscreption`) ON DELETE CASCADE,
  CONSTRAINT `examen_chk_1` CHECK ((`score` between 0 and 20))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inscription`
--

DROP TABLE IF EXISTS `inscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscription` (
  `etudiant_id` int NOT NULL,
  `enseignement_cours_id` int NOT NULL,
  `enseignement_professeur_id` int NOT NULL,
  `date_inscreption` date NOT NULL,
  PRIMARY KEY (`etudiant_id`,`enseignement_cours_id`,`enseignement_professeur_id`,`date_inscreption`),
  KEY `enseignement_cours_id` (`enseignement_cours_id`,`enseignement_professeur_id`),
  CONSTRAINT `inscription_ibfk_1` FOREIGN KEY (`etudiant_id`) REFERENCES `etudiant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inscription_ibfk_2` FOREIGN KEY (`enseignement_cours_id`, `enseignement_professeur_id`) REFERENCES `enseignement` (`cours_id`, `professeur_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `professeur`
--

DROP TABLE IF EXISTS `professeur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professeur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departement` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `vue_etudiant_charges`
--

DROP TABLE IF EXISTS `vue_etudiant_charges`;
/*!50001 DROP VIEW IF EXISTS `vue_etudiant_charges`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vue_etudiant_charges` AS SELECT 
 1 AS `etudiant`,
 1 AS `nombre_inscription`,
 1 AS `somme_credits`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vue_performances`
--

DROP TABLE IF EXISTS `vue_performances`;
/*!50001 DROP VIEW IF EXISTS `vue_performances`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vue_performances` AS SELECT 
 1 AS `etudiant_id`,
 1 AS `nom`,
 1 AS `moyenne_score`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vue_etudiant_charges`
--

/*!50001 DROP VIEW IF EXISTS `vue_etudiant_charges`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vue_etudiant_charges` AS select `e`.`nom` AS `etudiant`,count(`i`.`enseignement_cours_id`) AS `nombre_inscription`,sum(`c`.`credits`) AS `somme_credits` from (((`etudiant` `e` join `inscription` `i` on((`e`.`id` = `i`.`etudiant_id`))) join `enseignement` `ens` on(((`i`.`enseignement_cours_id` = `ens`.`cours_id`) and (`i`.`enseignement_professeur_id` = `ens`.`professeur_id`)))) join `cours` `c` on((`ens`.`cours_id` = `c`.`id`))) group by `e`.`id`,`e`.`nom` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vue_performances`
--

/*!50001 DROP VIEW IF EXISTS `vue_performances`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vue_performances` AS select `e`.`id` AS `etudiant_id`,`e`.`nom` AS `nom`,round(avg(`ex`.`score`),2) AS `moyenne_score` from ((`etudiant` `e` left join `inscription` `i` on((`e`.`id` = `i`.`etudiant_id`))) left join `examen` `ex` on(((`ex`.`inscription_etudiant_id` = `i`.`etudiant_id`) and (`ex`.`inscription_cours_id` = `i`.`enseignement_cours_id`) and (`ex`.`inscription_professeur_id` = `i`.`enseignement_professeur_id`) and (`ex`.`inscription_date_inscription` = `i`.`date_inscreption`)))) group by `e`.`id`,`e`.`nom` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-27 23:40:59
