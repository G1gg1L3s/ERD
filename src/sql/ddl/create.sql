-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema erd
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `erd` ;

-- -----------------------------------------------------
-- Schema erd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `erd` ;
USE `erd` ;

-- -----------------------------------------------------
-- Table `erd`.`documents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`documents` ;

CREATE TABLE IF NOT EXISTS `erd`.`documents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `erd`.`metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`metadata` ;

CREATE TABLE IF NOT EXISTS `erd`.`metadata` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `document_id` INT NULL,
  `keyy` VARCHAR(45) NOT NULL,
  `value` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_metadata_documents`
    FOREIGN KEY (`document_id`)
    REFERENCES `erd`.`documents` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `keyy` ON `erd`.`metadata` (`keyy` ASC);

CREATE INDEX `fk_metadata_documents_idx` ON `erd`.`metadata` (`document_id` ASC);


-- -----------------------------------------------------
-- Table `erd`.`tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`tags` ;

CREATE TABLE IF NOT EXISTS `erd`.`tags` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `value_UNIQUE` ON `erd`.`tags` (`value` ASC);


-- -----------------------------------------------------
-- Table `erd`.`links`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`links` ;

CREATE TABLE IF NOT EXISTS `erd`.`links` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `document_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_links_documents`
    FOREIGN KEY (`document_id`)
    REFERENCES `erd`.`documents` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_links_tags`
    FOREIGN KEY (`tag_id`)
    REFERENCES `erd`.`tags` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `document_tag_UNIQUE` ON `erd`.`links` (`document_id` ASC, `tag_id` ASC);

CREATE INDEX `fk_links_tags_idx` ON `erd`.`links` (`tag_id` ASC);


-- -----------------------------------------------------
-- Table `erd`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`users` ;

CREATE TABLE IF NOT EXISTS `erd`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE INDEX `NAME_INDEX` ON `erd`.`users` (`name` ASC);

CREATE INDEX `EMAIL_INDEX` ON `erd`.`users` (`email` ASC);


-- -----------------------------------------------------
-- Table `erd`.`events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`events` ;

CREATE TABLE IF NOT EXISTS `erd`.`events` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_events_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `erd`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_events_users_idx` ON `erd`.`events` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `erd`.`extras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`extras` ;

CREATE TABLE IF NOT EXISTS `erd`.`extras` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `event_id` INT NOT NULL,
  `keyy` VARCHAR(45) NOT NULL,
  `value` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_extras_events`
    FOREIGN KEY (`event_id`)
    REFERENCES `erd`.`events` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `keyy_INDEX` ON `erd`.`extras` (`keyy` ASC);

CREATE INDEX `fk_extras_events_idx` ON `erd`.`extras` (`event_id` ASC);


-- -----------------------------------------------------
-- Table `erd`.`object_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`object_types` ;

CREATE TABLE IF NOT EXISTS `erd`.`object_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE INDEX `name_INDEX` ON `erd`.`object_types` (`name` ASC);


-- -----------------------------------------------------
-- Table `erd`.`operation_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`operation_types` ;

CREATE TABLE IF NOT EXISTS `erd`.`operation_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE INDEX `name_INDEX` ON `erd`.`operation_types` (`name` ASC);


-- -----------------------------------------------------
-- Table `erd`.`request_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`request_types` ;

CREATE TABLE IF NOT EXISTS `erd`.`request_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `object_type` INT NOT NULL,
  `operation_type` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_request_object_type`
    FOREIGN KEY (`object_type`)
    REFERENCES `erd`.`object_types` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_request_operation_type`
    FOREIGN KEY (`operation_type`)
    REFERENCES `erd`.`operation_types` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `name_INDEX` ON `erd`.`request_types` (`name` ASC);

CREATE UNIQUE INDEX `object_operation_UNIQUE` ON `erd`.`request_types` (`object_type` ASC, `operation_type` ASC);

CREATE INDEX `fk_request_operation_type_idx` ON `erd`.`request_types` (`operation_type` ASC);


-- -----------------------------------------------------
-- Table `erd`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`roles` ;

CREATE TABLE IF NOT EXISTS `erd`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `name_UNIQUE` ON `erd`.`roles` (`name` ASC);


-- -----------------------------------------------------
-- Table `erd`.`assignments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`assignments` ;

CREATE TABLE IF NOT EXISTS `erd`.`assignments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_assignments_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `erd`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assignments_roles`
    FOREIGN KEY (`role_id`)
    REFERENCES `erd`.`roles` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `user_role_UNIQUE` ON `erd`.`assignments` (`user_id` ASC, `role_id` ASC);

CREATE INDEX `fk_assignments_roles_idx` ON `erd`.`assignments` (`role_id` ASC);


-- -----------------------------------------------------
-- Table `erd`.`grants`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`grants` ;

CREATE TABLE IF NOT EXISTS `erd`.`grants` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `role_id` INT NULL,
  `request_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_grants_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `erd`.`users` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grants_roles`
    FOREIGN KEY (`role_id`)
    REFERENCES `erd`.`roles` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grants_request_types`
    FOREIGN KEY (`request_type_id`)
    REFERENCES `erd`.`request_types` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `user_request_type_UNIQUE` ON `erd`.`grants` (`user_id` ASC, `request_type_id` ASC);

CREATE UNIQUE INDEX `role_request_type_UNIQUE` ON `erd`.`grants` (`role_id` ASC, `request_type_id` ASC);

CREATE INDEX `fk_grants_request_types_idx` ON `erd`.`grants` (`request_type_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;