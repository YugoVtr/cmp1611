-- Criar banco
DROP DATABASE IF EXISTS `cmp1611` ;
CREATE DATABASE `cmp1611` ;
USE `cmp1611`;

-- Criar tabelas
DROP TABLE IF EXISTS `TIPO_USUARIO`;
CREATE TABLE `TIPO_USUARIO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DESCRICAO` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ;

DROP TABLE IF EXISTS `USUARIO`;
CREATE TABLE `USUARIO` (
  `EMAIL` varchar(64) NOT NULL,
  `NOME` varchar(500) NOT NULL ,
  `SENHA` varchar(128) DEFAULT NULL,
  `TIPO_USUARIO_ID` INT NOT NULL,
  PRIMARY KEY (`EMAIL`),
  CONSTRAINT `USUARIO_fk_1` FOREIGN KEY (`TIPO_USUARIO_ID`) REFERENCES `TIPO_USUARIO` (`ID`)
) ;

DROP TABLE IF EXISTS `LINHA`;
CREATE TABLE `LINHA` (
  `NUMERO_LINHA` INT NOT NULL,
  `DESCRICAO` varchar(500) NOT NULL ,
  PRIMARY KEY (`NUMERO_LINHA`)
) ;

DROP TABLE IF EXISTS `ONIBUS`;
CREATE TABLE `ONIBUS` (
  `PLACA` varchar(64) NOT NULL,
  `DESCRICAO` varchar(500) NOT NULL ,
  `NUMERO_LINHA` INT NOT NULL ,
  PRIMARY KEY (`PLACA`),
  CONSTRAINT `ONIBUS_fk_1` FOREIGN KEY (`NUMERO_LINHA`) REFERENCES `LINHA` (`NUMERO_LINHA`)
) ;

DROP TABLE IF EXISTS `PONTO`;
CREATE TABLE `PONTO` (
  `NUMERO_PONTO` INT NOT NULL,
  `ENDERECO` varchar(500) NOT NULL,
  `PONTO_REFERENCIA` varchar(500),
  PRIMARY KEY (`NUMERO_PONTO`)
) ;

DROP TABLE IF EXISTS `PONTO_DA_LINHA`;
CREATE TABLE `PONTO_DA_LINHA` (
  `NUMERO_LINHA` INT NOT NULL,
  `NUMERO_PONTO` INT NOT NULL,
  `POSICAO_NA_LINHA` INT NOT NULL,
  PRIMARY KEY (`NUMERO_PONTO`, `NUMERO_LINHA`),
  CONSTRAINT `PONTO_DA_LINHA_fk_1` FOREIGN KEY (`NUMERO_LINHA`) REFERENCES `LINHA` (`NUMERO_LINHA`),
  CONSTRAINT `PONTO_DA_LINHA_fk_2` FOREIGN KEY (`NUMERO_PONTO`) REFERENCES `PONTO` (`NUMERO_PONTO`)
) ;

DROP TABLE IF EXISTS `HORARIO`;
CREATE TABLE `HORARIO` (
  `NUMERO_LINHA` INT NOT NULL,
  `NUMERO_PONTO` INT NOT NULL,
  `HORARIO_PARADA` TIME NOT NULL,
  PRIMARY KEY (`NUMERO_PONTO`, `NUMERO_LINHA`),
  CONSTRAINT `HORARIO_fk_1` FOREIGN KEY (`NUMERO_LINHA`, `NUMERO_PONTO`) REFERENCES `PONTO_DA_LINHA` (`NUMERO_LINHA`, `NUMERO_PONTO`)
) ;

DROP TABLE IF EXISTS `CONSULTA`;
CREATE TABLE `CONSULTA` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `EMAIL` varchar(64) NOT NULL,
  `DATA_HORA_CONSULTA` DATE NOT NULL,
  `NUMERO_PONTO` INT NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `CONSULTA_fk_1` FOREIGN KEY (`EMAIL`) REFERENCES `USUARIO` (`EMAIL`),
  CONSTRAINT `CONSULTA_fk_2` FOREIGN KEY (`NUMERO_PONTO`) REFERENCES `PONTO` (`NUMERO_PONTO`)
) ;
