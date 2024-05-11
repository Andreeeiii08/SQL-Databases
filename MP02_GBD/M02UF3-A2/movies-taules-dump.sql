-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: movies
-- ------------------------------------------------------
-- Server version	8.0.35
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actors`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actors` (
  `id_actor` int NOT NULL AUTO_INCREMENT,
  `actor` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_actor`),
  UNIQUE KEY `actor` (`actor`)
) ENGINE=InnoDB AUTO_INCREMENT=2048 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directors`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `directors` (
  `id_director` int NOT NULL AUTO_INCREMENT,
  `director` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_director`),
  UNIQUE KEY `director` (`director`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estudis`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudis` (
  `id_estudi` int NOT NULL AUTO_INCREMENT,
  `estudis` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_estudi`),
  UNIQUE KEY `estudis` (`estudis`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gèneres`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gèneres` (
  `id_genere` int NOT NULL AUTO_INCREMENT,
  `genere` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_genere`),
  UNIQUE KEY `genere` (`genere`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `països`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `països` (
  `id_pais` int NOT NULL AUTO_INCREMENT,
  `pais` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_pais`),
  UNIQUE KEY `pais` (`pais`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pellicules`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pellicules` (
  `id_movie` int NOT NULL,
  `titol` varchar(100) DEFAULT NULL,
  `any` int DEFAULT NULL,
  `vots` int DEFAULT NULL,
  PRIMARY KEY (`id_movie`),
  UNIQUE KEY `titol` (`titol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pellicules_directors`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pellicules_directors` (
  `id_movie` int NOT NULL,
  `id_director` int NOT NULL,
  PRIMARY KEY (`id_movie`,`id_director`),
  KEY `id_director` (`id_director`),
  CONSTRAINT `pellicules_directors_ibfk_1` FOREIGN KEY (`id_movie`) REFERENCES `pellicules` (`id_movie`),
  CONSTRAINT `pellicules_directors_ibfk_2` FOREIGN KEY (`id_director`) REFERENCES `directors` (`id_director`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pellicules_estudis`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pellicules_estudis` (
  `id_movie` int NOT NULL,
  `id_estudi` int NOT NULL,
  PRIMARY KEY (`id_movie`,`id_estudi`),
  KEY `id_estudi` (`id_estudi`),
  CONSTRAINT `pellicules_estudis_ibfk_1` FOREIGN KEY (`id_movie`) REFERENCES `pellicules` (`id_movie`),
  CONSTRAINT `pellicules_estudis_ibfk_2` FOREIGN KEY (`id_estudi`) REFERENCES `estudis` (`id_estudi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pellicules_gèneres`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pellicules_gèneres` (
  `id_movie` int NOT NULL,
  `id_genere` int NOT NULL,
  PRIMARY KEY (`id_movie`,`id_genere`),
  KEY `id_genere` (`id_genere`),
  CONSTRAINT `pellicules_gèneres_ibfk_1` FOREIGN KEY (`id_movie`) REFERENCES `pellicules` (`id_movie`),
  CONSTRAINT `pellicules_gèneres_ibfk_2` FOREIGN KEY (`id_genere`) REFERENCES `gèneres` (`id_genere`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pellicules_països`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pellicules_països` (
  `id_movie` int NOT NULL,
  `id_pais` int NOT NULL,
  PRIMARY KEY (`id_movie`,`id_pais`),
  KEY `id_pais` (`id_pais`),
  CONSTRAINT `pellicules_països_ibfk_1` FOREIGN KEY (`id_movie`) REFERENCES `pellicules` (`id_movie`),
  CONSTRAINT `pellicules_països_ibfk_2` FOREIGN KEY (`id_pais`) REFERENCES `països` (`id_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repartiment`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repartiment` (
  `id_movie` int DEFAULT NULL,
  `id_actor` int DEFAULT NULL,
  `rol` varchar(200) DEFAULT NULL,
  KEY `id_movie` (`id_movie`),
  KEY `id_actor` (`id_actor`),
  CONSTRAINT `repartiment_ibfk_1` FOREIGN KEY (`id_movie`) REFERENCES `pellicules` (`id_movie`),
  CONSTRAINT `repartiment_ibfk_2` FOREIGN KEY (`id_actor`) REFERENCES `actors` (`id_actor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-27 23:56:44
