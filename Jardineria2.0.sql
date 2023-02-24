-- MySQL Script generated by MySQL Workbench
-- Fri Feb 24 09:38:07 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema jardineria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `jardineria` ;

-- -----------------------------------------------------
-- Schema jardineria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jardineria` DEFAULT CHARACTER SET utf8mb3 ;
USE `jardineria` ;

-- -----------------------------------------------------
-- Table `jardineria`.`oficina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jardineria`.`oficina` (
  `idOficina` INT NOT NULL,
  `ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `pais` VARCHAR(45) NULL DEFAULT NULL,
  `region` VARCHAR(45) NULL DEFAULT NULL,
  `codigoPostal` INT NULL DEFAULT NULL,
  `telefono` INT NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idOficina`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `jardineria`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jardineria`.`empleados` (
  `idEmpleado` INT NOT NULL,
  `nombreEmpleado` VARCHAR(50) NULL DEFAULT NULL,
  `apellido1` VARCHAR(50) NULL DEFAULT NULL,
  `apellido2` VARCHAR(50) NULL DEFAULT NULL,
  `extension` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `codigoJefe` VARCHAR(45) NULL DEFAULT NULL,
  `puesto` VARCHAR(45) NULL DEFAULT NULL,
  `codigoOficina` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`, `codigoOficina`),
  CONSTRAINT `fk_Empleados_Oficina1`
    FOREIGN KEY (`codigoOficina`)
    REFERENCES `jardineria`.`oficina` (`idOficina`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_Empleados_Oficina1_idx` ON `jardineria`.`empleados` (`codigoOficina` ASC);


-- -----------------------------------------------------
-- Table `jardineria`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jardineria`.`clientes` (
  `idCliente` INT NOT NULL,
  `nombreCliente` VARCHAR(50) NULL DEFAULT NULL,
  `nombreContacto` VARCHAR(50) NULL DEFAULT NULL,
  `apellidoContacto` VARCHAR(45) NULL DEFAULT NULL,
  `fax` INT NULL DEFAULT NULL,
  `telefono` INT NULL DEFAULT NULL,
  `direccion1` VARCHAR(100) NULL DEFAULT NULL,
  `direccion2` VARCHAR(100) NULL DEFAULT NULL,
  `ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `region` VARCHAR(45) NULL DEFAULT NULL,
  `pais` VARCHAR(45) NULL DEFAULT NULL,
  `codigoPostal` INT NULL DEFAULT NULL,
  `limiteCredito` VARCHAR(45) NULL DEFAULT NULL,
  `codigoEmpleado` INT NOT NULL,
  PRIMARY KEY (`idCliente`, `codigoEmpleado`),
  CONSTRAINT `fk_Clientes_Empleados`
    FOREIGN KEY (`codigoEmpleado`)
    REFERENCES `jardineria`.`empleados` (`idEmpleado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_Clientes_Empleados_idx` ON `jardineria`.`clientes` (`codigoEmpleado` ASC);


-- -----------------------------------------------------
-- Table `jardineria`.`gama`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jardineria`.`gama` (
  `idGama` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `imagen` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idGama`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `jardineria`.`pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jardineria`.`pagos` (
  `idPagos` INT NOT NULL,
  `formaPago` VARCHAR(45) NULL DEFAULT NULL,
  `idTransaccion` VARCHAR(45) NULL DEFAULT NULL,
  `fechaPago` VARCHAR(45) NULL DEFAULT NULL,
  `totalPago` VARCHAR(45) NULL DEFAULT NULL,
  `codigoCliente` INT NOT NULL,
  PRIMARY KEY (`idPagos`, `codigoCliente`),
  CONSTRAINT `fk_Pagos_Clientes1`
    FOREIGN KEY (`codigoCliente`)
    REFERENCES `jardineria`.`clientes` (`idCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_Pagos_Clientes1_idx` ON `jardineria`.`pagos` (`codigoCliente` ASC);


-- -----------------------------------------------------
-- Table `jardineria`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jardineria`.`pedidos` (
  `idPedidos` INT NOT NULL,
  `fechaPedido` DATETIME NOT NULL,
  `fechaEntrega` DATETIME NULL DEFAULT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  `comentarios` VARCHAR(45) NULL DEFAULT NULL,
  `codigoCliente` INT NOT NULL,
  PRIMARY KEY (`idPedidos`, `codigoCliente`),
  CONSTRAINT `fk_Pedidos_Clientes1`
    FOREIGN KEY (`codigoCliente`)
    REFERENCES `jardineria`.`clientes` (`idCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_Pedidos_Clientes1_idx` ON `jardineria`.`pedidos` (`codigoCliente` ASC);


-- -----------------------------------------------------
-- Table `jardineria`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jardineria`.`productos` (
  `idProducto` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `gama` VARCHAR(45) NULL DEFAULT NULL,
  `dimensiones` VARCHAR(45) NULL DEFAULT NULL,
  `proveedor` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `cantidadStock` VARCHAR(45) NULL DEFAULT NULL,
  `precioVenta` VARCHAR(45) NULL DEFAULT NULL,
  `precioProveedor` VARCHAR(45) NULL DEFAULT NULL,
  `codigoGama` INT NOT NULL,
  PRIMARY KEY (`idProducto`, `codigoGama`),
  CONSTRAINT `fk_Productos_Gama1`
    FOREIGN KEY (`codigoGama`)
    REFERENCES `jardineria`.`gama` (`idGama`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_Productos_Gama1_idx` ON `jardineria`.`productos` (`codigoGama` ASC);


-- -----------------------------------------------------
-- Table `jardineria`.`pedidos_has_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jardineria`.`pedidos_has_productos` (
  `codigoPedido` INT NOT NULL,
  `codigoProducto` INT NOT NULL,
  `cantidad` INT NULL,
  `precioUnidad` INT NULL,
  PRIMARY KEY (`codigoPedido`, `codigoProducto`),
  CONSTRAINT `fk_Pedidos_has_Productos_Pedidos1`
    FOREIGN KEY (`codigoPedido`)
    REFERENCES `jardineria`.`pedidos` (`idPedidos`),
  CONSTRAINT `fk_Pedidos_has_Productos_Productos1`
    FOREIGN KEY (`codigoProducto`)
    REFERENCES `jardineria`.`productos` (`idProducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_Pedidos_has_Productos_Productos1_idx` ON `jardineria`.`pedidos_has_productos` (`codigoProducto` ASC);

CREATE INDEX `fk_Pedidos_has_Productos_Pedidos1_idx` ON `jardineria`.`pedidos_has_productos` (`codigoPedido` ASC);


-- -----------------------------------------------------
-- Table `jardineria`.`postal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jardineria`.`postal` (
  `idPostal` INT NOT NULL,
  PRIMARY KEY (`idPostal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
