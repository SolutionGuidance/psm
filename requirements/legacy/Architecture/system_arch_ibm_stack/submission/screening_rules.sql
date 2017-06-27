SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`NPIType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`NPIType` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`NPIType` (
  `NPITypeId` INT NOT NULL ,
  PRIMARY KEY (`NPITypeId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MajorProgram`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MajorProgram` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`MajorProgram` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MailPreference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MailPreference` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`MailPreference` (
  `MailPreferenceId` INT NOT NULL ,
  `code` INT NULL ,
  PRIMARY KEY (`MailPreferenceId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PrivatePractice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PrivatePractice` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`PrivatePractice` (
  `PrivatePracticeId` INT NOT NULL ,
  `name` VARCHAR(45) NULL ,
  `groupNPI` VARCHAR(45) NULL ,
  `officeAddressId` INT NULL ,
  `officePhoneNumber` VARCHAR(45) NULL ,
  `officeFaxNumber` VARCHAR(45) NULL ,
  `FEDERALTAXID` VARCHAR(45) NULL ,
  `legalName` VARCHAR(45) NULL ,
  `MINNESOTATAXID` VARCHAR(45) NULL ,
  `fiscalYearEnd` VARCHAR(45) NULL ,
  `createdTime` TIMESTAMP NULL ,
  `createdBy` INT NULL ,
  `modifiedTime` TIMESTAMP NULL ,
  `modifiedBy` INT NULL ,
  PRIMARY KEY (`PrivatePracticeId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CategoryService`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`CategoryService` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`CategoryService` (
  `category_service_id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`category_service_id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EnrollmentStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EnrollmentStatus` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`EnrollmentStatus` (
  `enrollment_status_id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`enrollment_status_id`) ,
  UNIQUE INDEX `enrollment_status_id_UNIQUE` (`enrollment_status_id` ASC) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Role` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Role` (
  `RoleId` INT NOT NULL ,
  `roleName` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`RoleId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`UserStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`UserStatus` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`UserStatus` (
  `UserStatusId` INT NOT NULL ,
  `statusName` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`UserStatusId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`User` (
  `UserId` INT NOT NULL ,
  `username` VARCHAR(45) NOT NULL ,
  `email` VARCHAR(45) NULL ,
  `firstName` VARCHAR(45) NOT NULL ,
  `lastName` VARCHAR(45) NOT NULL ,
  `middleName` VARCHAR(45) NULL ,
  `providerProfileId` INT NULL ,
  `roleId` INT NULL ,
  `statusId` INT NOT NULL ,
  PRIMARY KEY (`UserId`) ,
  INDEX `providerProfileId` () ,
  INDEX `roleId` () ,
  INDEX `statusId` () ,
  CONSTRAINT `providerProfileId`
    FOREIGN KEY ()
    REFERENCES `mydb`.`ProviderProfile` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `roleId`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Role` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `statusId`
    FOREIGN KEY ()
    REFERENCES `mydb`.`UserStatus` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`appeal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`appeal` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`appeal` (
  `appeal_id` INT NOT NULL AUTO_INCREMENT ,
  `description` INT NULL ,
  PRIMARY KEY (`appeal_id`) ,
  UNIQUE INDEX `appeal_id_UNIQUE` (`appeal_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Enrollment` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Enrollment` (
  `enrollment_id` INT NOT NULL AUTO_INCREMENT ,
  `status_id` INT NOT NULL ,
  `start_date` DATE NOT NULL ,
  `end_date` DATE NOT NULL ,
  `is_renewal` CHAR NOT NULL ,
  `user_id` INT NOT NULL ,
  `appeal_id` INT NOT NULL ,
  `denial_reason` VARCHAR(1024) NOT NULL ,
  PRIMARY KEY (`enrollment_id`) ,
  UNIQUE INDEX `enrollment_id_UNIQUE` (`enrollment_id` ASC) ,
  INDEX `status_id` () ,
  INDEX `user_id` () ,
  INDEX `appeal_id` () ,
  CONSTRAINT `status_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`EnrollmentStatus` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`User` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `appeal_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`appeal` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProviderProfile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ProviderProfile` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`ProviderProfile` (
  `providerProfileId` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `npiTypeId` INT NOT NULL ,
  `SSN` VARCHAR(45) NOT NULL ,
  `dob` DATE NOT NULL ,
  `requestEffectiveDate` DATE NOT NULL ,
  `requestEffectiveDate` VARCHAR(45) NULL ,
  `degreeId` INT NULL ,
  `specialitiesId` INT NULL ,
  `hasPrivateOffice` CHAR NOT NULL ,
  `altAddress1Id` INT NULL ,
  `altAddress2Id` INT NULL ,
  `remittanceAdviceEmailPreferenceId` INT NULL ,
  `reimbursementCheckEmailPreferenceId` INT NULL ,
  `providerCorrespondenceEmailPreferenceId` INT NULL ,
  `authorizationRequestNoticeEmailPreferenceId` INT NULL ,
  `enrollmentStatusEmailPreference` INT NULL ,
  `remittanceSequenceOrderId` INT NULL ,
  `affiliationsId` INT NULL ,
  `hasConvictedOfCriminalOffense` CHAR NULL ,
  `hasCivilMoneyPenalty` CHAR NULL ,
  `isTerminated` CHAR NULL ,
  `contactName` VARCHAR(45) NULL ,
  `contactPhoneNumber` VARCHAR(45) NULL ,
  `contactFaxNumber` VARCHAR(45) NULL ,
  `contactEmail` VARCHAR(45) NULL ,
  `providerStatementId` INT NULL ,
  `currentEnrollmentId` INT NULL ,
  `fingerPrintsScannedFile` VARCHAR(45) NULL ,
  `scannedEFTForm` VARCHAR(45) NULL ,
  `enrolmentFeeRequired` DOUBLE NULL ,
  `enrollmentFeePaid` CHAR NULL ,
  `NPI` MEDIUMTEXT  NULL ,
  `providerAgreementFile` VARCHAR(45) NULL ,
  `createdTime` TIMESTAMP NULL ,
  `createdBy` INT NULL ,
  `modifiedTime` TIMESTAMP NULL ,
  `modifiedBy` INT NULL ,
  `majorProgramId` INT NULL ,
  `categoryServiceId` INT NULL ,
  `tribalCodeId` INT NULL ,
  `employedOrAndContracted` CHAR NULL ,
  `private_practice_id` INT NOT NULL ,
  PRIMARY KEY (`providerProfileId`) ,
  INDEX `majorProgramId` () ,
  INDEX `reimbursementCheckEmailPreferenceId` () ,
  INDEX `authorizationRequestNoticeEmailPreferenceId` () ,
  INDEX `private_practice_id` () ,
  INDEX `currentEnrollmentId` () ,
  CONSTRAINT `npiTypeId`
    FOREIGN KEY ()
    REFERENCES `mydb`.`NPIType` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `majorProgramId`
    FOREIGN KEY ()
    REFERENCES `mydb`.`MajorProgram` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `remittanceAdviceEmailPreferenceId`
    FOREIGN KEY ()
    REFERENCES `mydb`.`MailPreference` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `reimbursementCheckEmailPreferenceId`
    FOREIGN KEY ()
    REFERENCES `mydb`.`MailPreference` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `providerCorrespondenceEmailPreferenceId`
    FOREIGN KEY ()
    REFERENCES `mydb`.`MailPreference` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `authorizationRequestNoticeEmailPreferenceId`
    FOREIGN KEY ()
    REFERENCES `mydb`.`MailPreference` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `enrollmentStatusEmailPreference`
    FOREIGN KEY ()
    REFERENCES `mydb`.`MailPreference` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `private_practice_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`PrivatePractice` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `categoryServiceId`
    FOREIGN KEY ()
    REFERENCES `mydb`.`CategoryService` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `currentEnrollmentId`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Enrollment` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SpecialityType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SpecialityType` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`SpecialityType` (
  `speciality_type_id` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`speciality_type_id`) ,
  UNIQUE INDEX `speciality_type_id_UNIQUE` (`speciality_type_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Speciality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Speciality` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Speciality` (
  `SpecialityId` INT NOT NULL ,
  `code` VARCHAR(45) NULL ,
  `type_id` INT NULL ,
  PRIMARY KEY (`SpecialityId`) ,
  INDEX `type_id` () ,
  CONSTRAINT `type_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`SpecialityType` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Xref_Speciality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Xref_Speciality` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Xref_Speciality` (
  `speciality_id` INT NOT NULL ,
  `provider_id` INT NOT NULL ,
  PRIMARY KEY (`speciality_id`, `provider_id`) ,
  INDEX `speciality_id` () ,
  INDEX `provider_id` () ,
  CONSTRAINT `speciality_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Speciality` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `provider_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`ProviderProfile` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Address` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Address` (
  `AddressId` INT NOT NULL ,
  `location` VARCHAR(45) NULL ,
  `city` VARCHAR(45) NULL ,
  `state` VARCHAR(2) NOT NULL ,
  `zipcode` VARCHAR(45) NULL ,
  `country` VARCHAR(45) NULL ,
  `createdTime` TIMESTAMP NULL ,
  `createdBy` INT NULL ,
  `modifiedTime` TIMESTAMP NULL ,
  `modifiedBy` INT NULL ,
  PRIMARY KEY (`AddressId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`GroupAffiliation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`GroupAffiliation` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`GroupAffiliation` (
  `groupAffiliationId` INT NOT NULL ,
  `name` VARCHAR(45) NULL ,
  `groupNPI` VARCHAR(45) NULL ,
  `addressId` INT NULL ,
  PRIMARY KEY (`groupAffiliationId`) ,
  INDEX `addressId` (`addressId` ASC) ,
  CONSTRAINT `addressId`
    FOREIGN KEY (`addressId` )
    REFERENCES `mydb`.`Address` (`AddressId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AuditRecord`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`AuditRecord` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`AuditRecord` (
  `audit_record_id` INT NOT NULL ,
  `useranem` VARCHAR(45) NOT NULL ,
  `ipaddress` VARCHAR(45) NOT NULL ,
  `oldData` VARCHAR(1024) NOT NULL ,
  `newData` VARCHAR(1024) NOT NULL ,
  PRIMARY KEY (`audit_record_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`HelpItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`HelpItem` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`HelpItem` (
  `help_item_id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(45) NOT NULL ,
  `description` VARCHAR(2048) NOT NULL ,
  PRIMARY KEY (`help_item_id`) ,
  UNIQUE INDEX `help_item_id_UNIQUE` (`help_item_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`renewal_enrollments_xref`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`renewal_enrollments_xref` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`renewal_enrollments_xref` (
  `enrollement_id` INT NOT NULL ,
  `profile_id` INT NULL ,
  PRIMARY KEY (`enrollement_id`) ,
  INDEX `profile_id` () ,
  INDEX `enrollement_id` () ,
  CONSTRAINT `profile_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`ProviderProfile` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `enrollement_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Enrollment` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`License`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`License` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`License` (
  `license_id` INT NOT NULL AUTO_INCREMENT ,
  `description` VARCHAR(1024) NOT NULL ,
  `original_issue_date` DATE NULL ,
  `renewal_end_date` DATE NULL ,
  `issuing_us_state` VARCHAR(2) NOT NULL ,
  PRIMARY KEY (`license_id`) ,
  UNIQUE INDEX `license_id_UNIQUE` (`license_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Provider_License_Xref`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Provider_License_Xref` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Provider_License_Xref` (
  `provider_id` INT NOT NULL ,
  `license_id` INT NOT NULL ,
  PRIMARY KEY (`provider_id`, `license_id`) ,
  INDEX `provider_id` () ,
  INDEX `license_id` () ,
  CONSTRAINT `provider_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`ProviderProfile` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `license_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`License` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
