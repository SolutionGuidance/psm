SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`SearchCriteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SearchCriteria` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`SearchCriteria` (
  `search_criteria_id` INT NOT NULL AUTO_INCREMENT ,
  `identifier` VARCHAR(45) NULL ,
  `lastName` VARCHAR(45) NULL ,
  `firstName` VARCHAR(45) NULL ,
  `state` VARCHAR(45) NULL ,
  PRIMARY KEY (`search_criteria_id`) ,
  UNIQUE INDEX `search_criteria_id_UNIQUE` (`search_criteria_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ResultLogEntry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ResultLogEntry` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`ResultLogEntry` (
  `result_log_entry_id` INT NOT NULL AUTO_INCREMENT ,
  `search_criteria_id` INT NOT NULL ,
  PRIMARY KEY (`result_log_entry_id`) ,
  UNIQUE INDEX `result_log_entry_id_UNIQUE` (`result_log_entry_id` ASC) ,
  INDEX `search_criteria_id` () ,
  CONSTRAINT `search_criteria_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`SearchCriteria` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SourceStats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SourceStats` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`SourceStats` (
  `source_stats_id` INT NOT NULL ,
  `success_requests_count` INT NOT NULL ,
  `page_not_found_requests_count` INT NOT NULL ,
  `page_changed_requests_count` INT NOT NULL ,
  `server_error_requests_count` INT NOT NULL ,
  `reliability` DOUBLE NULL ,
  PRIMARY KEY (`source_stats_id`) ,
  UNIQUE INDEX `source_stats_id_UNIQUE` (`source_stats_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LicenseSearchCriteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`LicenseSearchCriteria` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`LicenseSearchCriteria` (
  `lcense_search_criteria_id` INT NOT NULL AUTO_INCREMENT ,
  `city` VARCHAR(45) NULL ,
  `zipcode` VARCHAR(45) NULL ,
  `search_criteria_id` INT NOT NULL ,
  PRIMARY KEY (`lcense_search_criteria_id`) ,
  UNIQUE INDEX `lcense_search_criteria_id_UNIQUE` (`lcense_search_criteria_id` ASC) ,
  INDEX `search_criteria_id` () ,
  CONSTRAINT `search_criteria_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`SearchCriteria` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`NursingLicenseSearchByLicenseSearchCriteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`NursingLicenseSearchByLicenseSearchCriteria` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`NursingLicenseSearchByLicenseSearchCriteria` (
  `NursingLicenseSearchByLicenseSearchCriteriaId` INT NOT NULL ,
  `search_criteria_id` INT NOT NULL ,
  PRIMARY KEY (`NursingLicenseSearchByLicenseSearchCriteriaId`) ,
  INDEX `search_criteria_id` () ,
  CONSTRAINT `search_criteria_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`SearchCriteria` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ChiropracticLicenseSearchCriteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ChiropracticLicenseSearchCriteria` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`ChiropracticLicenseSearchCriteria` (
  `ChiropracticLicenseSearchCriteriaId` INT NOT NULL AUTO_INCREMENT ,
  `city` VARCHAR(45) NULL ,
  `zipcode` VARCHAR(45) NULL ,
  `partial` TINYINT(1)  NULL ,
  `search_criteria_id` INT NULL ,
  PRIMARY KEY (`ChiropracticLicenseSearchCriteriaId`) ,
  UNIQUE INDEX `ChiropracticLicenseSearchCriteriaId_UNIQUE` (`ChiropracticLicenseSearchCriteriaId` ASC) ,
  INDEX `search_criteria_id` () ,
  CONSTRAINT `search_criteria_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`SearchCriteria` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DentistryLicenseSearchCriteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`DentistryLicenseSearchCriteria` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`DentistryLicenseSearchCriteria` (
  `DentistryLicenseSearchCriteriaId` INT NOT NULL AUTO_INCREMENT ,
  `middleName` VARCHAR(45) NULL ,
  `license_type_id` VARCHAR(45) NULL ,
  `search_criteria_id` INT NOT NULL ,
  PRIMARY KEY (`DentistryLicenseSearchCriteriaId`) ,
  INDEX `search_criteria_id` (`search_criteria_id` ASC) ,
  CONSTRAINT `search_criteria_id`
    FOREIGN KEY (`search_criteria_id` )
    REFERENCES `mydb`.`SearchCriteria` (`search_criteria_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DieteticsAndNutritionPracticeLicenseServiceSearchCriteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`DieteticsAndNutritionPracticeLicenseServiceSearchCriteria` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`DieteticsAndNutritionPracticeLicenseServiceSearchCriteria` (
  `DieteticsAndNutritionPracticeLicenseServiceSearchCriteriaId` INT NULL AUTO_INCREMENT ,
  `search_criteria_id` INT NULL ,
  PRIMARY KEY (`DieteticsAndNutritionPracticeLicenseServiceSearchCriteriaId`) ,
  UNIQUE INDEX `DieteticsAndNutritionPracticeLicenseServiceSearchCriteriaId_UNIQUE` (`DieteticsAndNutritionPracticeLicenseServiceSearchCriteriaId` ASC) ,
  INDEX `search_criteria_id` () ,
  CONSTRAINT `search_criteria_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`SearchCriteria` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
