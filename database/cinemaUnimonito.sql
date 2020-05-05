CREATE DATABASE  IF NOT EXISTS `cinemaunimonito` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cinemaunimonito`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: cinemaunimonito
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `boletas`
--

DROP TABLE IF EXISTS `boletas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boletas` (
  `idCompBoleta` int NOT NULL AUTO_INCREMENT,
  `numeroBoletasGe` int NOT NULL,
  `numeroBoletasPe` int NOT NULL,
  `totalPrecioBoletas` int NOT NULL,
  PRIMARY KEY (`idCompBoleta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boletas`
--

LOCK TABLES `boletas` WRITE;
/*!40000 ALTER TABLE `boletas` DISABLE KEYS */;
/*!40000 ALTER TABLE `boletas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `confiteria`
--

DROP TABLE IF EXISTS `confiteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `confiteria` (
  `idConfiteria` int NOT NULL,
  `cantidadProducto` int NOT NULL,
  `nombreProducto` varchar(45) NOT NULL,
  `fk_Multiplex` int NOT NULL,
  `pagoConfiteria` int NOT NULL,
  `Confiteriacol` varchar(45) NOT NULL,
  PRIMARY KEY (`idConfiteria`),
  KEY `idMultiplex01_idx` (`fk_Multiplex`),
  CONSTRAINT `fk_multiplex` FOREIGN KEY (`fk_Multiplex`) REFERENCES `multiplex` (`idMultiplex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `confiteria`
--

LOCK TABLES `confiteria` WRITE;
/*!40000 ALTER TABLE `confiteria` DISABLE KEYS */;
/*!40000 ALTER TABLE `confiteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `idEmpleado` int NOT NULL,
  `numeroCedula` int NOT NULL,
  `tipo_Documento` int NOT NULL,
  `nombres` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `numeroTelefono` int NOT NULL,
  `fechaInicioContrato` varchar(45) NOT NULL,
  `salario` int NOT NULL,
  `cargo` varchar(45) NOT NULL,
  `multiplexEmpleado` varchar(45) NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  KEY `fk_tipoDocumento02_idx` (`tipo_Documento`),
  CONSTRAINT `fk_tipoDocumento02` FOREIGN KEY (`tipo_Documento`) REFERENCES `tipodocumento` (`idTipoDocumento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funciones`
--

DROP TABLE IF EXISTS `funciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funciones` (
  `idFunciones` int NOT NULL AUTO_INCREMENT,
  `id_Pelicula` int NOT NULL,
  `horaInicio` varchar(45) NOT NULL,
  `diaPresentacion` varchar(45) NOT NULL,
  PRIMARY KEY (`idFunciones`),
  KEY `idPeliculas01_idx` (`id_Pelicula`),
  CONSTRAINT `fk_peliculas` FOREIGN KEY (`id_Pelicula`) REFERENCES `peliculas` (`idPelicula`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funciones`
--

LOCK TABLES `funciones` WRITE;
/*!40000 ALTER TABLE `funciones` DISABLE KEYS */;
INSERT INTO `funciones` VALUES (1,1,'10:30 a. m.','25/05/2020'),(2,2,'12:30 p. m.','26/05/2020'),(3,3,'01:30 p. m.','27/05/2020'),(4,4,'05:40 p. m.','25/05/2020');
/*!40000 ALTER TABLE `funciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inforeserva`
--

DROP TABLE IF EXISTS `inforeserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inforeserva` (
  `idinfoReserva` int NOT NULL AUTO_INCREMENT,
  `id_Reserva` int NOT NULL,
  `metodo_Pago` int NOT NULL,
  `Pagocol` varchar(45) NOT NULL,
  `seleccionarSilla` varchar(45) NOT NULL,
  `fechaReserva` varchar(45) NOT NULL,
  `estadoReserva` varchar(45) NOT NULL,
  PRIMARY KEY (`idinfoReserva`),
  KEY `idReserva01_idx` (`id_Reserva`),
  KEY `metodoPagoFK_idx` (`metodo_Pago`),
  CONSTRAINT `fk_metodoPago` FOREIGN KEY (`metodo_Pago`) REFERENCES `metodospago` (`idMetodoPago`),
  CONSTRAINT `fk_reserva` FOREIGN KEY (`id_Reserva`) REFERENCES `reservas` (`idReserva`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inforeserva`
--

LOCK TABLES `inforeserva` WRITE;
/*!40000 ALTER TABLE `inforeserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `inforeserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `links`
--

DROP TABLE IF EXISTS `links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `links` (
  `idLinks` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `url` varchar(255) NOT NULL,
  `descripcion` text,
  `usuario_doc` int DEFAULT NULL,
  `creado_el` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idLinks`),
  KEY `fk_usuario_idx` (`usuario_doc`),
  CONSTRAINT `fk_usuario` FOREIGN KEY (`usuario_doc`) REFERENCES `registroclientes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `links`
--

LOCK TABLES `links` WRITE;
/*!40000 ALTER TABLE `links` DISABLE KEYS */;
INSERT INTO `links` VALUES (42,'brayan ','https://www.youtube.com/watch?v=yoH4bw_KNho',' ss ssdd',18,'2020-04-12 06:31:58'),(43,'Facebook','http://facebook.com','sws',18,'2020-04-12 06:35:26'),(44,'Batman','http://netflix.com','buena pelicula',21,'2020-04-16 22:22:51'),(45,'Facebook','https://www.youtube.com/watch?v=yoH4bw_KNho','derscripcion',22,'2020-04-16 22:42:54');
/*!40000 ALTER TABLE `links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodospago`
--

DROP TABLE IF EXISTS `metodospago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodospago` (
  `idMetodoPago` int NOT NULL,
  `metodo_Pago` varchar(45) NOT NULL,
  PRIMARY KEY (`idMetodoPago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodospago`
--

LOCK TABLES `metodospago` WRITE;
/*!40000 ALTER TABLE `metodospago` DISABLE KEYS */;
/*!40000 ALTER TABLE `metodospago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multiplex`
--

DROP TABLE IF EXISTS `multiplex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `multiplex` (
  `idMultiplex` int NOT NULL AUTO_INCREMENT,
  `nombreMultiplex` varchar(45) NOT NULL,
  `numeroSalas` int NOT NULL,
  `cantidadSillas` int NOT NULL,
  `idConfiteria` int NOT NULL,
  PRIMARY KEY (`idMultiplex`,`numeroSalas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multiplex`
--

LOCK TABLES `multiplex` WRITE;
/*!40000 ALTER TABLE `multiplex` DISABLE KEYS */;
/*!40000 ALTER TABLE `multiplex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peliculas`
--

DROP TABLE IF EXISTS `peliculas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peliculas` (
  `idPelicula` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `informacionPelicula` varchar(250) NOT NULL,
  `duracionPelicula` varchar(25) NOT NULL,
  `fechaEstreno` varchar(45) NOT NULL,
  `foto` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idPelicula`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peliculas`
--

LOCK TABLES `peliculas` WRITE;
/*!40000 ALTER TABLE `peliculas` DISABLE KEYS */;
INSERT INTO `peliculas` VALUES (1,'Black Widow','Pelicula de Super Heroes','2h 25m','2020-11-06','https://i.ibb.co/QXm0hzT/Black-Widow-P-ster-Oficial.png'),(2,'richard jewell ','Pelicula de Historia','2h 11m','2020-01-01','https://i.ibb.co/PWFGh2L/2256195.jpg'),(3,'SuperMan','Pelicula de Super Heroe','2h 24m','2020-05-12','https://i.ibb.co/2ts03JY/la-liga-de-la-justicia-superman-i51000.jpg'),(4,'duende','mitos','1h 22m','2020-05-15','https://i.ibb.co/QX9Grj2/5acb4df6744224b64fe0d703dec06d60.jpg'),(17,'Harley Queen','Pelicula de Accion','1h 45m','2020-01-25','https://i.ibb.co/L88F8Hw/9aeca7f248efbbe258cdb6425013e2cb.jpg');
/*!40000 ALTER TABLE `peliculas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puntoscompras`
--

DROP TABLE IF EXISTS `puntoscompras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `puntoscompras` (
  `idpuntosCompra` int NOT NULL,
  `numero_Documento` int NOT NULL,
  `puntosCompraBoleta` int NOT NULL,
  `puntosCompraConfiteria` int NOT NULL,
  `totalPuntos` int NOT NULL,
  PRIMARY KEY (`idpuntosCompra`),
  KEY `numeroDocumento2_idx` (`numero_Documento`),
  CONSTRAINT `fk_noDocumento` FOREIGN KEY (`numero_Documento`) REFERENCES `registroclientes` (`numeroDocumento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puntoscompras`
--

LOCK TABLES `puntoscompras` WRITE;
/*!40000 ALTER TABLE `puntoscompras` DISABLE KEYS */;
/*!40000 ALTER TABLE `puntoscompras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registroclientes`
--

DROP TABLE IF EXISTS `registroclientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registroclientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numeroDocumento` int NOT NULL,
  `password` varchar(90) NOT NULL,
  `tipoDocumento` int NOT NULL,
  `nombres` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `celular` varchar(45) NOT NULL,
  PRIMARY KEY (`numeroDocumento`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_tipoDocumento01_idx` (`tipoDocumento`),
  CONSTRAINT `fk_tipoDocumento01` FOREIGN KEY (`tipoDocumento`) REFERENCES `tipodocumento` (`idTipoDocumento`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registroclientes`
--

LOCK TABLES `registroclientes` WRITE;
/*!40000 ALTER TABLE `registroclientes` DISABLE KEYS */;
INSERT INTO `registroclientes` VALUES (20,123456,'$2a$10$lit8tjWEMa1cXkloBg2rBeiLJ/tXNjhiGzMm76a7GOmrN8Rbcipp.',1,'laura','D','dayannauseche0@gmail.com','31456897'),(19,145987,'$2a$10$9TPEqHt3819Af77jDwWoSOvzkpbHhERN8wRipWHxX7c92IclGjwua',1,'laura','D','brayandiazpiedrahita@gmail.com','3017998128'),(22,102459874,'$2a$10$X1nyNDu6D/zsNw71XEvkb.oxOr/mnh0DHyAjoqlw38OiyI6zRwrBG',1,'juan','fernandez','bdiazpiedra@uniminuto.edu.co','3017998128'),(21,1012459986,'$2a$10$Wfa45hL00S8B84DFPyYmiOgEadUsF/tFOSTRaSw6di5pRaCIn.RQS',1,'Laura ','Piedrahita','laura@gmail.com','3154869753'),(18,1022416695,'$2a$10$FSE29eJSx302Tk0SAgAe9u0NmyDgZmbzRslHBjZNy80R6v8KpsNJq',1,'Brayan steven','diaz piedrahita ','brayandiazpiedrahita@gmail.com','3017998128');
/*!40000 ALTER TABLE `registroclientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservas`
--

DROP TABLE IF EXISTS `reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservas` (
  `idReserva` int NOT NULL AUTO_INCREMENT,
  `idUsusario` int NOT NULL,
  `seleccionarPelicula` int NOT NULL,
  `seleccionarMultiplex` int NOT NULL,
  `seleccionarSala` int NOT NULL,
  `idCompBoletas` int NOT NULL,
  PRIMARY KEY (`idReserva`),
  KEY `numeroDocumento1_idx` (`idUsusario`),
  KEY `seleccionarSala1_idx` (`seleccionarSala`),
  KEY `seleccionarMultiplex1_idx` (`seleccionarMultiplex`),
  KEY `seleccionarPelicula1_idx` (`seleccionarPelicula`),
  KEY `idCompPelicula01_idx` (`idCompBoletas`),
  CONSTRAINT `fk_compBoletas` FOREIGN KEY (`idCompBoletas`) REFERENCES `boletas` (`idCompBoleta`),
  CONSTRAINT `fk_numeroDocumento` FOREIGN KEY (`idUsusario`) REFERENCES `registroclientes` (`numeroDocumento`),
  CONSTRAINT `fk_numeroIdEmpleado` FOREIGN KEY (`idUsusario`) REFERENCES `empleados` (`idEmpleado`),
  CONSTRAINT `fk_selectMultiplex` FOREIGN KEY (`seleccionarMultiplex`) REFERENCES `multiplex` (`idMultiplex`),
  CONSTRAINT `fk_selectPelicula` FOREIGN KEY (`seleccionarPelicula`) REFERENCES `peliculas` (`idPelicula`),
  CONSTRAINT `fk_selectSala` FOREIGN KEY (`seleccionarSala`) REFERENCES `salas` (`idSala`),
  CONSTRAINT `fk_usuarioEmpleado` FOREIGN KEY (`idUsusario`) REFERENCES `empleados` (`idEmpleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservas`
--

LOCK TABLES `reservas` WRITE;
/*!40000 ALTER TABLE `reservas` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salas`
--

DROP TABLE IF EXISTS `salas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salas` (
  `idSala` int NOT NULL,
  `numeroSilla` int NOT NULL,
  `nombreSala` varchar(45) NOT NULL,
  `cantidadSillasDisponiblesPreferenciales` int NOT NULL,
  `cantidadSillasDisponiblesGenerales` int NOT NULL,
  `precioSillasGenerales` int NOT NULL,
  `precioSillasPreferenciales` int NOT NULL,
  PRIMARY KEY (`idSala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salas`
--

LOCK TABLES `salas` WRITE;
/*!40000 ALTER TABLE `salas` DISABLE KEYS */;
/*!40000 ALTER TABLE `salas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salas_has_funciones`
--

DROP TABLE IF EXISTS `salas_has_funciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salas_has_funciones` (
  `Salas_idSala` int NOT NULL,
  `Funciones_idFunciones` int NOT NULL,
  PRIMARY KEY (`Salas_idSala`,`Funciones_idFunciones`),
  KEY `fk_Salas_has_Funciones_Funciones1_idx` (`Funciones_idFunciones`),
  KEY `fk_Salas_has_Funciones_Salas1_idx` (`Salas_idSala`),
  CONSTRAINT `fk_Salas_has_Funciones_Funciones1` FOREIGN KEY (`Funciones_idFunciones`) REFERENCES `funciones` (`idFunciones`),
  CONSTRAINT `fk_Salas_has_Funciones_Salas1` FOREIGN KEY (`Salas_idSala`) REFERENCES `salas` (`idSala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salas_has_funciones`
--

LOCK TABLES `salas_has_funciones` WRITE;
/*!40000 ALTER TABLE `salas_has_funciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `salas_has_funciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int unsigned NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('909ZtKjoMSYd3tw34qr-M1nrkrNseu2H',1588795380,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{\"user\":18}}'),('pYCsaOA74rVyTcmNVF39y9eLCZgNtA1Q',1588743166,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{\"user\":18}}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipodocumento`
--

DROP TABLE IF EXISTS `tipodocumento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipodocumento` (
  `idTipoDocumento` int NOT NULL AUTO_INCREMENT,
  `tipoDocumento` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipoDocumento`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipodocumento`
--

LOCK TABLES `tipodocumento` WRITE;
/*!40000 ALTER TABLE `tipodocumento` DISABLE KEYS */;
INSERT INTO `tipodocumento` VALUES (1,'C.C.'),(2,'T.I.'),(3,'C.E.');
/*!40000 ALTER TABLE `tipodocumento` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-05 15:19:23
