-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema uni_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema uni_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `uni_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `uni_db` ;

-- -----------------------------------------------------
-- Table `uni_db`.`specialty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni_db`.`specialty` (
  `spec_id` INT(11) NOT NULL,
  `spec_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`spec_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `uni_db`.`flow`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni_db`.`flow` (
  `flow_id` INT(11) NOT NULL,
  `beg_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `spec_id` INT(11) NOT NULL,
  PRIMARY KEY (`flow_id`),
  INDEX `spec_id_idx` (`spec_id` ASC) VISIBLE,
  CONSTRAINT `spec_id`
    FOREIGN KEY (`spec_id`)
    REFERENCES `uni_db`.`specialty` (`spec_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `uni_db`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni_db`.`user` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `pwd` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `uni_db`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni_db`.`staff` (
  `staff_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `national_id` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`staff_id`),
  INDEX `admin_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `admin_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `uni_db`.`user` (`user_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `uni_db`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni_db`.`course` (
  `course_id` INT(11) NOT NULL,
  `course_name` VARCHAR(45) NOT NULL,
  `beg_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `teacher_id` INT(11) NOT NULL,
  `flow_id` INT(11) NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `teacher_id_idx` (`teacher_id` ASC) VISIBLE,
  INDEX `flow_id_idx` (`flow_id` ASC) VISIBLE,
  CONSTRAINT `flow_id`
    FOREIGN KEY (`flow_id`)
    REFERENCES `uni_db`.`flow` (`flow_id`),
  CONSTRAINT `teacher_id`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `uni_db`.`staff` (`staff_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `uni_db`.`lesson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni_db`.`lesson` (
  `lesson_id` INT(11) NOT NULL,
  `date` DATE NOT NULL,
  `time` DATETIME NOT NULL,
  `staff_id` INT(11) NOT NULL,
  `attendance_id` INT(11) NOT NULL,
  `course_id` INT(11) NOT NULL,
  PRIMARY KEY (`lesson_id`),
  INDEX `staff_id_idx` (`staff_id` ASC) VISIBLE,
  INDEX `course_id_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `course_id`
    FOREIGN KEY (`course_id`)
    REFERENCES `uni_db`.`course` (`course_id`),
  CONSTRAINT `staff_id`
    FOREIGN KEY (`staff_id`)
    REFERENCES `uni_db`.`staff` (`staff_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `uni_db`.`attendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni_db`.`attendance` (
  `attendance_id` INT(11) NOT NULL,
  `lesson_id` INT(11) NOT NULL,
  `course_id` INT(11) NOT NULL,
  `teacher_id` INT(11) NOT NULL,
  `present` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`attendance_id`),
  INDEX `lesson_id_idx` (`lesson_id` ASC) VISIBLE,
  CONSTRAINT `lesson_id`
    FOREIGN KEY (`lesson_id`)
    REFERENCES `uni_db`.`lesson` (`lesson_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `uni_db`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni_db`.`students` (
  `student_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `national_id` INT(11) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `zip` INT(11) NOT NULL,
  `specialty_id` INT(11) NOT NULL,
  `flow_id` INT(11) NOT NULL,
  PRIMARY KEY (`student_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `uni_db`.`user` (`user_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
