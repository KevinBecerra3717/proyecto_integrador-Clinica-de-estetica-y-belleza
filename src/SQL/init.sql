-- MySQL Script generated by MySQL Workbench
-- Wed Mar 15 13:51:43 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rol` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `users_id` INT NOT NULL AUTO_INCREMENT,
  `users_email` VARCHAR(45) NOT NULL,
  `users_password` VARCHAR(45) NOT NULL,
  `rol_role_id` INT NOT NULL,
  PRIMARY KEY (`users_id`),
  INDEX `fk_users_rol1_idx` (`rol_role_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_rol1`
    FOREIGN KEY (`rol_role_id`)
    REFERENCES `mydb`.`rol` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_info` (
  `user_info_id` INT NOT NULL AUTO_INCREMENT,
  `user_first_name` VARCHAR(45) NOT NULL,
  `user_last_name` VARCHAR(45) NOT NULL,
  `user_cedula` VARCHAR(45) NULL,
  `user_address` VARCHAR(45) NOT NULL,
  `user_phone` INT(12) NOT NULL,
  `user_email` VARCHAR(45) NOT NULL,
  `user_NIT` VARCHAR(45) NULL,
  `users_users_id` INT NOT NULL,
  PRIMARY KEY (`user_info_id`),
  INDEX `fk_user_info_users1_idx` (`users_users_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_info_users1`
    FOREIGN KEY (`users_users_id`)
    REFERENCES `mydb`.`users` (`users_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`citas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`citas` (
  `citas_id` INT NOT NULL AUTO_INCREMENT,
  `citas_date` DATETIME NULL,
  `citas_cost` INT(11) NULL,
  PRIMARY KEY (`citas_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NOT NULL,
  `product_sale_price` INT(20) NOT NULL,
  `product_description` VARCHAR(120) NOT NULL,
  `product_image` LONGBLOB NOT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`stock` (
  `stock_id` INT NOT NULL AUTO_INCREMENT,
  `stock_quantity` INT(20) NOT NULL,
  `stock_location` VARCHAR(45) NOT NULL,
  `product_product_id` INT NOT NULL,
  PRIMARY KEY (`stock_id`),
  INDEX `fk_stock_product1_idx` (`product_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_stock_product1`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `mydb`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATE NULL,
  `order_cost` INT(12) NULL,
  `order_quantity` INT(10) NULL,
  `product_product_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_order_product1_idx` (`product_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_product1`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `mydb`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employee_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employee_info` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `employee_name` VARCHAR(45) NOT NULL,
  `employee_cedula` VARCHAR(45) NOT NULL,
  `employee_address` VARCHAR(45) NOT NULL,
  `employee_phone` INT(12) NOT NULL,
  `employee_enable` TINYINT NOT NULL DEFAULT 1,
  `users_users_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_info_users1_idx` (`users_users_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_info_users1`
    FOREIGN KEY (`users_users_id`)
    REFERENCES `mydb`.`users` (`users_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pursh_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pursh_order` (
  `pursh_id` INT NOT NULL AUTO_INCREMENT,
  `pursh_date` DATETIME NOT NULL,
  `employee_info_employee_id` INT NOT NULL,
  `client_info_client_info_id` INT NOT NULL,
  PRIMARY KEY (`pursh_id`),
  INDEX `fk_pursh_order_employee_info1_idx` (`employee_info_employee_id` ASC) VISIBLE,
  INDEX `fk_pursh_order_client_info1_idx` (`client_info_client_info_id` ASC) VISIBLE,
  CONSTRAINT `fk_pursh_order_employee_info1`
    FOREIGN KEY (`employee_info_employee_id`)
    REFERENCES `mydb`.`employee_info` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pursh_order_client_info1`
    FOREIGN KEY (`client_info_client_info_id`)
    REFERENCES `mydb`.`user_info` (`user_info_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`paytype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`paytype` (
  `paytype_id` INT NOT NULL AUTO_INCREMENT,
  `paytype_pay` VARCHAR(45) NULL,
  PRIMARY KEY (`paytype_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pursh_order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pursh_order_detail` (
  `pursh_order_detail_id` INT NOT NULL AUTO_INCREMENT,
  `pursh_order_detail_quantity` INT(10) NOT NULL,
  `pursh_order_detail_price` INT(20) NOT NULL,
  `pursh_order_pursh_id` INT NOT NULL,
  `product_product_id` INT NOT NULL,
  `paytype_paytype_id` INT NOT NULL,
  PRIMARY KEY (`pursh_order_detail_id`),
  INDEX `fk_pursh_order_detail_pursh_order1_idx` (`pursh_order_pursh_id` ASC) VISIBLE,
  INDEX `fk_pursh_order_detail_product1_idx` (`product_product_id` ASC) VISIBLE,
  INDEX `fk_pursh_order_detail_paytype1_idx` (`paytype_paytype_id` ASC) VISIBLE,
  CONSTRAINT `fk_pursh_order_detail_pursh_order1`
    FOREIGN KEY (`pursh_order_pursh_id`)
    REFERENCES `mydb`.`pursh_order` (`pursh_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pursh_order_detail_product1`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `mydb`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pursh_order_detail_paytype1`
    FOREIGN KEY (`paytype_paytype_id`)
    REFERENCES `mydb`.`paytype` (`paytype_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bill` (
  `bill_id` INT NOT NULL AUTO_INCREMENT,
  `bill_date` DATETIME NOT NULL,
  `client_info_client_info_id` INT NOT NULL,
  `employee_info_employee_id` INT NOT NULL,
  `pursh_order_pursh_id` INT NOT NULL,
  PRIMARY KEY (`bill_id`),
  INDEX `fk_bill_client_info1_idx` (`client_info_client_info_id` ASC) VISIBLE,
  INDEX `fk_bill_employee_info1_idx` (`employee_info_employee_id` ASC) VISIBLE,
  INDEX `fk_bill_pursh_order1_idx` (`pursh_order_pursh_id` ASC) VISIBLE,
  CONSTRAINT `fk_bill_client_info1`
    FOREIGN KEY (`client_info_client_info_id`)
    REFERENCES `mydb`.`user_info` (`user_info_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bill_employee_info1`
    FOREIGN KEY (`employee_info_employee_id`)
    REFERENCES `mydb`.`employee_info` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bill_pursh_order1`
    FOREIGN KEY (`pursh_order_pursh_id`)
    REFERENCES `mydb`.`pursh_order` (`pursh_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bill_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bill_detail` (
  `bill_detail_id` INT NOT NULL AUTO_INCREMENT,
  `bill_detail_quantity` VARCHAR(45) NULL,
  `bill_detail_total` VARCHAR(45) NULL,
  `bill_bill_id` INT NOT NULL,
  `paytype_paytype_id` INT NOT NULL,
  PRIMARY KEY (`bill_detail_id`),
  INDEX `fk_bill_detail_bill1_idx` (`bill_bill_id` ASC) VISIBLE,
  INDEX `fk_bill_detail_paytype1_idx` (`paytype_paytype_id` ASC) VISIBLE,
  CONSTRAINT `fk_bill_detail_bill1`
    FOREIGN KEY (`bill_bill_id`)
    REFERENCES `mydb`.`bill` (`bill_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bill_detail_paytype1`
    FOREIGN KEY (`paytype_paytype_id`)
    REFERENCES `mydb`.`paytype` (`paytype_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product_has_bill_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product_has_bill_detail` (
  `product_product_id` INT NOT NULL,
  `bill_detail_bill_detail_id` INT NOT NULL,
  PRIMARY KEY (`product_product_id`, `bill_detail_bill_detail_id`),
  INDEX `fk_product_has_bill_detail_bill_detail1_idx` (`bill_detail_bill_detail_id` ASC) VISIBLE,
  INDEX `fk_product_has_bill_detail_product1_idx` (`product_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_has_bill_detail_product1`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `mydb`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_bill_detail_bill_detail1`
    FOREIGN KEY (`bill_detail_bill_detail_id`)
    REFERENCES `mydb`.`bill_detail` (`bill_detail_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`aud_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`aud_product` (
  `aud_product_id` INT NOT NULL AUTO_INCREMENT,
  `aud_product_user` VARCHAR(45) NOT NULL,
  `aud_product_sale_price` INT(10) NOT NULL,
  `aud_product_date` DATETIME NOT NULL,
  PRIMARY KEY (`aud_product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_info_has_citas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_info_has_citas` (
  `user_info_user_info_id` INT NOT NULL,
  `citas_citas_id` INT NOT NULL,
  PRIMARY KEY (`user_info_user_info_id`, `citas_citas_id`),
  INDEX `fk_user_info_has_citas_citas1_idx` (`citas_citas_id` ASC) VISIBLE,
  INDEX `fk_user_info_has_citas_user_info1_idx` (`user_info_user_info_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_info_has_citas_user_info1`
    FOREIGN KEY (`user_info_user_info_id`)
    REFERENCES `mydb`.`user_info` (`user_info_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_info_has_citas_citas1`
    FOREIGN KEY (`citas_citas_id`)
    REFERENCES `mydb`.`citas` (`citas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;