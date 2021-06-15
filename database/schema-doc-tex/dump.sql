CREATE DATABASE  IF NOT EXISTS `hospital` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `hospital`;
-- MySQL dump 10.13  Distrib 5.7.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hospital
-- ------------------------------------------------------
-- Server version	5.7.31

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
-- Table structure for table `atendimento`
--

DROP TABLE IF EXISTS `atendimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atendimento` (
  `sala` char(10) NOT NULL,
  `atendimento_id` int(11) NOT NULL AUTO_INCREMENT,
  `horario_inicio_real` datetime DEFAULT NULL,
  `horario_fim_real` datetime DEFAULT NULL,
  `horario_agendado` datetime DEFAULT NULL,
  `estado` int(11) NOT NULL,
  `crm` bigint(20) NOT NULL,
  `plano_de_saude_id` int(11) DEFAULT NULL,
  `tipo_de_atendimento_id` int(11) DEFAULT NULL,
  `tratamento_id` int(11) DEFAULT NULL,
  `valor` int(11) NOT NULL,
  `comissao_da_clinica` int(11) NOT NULL,
  `data_de_recebimento` datetime DEFAULT NULL,
  `valor_recebidos_por_medico` int(11) NOT NULL,
  `data_do_reparsse_ao_medico` datetime DEFAULT NULL,
  `imposto_retido` int(11) NOT NULL,
  `valor_pago_pelo_plano` int(11) NOT NULL,
  PRIMARY KEY (`atendimento_id`),
  KEY `FK_Atendimento_2` (`crm`),
  KEY `FK_Atendimento_3` (`tipo_de_atendimento_id`),
  KEY `FK_Atendimento_4` (`tratamento_id`),
  KEY `FK_Atendimento_5` (`plano_de_saude_id`)
) ENGINE=MyISAM AUTO_INCREMENT=446 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `atendimento_esperado`
--

DROP TABLE IF EXISTS `atendimento_esperado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atendimento_esperado` (
  `tipo_de_tratamento_id` int(11) NOT NULL,
  `tipo_de_atendimento_id` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  PRIMARY KEY (`tipo_de_tratamento_id`,`tipo_de_atendimento_id`),
  KEY `FK_atendimento_esperado_3` (`tipo_de_atendimento_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `CPF` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`CPF`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger colocar_cliente_no_plano_nenhum
	after insert on cliente
	for each row
	begin
		insert into cliente_plano_de_saude 
        (cpf, plano_de_saude_id) values
        (new.cpf, 1);
	end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cliente_plano_de_saude`
--

DROP TABLE IF EXISTS `cliente_plano_de_saude`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente_plano_de_saude` (
  `CPF` bigint(20) unsigned NOT NULL,
  `plano_de_saude_id` int(11) NOT NULL,
  PRIMARY KEY (`CPF`,`plano_de_saude_id`),
  KEY `FK_cliente_plano_de_saude_2` (`plano_de_saude_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compete`
--

DROP TABLE IF EXISTS `compete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compete` (
  `tipo_de_atendimento_id` int(11) DEFAULT NULL,
  `especialidade_id` int(11) DEFAULT NULL,
  KEY `FK_compete_1` (`tipo_de_atendimento_id`),
  KEY `FK_compete_2` (`especialidade_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `depedentes`
--

DROP TABLE IF EXISTS `depedentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `depedentes` (
  `CPF` bigint(20) unsigned NOT NULL,
  `CPF_depedente` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`CPF`,`CPF_depedente`),
  KEY `FK_Depedentes_3` (`CPF_depedente`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doenca`
--

DROP TABLE IF EXISTS `doenca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doenca` (
  `doenca_id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`doenca_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doencas_pre_existentes`
--

DROP TABLE IF EXISTS `doencas_pre_existentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doencas_pre_existentes` (
  `doenca_id` int(11) NOT NULL,
  `CPF` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`CPF`,`doenca_id`),
  KEY `FK_doencas_pre_existentes_1` (`doenca_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `especialidade`
--

DROP TABLE IF EXISTS `especialidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `especialidade` (
  `nome` char(50) NOT NULL,
  `especialidade_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`especialidade_id`)
) ENGINE=MyISAM AUTO_INCREMENT=107 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `funcao`
--

DROP TABLE IF EXISTS `funcao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funcao` (
  `nome` char(30) NOT NULL,
  `funcao_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`funcao_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funcionario` (
  `data_de_adminissao` date NOT NULL,
  `salario_bruto` int(11) NOT NULL,
  `CPF` bigint(20) unsigned NOT NULL,
  `funcao_id` int(11) NOT NULL,
  PRIMARY KEY (`CPF`),
  KEY `FK_Funcionario_3` (`funcao_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medico`
--

DROP TABLE IF EXISTS `medico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico` (
  `CRM` bigint(20) NOT NULL,
  `escola_de_origem` varchar(64) NOT NULL,
  `tipo_de_residencia_medica_id` int(11) NOT NULL,
  PRIMARY KEY (`CRM`),
  KEY `FK_Medico_2` (`tipo_de_residencia_medica_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger colocar_medico_no_plano_nenhum
	after insert on medico
	for each row
	begin
		insert into medico_plano_de_saude 
        (crm, plano_de_saude_id) values
        (new.crm, 1);
	end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger colocar_tipo_de_atendimento_no_plano_nenhum
	after insert on medico
	for each row
	begin
		insert into plano_de_saude_tipo_de_atendimento 
        (plano_de_saude_id, tipo_de_atendimento_id, desconto) values
        (1, new.crm, 0);
	end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `medico_especialidade`
--

DROP TABLE IF EXISTS `medico_especialidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico_especialidade` (
  `CRM` bigint(20) NOT NULL,
  `especialidade_id` int(11) NOT NULL,
  PRIMARY KEY (`CRM`,`especialidade_id`),
  KEY `FK_medico_especialidade_2` (`especialidade_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medico_funcionario`
--

DROP TABLE IF EXISTS `medico_funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico_funcionario` (
  `CRM` bigint(20) NOT NULL,
  `CPF` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`CRM`,`CPF`),
  KEY `FK_Medico_funcionario_3` (`CPF`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medico_plano_de_saude`
--

DROP TABLE IF EXISTS `medico_plano_de_saude`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico_plano_de_saude` (
  `plano_de_saude_id` int(11) DEFAULT NULL,
  `CRM` bigint(20) DEFAULT NULL,
  KEY `FK_medico_plano_de_saude_1` (`plano_de_saude_id`),
  KEY `FK_medico_plano_de_saude_2` (`CRM`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medico_prestador_de_servico`
--

DROP TABLE IF EXISTS `medico_prestador_de_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico_prestador_de_servico` (
  `CRM` bigint(20) NOT NULL,
  `CPF` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`CRM`,`CPF`),
  KEY `FK_Medico_Prestador_de_Servico_3` (`CPF`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoa` (
  `CPF` bigint(20) unsigned NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `estado_civil` char(13) NOT NULL,
  `sexo` int(11) NOT NULL,
  `data_de_nascimento` date NOT NULL,
  `numero_do_telefone` char(15) NOT NULL,
  `cep` char(9) NOT NULL,
  `estado` char(30) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `bairro` varchar(50) NOT NULL,
  `logradouro` varchar(53) NOT NULL,
  `complemento` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CPF`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plano_de_saude`
--

DROP TABLE IF EXISTS `plano_de_saude`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plano_de_saude` (
  `plano_de_saude_id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  `registro` int(11) NOT NULL,
  PRIMARY KEY (`plano_de_saude_id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plano_de_saude_tipo_de_atendimento`
--

DROP TABLE IF EXISTS `plano_de_saude_tipo_de_atendimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plano_de_saude_tipo_de_atendimento` (
  `plano_de_saude_id` int(11) DEFAULT NULL,
  `tipo_de_atendimento_id` int(11) DEFAULT NULL,
  `desconto` int(11) NOT NULL,
  KEY `FK_plano_de_saude_tipo_de_atendimento_1` (`plano_de_saude_id`),
  KEY `FK_plano_de_saude_tipo_de_atendimento_2` (`tipo_de_atendimento_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_de_atendimento`
--

DROP TABLE IF EXISTS `tipo_de_atendimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_de_atendimento` (
  `tipo_de_atendimento_id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` char(50) NOT NULL,
  `duracao_esperada` time NOT NULL,
  `efeitos_colaterais` varchar(1000) NOT NULL,
  `preco` int(11) NOT NULL,
  PRIMARY KEY (`tipo_de_atendimento_id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_de_residencia_medica`
--

DROP TABLE IF EXISTS `tipo_de_residencia_medica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_de_residencia_medica` (
  `tipo_de_residencia_medica_id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`tipo_de_residencia_medica_id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_de_tratamento`
--

DROP TABLE IF EXISTS `tipo_de_tratamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_de_tratamento` (
  `numero_esperados_de_atendimentos` int(11) DEFAULT NULL,
  `eh_cronico` int(11) NOT NULL,
  `tipo_de_tratamento_id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`tipo_de_tratamento_id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tratamento`
--

DROP TABLE IF EXISTS `tratamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tratamento` (
  `tratamento_id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_de_tratamento_id` int(11) DEFAULT NULL,
  `cpf` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tratamento_id`),
  KEY `FK_Tratamento_2` (`tipo_de_tratamento_id`),
  KEY `FK_Tratamento_3` (`cpf`)
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'hospital'
--
/*!50003 DROP FUNCTION IF EXISTS `CRM_para_CPF` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CRM_para_CPF`(crm bigint) RETURNS bigint(20)
begin
	declare result bigint;

	select cpf into result from pessoa join 
		(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
		where A.CRM = crm;
        
	return result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_data_de_adminissao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_data_de_adminissao`(cpf_entrada bigint) RETURNS date
begin
	declare result date;
    
	select data_de_adminissao into result
	from funcionario
	where CPF = 26115330408;
    
    return result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_atendimentos_agendados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_atendimentos_agendados`(horario_inicio date, horario_fim date) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
		FROM atendimento
		join tratamento using(tratamento_id)
        join pessoa using(cpf)
		where horario_agendado between horario_inicio and horario_fim
        and atendimento.estado = 0;
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_atendimentos_agendados_por_um_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_atendimentos_agendados_por_um_cliente`(cpf_entrada bigint, filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from (
		select tratamento.cpf, (
			select nome
				from (select * from medico_funcionario union select * from medico_prestador_de_servico) as r
				join pessoa using(cpf)
				where crm = atendimento.crm
			) as nome_medico, sala, horario_agendado, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where tratamento.cpf = cpf_entrada and 
			atendimento.estado=0
	) as r
	where nome_medico like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_atendimentos_agendados_por_um_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_atendimentos_agendados_por_um_medico`(crm bigint, filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from (
		select tratamento.cpf, (
			select nome
				from pessoa
				where tratamento.cpf = pessoa.cpf
			) as nome_cliente, sala, horario_agendado, valor_recebidos_por_medico, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where atendimento.crm = crm and 
			atendimento.estado=1
	) as r
	where nome_cliente like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_atendimentos_proximo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_atendimentos_proximo`() RETURNS int(11)
begin
		declare n int; 
		
		select ceil(count(*)/10) into n
		from atendimento
		join (
				select nome, numero_do_telefone, tratamento_id, cpf from pessoa join tratamento using (cpf)
			) as A using (tratamento_id)
		where DATEDIFF(horario_agendado, now()) between 0 and 14;
        
        return n;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_atendimentos_realizados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_atendimentos_realizados`(horario_inicio date, horario_fim date) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
		FROM atendimento
		join tratamento using(tratamento_id)
        join pessoa using(cpf)
		where horario_inicio_real between horario_inicio and horario_fim
        and atendimento.estado = 1;
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_atendimentos_realizados_por_um_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_atendimentos_realizados_por_um_cliente`(cpf_entrada bigint, filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from (
		select tratamento.cpf, (
			select nome
				from (select * from medico_funcionario union select * from medico_prestador_de_servico) as r
				join pessoa using(cpf)
				where crm = atendimento.crm
			) as nome_medico, sala, horario_inicio_real, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where tratamento.cpf = cpf_entrada and 
			atendimento.estado=1
	) as r
	where nome_medico like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_atendimentos_realizados_por_um_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_atendimentos_realizados_por_um_medico`(crm bigint, filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from (
		select tratamento.cpf, (
			select nome
				from pessoa
				where tratamento.cpf = pessoa.cpf
			) as nome_cliente, sala, horario_inicio_real, valor_recebidos_por_medico, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where atendimento.crm = crm and 
			atendimento.estado=1
	) as r
	where nome_cliente like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_depedentes_de_um_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_depedentes_de_um_funcionario`(cpf_entrada bigint) RETURNS int(11)
begin
	declare result int;
    
	select ceil(count(*)/10) into result
	from depedentes
	join pessoa
	on depedentes.CPF_depedente = pessoa.CPF
	where depedentes.CPF = cpf_entrada;
    
    return result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_especialidades_de_um_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_especialidades_de_um_medico`(crm_entrada bigint) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
		from medico_especialidade join especialidade using(especialidade_id)
		where CRM = crm_entrada;
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_lista_de_clientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_lista_de_clientes`(filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from pessoa join cliente using (cpf)
	where nome like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_lista_de_funcionarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_lista_de_funcionarios`(filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from pessoa join funcionario using (cpf)
	where nome like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_lista_de_medicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_lista_de_medicos`(filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
		from pessoa
		join (select * from medico_funcionario union select * from medico_prestador_de_servico) as r using (cpf)
		where nome like CONCAT("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_lista_de_medicos_funcionarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_lista_de_medicos_funcionarios`(filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
		from pessoa
		join medico_funcionario using (cpf)
		where nome like CONCAT("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_lista_de_medicos_prestadores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_lista_de_medicos_prestadores`(filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
		from pessoa
		join medico_prestador_de_servico as r using (cpf)
		where nome like CONCAT("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_lista_de_planos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_lista_de_planos`(filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from plano_de_saude
	where nome like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_lista_de_tratamentos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_lista_de_tratamentos`(filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from tratamento	join pessoa using (cpf)
	where pessoa.nome like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_planos_de_saude_de_um_cliente_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_planos_de_saude_de_um_cliente_lista`(cpf_entrada bigint) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
    from plano_de_saude
	join cliente_plano_de_saude using(plano_de_saude_id)
	where cpf = cpf_entrada;
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_planos_de_saude_de_um_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_planos_de_saude_de_um_medico`(crm_entrada bigint) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
		from plano_de_saude	join medico_plano_de_saude using(plano_de_saude_id)
		where CRM = crm_entrada;
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_tratamentos_cronicos_proximos_de_estourar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_tratamentos_cronicos_proximos_de_estourar`() RETURNS int(11)
begin
		declare result int;
        
		select ceil(count(*)/10) into result
		from tratamento
			join tipo_de_tratamento using(tipo_de_tratamento_id)
			join pessoa using(cpf)
		where tipo_de_tratamento.eh_cronico = 1
			and not exists (
				select * from atendimento where atendimento.tratamento_id = tratamento.tratamento_id and estado = 1
				)
			and 14 >= all(
				select datediff(date_add(horario_agendado, interval 6 month), now())
				from atendimento
				where atendimento.estado = 0
					and atendimento.tratamento_id = tratamento.tratamento_id);
		return result;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_tratamento_por_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_tratamento_por_cliente`(cpf_entrada bigint) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
    from tratamento
    where cpf = cpf_entrada;
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `verificar_se_existe_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `verificar_se_existe_cliente`(cpf bigint) RETURNS int(11)
begin
		declare n int;
    
		select exists (
			select *
            from cliente
            where cliente.cpf = cpf
        ) into n from dual;
        
        return n;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `verificar_se_existe_pessoa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `verificar_se_existe_pessoa`(cpf bigint) RETURNS int(11)
begin
		declare n int;
    
		select exists (
			select *
            from pessoa
            where pessoa.cpf = cpf
        ) into n from dual;
        
        return n;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `agendar_atendimento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agendar_atendimento`(in info json)
begin
	#calcular:
    #comissao_da_clinica, valor_recebidos_por_medico, importo_retido, valor_pago_pelo_plano
    
    declare valor int;
	declare imposto_retido int;
    declare comissao_da_clinica int;
    declare valor_recebidos_por_medico int;
    declare eh_funcionario bool;
    declare valor_pago_pelo_plano int;
    declare tipo_de_atendimento_id int;
    declare plano_de_saude_id int;
    declare crm int;
    
    #JSON_UNQUOTE(JSON_EXTRACT(info, '$.salario_bruto'))
    
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.tipo_de_atendimento_id')) into tipo_de_atendimento_id;
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.plano_de_saude_id')) into plano_de_saude_id;
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.crm')) into crm;
    
    set comissao_da_clinica = 0;
    set valor_recebidos_por_medico = 0;
    
	select preco into valor
	from tipo_de_atendimento
	where tipo_de_atendimento.tipo_de_atendimento_id = tipo_de_atendimento_id;
    
    set imposto_retido = floor(valor * 0.05);
	
    select exists (
	select *
	from medico_funcionario
	where medico_funcionario.CRM = crm) into eh_funcionario;
	
    if eh_funcionario then
		set comissao_da_clinica = floor(valor * 0.3);
        set valor_recebidos_por_medico = floor(valor * 0.65);
    else
		set comissao_da_clinica = floor(valor * 0.95);
    end if;
    
    select floor(desconto * valor / 100) into valor_pago_pelo_plano
		from plano_de_saude_tipo_de_atendimento
		where plano_de_saude_tipo_de_atendimento.plano_de_saude_id = plano_de_saude_id
		and plano_de_saude_tipo_de_atendimento.tipo_de_atendimento_id = tipo_de_atendimento_id;
    
    if valor_pago_pelo_plano is null then
		set valor_pago_pelo_plano = 0;
    end if;
    
    insert atendimento (sala, horario_agendado, 
    estado, crm, plano_de_saude_id,
    tipo_de_atendimento_id, tratamento_id, valor,
    comissao_da_clinica, valor_recebidos_por_medico,
    imposto_retido, valor_pago_pelo_plano)
	select JSON_UNQUOTE(JSON_EXTRACT(info, '$.sala')),
    JSON_UNQUOTE(JSON_EXTRACT(info, '$.horario_agendado')),
    0,
    crm,
    plano_de_saude_id,
    tipo_de_atendimento_id,
    JSON_UNQUOTE(JSON_EXTRACT(info, '$.tratamento_id')),
    valor,
    comissao_da_clinica,
    valor_recebidos_por_medico,
    imposto_retido,
    valor_pago_pelo_plano;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_agendados_por_cliente_dados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_agendados_por_cliente_dados`(cpf bigint)
begin
	select count(*) as quant, min(horario_agendado) as data_proxima_consulta
		from atendimento join tratamento
		where estado=0 and tratamento.cpf = cpf;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_agendados_por_medico_dados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_agendados_por_medico_dados`(crm bigint)
begin
	select count(*) as quant, min(horario_agendado) as data_proxima_consulta
		from atendimento
		where estado=0 and atendimento.crm = crm;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_agendados_por_um_cliente_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_agendados_por_um_cliente_lista`(in k int, cpf_entrada bigint, filtro varchar(50))
begin
	set k = k * 10;
    
	select *
	from (
		select tratamento.cpf, (
			select nome
				from (select * from medico_funcionario union select * from medico_prestador_de_servico) as r
				join pessoa using(cpf)
				where crm = atendimento.crm
			) as nome_medico, sala, horario_agendado, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where tratamento.cpf = cpf_entrada and 
			atendimento.estado=0
	) as r
	where nome_medico like concat("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_agendados_por_um_medico_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_agendados_por_um_medico_lista`(in k int, crm bigint, filtro varchar(50))
begin
	set k = k * 10;
    
	select *
	from (
		select tratamento.cpf, (
			select nome
				from pessoa
				where tratamento.cpf = pessoa.cpf
			) as nome_medico, sala, horario_agendado, valor_recebidos_por_medico, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where atendimento.crm = crm and 
			atendimento.estado=1
	) as r
	where nome_medico like concat("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_proximos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_proximos`(in k int)
begin
		set k = k * 10;
    
		select A.nome, A.numero_do_telefone,
				(
					select nome from pessoa join 
						(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
						where A.CRM = atendimento.crm
				) as nome_medico,
				(
					select nome from tipo_de_atendimento where tipo_de_atendimento.tipo_de_atendimento_id = atendimento.tipo_de_atendimento_id
				) as tipo_de_atendimento, horario_agendado,
                atendimento_id
		from atendimento
		join (
				select nome, numero_do_telefone, tratamento_id, cpf from pessoa join tratamento using (cpf)
			) as A using (tratamento_id)
		where DATEDIFF(horario_agendado, now()) between 0 and 14
		order by horario_agendado
        limit k, 10;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_realizados_por_cliente_dados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_realizados_por_cliente_dados`(cpf bigint)
begin
	select count(*) as quant, max(horario_inicio_real) as data_ultima_consulta
		from atendimento join tratamento
		where atendimento.estado=1 and tratamento.cpf = cpf;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_realizados_por_medico_dados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_realizados_por_medico_dados`(crm bigint)
begin
	select count(*) as quant, max(horario_inicio_real) as data_ultima_consulta
		from atendimento
		where estado=1 and atendimento.crm = crm;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_realizados_por_um_cliente_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_realizados_por_um_cliente_lista`(in k int, cpf_entrada bigint, filtro varchar(50))
begin
	set k = k * 10;
    
	select *
	from (
		select tratamento.cpf, (
			select nome
				from (select * from medico_funcionario union select * from medico_prestador_de_servico) as r
				join pessoa using(cpf)
				where crm = atendimento.crm
			) as nome_medico, sala, horario_inicio_real, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where tratamento.cpf = cpf_entrada and 
			atendimento.estado=1
	) as r
	where nome_medico like concat("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_realizados_por_um_medico_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_realizados_por_um_medico_lista`(in k int, crm bigint, filtro varchar(50))
begin
	set k = k * 10;
    
	select *
	from (
		select tratamento.cpf, (
			select nome
				from pessoa
				where tratamento.cpf = pessoa.cpf
			) as nome_cliente, sala, horario_inicio_real, valor_recebidos_por_medico, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where atendimento.crm = crm and 
			atendimento.estado=1
	) as r
	where nome_medico like concat("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cadastrar_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cadastrar_cliente`(in info json)
begin
	declare doencas_do_cliente json;
    declare planos_de_saude_do_cliente json;
    DECLARE i INT;
    declare atual bigint;
    declare client_cpf bigint;
    
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.CPF')) into client_cpf from dual; 
    
    insert cliente(cpf) values (client_cpf);
    
   select JSON_EXTRACT(info, '$.doencas_pre_existentes') into doencas_do_cliente  from dual;
   
   set i = 0;
	label1:loop
		select JSON_EXTRACT(doencas_do_cliente, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label1;
		else
			insert doencas_pre_existentes(CPF, doenca_id)
            select client_cpf, atual;
            set i = i + 1;
		end if;
	end loop;
    
    select JSON_EXTRACT(info, '$.planos_de_saude') into planos_de_saude_do_cliente  from dual;
   
   set i = 0;
	label2:loop
		select JSON_EXTRACT(planos_de_saude_do_cliente, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label2;
		else
			insert cliente_plano_de_saude(CPF, plano_de_saude_id)
            select client_cpf, atual;
            set i = i + 1;
		end if;
	end loop;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cadastrar_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cadastrar_funcionario`(in info json)
begin
	declare dependetes_do_funcionario json;
    DECLARE i INT;
    declare atual bigint;
    declare func_cpf bigint;
    
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.CPF')) into func_cpf from dual; 
    
    insert funcionario(data_de_adminissao, salario_bruto, CPF, funcao_id)
	select
		now(),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.salario_bruto')),
        func_cpf,
        JSON_UNQUOTE(JSON_EXTRACT(info, '$.funcao_id'))
	from dual;
    
   select JSON_EXTRACT(info, '$.depedentes') into dependetes_do_funcionario  from dual;
   
   set i = 0;
	label1:loop
		select JSON_EXTRACT(dependetes_do_funcionario, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label1;
		else
			insert depedentes(CPF, CPF_depedente)
            select func_cpf, atual;
            set i = i + 1;
		end if;
	end loop;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cadastrar_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cadastrar_medico`(in info json)
begin
	declare especialidades_do_medico json;
    declare plano_de_saude_do_medico json;
    DECLARE i INT;
    declare atual bigint;
    declare medic_crm bigint;
    
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.CRM')) into medic_crm from dual; 
    
    insert medico(crm, escola_de_origem, tipo_de_residencia_medica_id)
	select
		medic_crm,
        JSON_UNQUOTE(JSON_EXTRACT(info, '$.escola_de_origem')),
        JSON_UNQUOTE(JSON_EXTRACT(info, '$.tipo_de_residencia_medica_id'))
	from dual;
    
   select JSON_EXTRACT(info, '$.especialidades') into especialidades_do_medico  from dual;
   select JSON_EXTRACT(info, '$.planos_de_saude') into plano_de_saude_do_medico  from dual;
   
   set i = 0;
	label1:loop
		select JSON_EXTRACT(especialidades_do_medico, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label1;
		else
			insert medico_especialidade(CRM, especialidade_id)
            select medic_crm, atual;
            set i = i + 1;
		end if;
	end loop;
    
    set i = 0;
	label2:loop
		select JSON_EXTRACT(plano_de_saude_do_medico, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label2;
		else
			insert medico_plano_de_saude(CRM, plano_de_saude_id)
            select medic_crm, atual;
            set i = i + 1;
		end if;
	end loop;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cadastrar_medico_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cadastrar_medico_funcionario`(in crm bigint, in cpf bigint)
begin
	insert into medico_funcionario (CRM, CPF)
    values (crm, cpf);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cadastrar_medico_prestador_de_servico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cadastrar_medico_prestador_de_servico`(in crm bigint, in cpf bigint)
begin
	insert into medico_prestador_de_servico (CRM, CPF)
    values (crm, cpf);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cadastrar_pessoa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cadastrar_pessoa`(in info json)
begin
	
    insert into pessoa (
		CPF,nome,estado_civil,sexo,data_de_nascimento,numero_do_telefone,cep,estado,cidade,bairro,logradouro,complemento,numero,email
    ) select 
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.CPF')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.nome')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.estado_civil')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.sexo')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.data_de_nascimento')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.numero_do_telefone')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.cep')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.estado')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.cidade')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.bairro')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.logradouro')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.complemento')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.numero')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.email'))
from dual;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `criar_tratamento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `criar_tratamento`(in tipo_de_tratamento int, in cpf bigint)
begin
	insert into tratamento(tipo_de_tratamento_id, cpf)
    values (tipo_de_tratamento, cpf);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_clientes_estado_civil` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_clientes_estado_civil`()
begin
        select estado_civil, count(*) as quant
		from pessoa join cliente using(cpf)
		group by estado_civil;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_clientes_idade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_clientes_idade`(out media real, out mediana real, out desvio real)
begin
		declare quant int;
        declare amplitude int;
        declare classes int;
        
		select avg(idade) into media
		from (
			select timestampdiff(YEAR,data_de_nascimento,now()) as idade
			from pessoa join cliente using(cpf)) as A;
            
		select std(idade) into desvio
		from (
			select timestampdiff(YEAR,data_de_nascimento,now()) as idade
			from pessoa join cliente using(cpf)) as A;
            
        select count(cpf) into quant from pessoa join cliente using(cpf);
        
        select avg(idade) into mediana
        from (
			select @linha:=@linha+1 as pos, timestampdiff(YEAR,data_de_nascimento,now()) as idade
				from pessoa join cliente using(cpf), (select @linha := 0) as r
        ) as valores_medios
        where pos = floor(250/2) or pos = ceil(250/2);
        
        select max(idade) - min(idade) into amplitude
        from(
            select timestampdiff(YEAR,data_de_nascimento,now()) as idade
            from pessoa join cliente using(cpf)
        ) as A;      
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(idade/classes) * classes) as  x, count(*) as y
        from (
            select timestampdiff(YEAR,data_de_nascimento,now()) as idade
            from pessoa join cliente using(cpf)
        ) as A
        group by floor(idade/classes);
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_das_especialidades_quant_atendimentos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_das_especialidades_quant_atendimentos`(out media real, out desvio_padrao real, out maximo int, out minimo int)
begin       
        drop view if exists temp_view;
        create view temp_view
			as select especialidade.nome as nome, count(crm) as valor
				from especialidade
				join medico_especialidade using (especialidade_id)
				join atendimento using (crm)
				group by especialidade_id;

		select avg(valor) into media from temp_view;
        select std(valor) into desvio_padrao from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select * from temp_view;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_das_especialidades_quant_medicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_das_especialidades_quant_medicos`(out media real, out desvio_padrao real, out maximo int, out minimo int)
begin       
        drop view if exists temp_view;
        create view temp_view
			as select especialidade.nome as nome, count(crm) as valor
				from especialidade
				join medico_especialidade using (especialidade_id)
				group by especialidade_id;

		select avg(valor) into media from temp_view;
        select std(valor) into desvio_padrao from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select * from temp_view;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_das_especialidades_valores_arrecadados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_das_especialidades_valores_arrecadados`(out media real, out desvio_padrao real, out maximo int, out minimo int)
begin       
        drop view if exists temp_view;
        create view temp_view
			as select especialidade.nome, sum(atendimento.valor) as valor
				from especialidade
				join medico_especialidade using(especialidade_id)
				join atendimento using(crm)
                group by especialidade_id;

		select avg(valor) into media from temp_view;
        select std(valor) into desvio_padrao from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select * from temp_view;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_funcionarios_estado_civil` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_funcionarios_estado_civil`()
begin
        select estado_civil, count(*)
		from pessoa join funcionario using(cpf)
		group by estado_civil;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_funcionarios_idade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_funcionarios_idade`(out media real, out mediana real, out desvio real)
begin
		declare quant int;
        declare amplitude int;
        declare classes int;
        
		select avg(idade) into media
		from (
			select timestampdiff(YEAR,data_de_nascimento,now()) as idade
			from pessoa join funcionario using(cpf)) as A;
            
		select std(idade) into desvio
		from (
			select timestampdiff(YEAR,data_de_nascimento,now()) as idade
			from pessoa join funcionario using(cpf)) as A;
            
        select count(cpf) into quant from pessoa join funcionario using(cpf);
        
        select avg(idade) into mediana
        from (
			select @linha:=@linha+1 as pos, timestampdiff(YEAR,data_de_nascimento,now()) as idade
				from pessoa join funcionario using(cpf), (select @linha := 0) as r
        ) as valores_medios
        where pos = floor(quant/2) or pos = ceil(quant/2);
        
        select max(idade) - min(idade) into amplitude
        from(
            select timestampdiff(YEAR,data_de_nascimento,now()) as idade
            from pessoa join funcionario using(cpf)
        ) as A;      
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(idade/classes) * classes) as  x, count(*) as y
        from (
            select timestampdiff(YEAR,data_de_nascimento,now()) as idade
            from pessoa join funcionario using(cpf)
        ) as A
        group by floor(idade/classes);
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_funcionarios_salario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_funcionarios_salario`(out media real, out desvio real)
begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, salario_bruto
				from funcionario
				join pessoa using(cpf);
        
		select avg(salario_bruto) into media from temp_view;
            
		select std(salario_bruto) into desvio from temp_view;
        
        select max(salario_bruto) - min(salario_bruto) into amplitude from temp_view;
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(salario_bruto/classes) * classes) as  x, count(*) as y
        from temp_view
        group by floor(salario_bruto/classes);
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_medicos_vs_quant_pacientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_medicos_vs_quant_pacientes`(out media real, out desvio_padrao real, out maximo int, out minimo int)
begin       
        drop view if exists temp_view;
        create view temp_view
			as select (
				select nome from pessoa join 
						(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
						where A.CRM = atendimento.crm
				) as nome, count(cpf) as valor
				from atendimento
				join tratamento using(tratamento_id)
				group by(crm)
				order by valor;

		select avg(valor) into media from temp_view;
        select std(valor) into desvio_padrao from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
              
        select valor as x, count(*) as y
        from temp_view
        group by x;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_plano_de_saude_atendimentos_aceitos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_plano_de_saude_atendimentos_aceitos`(out media real, out desvio real, out minimo int, out maximo int)
begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, count(tipo_de_atendimento_id) as valor
			from plano_de_saude
			join plano_de_saude_tipo_de_atendimento using (plano_de_saude_id)
			group by plano_de_saude_id;
        
		select avg(valor) into media from temp_view;
		select std(valor) into desvio from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select valor as  x, count(*) as y
        from temp_view
        group by valor;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_plano_de_saude_quantidade_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_plano_de_saude_quantidade_cliente`(out media real, out desvio real, out minimo int, out maximo int)
begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, count(cpf) as valor
				from plano_de_saude
				join cliente_plano_de_saude using(plano_de_saude_id)
				group by plano_de_saude_id;
        
		select avg(valor) into media from temp_view;
		select std(valor) into desvio from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select maximo - minimo into amplitude from dual;
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(valor/classes) * classes) as  x, count(*) as y
        from temp_view
        group by floor(valor/classes);
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_plano_de_saude_quantidade_de_medicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_plano_de_saude_quantidade_de_medicos`(out media real, out desvio real, out minimo int, out maximo int)
begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, count(crm) as valor
			from plano_de_saude
			join medico_plano_de_saude using (plano_de_saude_id)
			group by plano_de_saude_id;
        
		select avg(valor) into media from temp_view;
		select std(valor) into desvio from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select maximo - minimo into amplitude from dual;
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(valor/classes) * classes) as  x, count(*) as y
        from temp_view
        group by floor(valor/classes);
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_plano_de_saude_vs_desconto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_plano_de_saude_vs_desconto`(out media real, out desvio real, out minimo int, out maximo int)
begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, sum(valor_pago_pelo_plano) as valor
				from plano_de_saude
				join atendimento using(plano_de_saude_id)
				group by plano_de_saude_id;
        
		select avg(valor) into media from temp_view;
		select std(valor) into desvio from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select maximo - minimo into amplitude from dual;
        
        select floor(amplitude/20) into classes from dual;
        
        select * from temp_view;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_sobre_atendimento_realizado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_sobre_atendimento_realizado`(in atendimento_id int)
begin
		select horario_agendado, horario_inicio_real, horario_fim_real,
		(
			select nome
			from tratamento
			join pessoa using(cpf)
			where tratamento.tratamento_id = atendimento.tratamento_id
		) as nome_cliente,
		(
			select nome
			from pessoa join
			(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
			where A.CRM = atendimento.crm
		) as nome_medico,
		valor, comissao_da_clinica, valor_recebidos_por_medico, data_de_recebimento, data_do_reparsse_ao_medico, 
		(
			select nome
			from tipo_de_atendimento
			where tipo_de_atendimento.tipo_de_atendimento_id = atendimento.tipo_de_atendimento_id
		) as tipo_de_atendimento
	from atendimento
	where atendimento.atendimento_id=8; 
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `depedentes_de_um_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `depedentes_de_um_funcionario`(in k int, in cpf_entrada bigint)
begin
	set k = k * 10;
    
	select nome, pessoa.cpf
	from depedentes
	join pessoa
	on depedentes.CPF_depedente = pessoa.CPF
	where depedentes.CPF = cpf_entrada
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `especialidades_de_um_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `especialidades_de_um_medico`(in k int, crm_entrada bigint)
begin
	set k = k * 10;

	select nome
	from medico_especialidade join especialidade using(especialidade_id)
	where CRM = crm_entrada
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `informacoes_escolares_de_um_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `informacoes_escolares_de_um_medico`(in crm bigint)
begin
	select escola_de_origem, nome as tipo_de_residencia_medica
	from medico
	join tipo_de_residencia_medica using(tipo_de_residencia_medica_id)
	where crm = 3;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_atendimentos_agendados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_atendimentos_agendados`(in k int, horario_inicio date, horario_fim date)
begin
	set k = k * 10;

	SELECT cliente.nome as nome_cliente,
		(
			select nome
			from tipo_de_atendimento
			where tipo_de_atendimento.tipo_de_atendimento_id = atendimento.tipo_de_atendimento_id
		) as tipo_de_atendimento,
		(
			select nome
			from pessoa
			join (select * from medico_funcionario union select * from medico_prestador_de_servico) as r using (cpf)
			where r.crm = atendimento.crm
		) as nome_medico, horario_agendado, 
		atendimento_id
	FROM atendimento
	join tratamento using(tratamento_id)
    join pessoa as cliente using(cpf)
	where horario_agendado between horario_inicio and horario_fim
    and atendimento.estado = 0
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_atendimentos_realizados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_atendimentos_realizados`(in k int, horario_inicio date, horario_fim date)
begin
	set k = k * 10;

	SELECT cliente.nome as nome_cliente,
		(
			select nome
			from tipo_de_atendimento
			where tipo_de_atendimento.tipo_de_atendimento_id = atendimento.tipo_de_atendimento_id
		) as tipo_de_atendimento,
		(
			select nome
			from pessoa
			join (select * from medico_funcionario union select * from medico_prestador_de_servico) as r using (cpf)
			where r.crm = atendimento.crm
		) as nome_medico, horario_inicio_real, 
		atendimento_id
	FROM atendimento
	join tratamento using(tratamento_id)
    join pessoa as cliente using(cpf)
	where horario_inicio_real between horario_inicio and horario_fim
    and atendimento.estado = 1
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_clientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_clientes`(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, timestampdiff(YEAR,data_de_nascimento,now()) as idade, sexo, numero_do_telefone, cpf
	from pessoa join cliente using (cpf)
    where nome like concat("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_doencas_pre_existentes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_doencas_pre_existentes`(in cpf bigint)
begin
	select nome
	from doenca
	join doencas_pre_existentes using(doenca_id)
	where doencas_pre_existentes.cpf = cpf;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_funcionario`(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select pessoa.nome, funcao.nome as cargo, data_de_adminissao, sexo, numero_do_telefone, pessoa.cpf
	from pessoa join funcionario using (cpf)
    join funcao using(funcao_id)
    where pessoa.nome like concat("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_medicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_medicos`(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, timestampdiff(YEAR,data_de_nascimento,now()) as idade, crm, sexo, numero_do_telefone
	from pessoa
	join (select * from medico_funcionario union select * from medico_prestador_de_servico) as r using (cpf)
	where nome like CONCAT("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_medicos_funcionarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_medicos_funcionarios`(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, timestampdiff(YEAR,data_de_nascimento,now()) as idade, crm, sexo, numero_do_telefone
	from pessoa
	join medico_funcionario using (cpf)
	where nome like CONCAT("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_medicos_prestadores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_medicos_prestadores`(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, timestampdiff(YEAR,data_de_nascimento,now()) as idade, crm, sexo, numero_do_telefone
	from pessoa
	join medico_prestador_de_servico as r using (cpf)
	where nome like CONCAT("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_planos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_planos`(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, plano_de_saude_id
	from plano_de_saude
    where nome like concat("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_tratamentos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_tratamentos`(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select tratamento_id, pessoa.nome as cliente_nome, tipo_de_tratamento.nome as tipo_de_tratamento, count(*) as quant_de_atendimentos
	from tratamento
		join tipo_de_tratamento using (tipo_de_tratamento_id)
		join pessoa using (cpf)
		join atendimento using(tratamento_id)
	group by tratamento_id
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `medicos_funcionarios_vs_prestadores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `medicos_funcionarios_vs_prestadores`()
begin
		declare total real;
        declare funcionarios real;
		
        select count(*) into total from medico;
		select count(*) into funcionarios from medico_funcionario;
		
        
        select total, funcionarios, total - funcionarios as prestadores from dual;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_dados_atendimentos_agendados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_dados_atendimentos_agendados`(in inicio date, in fim date)
begin
	select
		avg(valor) as valor_recebido_media,
		std(valor) as valor_recebido_desvio,
		sum(valor) as valor_recebido_soma,
		avg(comissao_da_clinica) as valor_arrecadado_media,
		std(comissao_da_clinica) as valor_arrecadado_desvio,
		sum(comissao_da_clinica) as valor_arrecadado_total,
		count(*) as quantidade
	from atendimento
	where horario_agendado between inicio and fim
    and atendimento.estado = 0;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_dados_atendimentos_realizados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_dados_atendimentos_realizados`(in inicio date, in fim date)
begin
	select
		avg(valor) as valor_recebido_media,
		std(valor) as valor_recebido_desvio,
		sum(valor) as valor_recebido_soma,
		avg(comissao_da_clinica) as valor_arrecadado_media,
		std(comissao_da_clinica) as valor_arrecadado_desvio,
		sum(comissao_da_clinica) as valor_arrecadado_total,
		count(*) as quantidade
	from atendimento
	where horario_inicio_real between inicio and fim
    and estado = 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_dados_pessoais` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_dados_pessoais`(cpf bigint)
begin
	select cpf, nome, estado_civil, sexo, data_de_nascimento, timestampdiff(YEAR,data_de_nascimento,now()) as idade, cep, estado, cidade, bairro, logradouro, numero, complemento, email, numero_do_telefone
from pessoa
join cliente using(cpf)
where cliente.cpf = cpf;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_dados_tratamentos_cronicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_dados_tratamentos_cronicos`()
begin
    select eh_cronico, count(*) as quant
    from tratamento join tipo_de_tratamento using(tipo_de_tratamento_id)
    group by eh_cronico;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_dados_tratamentos_quantidades` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_dados_tratamentos_quantidades`()
begin
    select nome, count(*) as quant
    from tratamento join tipo_de_tratamento using(tipo_de_tratamento_id)
    group by tipo_de_tratamento_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_doencas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_doencas`()
begin
	select doenca_id, nome
    from doenca;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_especialidades` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_especialidades`()
begin
	select especialidade_id, nome
    from especialidade;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_funcoes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_funcoes`()
begin
	select funcao_id, nome
    from funcao;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_lista_completa_tratamentos_do_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_lista_completa_tratamentos_do_cliente`(in cpf bigint)
begin
	SELECT nome FROM tratamento join cliente using(cpf) join tipo_de_tratamento using(tipo_de_tratamento_id);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_medicos_validos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_medicos_validos`(in plano_de_saude_id int, in tipo_de_atendimento_id int)
begin
	drop temporary table if exists crms;
	CREATE TEMPORARY TABLE crms(crm bigint);
	
    INSERT INTO crms(crm)
		select distinct medico_plano_de_saude.crm
		from medico_plano_de_saude join medico_especialidade using(crm)
		join compete using(especialidade_id)
		where compete.tipo_de_atendimento_id = tipo_de_atendimento_id
		and medico_plano_de_saude.plano_de_saude_id = plano_de_saude_id;
	
    select nome from pessoa join 
		(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
		join crms using(crm);
	drop temporary table if exists crms;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_planos_de_saude_validos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_planos_de_saude_validos`(in cpf bigint, in tipo_de_atendimento_id int)
begin
	select nome
	from plano_de_saude
	join plano_de_saude_tipo_de_atendimento using(plano_de_saude_id)
	join cliente_plano_de_saude using(plano_de_saude_id)
	where plano_de_saude_tipo_de_atendimento.tipo_de_atendimento_id = tipo_de_atendimento_id and
	cliente_plano_de_saude.cpf = cpf;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_plano_de_saude` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_plano_de_saude`()
begin
	select plano_de_saude_id, nome
    from plano_de_saude;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_tipos_de_atendimento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_tipos_de_atendimento`()
begin
	SELECT nome FROM tipo_de_atendimento;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_tipos_de_residencia_medica` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_tipos_de_residencia_medica`()
begin
	select tipo_de_residencia_medica_id, nome
    from tipo_de_residencia_medica;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_tipos_de_tratamento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_tipos_de_tratamento`()
begin
	SELECT nome FROM hospital.tipo_de_tratamento;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `planos_de_saude_de_um_cliente_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `planos_de_saude_de_um_cliente_lista`(in k int,in cpf_entrada bigint)
begin
	set k = k * 10;
    
	select nome,
		(
		select count(tratamento_id)
		from tratamento
		join atendimento using(tratamento_id)
		where tratamento.cpf = cliente_plano_de_saude.cpf
			and atendimento.plano_de_saude_id = plano_de_saude.plano_de_saude_id
			and atendimento.estado=1
		) as quant_realizadas, (
			select count(tratamento_id)
			from tratamento
			join atendimento using(tratamento_id)
			where tratamento.cpf = cliente_plano_de_saude.cpf
				and atendimento.plano_de_saude_id = plano_de_saude.plano_de_saude_id
				and atendimento.estado=0
	) as quant_agendados from plano_de_saude
	join cliente_plano_de_saude using(plano_de_saude_id)
	where cpf = cpf_entrada
	group by plano_de_saude.plano_de_saude_id
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `planos_de_saude_de_um_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `planos_de_saude_de_um_medico`(in k int, crm_entrada bigint)
begin
	set k = k * 10;

	select nome
	from plano_de_saude	join medico_plano_de_saude using(plano_de_saude_id)
	where CRM = crm_entrada
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tratamentos_cronicos_proximos_de_estourar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tratamentos_cronicos_proximos_de_estourar`(in k int)
begin
		set k = k * 10;
    
		select pessoa.nome as nome_do_cliente,
			tipo_de_tratamento.nome as tipo_de_tratamento,
			pessoa.numero_do_telefone as numero_do_telefone,
			tratamento.tratamento_id as tratamento_id
		from tratamento
			join tipo_de_tratamento using(tipo_de_tratamento_id)
			join pessoa using(cpf)
		where tipo_de_tratamento.eh_cronico = 1
			and not exists (
				select * from atendimento where atendimento.tratamento_id = tratamento.tratamento_id and estado = 1
				)
			and 14 >= all(
				select datediff(date_add(horario_agendado, interval 6 month), now())
				from atendimento
				where atendimento.estado = 0
					and atendimento.tratamento_id = tratamento.tratamento_id)
		limit k, 10;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tratamentos_por_um_cliente_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tratamentos_por_um_cliente_lista`(in k int, cpf_entrada bigint)
begin
	set k = k * 10;
    
	select nome, count(atendimento_id) as quant_consultas, tratamento_id
	from tratamento
	join tipo_de_tratamento using(tipo_de_tratamento_id)
	join atendimento using(tratamento_id)
	where cpf = cpf_entrada
	group by tratamento_id
    limit k, 10;
end ;;
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

-- Dump completed on 2021-06-15 16:32:38
