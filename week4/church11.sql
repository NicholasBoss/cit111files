-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema church11
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `church11` ;

-- -----------------------------------------------------
-- Schema church11
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `church11` ;
USE `church11` ;

-- -----------------------------------------------------
-- Table `church11`.`unit_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `church11`.`unit_type` ;

CREATE TABLE IF NOT EXISTS `church11`.`unit_type` (
  `unit_type_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`unit_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `church11`.`unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `church11`.`unit` ;

CREATE TABLE IF NOT EXISTS `church11`.`unit` (
  `unit_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `unit_name` VARCHAR(45) NOT NULL,
  `unit_type_id` INT UNSIGNED NOT NULL,
  `parent_unit_id` INT UNSIGNED NULL,
  PRIMARY KEY (`unit_id`),
  INDEX `fk_unit_unit_type_idx` (`unit_type_id` ASC) VISIBLE,
  INDEX `fk_unit_unit1_idx` (`parent_unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_unit_unit_type`
    FOREIGN KEY (`unit_type_id`)
    REFERENCES `church11`.`unit_type` (`unit_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_unit_unit1`
    FOREIGN KEY (`parent_unit_id`)
    REFERENCES `church11`.`unit` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `church11`.`member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `church11`.`member` ;

CREATE TABLE IF NOT EXISTS `church11`.`member` (
  `member_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  `unit_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`member_id`),
  INDEX `fk_member_unit1_idx` (`unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_member_unit1`
    FOREIGN KEY (`unit_id`)
    REFERENCES `church11`.`unit` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `church11`.`organization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `church11`.`organization` ;

CREATE TABLE IF NOT EXISTS `church11`.`organization` (
  `organization_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_name` VARCHAR(45) NOT NULL,
  `unit_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`organization_id`),
  INDEX `fk_organization_unit1_idx` (`unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_organization_unit1`
    FOREIGN KEY (`unit_id`)
    REFERENCES `church11`.`unit` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `church11`.`position`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `church11`.`position` ;

CREATE TABLE IF NOT EXISTS `church11`.`position` (
  `position_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `position_name` VARCHAR(45) NOT NULL,
  `organization_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`position_id`),
  INDEX `fk_position_organization1_idx` (`organization_id` ASC) VISIBLE,
  CONSTRAINT `fk_position_organization1`
    FOREIGN KEY (`organization_id`)
    REFERENCES `church11`.`organization` (`organization_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `church11`.`calling`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `church11`.`calling` ;

CREATE TABLE IF NOT EXISTS `church11`.`calling` (
  `member_id` INT UNSIGNED NOT NULL,
  `position_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`member_id`, `position_id`),
  INDEX `fk_member_position_position1_idx` (`position_id` ASC) VISIBLE,
  INDEX `fk_member_position_member1_idx` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_member_position_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `church11`.`member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_member_position_position1`
    FOREIGN KEY (`position_id`)
    REFERENCES `church11`.`position` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
