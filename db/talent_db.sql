SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_type` TINYINT NOT NULL DEFAULT 0 COMMENT '0 -> job_seeker\n1 -> recruiter',
  `meta_data` VARCHAR(512) NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC))
ENGINE = InnoDB
COMMENT = 'Serves as the master parent table for users. Also stores use /* comment truncated */ /*r_type ( 0 => job_seeker , 1 => recruiter )*/';


-- -----------------------------------------------------
-- Table `mydb`.`job_seekers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`job_seekers` (
  `job_seekers` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `job_seeker_first_name` VARCHAR(128) NULL,
  `job_seeker_second_name` VARCHAR(128) NULL,
  `job_seeker_last_name` VARCHAR(128) NULL,
  PRIMARY KEY (`job_seekers`),
  INDEX `job_seekers_user_id_idx` (`user_id` ASC),
  CONSTRAINT `job_seekers_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_logins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_logins` (
  `user_login_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `user_email` VARCHAR(128) NOT NULL,
  `user_password` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`user_login_id`),
  INDEX `user_login_user_id_idx` (`user_id` ASC),
  CONSTRAINT `user_login_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`oauth_providers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`oauth_providers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `service_provider_id` TINYINT NOT NULL COMMENT '0 -> linkedIn\n1 -> github\n2 -> gmail',
  `user_id` INT NOT NULL,
  `oauth_secret` VARCHAR(512) NULL,
  `meta_data` VARCHAR(128) NULL,
  PRIMARY KEY (`id`),
  INDEX `oauth_providers_user_id_idx` (`user_id` ASC),
  CONSTRAINT `oauth_providers_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dump_datas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dump_datas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `dump_data` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `dump_datas_user_id_idx` (`user_id` ASC),
  CONSTRAINT `dump_datas_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
