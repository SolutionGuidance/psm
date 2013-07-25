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
-- Table `mydb`.`EPLSSearchCriteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EPLSSearchCriteria` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`EPLSSearchCriteria` (
  `EPLSSearchCriteriaId` INT NOT NULL ,
  `search_criteria_id` INT NOT NULL ,
  `npiType_id` INT NULL ,
  `name` VARCHAR(45) NULL ,
  `actionDateTo` DATE NULL ,
  `actionDateFrom` DATE NULL ,
  `terminationDateFrom` DATE NULL ,
  `terminationDateTo` DATE NULL ,
  `createDateFrom` DATE NULL ,
  `createDateTo` DATE NULL ,
  `modifyDateFrom` DATE NULL ,
  `modifyDateTo` DATE NULL ,
  `exclusion_type_id` INT NULL ,
  `reciprocalCode` VARCHAR(45) NULL ,
  `procurementCode` VARCHAR(45) NULL ,
  `nonProcurementCode` VARCHAR(45) NULL ,
  `agency` VARCHAR(45) NULL ,
  `usState` VARCHAR(45) NULL ,
  `country` VARCHAR(45) NULL ,
  `duns` VARCHAR(45) NULL ,
  `cageCode` VARCHAR(45) NULL ,
  PRIMARY KEY (`EPLSSearchCriteriaId`) ,
  INDEX `search_criteria_id` () ,
  CONSTRAINT `search_criteria_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`SearchCriteria` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BusinessLienSearchCriteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BusinessLienSearchCriteria` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`BusinessLienSearchCriteria` (
  `BusinessLienSearchCriteriaId` INT NOT NULL AUTO_INCREMENT ,
  `businessName` VARCHAR(45) NULL ,
  `fileNumber` INT NULL ,
  `scope` TINYINT NULL ,
  `search_criteria_id` INT NULL ,
  `filingStatus` TINYINT(1)  NULL ,
  PRIMARY KEY (`BusinessLienSearchCriteriaId`) ,
  UNIQUE INDEX `ChiropracticLicenseSearchCriteriaId_UNIQUE` (`BusinessLienSearchCriteriaId` ASC) ,
  INDEX `search_criteria_id` () ,
  CONSTRAINT `search_criteria_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`SearchCriteria` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`NNPESSearchCriteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`NNPESSearchCriteria` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`NNPESSearchCriteria` (
  `NNPESSearchCriteriaId` INT NOT NULL AUTO_INCREMENT ,
  `NPI` VARCHAR(45) NULL ,
  `practiceCity` VARCHAR(45) NULL ,
  `search_criteria_id` INT NOT NULL ,
  `practiceState` VARCHAR(45) NULL ,
  `securityImageCode` VARCHAR(45) NULL ,
  `orgName` VARCHAR(45) NULL ,
  `orgDba` VARCHAR(45) NULL ,
  `captchImage:byte[]` BLOB NULL ,
  PRIMARY KEY (`NNPESSearchCriteriaId`) ,
  INDEX `search_criteria_id` (`search_criteria_id` ASC) ,
  CONSTRAINT `search_criteria_id`
    FOREIGN KEY (`search_criteria_id` )
    REFERENCES `mydb`.`SearchCriteria` (`search_criteria_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OIGSearchCriteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`OIGSearchCriteria` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`OIGSearchCriteria` (
  `OIGSearchCriteriaId` INT NULL AUTO_INCREMENT ,
  `search_criteria_id` INT NULL ,
  `businessName` VARCHAR(45) NULL ,
  PRIMARY KEY (`OIGSearchCriteriaId`) ,
  UNIQUE INDEX `DieteticsAndNutritionPracticeLicenseServiceSearchCriteriaId_UNIQUE` (`OIGSearchCriteriaId` ASC) ,
  INDEX `search_criteria_id` () ,
  CONSTRAINT `search_criteria_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`SearchCriteria` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CIGFeed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`CIGFeed` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`CIGFeed` (
  `CIGFeedId` INT NOT NULL AUTO_INCREMENT ,
  `type_id` INT NULL ,
  `title` VARCHAR(45) NULL ,
  `guid` VARCHAR(45) NULL ,
  `isPerminent` TINYINT(1)  NULL ,
  `description` VARCHAR(45) NULL ,
  `link` VARCHAR(45) NULL ,
  PRIMARY KEY (`CIGFeedId`) ,
  UNIQUE INDEX `CIGFeedId_UNIQUE` (`CIGFeedId` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ExclusionStatistics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ExclusionStatistics` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`ExclusionStatistics` (
  `ExclusionStatisticsId` INT NOT NULL ,
  `totalExcluded` INT NULL ,
  `exclusionType_id` INT NULL ,
  `percentageOfExclusion` DOUBLE NULL ,
  PRIMARY KEY (`ExclusionStatisticsId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ExclusionType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ExclusionType` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`ExclusionType` (
  `ExclusionTypeId` INT NOT NULL AUTO_INCREMENT ,
  `Name` VARCHAR(45) NULL ,
  PRIMARY KEY (`ExclusionTypeId`) ,
  UNIQUE INDEX `ExclusionTypeId_UNIQUE` (`ExclusionTypeId` ASC) )
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
