-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema erd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema erd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `erd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `erd` ;

-- -----------------------------------------------------
-- Table `erd`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`roles` ;

CREATE TABLE IF NOT EXISTS `erd`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `erd`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`users` ;

CREATE TABLE IF NOT EXISTS `erd`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `erd`.`assignments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`assignments` ;

CREATE TABLE IF NOT EXISTS `erd`.`assignments` (
  `user` INT NULL DEFAULT NULL,
  `role` INT NULL DEFAULT NULL,
  INDEX `user_assignment` (`user` ASC) VISIBLE,
  INDEX `role_assignment` (`role` ASC) VISIBLE,
  CONSTRAINT `role_assignment`
    FOREIGN KEY (`role`)
    REFERENCES `erd`.`roles` (`id`),
  CONSTRAINT `user_assignment`
    FOREIGN KEY (`user`)
    REFERENCES `erd`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `erd`.`documents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`documents` ;

CREATE TABLE IF NOT EXISTS `erd`.`documents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `erd`.`events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`events` ;

CREATE TABLE IF NOT EXISTS `erd`.`events` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user` INT NULL DEFAULT NULL,
  `date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `user_event` (`user` ASC) VISIBLE,
  CONSTRAINT `user_event`
    FOREIGN KEY (`user`)
    REFERENCES `erd`.`users` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `erd`.`extras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`extras` ;

CREATE TABLE IF NOT EXISTS `erd`.`extras` (
  `event` INT NULL DEFAULT NULL,
  `keyy` VARCHAR(45) NULL DEFAULT NULL,
  `value` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `event_extra` (`event` ASC) VISIBLE,
  CONSTRAINT `event_extra`
    FOREIGN KEY (`event`)
    REFERENCES `erd`.`events` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `erd`.`object_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`object_types` ;

CREATE TABLE IF NOT EXISTS `erd`.`object_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `erd`.`operation_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`operation_types` ;

CREATE TABLE IF NOT EXISTS `erd`.`operation_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `erd`.`request_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`request_types` ;

CREATE TABLE IF NOT EXISTS `erd`.`request_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `operation_type` INT NULL DEFAULT NULL,
  `object_type` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `operation_request` (`operation_type` ASC) VISIBLE,
  INDEX `object_request` (`object_type` ASC) VISIBLE,
  CONSTRAINT `object_request`
    FOREIGN KEY (`object_type`)
    REFERENCES `erd`.`object_types` (`id`),
  CONSTRAINT `operation_request`
    FOREIGN KEY (`operation_type`)
    REFERENCES `erd`.`operation_types` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `erd`.`grants`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`grants` ;

CREATE TABLE IF NOT EXISTS `erd`.`grants` (
  `user` INT NULL DEFAULT NULL,
  `role` INT NULL DEFAULT NULL,
  `request_type` INT NULL DEFAULT NULL,
  INDEX `user_grant` (`user` ASC) VISIBLE,
  INDEX `role_grant` (`role` ASC) VISIBLE,
  INDEX `request_grant` (`request_type` ASC) VISIBLE,
  CONSTRAINT `request_grant`
    FOREIGN KEY (`request_type`)
    REFERENCES `erd`.`request_types` (`id`),
  CONSTRAINT `role_grant`
    FOREIGN KEY (`role`)
    REFERENCES `erd`.`roles` (`id`),
  CONSTRAINT `user_grant`
    FOREIGN KEY (`user`)
    REFERENCES `erd`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `erd`.`tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`tags` ;

CREATE TABLE IF NOT EXISTS `erd`.`tags` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `erd`.`links`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`links` ;

CREATE TABLE IF NOT EXISTS `erd`.`links` (
  `document` INT NULL DEFAULT NULL,
  `tag` INT NULL DEFAULT NULL,
  INDEX `document_link` (`document` ASC) VISIBLE,
  INDEX `tag_link` (`tag` ASC) VISIBLE,
  CONSTRAINT `document_link`
    FOREIGN KEY (`document`)
    REFERENCES `erd`.`documents` (`id`),
  CONSTRAINT `tag_link`
    FOREIGN KEY (`tag`)
    REFERENCES `erd`.`tags` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `erd`.`metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erd`.`metadata` ;

CREATE TABLE IF NOT EXISTS `erd`.`metadata` (
  `document` INT NULL DEFAULT NULL,
  `keyy` VARCHAR(255) NULL DEFAULT NULL,
  `value` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `document_metadata` (`document` ASC) VISIBLE,
  CONSTRAINT `document_metadata`
    FOREIGN KEY (`document`)
    REFERENCES `erd`.`documents` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `erd`.`roles`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`roles` (`id`, `name`, `description`) VALUES (1, 'Viewer', '');
INSERT INTO `erd`.`roles` (`id`, `name`, `description`) VALUES (2, 'Editor', NULL);
INSERT INTO `erd`.`roles` (`id`, `name`, `description`) VALUES (3, 'Guest', NULL);
INSERT INTO `erd`.`roles` (`id`, `name`, `description`) VALUES (4, 'Admin', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`users` (`id`, `name`, `email`) VALUES (1, 'Marcus', 'marcus@emai.com');
INSERT INTO `erd`.`users` (`id`, `name`, `email`) VALUES (2, 'G1gg1L3s', 'test@test.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`assignments`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`assignments` (`user`, `role`) VALUES (1, 2);
INSERT INTO `erd`.`assignments` (`user`, `role`) VALUES (2, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`documents`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`documents` (`id`) VALUES (1);
INSERT INTO `erd`.`documents` (`id`) VALUES (2);
INSERT INTO `erd`.`documents` (`id`) VALUES (3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`events`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`events` (`id`, `user`, `date`) VALUES (1, 1, '2020-04-28 14:56:20');
INSERT INTO `erd`.`events` (`id`, `user`, `date`) VALUES (2, 2, '2020-05-03 12:01:50');

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`extras`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`extras` (`event`, `keyy`, `value`) VALUES (1, 'type', '1');
INSERT INTO `erd`.`extras` (`event`, `keyy`, `value`) VALUES (1, 'success', 'true');
INSERT INTO `erd`.`extras` (`event`, `keyy`, `value`) VALUES (2, 'type', '2');
INSERT INTO `erd`.`extras` (`event`, `keyy`, `value`) VALUES (2, 'success', 'false');
INSERT INTO `erd`.`extras` (`event`, `keyy`, `value`) VALUES (2, 'reasone', 'Not found');

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`object_types`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`object_types` (`id`, `name`) VALUES (1, 'Document');
INSERT INTO `erd`.`object_types` (`id`, `name`) VALUES (2, 'User');

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`operation_types`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`operation_types` (`id`, `name`) VALUES (1, 'Create');
INSERT INTO `erd`.`operation_types` (`id`, `name`) VALUES (2, 'Read');
INSERT INTO `erd`.`operation_types` (`id`, `name`) VALUES (3, 'Update');
INSERT INTO `erd`.`operation_types` (`id`, `name`) VALUES (4, 'Delete');

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`request_types`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`request_types` (`id`, `name`, `operation_type`, `object_type`) VALUES (1, 'Create document', 1, 1);
INSERT INTO `erd`.`request_types` (`id`, `name`, `operation_type`, `object_type`) VALUES (2, 'View document', 2, 1);
INSERT INTO `erd`.`request_types` (`id`, `name`, `operation_type`, `object_type`) VALUES (3, 'Edit document', 3, 1);
INSERT INTO `erd`.`request_types` (`id`, `name`, `operation_type`, `object_type`) VALUES (4, 'Delete document', 4, 1);
INSERT INTO `erd`.`request_types` (`id`, `name`, `operation_type`, `object_type`) VALUES (5, 'Give permissions to user', 3, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`grants`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`grants` (`user`, `role`, `request_type`) VALUES (NULL, 4, 1);
INSERT INTO `erd`.`grants` (`user`, `role`, `request_type`) VALUES (NULL, 4, 2);
INSERT INTO `erd`.`grants` (`user`, `role`, `request_type`) VALUES (NULL, 4, 3);
INSERT INTO `erd`.`grants` (`user`, `role`, `request_type`) VALUES (NULL, 4, 4);
INSERT INTO `erd`.`grants` (`user`, `role`, `request_type`) VALUES (NULL, 4, 5);
INSERT INTO `erd`.`grants` (`user`, `role`, `request_type`) VALUES (NULL, 1, 2);
INSERT INTO `erd`.`grants` (`user`, `role`, `request_type`) VALUES (NULL, 2, 1);
INSERT INTO `erd`.`grants` (`user`, `role`, `request_type`) VALUES (NULL, 2, 2);
INSERT INTO `erd`.`grants` (`user`, `role`, `request_type`) VALUES (NULL, 2, 3);
INSERT INTO `erd`.`grants` (`user`, `role`, `request_type`) VALUES (NULL, 2, 4);
INSERT INTO `erd`.`grants` (`user`, `role`, `request_type`) VALUES (1, NULL, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`tags`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`tags` (`id`, `value`) VALUES (1, 'Database');
INSERT INTO `erd`.`tags` (`id`, `value`) VALUES (2, 'Relational');
INSERT INTO `erd`.`tags` (`id`, `value`) VALUES (3, 'Users');
INSERT INTO `erd`.`tags` (`id`, `value`) VALUES (4, 'Logic');
INSERT INTO `erd`.`tags` (`id`, `value`) VALUES (5, 'Database Theory');
INSERT INTO `erd`.`tags` (`id`, `value`) VALUES (6, 'specification component');
INSERT INTO `erd`.`tags` (`id`, `value`) VALUES (7, 'algebra query language');

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`links`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`links` (`document`, `tag`) VALUES (1, 1);
INSERT INTO `erd`.`links` (`document`, `tag`) VALUES (1, 2);
INSERT INTO `erd`.`links` (`document`, `tag`) VALUES (1, 3);
INSERT INTO `erd`.`links` (`document`, `tag`) VALUES (2, 1);
INSERT INTO `erd`.`links` (`document`, `tag`) VALUES (2, 2);
INSERT INTO `erd`.`links` (`document`, `tag`) VALUES (2, 5);
INSERT INTO `erd`.`links` (`document`, `tag`) VALUES (3, 1);
INSERT INTO `erd`.`links` (`document`, `tag`) VALUES (3, 2);
INSERT INTO `erd`.`links` (`document`, `tag`) VALUES (3, 6);
INSERT INTO `erd`.`links` (`document`, `tag`) VALUES (3, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `erd`.`metadata`
-- -----------------------------------------------------
START TRANSACTION;
USE `erd`;
INSERT INTO `erd`.`metadata` (`document`, `keyy`, `value`) VALUES (1, 'name', 'Relational Database: A Practical Foundation for Productivity');
INSERT INTO `erd`.`metadata` (`document`, `keyy`, `value`) VALUES (1, 'author', 'E.F.Codd');
INSERT INTO `erd`.`metadata` (`document`, `keyy`, `value`) VALUES (1, 'location', 'https://doi.org/10.1016/B978-0-934613-53-8.50009-1');
INSERT INTO `erd`.`metadata` (`document`, `keyy`, `value`) VALUES (2, 'name', 'Towards a Logical Reconstruction of Relational Database Theory');
INSERT INTO `erd`.`metadata` (`document`, `keyy`, `value`) VALUES (2, 'author', 'Raymond Reiter');
INSERT INTO `erd`.`metadata` (`document`, `keyy`, `value`) VALUES (2, 'location', 'https://doi.org/10.1016/B978-0-934613-53-8.50025-X');
INSERT INTO `erd`.`metadata` (`document`, `keyy`, `value`) VALUES (2, 'publisher', 'Elsevier');
INSERT INTO `erd`.`metadata` (`document`, `keyy`, `value`) VALUES (3, 'name', 'Elements of Relational Database Theory');
INSERT INTO `erd`.`metadata` (`document`, `keyy`, `value`) VALUES (3, 'author', 'Paris C.KANELLAKIS');
INSERT INTO `erd`.`metadata` (`document`, `keyy`, `value`) VALUES (3, 'location', 'https://doi.org/10.1016/B978-0-444-88074-1.50022-6');
INSERT INTO `erd`.`metadata` (`document`, `keyy`, `value`) VALUES (3, 'date', '1990');

COMMIT;

