
/*

reversal subscript generation
   This subscript will create a script to undo all of the work below, removing the sequences and tables.
   Run this script to generate the SQL. Then run the resultant script.

set lines 800;
set pages 800;
set head off;
set feedback off;
select 'drop table CMS.' || table_name || ' cascade constraints purge;' from all_tables where owner = 'CMS' order by table_name;
select 'drop sequence CMS.' || sequence_name || ';' from all_sequences where sequence_owner='CMS' order by sequence_name;

*/


-- ----------------------------
--  Table structure for "PEOPLEASSIGNMENTS_POTOWNERS"
-- ----------------------------
CREATE TABLE "PEOPLEASSIGNMENTS_POTOWNERS" (   "TASK_ID" NUMBER(19,0) NOT NULL, "ENTITY_ID" VARCHAR2(255CHAR) NOT NULL);

-- ----------------------------
--  Records of "PEOPLEASSIGNMENTS_POTOWNERS"
-- ----------------------------
INSERT INTO "PEOPLEASSIGNMENTS_POTOWNERS" VALUES ('322', 'Service Administrator');
INSERT INTO "PEOPLEASSIGNMENTS_POTOWNERS" VALUES ('324', 'Service Administrator');
COMMIT;

-- ----------------------------
--  Table structure for "LU_PROVIDER_TYPE"
-- ----------------------------
CREATE TABLE "LU_PROVIDER_TYPE" (   "CODE" VARCHAR2(2BYTE) NOT NULL, "DESCRIPTION" VARCHAR2(255BYTE), "APPLICANT_TYP" NUMBER(10,0) DEFAULT 0 NOT NULL, "AGREEMENT_ID" NUMBER(19,0), "ADDENDUM_ID" NUMBER(19,0), "PRIVATE_OFFICE_FLG" CHAR(1CHAR), "EMPLOYED_CONTRACTED_FLG" CHAR(1CHAR), "ADDITONAL_PRACTICE_FLG" CHAR(1CHAR), "PAYMENT_REQUIRED_FLG" CHAR(1CHAR), "AGREEMENT_FLG" CHAR(1CHAR), "ADDENDUM_FLG" CHAR(1CHAR));

-- ----------------------------
--  Records of "LU_PROVIDER_TYPE"
-- ----------------------------
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('64', 'Individual Education Plan', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('65', 'Nursing Facility', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('66', 'Hospice', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('67', 'Hospital', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('68', 'Renal Dialysis Facility', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('69', 'Intermediate Care Facilities For Persons With Developmental Disabilities', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('70', 'Physician Clinic', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('71', 'Dental Clinic', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('72', 'Dental Hygienist Clinic', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('73', 'Podiatry Clinic', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('74', 'Billing Entity For Mental Health', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('01', 'Audiologist', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('02', 'Optometrist', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('03', 'Certified Registered Nurse Anesthetist', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('04', 'Personal Care Assistant', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('05', 'Certified Professional Midwife', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('06', 'Community Health Care Worker', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('07', 'Clinical Nurse Specialist', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('08', 'Chiropractor', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('09', 'Podiatrist', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('10', 'Licensed Marriage and Family Therapist', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('11', 'Licensed Professional Clinical Counselor', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('12', 'Nurse Practitioner', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('13', 'Occupational Therapist', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('14', 'Physician Assistant', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('15', 'Private Duty Nurse', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('16', 'Physical Therapist', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('17', 'Speech Language Pathologist', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('18', 'Acupuncturist', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('19', 'Allied Dental Professional', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('20', 'Certified Mental Health Rehab Prof - CPRP', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('21', 'Dentist', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('22', 'Hearing Aid Dispenser', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('23', 'Licensed Dietician or Licensed Nutritionist', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('24', 'Licensed Independent Clinical Social Worker', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('25', 'Nurse Midwife', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('26', 'Pharmacist', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('27', 'Licensed Psychologist', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('28', 'Physician', '0', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('29', 'Billing Entity for Physical Rehabilitative Providers', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('30', 'Clearing House', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('31', 'Durable Medical Equipment', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('32', 'EDI Trading Partner', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('33', 'Family Planning Agency', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('34', 'Head Start', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('35', 'Home Health Agency', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('36', 'Independent Diagnostic Testing Facility', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('37', 'Independent Laboratory', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('38', 'Indian Health Service Facility', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('39', 'Intensive Residential Treatment Facility', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('40', 'Optical Supplier', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('41', 'Personal Care Provider Organization', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('42', 'Pharmacy', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('43', 'Private Duty Nursing Agency', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('44', 'Public Health Clinic', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('45', 'Public Health Nursing Organization', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('46', 'Regional Treatment Center', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('47', 'Rehabilitation Agency', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('48', 'Rural Health Clinic', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('49', 'Targeted Case Management', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('50', 'WIC Program', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('51', 'X-Ray Services', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('52', 'Ambulatory Surgical Center', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('53', 'Certified Registered Nurse Anesthetist Group', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('54', 'Child And Teen Checkup Clinic', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('55', 'Childrens Mental Health Residential Treatment Facility', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('56', 'Community Health Clinic', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('57', 'Community Mental Health Center', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('58', 'County Contracted Mental Health Rehab', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('59', 'Day Training And Habilitation/Day Activity Center', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('60', 'Day Treatment', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('61', 'Home And Community Based Services (Waivered Services)', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('62', 'Billing Intermediary', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('63', 'Federally Qualified Health Center', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('75', 'Chiropractic Clinic', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('76', 'Birthing Center', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('77', 'Medical Transportation', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO "LU_PROVIDER_TYPE" VALUES ('78', 'Billing Entity for Physician Services', '1', null, null, 'N', 'N', 'N', 'N', 'N', 'N');
COMMIT;

-- ----------------------------
--  Table structure for "EXTERNAL_ACCOUNT_LINK"
-- ----------------------------
CREATE TABLE "EXTERNAL_ACCOUNT_LINK" (   "EXTERNAL_ACCOUNT_LINK_ID" NUMBER(19,0) NOT NULL, "USER_ID" VARCHAR2(255CHAR), "SYSTEM_ID" VARCHAR2(255CHAR), "EXTERNAL_USER_ID" VARCHAR2(255CHAR));

-- ----------------------------
--  Table structure for "NOTIFICATION_EMAIL_HEADER"
-- ----------------------------
CREATE TABLE "NOTIFICATION_EMAIL_HEADER" (   "NOTIFICATION_ID" NUMBER(19,0) NOT NULL, "EMAILHEADERS_ID" NUMBER(19,0) NOT NULL, "MAPKEY" VARCHAR2(255CHAR) NOT NULL);

-- ----------------------------
--  Table structure for "OWNER_ASSET"
-- ----------------------------
CREATE TABLE "OWNER_ASSET" (   "OWNER_ASSET_ID" NUMBER(19,0) NOT NULL, "TYPE" VARCHAR2(255CHAR), "NAME" VARCHAR2(255CHAR), "ADDRESS_ID" NUMBER(19,0), "OWNERSHIP_TYP_CD" VARCHAR2(2CHAR), "OWNERSHIP_INFO_ID" NUMBER(19,0), "IDX" NUMBER(10,0));

-- ----------------------------
--  Table structure for "ENTITY"
-- ----------------------------
CREATE TABLE "ENTITY" (   "ENTITY_ID" NUMBER(19,0) NOT NULL, "PERSON_IND" VARCHAR2(1CHAR) NOT NULL, "ENROLLED_IND" VARCHAR2(1CHAR), "PROFILE_ID" NUMBER(19,0), "TICKET_ID" NUMBER(19,0), "NAME" VARCHAR2(100CHAR), "LEGAL_NAME" VARCHAR2(100CHAR), "LEGACY_IND" VARCHAR2(1CHAR), "NPI" VARCHAR2(10CHAR), "NPI_VERIFIED_IND" VARCHAR2(1CHAR), "NONEXCL_VERIFIED_IND" VARCHAR2(1CHAR), "PROVIDER_TYP_CD" VARCHAR2(2CHAR), "PRIMARY_CONTACT_ID" NUMBER(19,0), "MIDDLE_NAME" VARCHAR2(50CHAR), "SSN" VARCHAR2(9CHAR), "SSN_VERIFIED_IND" VARCHAR2(1CHAR), "BIRTH_DT" DATE, "DEGREE_CD" VARCHAR2(2CHAR), "DEGREE_AWARD_DT" DATE, "PREFIX" VARCHAR2(50CHAR), "SUFFIX" VARCHAR2(50CHAR), "FIRST_NAME" VARCHAR2(50CHAR), "LAST_NAME" VARCHAR2(50CHAR), "STATE_TAX_ID" VARCHAR2(10CHAR), "FEIN" VARCHAR2(7CHAR), "AGENCY_ID" VARCHAR2(100CHAR), "BGS_ID" VARCHAR2(100CHAR), "BGS_CLEARANCE_DT" DATE, "SAME_BILLING_ADDRESS_IND" VARCHAR2(1CHAR), "SAME_REIMBURSEMENT_ADDRESS_IND" VARCHAR2(1CHAR), "SAME_1099_ADDRESS_IND" VARCHAR2(1CHAR), "BILLING_ADDRESS_ID" NUMBER(19,0), "REIMBURSEMENT_ADDRESS_ID" NUMBER(19,0), "TEN99_ADDRESS_ID" NUMBER(19,0), "FISCAL_YEAR_END" VARCHAR2(5CHAR), "REMITTANCE_SEQUENCE_ORDER" VARCHAR2(255CHAR), "EFT_VENDOR_NUMBER" VARCHAR2(14CHAR), "SUB_TYP" VARCHAR2(100BYTE));

-- ----------------------------
--  Records of "ENTITY"
-- ----------------------------
INSERT INTO "ENTITY" VALUES ('32770', 'N', null, '0', '32768', 'Test', 'Test', null, '1063417558', null, 'Y', '76', '32770', null, null, null, null, null, null, null, null, null, null, null, '2453434', null, null, null, 'Y', null, 'Y', '32773', null, '32774', null, 'PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER', null, null);
INSERT INTO "ENTITY" VALUES ('32771', 'Y', null, '0', '0', 'Test', null, null, null, null, null, null, '32771', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO "ENTITY" VALUES ('5', 'N', null, '0', '1', 'Test', 'Test', null, '1568709970', null, 'Y', '75', '3', null, null, null, null, null, null, null, null, null, null, null, '3254632', null, null, null, 'Y', null, 'Y', '6', null, '7', null, 'PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER', null, null);
INSERT INTO "ENTITY" VALUES ('6', 'Y', null, '0', '0', 'Test', null, null, null, null, null, null, '4', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO "ENTITY" VALUES ('7', 'Y', null, '0', '0', 'Test', null, null, '1154324259', null, null, '08', null, null, '245234343', null, TO_DATE('1982-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO "ENTITY" VALUES ('8', 'Y', null, '0', '0', 'Test', null, null, '1568709970', null, null, '08', null, null, '234236435', null, TO_DATE('1981-10-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for "CONTACT_INFO"
-- ----------------------------
CREATE TABLE "CONTACT_INFO" (   "CONTACT_INFO_ID" NUMBER(19,0) NOT NULL, "PHONE_NUMBER" VARCHAR2(30CHAR), "FAX_NUMBER" VARCHAR2(30CHAR), "EMAIL" VARCHAR2(50CHAR), "ADDRESS_ID" NUMBER(19,0));

-- ----------------------------
--  Records of "CONTACT_INFO"
-- ----------------------------
INSERT INTO "CONTACT_INFO" VALUES ('3', '121 413-1451', '131 251-3121', null, '5');
INSERT INTO "CONTACT_INFO" VALUES ('4', '121 512-1251', null, null, null);
INSERT INTO "CONTACT_INFO" VALUES ('32770', '121 214-4121', '312 121-2151', null, '32772');
INSERT INTO "CONTACT_INFO" VALUES ('32771', '121 214-2112', null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for "LU_REQUEST_TYP"
-- ----------------------------
CREATE TABLE "LU_REQUEST_TYP" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "LU_REQUEST_TYP"
-- ----------------------------
INSERT INTO "LU_REQUEST_TYP" VALUES ('01', 'Import Profile');
INSERT INTO "LU_REQUEST_TYP" VALUES ('02', 'Enrollment');
INSERT INTO "LU_REQUEST_TYP" VALUES ('03', 'Renewal');
INSERT INTO "LU_REQUEST_TYP" VALUES ('04', 'Suspend');
INSERT INTO "LU_REQUEST_TYP" VALUES ('05', 'Update');
COMMIT;

-- ----------------------------
--  Table structure for "TICKET"
-- ----------------------------
CREATE TABLE "TICKET" (   "TICKET_ID" NUMBER(19,0) NOT NULL, "STATUS_CD" VARCHAR2(2CHAR), "REQUEST_TYP_CD" VARCHAR2(2CHAR), "PROCESS_INSTANCE_ID" NUMBER(19,0) DEFAULT 0 NOT NULL, "REF_PROFILE_ID" NUMBER(19,0) DEFAULT 0 NOT NULL, "SUBMISSION_TS" TIMESTAMP(6) NULL, "STATUS_TS" TIMESTAMP(6) NULL, "STATUS_NOTE_TXT" VARCHAR2(1000CHAR), "SUBMITTED_BY" VARCHAR2(50CHAR), "CREATED_BY" VARCHAR2(50CHAR), "CREATE_TS" TIMESTAMP(6) NULL, "LAST_UPDATED_BY" VARCHAR2(50CHAR), "PROGRESS_PAGE" VARCHAR2(100CHAR), "REF_PROFILE_TS" TIMESTAMP(6) NULL);

-- ----------------------------
--  Records of "TICKET"
-- ----------------------------
INSERT INTO "TICKET" VALUES ('1', '02', '02', '321', '0', TO_TIMESTAMP('2013-04-15 17:43:46.597000','YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2013-04-15 17:43:46.597000','YYYY-MM-DD HH24:MI:SS.FF'), null, 'XXXXCMSO00000000000000065536', 'XXXXCMSO00000000000000065536', TO_TIMESTAMP('2013-04-15 17:43:45.758000','YYYY-MM-DD HH24:MI:SS.FF'), 'XXXXCMSO00000000000000065536', 'Provider Statement', null);
INSERT INTO "TICKET" VALUES ('32768', '02', '02', '323', '0', TO_TIMESTAMP('2013-04-15 19:07:39.536000','YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2013-04-15 19:07:39.537000','YYYY-MM-DD HH24:MI:SS.FF'), null, 'XXXXCMSO00000000000000065536', 'XXXXCMSO00000000000000065536', TO_TIMESTAMP('2013-04-15 19:07:39.063000','YYYY-MM-DD HH24:MI:SS.FF'), 'XXXXCMSO00000000000000065536', 'Provider Statement', null);
COMMIT;

-- ----------------------------
--  Table structure for "PROVIDER_STATEMENT"
-- ----------------------------
CREATE TABLE "PROVIDER_STATEMENT" (   "PROVIDER_STATEMENT_ID" NUMBER(19,0) NOT NULL, "PROFILEID" NUMBER(19,0), "TICKETID" NUMBER(19,0), "NAME" VARCHAR2(45CHAR), "TITLE" VARCHAR2(45CHAR), "STATEMENT_DT" DATE, "SIGN_ATTACHEMENT_ID" NUMBER(19,0) NOT NULL);

-- ----------------------------
--  Records of "PROVIDER_STATEMENT"
-- ----------------------------
INSERT INTO "PROVIDER_STATEMENT" VALUES ('2', '0', '1', 'Test', 'Test', TO_DATE('2013-04-15 00:00:00','YYYY-MM-DD HH24:MI:SS'), '0');
INSERT INTO "PROVIDER_STATEMENT" VALUES ('32769', '0', '32768', 'Test', 'Test', TO_DATE('2013-04-15 00:00:00','YYYY-MM-DD HH24:MI:SS'), '0');
COMMIT;

-- ----------------------------
--  Table structure for "DESIGNATED_CONTACT"
-- ----------------------------
CREATE TABLE "DESIGNATED_CONTACT" (   "CONTROL_NO" NUMBER(19,0) NOT NULL, "PROFILE_ID" NUMBER(19,0), "TICKET_ID" NUMBER(19,0), "SAME_AS_PROVIDER_IND" VARCHAR2(1CHAR), "HIRE_DT" DATE, "TYPE" VARCHAR2(255CHAR), "PERSON_ID" NUMBER(19,0));

-- ----------------------------
--  Records of "DESIGNATED_CONTACT"
-- ----------------------------
INSERT INTO "DESIGNATED_CONTACT" VALUES ('2', '0', '1', null, null, 'ENROLLMENT', '6');
INSERT INTO "DESIGNATED_CONTACT" VALUES ('32769', '0', '32768', null, null, 'ENROLLMENT', '32771');
COMMIT;

-- ----------------------------
--  Table structure for "LU_SPECIALTY_TYPE"
-- ----------------------------
CREATE TABLE "LU_SPECIALTY_TYPE" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR), "SUB_CAT_CD" VARCHAR2(2CHAR));

-- ----------------------------
--  Records of "LU_SPECIALTY_TYPE"
-- ----------------------------
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('S1', 'CRNA Certification', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('S2', 'Certified Professional Midwife', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('S3', 'Psychiatric/Mental Health', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('S4', 'Gerontology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('S5', 'Pediatrics', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('S6', 'Physical Rehabilitation', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('D1', 'General Dentistry', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('D2', 'Endodontist', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('D3', 'Oral Surgery', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('D4', 'Orthodontics', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('D5', 'Pedodontics', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('D6', 'Periodontics', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('P1', 'Neuropsychology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('01', 'Allergy', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('02', 'Anesthesiology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('03', 'Cardiovascular Disease', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('04', 'Cardiovascular Surgery', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('05', 'Child Psychiatry', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('06', 'Colon and Rectal Surgery', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('07', 'Dermatology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('08', 'Diabetes', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('09', 'Emergency Services', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('10', 'Endocrinology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('11', 'Family Practice', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('12', 'Gastroenterology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('13', 'General Practice', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('14', 'General Surgery', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('15', 'Gynecology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('16', 'Immunology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('17', 'Infectious Disease', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('18', 'Internal Medicine', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('19', 'Nephrology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('20', 'Neurological Surgery', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('21', 'Neurology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('22', 'Nuclear Medicine', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('23', 'Obstetrics', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('24', 'Obstetrics and Gynecology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('25', 'Oncology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('26', 'Ophthalmology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('27', 'Pathology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('28', 'Peripheral Vascular Diseases or Surgery', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('29', 'Physical Medicine and Rehabilitation', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('30', 'Plastic Surgery', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('31', 'Preventive Medicine', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('32', 'Psychiatry', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('33', 'Pulmonary Disease', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('34', 'Radiology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('35', 'Radiology and Radiation Therapy', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('36', 'Rheumatology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('37', 'Thoracic Surgery', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('38', 'Urology', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('39', 'Other', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('FL', 'Fond Du Lac Indian Reservation', 'TC');
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('GP', 'Grand Portage Indian Reservation', 'TC');
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('LL', 'Leech Lake Indian Reservation', 'TC');
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('LS', 'Lower Sioux Indian Reservation', 'TC');
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('ML', 'Mille Lacs Indian Reservation', 'TC');
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('NL', 'Net Lake Indian Reservation"', 'TC');
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('PI', 'Prairie Island Indian Reservation', 'TC');
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('RL', 'Red Lake Reservation', 'TC');
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('US', 'Upper Sioux Indian Reservation', 'TC');
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('WE', 'White Earth Indian Reservation', 'TC');
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('86', 'Air Transport (Ambulance)', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('87', 'Advanced Life Support (Ambulance)', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('88', 'Basic Life Support (Ambulance)', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('89', 'Special Transportation Services (STS)', null);
INSERT INTO "LU_SPECIALTY_TYPE" VALUES ('WC', 'Wheelchair Transportation', null);
COMMIT;
-- data-fixes-11-19-13.sql
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('41', 'Gerontological');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('42', 'Pediatric');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('43', 'Family');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('44', 'Adult');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('45', 'OB/GYN');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('46', 'Neonatal');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('47', 'Women''s Health Care');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('48', 'Acute Care');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('49', 'Gerontology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('50', 'Pediatrics');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('C1', 'Adult CNS');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('C2', 'Diabetes Management CNS');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('C3', 'Gerontological CNS');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('C4', 'Home Health CNS');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('C5', 'Pediatric CNS');
INSERT INTO LU_SPECIALTY_TYPE (CODE, DESCRIPTION) VALUES ('S9', 'Certified Nurse Midwife');
commit;


-- ----------------------------
--  Table structure for "LU_COUNTY"
-- ----------------------------
CREATE TABLE "LU_COUNTY" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "LU_COUNTY"
-- ----------------------------
INSERT INTO "LU_COUNTY" VALUES ('01', 'Aitkin');
INSERT INTO "LU_COUNTY" VALUES ('02', 'Anoka');
INSERT INTO "LU_COUNTY" VALUES ('03', 'Becker');
INSERT INTO "LU_COUNTY" VALUES ('04', 'Beltrami');
INSERT INTO "LU_COUNTY" VALUES ('05', 'Benton');
INSERT INTO "LU_COUNTY" VALUES ('06', 'Big Stone');
INSERT INTO "LU_COUNTY" VALUES ('07', 'Blue Earth');
INSERT INTO "LU_COUNTY" VALUES ('08', 'Brown');
INSERT INTO "LU_COUNTY" VALUES ('09', 'Carlton');
INSERT INTO "LU_COUNTY" VALUES ('10', 'Carver');
INSERT INTO "LU_COUNTY" VALUES ('11', 'Cass');
INSERT INTO "LU_COUNTY" VALUES ('12', 'Chippewa');
INSERT INTO "LU_COUNTY" VALUES ('13', 'Chisago');
INSERT INTO "LU_COUNTY" VALUES ('14', 'Clay');
INSERT INTO "LU_COUNTY" VALUES ('15', 'Clearwater');
INSERT INTO "LU_COUNTY" VALUES ('16', 'Cook');
INSERT INTO "LU_COUNTY" VALUES ('17', 'Cottonwood');
INSERT INTO "LU_COUNTY" VALUES ('18', 'Crow Wing');
INSERT INTO "LU_COUNTY" VALUES ('19', 'Dakota');
INSERT INTO "LU_COUNTY" VALUES ('20', 'Dodge');
INSERT INTO "LU_COUNTY" VALUES ('21', 'Douglas');
INSERT INTO "LU_COUNTY" VALUES ('22', 'Faribault');
INSERT INTO "LU_COUNTY" VALUES ('23', 'Fillmore');
INSERT INTO "LU_COUNTY" VALUES ('24', 'Freeborn');
INSERT INTO "LU_COUNTY" VALUES ('25', 'Goodhue');
INSERT INTO "LU_COUNTY" VALUES ('26', 'Grant');
INSERT INTO "LU_COUNTY" VALUES ('27', 'Hennepin');
INSERT INTO "LU_COUNTY" VALUES ('28', 'Houston');
INSERT INTO "LU_COUNTY" VALUES ('29', 'Hubbard');
INSERT INTO "LU_COUNTY" VALUES ('30', 'Isanti');
INSERT INTO "LU_COUNTY" VALUES ('31', 'Itasca');
INSERT INTO "LU_COUNTY" VALUES ('32', 'Jackson');
INSERT INTO "LU_COUNTY" VALUES ('33', 'Kanabec');
INSERT INTO "LU_COUNTY" VALUES ('34', 'Kandiyohi');
INSERT INTO "LU_COUNTY" VALUES ('35', 'Kittson');
INSERT INTO "LU_COUNTY" VALUES ('36', 'Koochiching');
INSERT INTO "LU_COUNTY" VALUES ('37', 'Lac qui Parle');
INSERT INTO "LU_COUNTY" VALUES ('38', 'Lake');
INSERT INTO "LU_COUNTY" VALUES ('39', 'Lake of the Woods');
INSERT INTO "LU_COUNTY" VALUES ('40', 'Le Sueur');
INSERT INTO "LU_COUNTY" VALUES ('41', 'Lincoln');
INSERT INTO "LU_COUNTY" VALUES ('42', 'Lyon');
INSERT INTO "LU_COUNTY" VALUES ('43', 'Mahnomen');
INSERT INTO "LU_COUNTY" VALUES ('44', 'Marshall');
INSERT INTO "LU_COUNTY" VALUES ('45', 'Martin');
INSERT INTO "LU_COUNTY" VALUES ('46', 'McLeod');
INSERT INTO "LU_COUNTY" VALUES ('47', 'Meeker');
INSERT INTO "LU_COUNTY" VALUES ('48', 'Mille Lacs');
INSERT INTO "LU_COUNTY" VALUES ('49', 'Morrison');
INSERT INTO "LU_COUNTY" VALUES ('50', 'Mower');
INSERT INTO "LU_COUNTY" VALUES ('51', 'Murray');
INSERT INTO "LU_COUNTY" VALUES ('52', 'Nicollet');
INSERT INTO "LU_COUNTY" VALUES ('53', 'Nobles');
INSERT INTO "LU_COUNTY" VALUES ('54', 'Norman');
INSERT INTO "LU_COUNTY" VALUES ('55', 'Olmsted');
INSERT INTO "LU_COUNTY" VALUES ('56', 'Otter Tail');
INSERT INTO "LU_COUNTY" VALUES ('57', 'Pennington');
INSERT INTO "LU_COUNTY" VALUES ('58', 'Pine');
INSERT INTO "LU_COUNTY" VALUES ('59', 'Pipestone');
INSERT INTO "LU_COUNTY" VALUES ('60', 'Polk');
INSERT INTO "LU_COUNTY" VALUES ('61', 'Pope');
INSERT INTO "LU_COUNTY" VALUES ('62', 'Ramsey');
INSERT INTO "LU_COUNTY" VALUES ('63', 'Red Lake');
INSERT INTO "LU_COUNTY" VALUES ('64', 'Redwood');
INSERT INTO "LU_COUNTY" VALUES ('65', 'Renville');
INSERT INTO "LU_COUNTY" VALUES ('66', 'Rice');
INSERT INTO "LU_COUNTY" VALUES ('67', 'Rock');
INSERT INTO "LU_COUNTY" VALUES ('68', 'Roseau');
INSERT INTO "LU_COUNTY" VALUES ('69', 'Scott');
INSERT INTO "LU_COUNTY" VALUES ('70', 'Sherburne');
INSERT INTO "LU_COUNTY" VALUES ('71', 'Sibley');
INSERT INTO "LU_COUNTY" VALUES ('72', 'St. Louis');
INSERT INTO "LU_COUNTY" VALUES ('73', 'Stearns');
INSERT INTO "LU_COUNTY" VALUES ('74', 'Steele');
INSERT INTO "LU_COUNTY" VALUES ('75', 'Stevens');
INSERT INTO "LU_COUNTY" VALUES ('76', 'Swift');
INSERT INTO "LU_COUNTY" VALUES ('77', 'Todd');
INSERT INTO "LU_COUNTY" VALUES ('78', 'Traverse');
INSERT INTO "LU_COUNTY" VALUES ('79', 'Wabasha');
INSERT INTO "LU_COUNTY" VALUES ('80', 'Wadena');
INSERT INTO "LU_COUNTY" VALUES ('81', 'Waseca');
INSERT INTO "LU_COUNTY" VALUES ('82', 'Washington');
INSERT INTO "LU_COUNTY" VALUES ('83', 'Watonwan');
INSERT INTO "LU_COUNTY" VALUES ('84', 'Wilkin');
INSERT INTO "LU_COUNTY" VALUES ('85', 'Winona');
INSERT INTO "LU_COUNTY" VALUES ('86', 'Wright');
INSERT INTO "LU_COUNTY" VALUES ('87', 'Yellow');
COMMIT;
-- data-fixes-11-19-13
ALTER TABLE LU_COUNTY MODIFY (CODE VARCHAR2(3 CHAR) );
DELETE FROM LU_COUNTY;
INSERT INTO LU_COUNTY VALUES ('001', 'Aitkin');
INSERT INTO LU_COUNTY VALUES ('003', 'Anoka');	
INSERT INTO LU_COUNTY VALUES ('005', 'Becker');	
INSERT INTO LU_COUNTY VALUES ('007', 'Beltrami');	
INSERT INTO LU_COUNTY VALUES ('009', 'Benton');	
INSERT INTO LU_COUNTY VALUES ('011', 'Bigstone');	
INSERT INTO LU_COUNTY VALUES ('013', 'Blue Earth');	
INSERT INTO LU_COUNTY VALUES ('015', 'Brown');	
INSERT INTO LU_COUNTY VALUES ('017', 'Carlton');	
INSERT INTO LU_COUNTY VALUES ('019', 'Carver');	
INSERT INTO LU_COUNTY VALUES ('021', 'Cass');	
INSERT INTO LU_COUNTY VALUES ('023', 'Chippewa');	
INSERT INTO LU_COUNTY VALUES ('025', 'Chisago');	
INSERT INTO LU_COUNTY VALUES ('027', 'Clay');	
INSERT INTO LU_COUNTY VALUES ('029', 'Clearwater');	
INSERT INTO LU_COUNTY VALUES ('031', 'Cook');	
INSERT INTO LU_COUNTY VALUES ('033', 'Cottonwood');	
INSERT INTO LU_COUNTY VALUES ('035', 'Crow Wing');	
INSERT INTO LU_COUNTY VALUES ('037', 'Dakota');	
INSERT INTO LU_COUNTY VALUES ('039', 'Dodge');	
INSERT INTO LU_COUNTY VALUES ('041', 'Douglas');	
INSERT INTO LU_COUNTY VALUES ('043', 'Faribault');	
INSERT INTO LU_COUNTY VALUES ('045', 'Fillmore');	
INSERT INTO LU_COUNTY VALUES ('047', 'Freeborn');	
INSERT INTO LU_COUNTY VALUES ('049', 'Goodhue');	
INSERT INTO LU_COUNTY VALUES ('051', 'Grant');	
INSERT INTO LU_COUNTY VALUES ('053', 'Hennepin');	
INSERT INTO LU_COUNTY VALUES ('055', 'Houston');	
INSERT INTO LU_COUNTY VALUES ('057', 'Hubbard');	
INSERT INTO LU_COUNTY VALUES ('059', 'Isanti');	
INSERT INTO LU_COUNTY VALUES ('061', 'Itaska');	
INSERT INTO LU_COUNTY VALUES ('063', 'Jackson');	
INSERT INTO LU_COUNTY VALUES ('065', 'Kanabec');	
INSERT INTO LU_COUNTY VALUES ('067', 'Kandiyohi');	
INSERT INTO LU_COUNTY VALUES ('069', 'Kittson');	
INSERT INTO LU_COUNTY VALUES ('071', 'Koochiching');	
INSERT INTO LU_COUNTY VALUES ('073', 'Lac Qui Parle');	
INSERT INTO LU_COUNTY VALUES ('075', 'Lake');	
INSERT INTO LU_COUNTY VALUES ('077', 'Lake of the Woods');	
INSERT INTO LU_COUNTY VALUES ('079', 'LeSueur');	
INSERT INTO LU_COUNTY VALUES ('081', 'Lincoln');	
INSERT INTO LU_COUNTY VALUES ('083', 'Lyon');	
INSERT INTO LU_COUNTY VALUES ('087', 'Mahnomen');	
INSERT INTO LU_COUNTY VALUES ('089', 'Marshall');	
INSERT INTO LU_COUNTY VALUES ('091', 'Martin');	
INSERT INTO LU_COUNTY VALUES ('085', 'McLeod');	
INSERT INTO LU_COUNTY VALUES ('093', 'Meeker');	
INSERT INTO LU_COUNTY VALUES ('095', 'Mille Lacs');	
INSERT INTO LU_COUNTY VALUES ('097', 'Morrison');	
INSERT INTO LU_COUNTY VALUES ('099', 'Mower');	
INSERT INTO LU_COUNTY VALUES ('101', 'Murray');	
INSERT INTO LU_COUNTY VALUES ('103', 'Nicollet');	
INSERT INTO LU_COUNTY VALUES ('105', 'Nobles');	
INSERT INTO LU_COUNTY VALUES ('107', 'Norman');	
INSERT INTO LU_COUNTY VALUES ('109', 'Olmsted');	
INSERT INTO LU_COUNTY VALUES ('111', 'Ottertail');	
INSERT INTO LU_COUNTY VALUES ('113', 'Pennington');	
INSERT INTO LU_COUNTY VALUES ('115', 'Pine');	
INSERT INTO LU_COUNTY VALUES ('117', 'Pipestone');	
INSERT INTO LU_COUNTY VALUES ('119', 'Polk');	
INSERT INTO LU_COUNTY VALUES ('121', 'Pope');	
INSERT INTO LU_COUNTY VALUES ('123', 'Ramsey');	
INSERT INTO LU_COUNTY VALUES ('125', 'Red Lake');	
INSERT INTO LU_COUNTY VALUES ('127', 'Redwood');	
INSERT INTO LU_COUNTY VALUES ('129', 'Renville');	
INSERT INTO LU_COUNTY VALUES ('131', 'Rice');	
INSERT INTO LU_COUNTY VALUES ('133', 'Rock');	
INSERT INTO LU_COUNTY VALUES ('135', 'Roseau');	
INSERT INTO LU_COUNTY VALUES ('139', 'Scott');	
INSERT INTO LU_COUNTY VALUES ('141', 'Sherburne');	
INSERT INTO LU_COUNTY VALUES ('143', 'Sibley');	
INSERT INTO LU_COUNTY VALUES ('137', 'St Louis');	
INSERT INTO LU_COUNTY VALUES ('145', 'Stearns');	
INSERT INTO LU_COUNTY VALUES ('147', 'Steele');	
INSERT INTO LU_COUNTY VALUES ('149', 'Stevens');	
INSERT INTO LU_COUNTY VALUES ('151', 'Swift');	
INSERT INTO LU_COUNTY VALUES ('153', 'Todd');	
INSERT INTO LU_COUNTY VALUES ('155', 'Traverse');	
INSERT INTO LU_COUNTY VALUES ('157', 'Wabasha');	
INSERT INTO LU_COUNTY VALUES ('159', 'Wadena');	
INSERT INTO LU_COUNTY VALUES ('161', 'Waseca');	
INSERT INTO LU_COUNTY VALUES ('163', 'Washington');	
INSERT INTO LU_COUNTY VALUES ('165', 'Watonwan');	
INSERT INTO LU_COUNTY VALUES ('167', 'Wilkin');	
INSERT INTO LU_COUNTY VALUES ('169', 'Winona');	
INSERT INTO LU_COUNTY VALUES ('171', 'Wright');	
INSERT INTO LU_COUNTY VALUES ('173', 'Yellow Medicine');	
commit;

-- ----------------------------
--  Table structure for "PROVIDER_AGREEMENT_XREF"
-- ----------------------------
CREATE TABLE "PROVIDER_AGREEMENT_XREF" (   "PROVIDER_AGREEMENT_XREF_ID" NUMBER(19,0) NOT NULL, "PROFILEID" NUMBER(19,0), "TICKETID" NUMBER(19,0), "ACCEPTED_DATE" DATE, "AGREEMENT_DOCUMENT_ID" NUMBER(19,0));

-- ----------------------------
--  Records of "PROVIDER_AGREEMENT_XREF"
-- ----------------------------
INSERT INTO "PROVIDER_AGREEMENT_XREF" VALUES ('3', '0', '32768', TO_DATE('2013-04-15 00:00:00','YYYY-MM-DD HH24:MI:SS'), '1');
INSERT INTO "PROVIDER_AGREEMENT_XREF" VALUES ('4', '0', '32768', TO_DATE('2013-04-15 00:00:00','YYYY-MM-DD HH24:MI:SS'), '2');
COMMIT;

-- ----------------------------
--  Table structure for "LU_QP_TYP"
-- ----------------------------
CREATE TABLE "LU_QP_TYP" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "LU_QP_TYP"
-- ----------------------------
INSERT INTO "LU_QP_TYP" VALUES ('01', 'Registered Nurse');
INSERT INTO "LU_QP_TYP" VALUES ('02', 'Licensed Social Worker');
INSERT INTO "LU_QP_TYP" VALUES ('03', 'Mental Health Professional');
INSERT INTO "LU_QP_TYP" VALUES ('04', 'Qualified Developmental Disability Specialist');
COMMIT;

-- ----------------------------
--  Table structure for "PROVIDER_TYPE_REQ_FIELDS"
-- ----------------------------
CREATE TABLE "PROVIDER_TYPE_REQ_FIELDS" (   "PROVIDER_TYPE_CD" VARCHAR2(2CHAR) NOT NULL, "REQUIRED_FIELD_CD" VARCHAR2(2CHAR) NOT NULL);

-- ----------------------------
--  Table structure for "ORGANIZATIONALENTITY"
-- ----------------------------
CREATE TABLE "ORGANIZATIONALENTITY" (   "DTYPE" VARCHAR2(31CHAR) NOT NULL, "ID" VARCHAR2(255CHAR) NOT NULL);

-- ----------------------------
--  Records of "ORGANIZATIONALENTITY"
-- ----------------------------
INSERT INTO "ORGANIZATIONALENTITY" VALUES ('Group', 'Service Agent');
INSERT INTO "ORGANIZATIONALENTITY" VALUES ('Group', 'Service Administrator');
INSERT INTO "ORGANIZATIONALENTITY" VALUES ('Group', 'System Administrator');
INSERT INTO "ORGANIZATIONALENTITY" VALUES ('User', 'Administrator');
COMMIT;

-- ----------------------------
--  Table structure for "NODEINSTANCELOG"
-- ----------------------------
CREATE TABLE "NODEINSTANCELOG" (   "ID" NUMBER(19,0) NOT NULL, "LOG_DATE" TIMESTAMP(6) NULL, "NODEID" VARCHAR2(255CHAR), "NODEINSTANCEID" VARCHAR2(255CHAR), "NODENAME" VARCHAR2(255CHAR), "PROCESSID" VARCHAR2(255CHAR), "PROCESSINSTANCEID" NUMBER(19,0) NOT NULL, "TYPE" NUMBER(10,0) NOT NULL);

-- ----------------------------
--  Table structure for "DOCUMENT_CONTENT"
-- ----------------------------
CREATE TABLE "DOCUMENT_CONTENT" (   "CONTENT_ID" VARCHAR2(255CHAR) NOT NULL, "RAW_CONTENT" BLOB);

-- ----------------------------
--  Records of "DOCUMENT_CONTENT"
-- ----------------------------
INSERT INTO "DOCUMENT_CONTENT" VALUES ('ae50f0fc-2b4d-4f56-bcf1-f29c90bb4789', null); -- HEXTORAW('494e5345525420494e544f2050524f56494445525f53455454494e472850524f56494445525f53455454494e475f49442c2050524f56494445525f5459505f43442c2052454c415445445f454e544954595f5459502c2052454c415445445f454e544954595f43442c2052454c5f545950290d0a2020202056414c5545532028323430332c20273234272c20275370656369616c747954797065272c20275333272c2027534f27293b0d0a494e5345525420494e544f2050524f56494445525f53455454494e472850524f56494445525f53455454494e475f49442c2050524f56494445525f5459505f43442c2052454c415445445f454e544954595f5459502c2052454c415445445f454e544954595f43442c2052454c5f545950290d0a2020202056414c5545532028323430342c20273234272c202749737375696e67426f617264272c20274233272c2027534227293b0d0a'));
INSERT INTO "DOCUMENT_CONTENT" VALUES ('8f224cb7-d702-4dd8-8920-5dbbd02177e7', null); -- HEXTORAW('494e5345525420494e544f2050524f56494445525f53455454494e472850524f56494445525f53455454494e475f49442c2050524f56494445525f5459505f43442c2052454c415445445f454e544954595f5459502c2052454c415445445f454e544954595f43442c2052454c5f545950290d0a2020202056414c5545532028323430332c20273234272c20275370656369616c747954797065272c20275333272c2027534f27293b0d0a494e5345525420494e544f2050524f56494445525f53455454494e472850524f56494445525f53455454494e475f49442c2050524f56494445525f5459505f43442c2052454c415445445f454e544954595f5459502c2052454c415445445f454e544954595f43442c2052454c5f545950290d0a2020202056414c5545532028323430342c20273234272c202749737375696e67426f617264272c20274233272c2027534227293b0d0a'));
INSERT INTO "DOCUMENT_CONTENT" VALUES ('9d5576a6-024a-431f-b5b7-4df279c5e735', null); -- HEXTORAW('494e5345525420494e544f2050524f56494445525f53455454494e472850524f56494445525f53455454494e475f49442c2050524f56494445525f5459505f43442c2052454c415445445f454e544954595f5459502c2052454c415445445f454e544954595f43442c2052454c5f545950290d0a2020202056414c5545532028323430332c20273234272c20275370656369616c747954797065272c20275333272c2027534f27293b0d0a494e5345525420494e544f2050524f56494445525f53455454494e472850524f56494445525f53455454494e475f49442c2050524f56494445525f5459505f43442c2052454c415445445f454e544954595f5459502c2052454c415445445f454e544954595f43442c2052454c5f545950290d0a2020202056414c5545532028323430342c20273234272c202749737375696e67426f617264272c20274233272c2027534227293b0d0a'));
INSERT INTO "DOCUMENT_CONTENT" VALUES ('19bc8c7c-4d50-4d73-ac69-e262967f44e9', null); -- HEXTORAW('494e5345525420494e544f2050524f56494445525f53455454494e472850524f56494445525f53455454494e475f49442c2050524f56494445525f5459505f43442c2052454c415445445f454e544954595f5459502c2052454c415445445f454e544954595f43442c2052454c5f545950290d0a2020202056414c5545532028323430332c20273234272c20275370656369616c747954797065272c20275333272c2027534f27293b0d0a494e5345525420494e544f2050524f56494445525f53455454494e472850524f56494445525f53455454494e475f49442c2050524f56494445525f5459505f43442c2052454c415445445f454e544954595f5459502c2052454c415445445f454e544954595f43442c2052454c5f545950290d0a2020202056414c5545532028323430342c20273234272c202749737375696e67426f617264272c20274233272c2027534227293b0d0a'));
INSERT INTO "DOCUMENT_CONTENT" VALUES ('2633cb95-c29a-461d-b2d7-224b557f0cf5', null); -- HEXTORAW('494e5345525420494e544f2050524f56494445525f53455454494e472850524f56494445525f53455454494e475f49442c2050524f56494445525f5459505f43442c2052454c415445445f454e544954595f5459502c2052454c415445445f454e544954595f43442c2052454c5f545950290d0a2020202056414c5545532028323430332c20273234272c20275370656369616c747954797065272c20275333272c2027534f27293b0d0a494e5345525420494e544f2050524f56494445525f53455454494e472850524f56494445525f53455454494e475f49442c2050524f56494445525f5459505f43442c2052454c415445445f454e544954595f5459502c2052454c415445445f454e544954595f43442c2052454c5f545950290d0a2020202056414c5545532028323430342c20273234272c202749737375696e67426f617264272c20274233272c2027534227293b0d0a'));
INSERT INTO "DOCUMENT_CONTENT" VALUES ('d513ca45-88cd-4c93-b090-e078b19a7115', null); -- HEXTORAW('46616468656c204162626173205361656564204173686f7572202d2044617465206f66204269727468200a4d7568616d6d61642053616c6d616e204d6f68616d6d656420416d6572202d2044617465206f662042697274680a'));
INSERT INTO "DOCUMENT_CONTENT" VALUES ('ed2e2e67-cf76-4bc2-81fc-2e3a20980be6', null); -- HEXTORAW('687474703a2f2f7777772e69626d2e636f6d2f646576656c6f706572776f726b732f62706d2f6e6577746f2f0a687474703a2f2f7777772e69626d2e636f6d2f646576656c6f706572776f726b732f646f776e6c6f6164732f736f6173616e64626f782f69626d62706d2e68746d6c0a68747470733a2f2f7777772e69626d2e636f6d2f646576656c6f706572776f726b732f6d79646576656c6f706572776f726b732f77696b69732f686f6d653f6c616e673d656e5f5553232f77696b692f42504d77656244656d6f732e636f6d'));
INSERT INTO "DOCUMENT_CONTENT" VALUES ('854131c2-0fd4-40ae-ad53-2ee917a3e75c', null); -- HEXTORAW('687474703a2f2f7777772e69626d2e636f6d2f646576656c6f706572776f726b732f62706d2f6e6577746f2f0a687474703a2f2f7777772e69626d2e636f6d2f646576656c6f706572776f726b732f646f776e6c6f6164732f736f6173616e64626f782f69626d62706d2e68746d6c0a68747470733a2f2f7777772e69626d2e636f6d2f646576656c6f706572776f726b732f6d79646576656c6f706572776f726b732f77696b69732f686f6d653f6c616e673d656e5f5553232f77696b692f42504d77656244656d6f732e636f6d'));
INSERT INTO "DOCUMENT_CONTENT" VALUES ('51587ca1-6c34-4d64-bcec-ac90f8a141ea', null); -- HEXTORAW('687474703a2f2f7777772e69626d2e636f6d2f646576656c6f706572776f726b732f62706d2f6e6577746f2f0a687474703a2f2f7777772e69626d2e636f6d2f646576656c6f706572776f726b732f646f776e6c6f6164732f736f6173616e64626f782f69626d62706d2e68746d6c0a68747470733a2f2f7777772e69626d2e636f6d2f646576656c6f706572776f726b732f6d79646576656c6f706572776f726b732f77696b69732f686f6d653f6c616e673d656e5f5553232f77696b692f42504d77656244656d6f732e636f6d'));
INSERT INTO "DOCUMENT_CONTENT" VALUES ('d4a72c15-20e8-4711-be8d-c82d2b5c4d65', null); -- HEXTORAW('687474703a2f2f7777772e69626d2e636f6d2f646576656c6f706572776f726b732f62706d2f6e6577746f2f0a687474703a2f2f7777772e69626d2e636f6d2f646576656c6f706572776f726b732f646f776e6c6f6164732f736f6173616e64626f782f69626d62706d2e68746d6c0a68747470733a2f2f7777772e69626d2e636f6d2f646576656c6f706572776f726b732f6d79646576656c6f706572776f726b732f77696b69732f686f6d653f6c616e673d656e5f5553232f77696b692f42504d77656244656d6f732e636f6d'));
INSERT INTO "DOCUMENT_CONTENT" VALUES ('33017dfc-fa0d-45bb-af41-50e37d664c21', null); -- HEXTORAW('494e5345525420494e544f2050524f56494445525f53455454494e472850524f56494445525f53455454494e475f49442c2050524f56494445525f5459505f43442c2052454c415445445f454e544954595f5459502c2052454c415445445f454e544954595f43442c2052454c5f545950290d0a2020202056414c5545532028323430332c20273234272c20275370656369616c747954797065272c20275333272c2027534f27293b0d0a494e5345525420494e544f2050524f56494445525f53455454494e472850524f56494445525f53455454494e475f49442c2050524f56494445525f5459505f43442c2052454c415445445f454e544954595f5459502c2052454c415445445f454e544954595f43442c2052454c5f545950290d0a2020202056414c5545532028323430342c20273234272c202749737375696e67426f617264272c20274233272c2027534227293b0d0a'));
INSERT INTO "DOCUMENT_CONTENT" VALUES ('2ce5d022-2b47-411a-8f01-9ef65863eb40', null); -- HEXTORAW('494e5345525420494e544f2050524f56494445525f53455454494e472850524f56494445525f53455454494e475f49442c2050524f56494445525f5459505f43442c2052454c415445445f454e544954595f5459502c2052454c415445445f454e544954595f43442c2052454c5f545950290d0a2020202056414c5545532028323430332c20273234272c20275370656369616c747954797065272c20275333272c2027534f27293b0d0a494e5345525420494e544f2050524f56494445525f53455454494e472850524f56494445525f53455454494e475f49442c2050524f56494445525f5459505f43442c2052454c415445445f454e544954595f5459502c2052454c415445445f454e544954595f43442c2052454c5f545950290d0a2020202056414c5545532028323430342c20273234272c202749737375696e67426f617264272c20274233272c2027534227293b0d0a'));
COMMIT;

-- ----------------------------
--  Table structure for "LU_TICKET_STATUS"
-- ----------------------------
CREATE TABLE "LU_TICKET_STATUS" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "LU_TICKET_STATUS"
-- ----------------------------
INSERT INTO "LU_TICKET_STATUS" VALUES ('01', 'Draft');
INSERT INTO "LU_TICKET_STATUS" VALUES ('02', 'Pending');
INSERT INTO "LU_TICKET_STATUS" VALUES ('03', 'Rejected');
INSERT INTO "LU_TICKET_STATUS" VALUES ('04', 'Approved');
COMMIT;

-- ----------------------------
--  Table structure for "AUDIT_DETAIL"
-- ----------------------------
CREATE TABLE "AUDIT_DETAIL" (   "AUDIT_DETAIL_ID" NUMBER(19,0) NOT NULL, "AUDIT_RECORD_ID" NUMBER(19,0), "TABLE_NAME" VARCHAR2(200CHAR), "COLUMN_NAME" VARCHAR2(200CHAR), "OLD_DATA" VARCHAR2(500CHAR), "NEW_DATA" VARCHAR2(500CHAR));

-- ----------------------------
--  Records of "AUDIT_DETAIL"
-- ----------------------------
INSERT INTO "AUDIT_DETAIL" VALUES ('11', '3', 'CMS_USER', 'USER_ID', null, 'XXXXCMSO00000000000000000003');
INSERT INTO "AUDIT_DETAIL" VALUES ('12', '3', 'CMS_USER', 'USER_NAME', null, 'cyberjag');
INSERT INTO "AUDIT_DETAIL" VALUES ('13', '3', 'CMS_USER', 'FIRST_NAME', null, 'Jerrish');
INSERT INTO "AUDIT_DETAIL" VALUES ('14', '3', 'CMS_USER', 'EMAIL', null, 'jerrishissac@gmail.com');
INSERT INTO "AUDIT_DETAIL" VALUES ('15', '3', 'CMS_USER', 'STATUS', null, 'ACTIVE');
INSERT INTO "AUDIT_DETAIL" VALUES ('16', '3', 'CMS_USER', 'ROLE_CD', null, 'R1');
INSERT INTO "AUDIT_DETAIL" VALUES ('17', '4', 'CMS_USER', 'USER_ID', null, 'XXXXCMSO00000000000000000004');
INSERT INTO "AUDIT_DETAIL" VALUES ('18', '4', 'CMS_USER', 'USER_NAME', null, 'cyberjag2');
INSERT INTO "AUDIT_DETAIL" VALUES ('19', '4', 'CMS_USER', 'FIRST_NAME', null, 'Jerrish');
INSERT INTO "AUDIT_DETAIL" VALUES ('20', '4', 'CMS_USER', 'EMAIL', null, 'jerrishissac@gmail.com');
INSERT INTO "AUDIT_DETAIL" VALUES ('21', '4', 'CMS_USER', 'STATUS', null, 'ACTIVE');
INSERT INTO "AUDIT_DETAIL" VALUES ('22', '4', 'CMS_USER', 'ROLE_CD', null, 'R1');
INSERT INTO "AUDIT_DETAIL" VALUES ('32768', '32768', 'CMS_USER', 'USER_ID', null, 'XXXXCMSO00000000000000032768');
INSERT INTO "AUDIT_DETAIL" VALUES ('32769', '32768', 'CMS_USER', 'USER_NAME', null, 'jag');
INSERT INTO "AUDIT_DETAIL" VALUES ('32770', '32768', 'CMS_USER', 'FIRST_NAME', null, 'Jerrish');
INSERT INTO "AUDIT_DETAIL" VALUES ('32771', '32768', 'CMS_USER', 'EMAIL', null, 'jerrishissac@gmail.com');
INSERT INTO "AUDIT_DETAIL" VALUES ('32772', '32768', 'CMS_USER', 'STATUS', null, 'ACTIVE');
INSERT INTO "AUDIT_DETAIL" VALUES ('32773', '32768', 'CMS_USER', 'ROLE_CD', null, 'R1');
INSERT INTO "AUDIT_DETAIL" VALUES ('65536', '65536', 'CMS_USER', 'USER_ID', null, 'XXXXCMSO00000000000000065536');
INSERT INTO "AUDIT_DETAIL" VALUES ('65537', '65536', 'CMS_USER', 'USER_NAME', null, 'jag');
INSERT INTO "AUDIT_DETAIL" VALUES ('65538', '65536', 'CMS_USER', 'FIRST_NAME', null, 'Jerrish');
INSERT INTO "AUDIT_DETAIL" VALUES ('65539', '65536', 'CMS_USER', 'EMAIL', null, 'jerrishissac@gmail.com');
INSERT INTO "AUDIT_DETAIL" VALUES ('65540', '65536', 'CMS_USER', 'STATUS', null, 'ACTIVE');
INSERT INTO "AUDIT_DETAIL" VALUES ('65541', '65536', 'CMS_USER', 'ROLE_CD', null, 'R1');
COMMIT;

-- ----------------------------
--  Table structure for "LU_ISSUING_BOARD"
-- ----------------------------
CREATE TABLE "LU_ISSUING_BOARD" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));
ALTER TABLE "LU_ISSUING_BOARD" ADD CONSTRAINT "SYS_C004065" PRIMARY KEY("CODE");

-- ----------------------------
--  Records of "LU_ISSUING_BOARD"
-- ----------------------------
INSERT INTO "LU_ISSUING_BOARD" VALUES ('B1', 'AANA');
INSERT INTO "LU_ISSUING_BOARD" VALUES ('B2', 'NARM');
INSERT INTO "LU_ISSUING_BOARD" VALUES ('B3', 'ANCC');
INSERT INTO "LU_ISSUING_BOARD" VALUES ('B4', 'AOTA');
INSERT INTO "LU_ISSUING_BOARD" VALUES ('B5', 'ADA');
INSERT INTO "LU_ISSUING_BOARD" VALUES ('B6', 'ABMS');
INSERT INTO "LU_ISSUING_BOARD" VALUES ('B7', 'ABPS');
INSERT INTO "LU_ISSUING_BOARD" VALUES ('B8', 'MNDOT');
INSERT INTO "LU_ISSUING_BOARD" VALUES ('B9', 'FAA');
INSERT INTO "LU_ISSUING_BOARD" VALUES ('N1', 'Not Applicable');
COMMIT;
-- data-fixes-11-19-13.sql
// collides w/ MNDOT above
// INSERT INTO LU_ISSUING_BOARD VALUES ('B8', 'AMCB');
INSERT INTO LU_ISSUING_BOARD(CODE, DESCRIPTION) VALUES ('C1', 'ABOMS');
commit;

-- ----------------------------
--  Table structure for "NOTIFICATION_BAS"
-- ----------------------------
CREATE TABLE "NOTIFICATION_BAS" (   "TASK_ID" NUMBER(19,0) NOT NULL, "ENTITY_ID" VARCHAR2(255CHAR) NOT NULL);

-- ----------------------------
--  Table structure for "PROFILE_PAYTO_XREF"
-- ----------------------------
CREATE TABLE "PROFILE_PAYTO_XREF" (   "PROFILE_PAYTO_XREF_ID" NUMBER(19,0) NOT NULL, "EFF_DT" DATE, "PAYTO_TYP_CD" VARCHAR2(2CHAR), "PROFILE_ID" NUMBER(19,0), "TICKET_ID" NUMBER(19,0), "TARGET_PROFILE_ID" NUMBER(19,0), "NAME" VARCHAR2(200BYTE), "CONTACT_NAME" VARCHAR2(200BYTE), "NPI" VARCHAR2(10BYTE), "PHONE_NUMBER" VARCHAR2(100BYTE));

-- ----------------------------
--  Table structure for "PROVIDER_SVCS"
-- ----------------------------
CREATE TABLE "PROVIDER_SVCS" (   "PROVIDER_SVCS_ID" NUMBER(19,0) NOT NULL, "PROFILE_ID" NUMBER(19,0), "TICKET_ID" NUMBER(19,0), "SVC_CAT_CD" VARCHAR2(2CHAR));

-- ----------------------------
--  Table structure for "ADDRESS"
-- ----------------------------
CREATE TABLE "ADDRESS" (   "ADDRESS_ID" NUMBER(19,0) NOT NULL, "ATTN_TO" VARCHAR2(30CHAR), "LINE1" VARCHAR2(30CHAR), "LINE2" VARCHAR2(30CHAR), "CITY" VARCHAR2(20CHAR), "STATE" VARCHAR2(2CHAR), "ZIPCODE" VARCHAR2(10CHAR), "COUNTY" VARCHAR2(20CHAR));

-- ----------------------------
--  Records of "ADDRESS"
-- ----------------------------
INSERT INTO "ADDRESS" VALUES ('5', null, null, 'Test', 'Test', 'MN', '12131', null);
INSERT INTO "ADDRESS" VALUES ('6', null, null, 'Test', 'Test', 'MN', '12131', null);
INSERT INTO "ADDRESS" VALUES ('7', null, null, 'Test', 'Test', 'MN', '12131', null);
INSERT INTO "ADDRESS" VALUES ('8', null, null, 'Test', 'Test', 'MN', '12121', null);
INSERT INTO "ADDRESS" VALUES ('32772', null, null, 'Test', 'Test', 'MN', '12121', null);
INSERT INTO "ADDRESS" VALUES ('32773', null, null, 'Test', 'Test', 'MN', '12121', null);
INSERT INTO "ADDRESS" VALUES ('32774', null, null, 'Test', 'Test', 'MN', '12121', null);
INSERT INTO "ADDRESS" VALUES ('32775', null, null, 'Test', 'Test', 'MN', '12121', null);
COMMIT;

-- ----------------------------
--  Table structure for "PROFILE_GRP_XREF"
-- ----------------------------
CREATE TABLE "PROFILE_GRP_XREF" (   "PROFILE_GRP_XREF_ID" NUMBER(19,0) NOT NULL, "PRIMARY_IND" VARCHAR2(1CHAR), "EFF_DT" DATE, "PROFILE_ID" NUMBER(19,0), "TICKET_ID" NUMBER(19,0), "OBJECT_TYP" VARCHAR2(1CHAR), "TARGET_PROFILE_ID" NUMBER(19,0), "TARGET_ENTITY_ID" NUMBER(19,0), "QP_TYP_CD" CHAR(2BYTE), "TERM_IND" CHAR(1BYTE), "TERM_DT" DATE, "ACK_ID" VARCHAR2(200BYTE));

-- ----------------------------
--  Records of "PROFILE_GRP_XREF"
-- ----------------------------
INSERT INTO "PROFILE_GRP_XREF" VALUES ('3', null, TO_DATE('2011-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), '0', '1', 'M', '0', '7', null, null, null, null);
INSERT INTO "PROFILE_GRP_XREF" VALUES ('4', null, TO_DATE('2011-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), '0', '1', 'M', '0', '8', null, null, null, null);
COMMIT;
-- data-fixes-11-19-13
ALTER TABLE PROFILE_GRP_XREF ADD (BGS_STUDY_ID VARCHAR2(75) );
ALTER TABLE PROFILE_GRP_XREF ADD (BGS_CLEARANCE_DT DATE );
commit;

-- ----------------------------
--  Table structure for "I18NTEXT"
-- ----------------------------
CREATE TABLE "I18NTEXT" (   "ID" NUMBER(19,0) NOT NULL, "LANGUAGE" VARCHAR2(255CHAR), "TEXT" CLOB, "TASK_SUBJECTS_ID" NUMBER(19,0), "TASK_NAMES_ID" NUMBER(19,0), "TASK_DESCRIPTIONS_ID" NUMBER(19,0), "DEADLINE_DOCUMENTATION_ID" NUMBER(19,0), "NOTIFICATION_SUBJECTS_ID" NUMBER(19,0), "NOTIFICATION_NAMES_ID" NUMBER(19,0), "NOTIFICATION_DOCUMENTATION_ID" NUMBER(19,0), "NOTIFICATION_DESCRIPTIONS_ID" NUMBER(19,0), "REASSIGNMENT_DOCUMENTATION_ID" NUMBER(19,0));

-- ----------------------------
--  Records of "I18NTEXT"
-- ----------------------------
INSERT INTO "I18NTEXT" VALUES ('401', 'en-UK', 'this is a comment', null, null, '322', null, null, null, null, null, null);
INSERT INTO "I18NTEXT" VALUES ('402', 'en-UK', 'Screening Review', null, '322', null, null, null, null, null, null, null);
INSERT INTO "I18NTEXT" VALUES ('403', 'en-UK', 'this is a comment', '322', null, null, null, null, null, null, null, null);
INSERT INTO "I18NTEXT" VALUES ('404', 'en-UK', 'this is a comment', null, null, '324', null, null, null, null, null, null);
INSERT INTO "I18NTEXT" VALUES ('405', 'en-UK', 'Screening Review', null, '324', null, null, null, null, null, null, null);
INSERT INTO "I18NTEXT" VALUES ('406', 'en-UK', 'this is a comment', '324', null, null, null, null, null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for "VARIABLEINSTANCELOG"
-- ----------------------------
CREATE TABLE "VARIABLEINSTANCELOG" (   "ID" NUMBER(19,0) NOT NULL, "LOG_DATE" TIMESTAMP(6) NULL, "PROCESSID" VARCHAR2(255CHAR), "PROCESSINSTANCEID" NUMBER(19,0) NOT NULL, "VALUE" VARCHAR2(255CHAR), "VARIABLEID" VARCHAR2(255CHAR), "VARIABLEINSTANCEID" VARCHAR2(255CHAR));

-- ----------------------------
--  Table structure for "SUBTASKSSTRATEGY"
-- ----------------------------
CREATE TABLE "SUBTASKSSTRATEGY" (   "DTYPE" VARCHAR2(100CHAR) NOT NULL, "ID" NUMBER(19,0) NOT NULL, "NAME" VARCHAR2(255CHAR), "TASK_ID" NUMBER(19,0));

-- ----------------------------
--  Table structure for "LU_LICENSE_STATUS"
-- ----------------------------
CREATE TABLE "LU_LICENSE_STATUS" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "LU_LICENSE_STATUS"
-- ----------------------------
INSERT INTO "LU_LICENSE_STATUS" VALUES ('01', 'Active');
INSERT INTO "LU_LICENSE_STATUS" VALUES ('02', 'Suspended');
INSERT INTO "LU_LICENSE_STATUS" VALUES ('03', 'Expired');
COMMIT;

-- ----------------------------
--  Table structure for "EVENTTYPES"
-- ----------------------------
CREATE TABLE "EVENTTYPES" (   "INSTANCEID" NUMBER(19,0) NOT NULL, "ELEMENT" VARCHAR2(255CHAR));

-- ----------------------------
--  Table structure for "PEOPLEASSIGNMENTS_RECIPIENTS"
-- ----------------------------
CREATE TABLE "PEOPLEASSIGNMENTS_RECIPIENTS" (   "TASK_ID" NUMBER(19,0) NOT NULL, "ENTITY_ID" VARCHAR2(255CHAR) NOT NULL);

-- ----------------------------
--  Table structure for "REQUIRED_FLD_TYPE"
-- ----------------------------
CREATE TABLE "REQUIRED_FLD_TYPE" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Table structure for "TASK"
-- ----------------------------
CREATE TABLE "TASK" (   "ID" NUMBER(19,0) NOT NULL, "ARCHIVED" NUMBER(5,0), "ALLOWEDTODELEGATE" VARCHAR2(255CHAR), "PRIORITY" NUMBER(10,0) NOT NULL, "ACTIVATIONTIME" TIMESTAMP(6) NULL, "CREATEDON" TIMESTAMP(6) NULL, "DOCUMENTACCESSTYPE" NUMBER(10,0), "DOCUMENTCONTENTID" NUMBER(19,0) NOT NULL, "DOCUMENTTYPE" VARCHAR2(255CHAR), "EXPIRATIONTIME" TIMESTAMP(6) NULL, "FAULTACCESSTYPE" NUMBER(10,0), "FAULTCONTENTID" NUMBER(19,0) NOT NULL, "FAULTNAME" VARCHAR2(255CHAR), "FAULTTYPE" VARCHAR2(255CHAR), "OUTPUTACCESSTYPE" NUMBER(10,0), "OUTPUTCONTENTID" NUMBER(19,0) NOT NULL, "OUTPUTTYPE" VARCHAR2(255CHAR), "PARENTID" NUMBER(19,0) NOT NULL, "PREVIOUSSTATUS" NUMBER(10,0), "PROCESSID" VARCHAR2(255CHAR), "PROCESSINSTANCEID" NUMBER(19,0) NOT NULL, "PROCESSSESSIONID" NUMBER(10,0) NOT NULL, "SKIPABLE" NUMBER(1,0) NOT NULL, "STATUS" VARCHAR2(255CHAR), "WORKITEMID" NUMBER(19,0) NOT NULL, "OPTLOCK" NUMBER(10,0), "TASKINITIATOR_ID" VARCHAR2(255CHAR), "ACTUALOWNER_ID" VARCHAR2(255CHAR), "CREATEDBY_ID" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "TASK"
-- ----------------------------
INSERT INTO "TASK" VALUES ('322', '0', null, '0', TO_TIMESTAMP('2013-04-15 17:43:57.648000','YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2013-04-15 17:43:57.648000','YYYY-MM-DD HH24:MI:SS.FF'), '0', '321', 'java.util.map', null, null, '-1', null, null, null, '-1', null, '-1', '0', 'gov.medicaid.process.enrollment', '321', '261', '1', 'Ready', '709', '1', null, null, null);
INSERT INTO "TASK" VALUES ('324', '0', null, '0', TO_TIMESTAMP('2013-04-15 19:07:45.954000','YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2013-04-15 19:07:45.954000','YYYY-MM-DD HH24:MI:SS.FF'), '0', '322', 'java.util.map', null, null, '-1', null, null, null, '-1', null, '-1', '0', 'gov.medicaid.process.enrollment', '323', '262', '1', 'Ready', '718', '1', null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for "REASSIGNMENT"
-- ----------------------------
CREATE TABLE "REASSIGNMENT" (   "ID" NUMBER(19,0) NOT NULL, "ESCALATION_REASSIGNMENTS_ID" NUMBER(19,0));

-- ----------------------------
--  Table structure for "PEOPLEASSIGNMENTS_BAS"
-- ----------------------------
CREATE TABLE "PEOPLEASSIGNMENTS_BAS" (   "TASK_ID" NUMBER(19,0) NOT NULL, "ENTITY_ID" VARCHAR2(255CHAR) NOT NULL);

-- ----------------------------
--  Records of "PEOPLEASSIGNMENTS_BAS"
-- ----------------------------
INSERT INTO "PEOPLEASSIGNMENTS_BAS" VALUES ('322', 'Administrator');
INSERT INTO "PEOPLEASSIGNMENTS_BAS" VALUES ('324', 'Administrator');
COMMIT;

-- ----------------------------
--  Table structure for "LICENSE"
-- ----------------------------
CREATE TABLE "LICENSE" (   "LICENSE_ID" NUMBER(19,0) NOT NULL, "PROFILE_ID" NUMBER(19,0), "TICKET_ID" NUMBER(19,0), "OBJECT_TYP" VARCHAR2(1CHAR), "SPECIALTY_TYP_CD" VARCHAR2(2CHAR), "LICENSE_TYP_CD" VARCHAR2(2CHAR), "LICENSE_NUMBER" VARCHAR2(45CHAR), "ORIGINAL_ISSUE_DT" DATE, "RENEWAL_END_DT" DATE, "ISSUING_US_STATE" VARCHAR2(2CHAR), "ATTACHMENT_ID" NUMBER(19,0), "LICENSE_STATUS_CD" VARCHAR2(2CHAR), "ISSUING_BOARD_CD" VARCHAR2(2CHAR), "AFFILIATE_ID" NUMBER(19,0));

-- ----------------------------
--  Records of "LICENSE"
-- ----------------------------
INSERT INTO "LICENSE" VALUES ('3', '0', '32768', 'L', null, 'B1', '1231232', TO_DATE('2011-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), 'MN', '262148', null, null, '0');
INSERT INTO "LICENSE" VALUES ('4', '0', '32768', 'L', null, null, '324324', TO_DATE('2011-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), 'MN', '262149', null, null, '0');
COMMIT;
-- data-fixes-11-19-13.sql
ALTER TABLE LICENSE MODIFY (ISSUING_US_STATE VARCHAR2(8 CHAR));
COMMIT;


-- ----------------------------
--  Table structure for "SESSIONINFO"
-- ----------------------------
CREATE TABLE "SESSIONINFO" (   "ID" NUMBER(10,0) NOT NULL, "LASTMODIFICATIONDATE" TIMESTAMP(6) NULL, "RULESBYTEARRAY" BLOB, "STARTDATE" TIMESTAMP(6) NULL, "OPTLOCK" NUMBER(10,0));

-- ----------------------------
--  Records of "SESSIONINFO"
-- ----------------------------
INSERT INTO "SESSIONINFO" VALUES ('261', TO_TIMESTAMP('2013-04-15 17:43:57.465000','YYYY-MM-DD HH24:MI:SS.FF'), null, TO_TIMESTAMP('2013-04-15 19:07:39.700000','YYYY-MM-DD HH24:MI:SS.FF'), '1'); -- HEXTORAW('aced00057a000004000a060805100418004ab751080012436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567791aed50aced0005737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a6578700000000177040000000a7372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b78707425723c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965737a000004002220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e3236313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031332d30352d30312b30353a33303c2f456666656374697665446174653e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e546573743c2f4e616d653e3c50686f6e654e756d6265723e313231203531322d313235313c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e58585858434d534f30303030303030303030303030303036353533363c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031332d30342d31352b30353a33303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031332d30342d31352b30353a33303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e436869726f7072616374696320436c696e69633c2f50726f7669646572547970653e3c4e50493e313536383730393937303c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e313231203431332d313435313c2f50686f6e654e756d6265723e3c4661784e756d6265723e313331203235312d333132313c2f4661784e756d6265723e3c416464726573733e3c416464726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f64653e31323133313c2f5a7a000004006970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e333235343633323c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c4c6963656e7365496e666f726d6174696f6e2f3e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e546573743c2f4e616d653e3c5469746c653e546573743c2f5469746c653e3c5369676e446174653e323031332d30342d31352b30353a33303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475733e3c4c6963656e7365733e593c2f4c6963656e7365733e3c4e6f6e4578636c7573696f6e3e593c2f4e6f6e4578636c7573696f6e3e3c2f566572696669636174696f6e5374617475733e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313135343332343235393c2f4e50493e3c46756c6c4e616d653e546573743c2f46756c6c4e616d653e3c536f6369616c53657a000004006375726974794e756d6265723e3234353233343334333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938322d30312d30312b30353a33303c2f446174654f6642697274683e3c50726f7669646572547970653e436869726f70726163746f723c2f50726f7669646572547970653e3c5374617274446174653e323031312d30312d30312b30353a33303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c47726f75704d656d6265723e3c4e50493e313536383730393937303c2f4e50493e3c46756c6c4e616d653e546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3233343233363433353c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938312d31302d31302b30353a33303c2f446174654f6642697274683e3c50726f7669646572547970653e436869726f70726163746f723c2f50726f7669646572547970653e3c5374617274446174653e323031312d30312d30312b30353a33303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4f776e6572202d203525206f72206d6f7265206f66204f776e65727368697020496e7465726573743c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e546573743c2f46697273744e616d653e3c4d6964646c654e616d653e3c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3332343233353432333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938322d30312d30312b30353a33303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e7a00000400546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f64653e31323132313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323031312d30312d30312b30353a33303c2f48697265446174653e3c4f74686572496e746572657374496e643e4e3c2f4f74686572496e746572657374496e643e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c466163696c69747943726564656e7469616c732f3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431373a34333a35362e3139312b30353a33303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031332d30342d31355431373a34333a34392e3535372b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e58585858434d534f30303030303030303030303030303036353533363c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431373a34333a35362e3139312b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e7a0000040073323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c4578636c7573696f6e566572696669636174696f6e526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a536372657a00000400656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e3332313c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3033302b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3033332b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3535382b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3835312b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f7a000004006e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3837312b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35302e3138342b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35302e3138342b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c6973743c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35302e3138392b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35332e3131332b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131332b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454697a000004006d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131332b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35332e3131362b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131352b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131362b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35332e3334392b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3334392b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f636573737a00000400457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3334392b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35342e3132382b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35342e3132382b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436342b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35362e3139312b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436342b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e7a0000011e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35362e3139322b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e7878525a080010001a5018012001320608011000180042271a080a044d41494e100022060a044d41494e2a130a0d44524f4f4c535f53595354454d1000180152190a0744454641554c54120e08021001180140004a040000000022026800'), TO_TIMESTAMP('2013-04-15 17:43:47.368000','YYYY-MM-DD HH24:MI:SS.FF'), '1');
INSERT INTO "SESSIONINFO" VALUES ('262', TO_TIMESTAMP('2013-04-15 19:07:45.943000','YYYY-MM-DD HH24:MI:SS.FF'), null, TO_TIMESTAMP('2013-04-15 19:07:39.700000','YYYY-MM-DD HH24:MI:SS.FF'), '1'); -- HEXTORAW('aced00057a000004000a060805100418004aae59080012436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567791ae458aced0005737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a6578700000000177040000000a7372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b78707429693c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73333a456e726f6c6c6d656e7450726f6365737320786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e536572766963652220786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617a000004007265642f456e7469746965732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f63657373223e3c6e73333a53657373696f6e49643e3236323c2f6e73333a53657373696f6e49643e3c6e73333a456e726f6c6c6d656e743e3c4f626a65637449643e33323736383c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031332d30352d30312b30353a33303c2f456666656374697665446174653e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e546573743c2f4e616d653e3c50686f6e654e756d6265723e313231203231342d323131323c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e58585858434d534f30303030303030303030303030303036353533363c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031332d30342d31352b30353a33303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031332d30342d31352b30353a33303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73333a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e4269727468696e672043656e7465723c2f50726f7669646572547970653e3c4e50493e313036333431373535383c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e313231203231342d343132313c2f50686f6e654e756d6265723e3c4661784e756d6265723e333132203132312d323135313c2f4661784e756d6265723e3c416464726573733e3c416464726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f64653e31323132313c2f5a7a000004006970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e323435333433343c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c4c6963656e7365496e666f726d6174696f6e2f3e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74733e3c50726f766964657241677265656d656e743e3c41677265656d656e74446f63756d656e7449643e313c2f41677265656d656e74446f63756d656e7449643e3c41677265656d656e74446f63756d656e74547970653e30313c2f41677265656d656e74446f63756d656e74547970653e3c41677265656d656e74446f63756d656e745469746c653e50726f76696465722041677265656d656e743c2f41677265656d656e74446f63756d656e745469746c653e3c41677265656d656e74446f63756d656e7456657273696f6e3e313c2f41677265656d656e74446f63756d656e7456657273696f6e3e3c4163636570746564446174653e323031332d30342d31352b30353a33303c2f4163636570746564446174653e3c2f50726f766964657241677265656d656e743e3c50726f766964657241677265656d7a00000400656e743e3c41677265656d656e74446f63756d656e7449643e323c2f41677265656d656e74446f63756d656e7449643e3c41677265656d656e74446f63756d656e74547970653e30323c2f41677265656d656e74446f63756d656e74547970653e3c41677265656d656e74446f63756d656e745469746c653e50726f76696465722041677265656d656e7420416464656e64756d3c2f41677265656d656e74446f63756d656e745469746c653e3c41677265656d656e74446f63756d656e7456657273696f6e3e313c2f41677265656d656e74446f63756d656e7456657273696f6e3e3c4163636570746564446174653e323031332d30342d31352b30353a33303c2f4163636570746564446174653e3c2f50726f766964657241677265656d656e743e3c2f416363657074656441677265656d656e74733e3c50726f766964657253746174656d656e743e3c4e616d653e546573743c2f4e616d653e3c5469746c653e546573743c2f5469746c653e3c5369676e446174653e323031332d30342d31352b30353a33303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74733e3c4174746163686d656e743e3c4f626a65637449643e3236323134363c2f4f626a65637449643e3c4e616d653e42504d3c2f4e616d653e3c4d696d65547970653e6170706c69636174696f6e2f6f637465742d73747265616d3c2f4d696d65547970653e3c2f4174746163686d656e743e3c4174746163686d656e743e3c4f626a65637449643e3236323134373c2f4f626a65637449643e3c4e616d653e42504d3c2f4e616d653e3c4d696d65547970653e6170706c69636174696f6e2f6f637465742d73747265616d3c2f4d696d65547970653e3c2f4174746163686d656e743e3c2f4174746163686564446f63756d656e74733e3c566572696669636174696f6e5374617475733e3c4c6963656e7365733e593c2f4c6963656e7365733e3c4e6f6e4578636c7573696f6e3e593c2f4e6f6e4578636c7573696f6e3e3c2f566572696669636174696f6e5374617475733e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4f776e6572202d203525206f72206d6f7265206f66204f776e65727368697020496e7465726573743c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f7a00000400776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e546573743c2f46697273744e616d653e3c4d6964646c654e616d653e3c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132333231333132333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938322d30312d30312b30353a33303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f64653e31323132313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323031312d30312d30312b30353a33303c2f48697265446174653e3c4f74686572496e746572657374496e643e4e3c2f4f74686572496e746572657374496e643e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c466163696c69747943726564656e7469616c733e3c4c6963656e73653e3c4f626a65637449643e313c2f4f626a65637449643e3c4f626a656374547970653e4c3c2f4f626a656374547970653e3c4c6963656e7365547970653e42697274682043656e746572206c6963656e73652066726f6d20746865204d4e204465706172746d656e74206f66204865616c74683c2f4c6963656e7365547970653e3c4c6963656e73654e756d6265723e313233313233323c2f4c6963656e73654e756d6265723e3c4f726967696e616c4973737565446174653e323031312d30312d30312b30353a33303c2f4f726967696e616c4973737565446174653e3c52656e6577616c446174653e323031342d30312d30312b30353a33303c2f52656e6577616c446174653e3c49737375696e6753746174653e4d4e3c2f49737375696e6753746174653e3c4174746163686d656e744f626a65637449643e3236323134363c2f4174746163686d656e744f626a65637449643e3c2f4c6963656e73653e3c4c6963656e73653e3c4f626a65637449643e323c2f4f626a65637449643e3c4f626a656374547970653e4c3c2f4f626a657a000004006374547970653e3c4c6963656e73654e756d6265723e3332343332343c2f4c6963656e73654e756d6265723e3c4f726967696e616c4973737565446174653e323031312d30312d30312b30353a33303c2f4f726967696e616c4973737565446174653e3c52656e6577616c446174653e323031342d30312d30312b30353a33303c2f52656e6577616c446174653e3c49737375696e6753746174653e4d4e3c2f49737375696e6753746174653e3c4174746163686d656e744f626a65637449643e3236323134373c2f4174746163686d656e744f626a65637449643e3c2f4c6963656e73653e3c2f466163696c69747943726564656e7469616c733e3c43617465676f726965734f66536572766963652f3e3c2f6e73333a50726f7669646572496e666f726d6174696f6e3e3c2f6e73333a456e726f6c6c6d656e743e3c6e73333a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431393a30373a34352e3138382b30353a33303c2f537461747573446174653e3c2f6e73333a456e726f6c6c6d656e745374617475733e3c6e73333a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031332d30342d31355431393a30373a34312e3232352b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e58585858434d534f30303030303030303030303030303036353533363c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431393a30373a34352e3138382b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73333a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73333a506f737453757a00000400626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73333a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73333a50726f63657373526573756c74733e3c6e73333a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73333a56616c69646174696f6e526573756c743e3c6e73333a53637265656e696e67526573756c74733e3c6e73333a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73333a4175746f6d6174696353637265656e696e675374617475733e3c6e73333a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c4578636c7573696f6e566572696669636174696f6e526573756c742f3e3c2f6e73333a53637265656e696e67526573756c743e3c6e73333a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73333a53637265656e696e67526573756c743e3c2f6e73333a53637265656e696e67526573757a000004006c74733e3c2f6e73333a50726f63657373526573756c74733e3c6e73333a50726f6365737341756469743e3c6e73333a50726f63657373496e7374616e636549643e3332333c2f6e73333a50726f63657373496e7374616e636549643e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e303c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e537461727450726f636573733c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34302e3736312b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e313c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e50726550726f636573733c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34302e3736342b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e323c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e56616c69646174653c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3232362b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e333c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3531332b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454697a000004006d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e343c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3531372b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34312e3833372b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3833372b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e353c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c6973743c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3834322b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34342e3031322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031322b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a7a0000040050726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e363c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031322b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34342e3031342b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031342b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e373c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e5665726966792053534e3c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031352b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34342e3232342b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3232342b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e7a00000400733e3c6e73333a4f626a65637449643e383c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3232342b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3430312b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e31303c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3430312b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e31313c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34352e3138382b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e31323c2f6e73333a4f7a00000115626a65637449643e3c6e73333a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34352e3138392b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c2f6e73333a50726f6365737341756469743e3c2f6e73333a456e726f6c6c6d656e7450726f636573733e7878525a080010001a5018012001320608011000180042271a080a044d41494e100022060a044d41494e2a130a0d44524f4f4c535f53595354454d1000180152190a0744454641554c54120e08021001180140004a040000000022026800'), TO_TIMESTAMP('2013-04-15 19:07:39.700000','YYYY-MM-DD HH24:MI:SS.FF'), '1');
COMMIT;

-- ----------------------------
--  Table structure for "LU_SVC_CAT"
-- ----------------------------
CREATE TABLE "LU_SVC_CAT" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "LU_SVC_CAT"
-- ----------------------------
INSERT INTO "LU_SVC_CAT" VALUES ('01', 'AC Transportation');
INSERT INTO "LU_SVC_CAT" VALUES ('02', 'Home Delivered Meals');
INSERT INTO "LU_SVC_CAT" VALUES ('03', 'Adult Day Services');
INSERT INTO "LU_SVC_CAT" VALUES ('04', 'Homemaker Services');
INSERT INTO "LU_SVC_CAT" VALUES ('05', 'Behavioral Program Services');
INSERT INTO "LU_SVC_CAT" VALUES ('06', 'In-home Family Support');
INSERT INTO "LU_SVC_CAT" VALUES ('07', 'Caregiver Training');
INSERT INTO "LU_SVC_CAT" VALUES ('08', 'Independent Living Skills');
INSERT INTO "LU_SVC_CAT" VALUES ('09', 'Case Management Waiver/Alternative Care');
INSERT INTO "LU_SVC_CAT" VALUES ('10', 'Modification and Adaptations');
INSERT INTO "LU_SVC_CAT" VALUES ('11', 'Chore');
INSERT INTO "LU_SVC_CAT" VALUES ('12', 'Nutritional Services');
INSERT INTO "LU_SVC_CAT" VALUES ('13', 'Cognitive Therapy');
INSERT INTO "LU_SVC_CAT" VALUES ('14', 'PERS and AC Supplies');
INSERT INTO "LU_SVC_CAT" VALUES ('15', 'Companion Services');
INSERT INTO "LU_SVC_CAT" VALUES ('16', 'Respite Care');
INSERT INTO "LU_SVC_CAT" VALUES ('17', 'Consumer Directed Community Support (CDCS)');
INSERT INTO "LU_SVC_CAT" VALUES ('18', 'Specialized Supplies and Equipment (Waiver)');
INSERT INTO "LU_SVC_CAT" VALUES ('19', 'Spenddown Collection');
INSERT INTO "LU_SVC_CAT" VALUES ('20', 'Customized Living, 24 CL, Residential Care Services, Assisted Living Services');
INSERT INTO "LU_SVC_CAT" VALUES ('21', 'Structured Day Program Services');
INSERT INTO "LU_SVC_CAT" VALUES ('22', 'Supported Employment Services');
INSERT INTO "LU_SVC_CAT" VALUES ('23', 'Family Counseling and Training');
INSERT INTO "LU_SVC_CAT" VALUES ('24', 'Supported Living Services');
INSERT INTO "LU_SVC_CAT" VALUES ('25', 'Foster Care Services');
INSERT INTO "LU_SVC_CAT" VALUES ('26', 'Waiver Transportation');
COMMIT;

-- ----------------------------
--  Table structure for "NOTIFICATION_RECIPIENTS"
-- ----------------------------
CREATE TABLE "NOTIFICATION_RECIPIENTS" (   "TASK_ID" NUMBER(19,0) NOT NULL, "ENTITY_ID" VARCHAR2(255CHAR) NOT NULL);

-- ----------------------------
--  Table structure for "BENEFICIAL_OWNER"
-- ----------------------------
CREATE TABLE "BENEFICIAL_OWNER" (   "BENEFICIAL_OWNER_ID" NUMBER(19,0) NOT NULL, "PERSON_IND" VARCHAR2(1CHAR) NOT NULL, "BEN_TYPE_CD" VARCHAR2(2CHAR), "OTH_TYPE_DESC" VARCHAR2(255CHAR), "SUBCONTRACTOR_NAME" VARCHAR2(255CHAR), "OWN_INTEREST_PCT" NUMBER(19,2), "ADDRESS_ID" NUMBER(19,0), "OTH_PROV_INTRST_IND" VARCHAR2(255CHAR), "OTH_PROV_NAME" VARCHAR2(255CHAR), "OTH_PROV_OWN_PCT" NUMBER(19,2), "OTH_PROV_ADDRESS_ID" NUMBER(19,0), "MIDDLE_NAME" VARCHAR2(255CHAR), "FIRST_NAME" VARCHAR2(255CHAR), "LAST_NAME" VARCHAR2(255CHAR), "SSN" VARCHAR2(255CHAR), "BIRTH_DT" DATE, "HIRE_DT" DATE, "RELATIONSHIP_TYP_CD" VARCHAR2(2CHAR), "OWNERSHIP_INFO_ID" NUMBER(19,0), "IDX" NUMBER(10,0), "FEIN" VARCHAR2(20BYTE), "LEGAL_NAME" VARCHAR2(400BYTE));

-- ----------------------------
--  Records of "BENEFICIAL_OWNER"
-- ----------------------------
INSERT INTO "BENEFICIAL_OWNER" VALUES ('2', 'Y', '03', null, null, '0', '8', 'N', null, null, null, null, 'Test', 'Test', '324235423', TO_DATE('1982-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), TO_DATE('2011-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), null, '2', '0', null, null);
INSERT INTO "BENEFICIAL_OWNER" VALUES ('32769', 'Y', '03', null, null, '0', '32775', 'N', null, null, null, null, 'Test', 'Test', '123213123', TO_DATE('1982-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), TO_DATE('2011-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), null, '32769', '0', null, null);
COMMIT;

-- ----------------------------
--  Table structure for "CONTENT"
-- ----------------------------
CREATE TABLE "CONTENT" (   "ID" NUMBER(19,0) NOT NULL, "CONTENT" BLOB);

-- ----------------------------
--  Records of "CONTENT"
-- ----------------------------
INSERT INTO "CONTENT" VALUES ('321', null); -- HEXTORAW('aced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c770800000010000000057400074163746f72496474000074000c50726f636573734d6f64656c7372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b787074230a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e3236313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031332d30352d30312b30353a33303c2f456666656374697665446174653e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e546573743c2f4e616d653e3c50686f6e654e756d6265723e313231203531322d313235313c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e58585858434d534f30303030303030303030303030303036353533363c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031332d30342d31352b30353a33303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031332d30342d31352b30353a33303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e436869726f7072616374696320436c696e69633c2f50726f7669646572547970653e3c4e50493e313536383730393937303c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e313231203431332d313435313c2f50686f6e654e756d6265723e3c4661784e756d6265723e313331203235312d333132313c2f4661784e756d6265723e3c416464726573733e3c416464726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f64653e31323133313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e333235343633323c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c4c6963656e7365496e666f726d6174696f6e2f3e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e546573743c2f4e616d653e3c5469746c653e546573743c2f5469746c653e3c5369676e446174653e323031332d30342d31352b30353a33303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475733e3c4c6963656e7365733e593c2f4c6963656e7365733e3c4e6f6e4578636c7573696f6e3e593c2f4e6f6e4578636c7573696f6e3e3c2f566572696669636174696f6e5374617475733e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313135343332343235393c2f4e50493e3c46756c6c4e616d653e546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3234353233343334333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938322d30312d30312b30353a33303c2f446174654f6642697274683e3c50726f7669646572547970653e436869726f70726163746f723c2f50726f7669646572547970653e3c5374617274446174653e323031312d30312d30312b30353a33303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c47726f75704d656d6265723e3c4e50493e313536383730393937303c2f4e50493e3c46756c6c4e616d653e546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3233343233363433353c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938312d31302d31302b30353a33303c2f446174654f6642697274683e3c50726f7669646572547970653e436869726f70726163746f723c2f50726f7669646572547970653e3c5374617274446174653e323031312d30312d30312b30353a33303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4f776e6572202d203525206f72206d6f7265206f66204f776e65727368697020496e7465726573743c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e546573743c2f46697273744e616d653e3c4d6964646c654e616d653e3c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3332343233353432333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938322d30312d30312b30353a33303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f64653e31323132313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323031312d30312d30312b30353a33303c2f48697265446174653e3c4f74686572496e746572657374496e643e4e3c2f4f74686572496e746572657374496e643e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c466163696c69747943726564656e7469616c732f3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431373a34333a35362e3139312b30353a33303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031332d30342d31355431373a34333a34392e3535372b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e58585858434d534f30303030303030303030303030303036353533363c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431373a34333a35362e3139312b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c4578636c7573696f6e566572696669636174696f6e526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e3332313c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3033302b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3033332b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3535382b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3835312b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35332e3334392b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3837312b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35302e3138342b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35302e3138342b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c6973743c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35302e3138392b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35332e3131332b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131332b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131332b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35332e3131362b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131352b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131362b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35332e3334392b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3334392b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3334392b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35342e3132382b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35342e3132382b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35362e3139312b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35362e3139322b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e78740007436f6d6d656e7474001174686973206973206120636f6d6d656e747400085461736b4e616d6574001053637265656e696e672052657669657774000747726f75704964740015536572766963652041646d696e6973747261746f7278'));
INSERT INTO "CONTENT" VALUES ('322', null); -- HEXTORAW('aced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c770800000010000000057400074163746f72496474000074000c50726f636573734d6f64656c7372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b78707427013c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73333a456e726f6c6c6d656e7450726f6365737320786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e536572766963652220786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f63657373223e3c6e73333a53657373696f6e49643e3236323c2f6e73333a53657373696f6e49643e3c6e73333a456e726f6c6c6d656e743e3c4f626a65637449643e33323736383c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031332d30352d30312b30353a33303c2f456666656374697665446174653e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e546573743c2f4e616d653e3c50686f6e654e756d6265723e313231203231342d323131323c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e58585858434d534f30303030303030303030303030303036353533363c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031332d30342d31352b30353a33303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031332d30342d31352b30353a33303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73333a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e4269727468696e672043656e7465723c2f50726f7669646572547970653e3c4e50493e313036333431373535383c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e313231203231342d343132313c2f50686f6e654e756d6265723e3c4661784e756d6265723e333132203132312d323135313c2f4661784e756d6265723e3c416464726573733e3c416464726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f64653e31323132313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e323435333433343c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c4c6963656e7365496e666f726d6174696f6e2f3e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74733e3c50726f766964657241677265656d656e743e3c41677265656d656e74446f63756d656e7449643e313c2f41677265656d656e74446f63756d656e7449643e3c41677265656d656e74446f63756d656e74547970653e30313c2f41677265656d656e74446f63756d656e74547970653e3c41677265656d656e74446f63756d656e745469746c653e50726f76696465722041677265656d656e743c2f41677265656d656e74446f63756d656e745469746c653e3c41677265656d656e74446f63756d656e7456657273696f6e3e313c2f41677265656d656e74446f63756d656e7456657273696f6e3e3c4163636570746564446174653e323031332d30342d31352b30353a33303c2f4163636570746564446174653e3c2f50726f766964657241677265656d656e743e3c50726f766964657241677265656d656e743e3c41677265656d656e74446f63756d656e7449643e323c2f41677265656d656e74446f63756d656e7449643e3c41677265656d656e74446f63756d656e74547970653e30323c2f41677265656d656e74446f63756d656e74547970653e3c41677265656d656e74446f63756d656e745469746c653e50726f76696465722041677265656d656e7420416464656e64756d3c2f41677265656d656e74446f63756d656e745469746c653e3c41677265656d656e74446f63756d656e7456657273696f6e3e313c2f41677265656d656e74446f63756d656e7456657273696f6e3e3c4163636570746564446174653e323031332d30342d31352b30353a33303c2f4163636570746564446174653e3c2f50726f766964657241677265656d656e743e3c2f416363657074656441677265656d656e74733e3c50726f766964657253746174656d656e743e3c4e616d653e546573743c2f4e616d653e3c5469746c653e546573743c2f5469746c653e3c5369676e446174653e323031332d30342d31352b30353a33303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74733e3c4174746163686d656e743e3c4f626a65637449643e3236323134363c2f4f626a65637449643e3c4e616d653e42504d3c2f4e616d653e3c4d696d65547970653e6170706c69636174696f6e2f6f637465742d73747265616d3c2f4d696d65547970653e3c2f4174746163686d656e743e3c4174746163686d656e743e3c4f626a65637449643e3236323134373c2f4f626a65637449643e3c4e616d653e42504d3c2f4e616d653e3c4d696d65547970653e6170706c69636174696f6e2f6f637465742d73747265616d3c2f4d696d65547970653e3c2f4174746163686d656e743e3c2f4174746163686564446f63756d656e74733e3c566572696669636174696f6e5374617475733e3c4c6963656e7365733e593c2f4c6963656e7365733e3c4e6f6e4578636c7573696f6e3e593c2f4e6f6e4578636c7573696f6e3e3c2f566572696669636174696f6e5374617475733e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4f776e6572202d203525206f72206d6f7265206f66204f776e65727368697020496e7465726573743c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e546573743c2f46697273744e616d653e3c4d6964646c654e616d653e3c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132333231333132333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938322d30312d30312b30353a33303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f64653e31323132313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323031312d30312d30312b30353a33303c2f48697265446174653e3c4f74686572496e746572657374496e643e4e3c2f4f74686572496e746572657374496e643e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c466163696c69747943726564656e7469616c733e3c4c6963656e73653e3c4f626a65637449643e313c2f4f626a65637449643e3c4f626a656374547970653e4c3c2f4f626a656374547970653e3c4c6963656e7365547970653e42697274682043656e746572206c6963656e73652066726f6d20746865204d4e204465706172746d656e74206f66204865616c74683c2f4c6963656e7365547970653e3c4c6963656e73654e756d6265723e313233313233323c2f4c6963656e73654e756d6265723e3c4f726967696e616c4973737565446174653e323031312d30312d30312b30353a33303c2f4f726967696e616c4973737565446174653e3c52656e6577616c446174653e323031342d30312d30312b30353a33303c2f52656e6577616c446174653e3c49737375696e6753746174653e4d4e3c2f49737375696e6753746174653e3c4174746163686d656e744f626a65637449643e3236323134363c2f4174746163686d656e744f626a65637449643e3c2f4c6963656e73653e3c4c6963656e73653e3c4f626a65637449643e323c2f4f626a65637449643e3c4f626a656374547970653e4c3c2f4f626a656374547970653e3c4c6963656e73654e756d6265723e3332343332343c2f4c6963656e73654e756d6265723e3c4f726967696e616c4973737565446174653e323031312d30312d30312b30353a33303c2f4f726967696e616c4973737565446174653e3c52656e6577616c446174653e323031342d30312d30312b30353a33303c2f52656e6577616c446174653e3c49737375696e6753746174653e4d4e3c2f49737375696e6753746174653e3c4174746163686d656e744f626a65637449643e3236323134373c2f4174746163686d656e744f626a65637449643e3c2f4c6963656e73653e3c2f466163696c69747943726564656e7469616c733e3c43617465676f726965734f66536572766963652f3e3c2f6e73333a50726f7669646572496e666f726d6174696f6e3e3c2f6e73333a456e726f6c6c6d656e743e3c6e73333a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431393a30373a34352e3138382b30353a33303c2f537461747573446174653e3c2f6e73333a456e726f6c6c6d656e745374617475733e3c6e73333a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031332d30342d31355431393a30373a34312e3232352b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e58585858434d534f30303030303030303030303030303036353533363c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431393a30373a34352e3138382b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73333a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73333a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73333a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73333a50726f63657373526573756c74733e3c6e73333a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73333a56616c69646174696f6e526573756c743e3c6e73333a53637265656e696e67526573756c74733e3c6e73333a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73333a4175746f6d6174696353637265656e696e675374617475733e3c6e73333a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c4578636c7573696f6e566572696669636174696f6e526573756c742f3e3c2f6e73333a53637265656e696e67526573756c743e3c6e73333a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73333a53637265656e696e67526573756c743e3c2f6e73333a53637265656e696e67526573756c74733e3c2f6e73333a50726f63657373526573756c74733e3c6e73333a50726f6365737341756469743e3c6e73333a50726f63657373496e7374616e636549643e3332333c2f6e73333a50726f63657373496e7374616e636549643e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e303c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e537461727450726f636573733c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34302e3736312b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e313c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e50726550726f636573733c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34302e3736342b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e323c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e56616c69646174653c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3232362b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e333c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3531332b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34342e3232342b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e343c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3531372b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34312e3833372b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3833372b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e353c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c6973743c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3834322b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34342e3031322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031322b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e363c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031322b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34342e3031342b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031342b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e373c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e5665726966792053534e3c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031352b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34342e3232342b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3232342b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e383c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3232342b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3430312b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e31303c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3430312b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e31313c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34352e3138382b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e31323c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34352e3138392b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c2f6e73333a50726f6365737341756469743e3c2f6e73333a456e726f6c6c6d656e7450726f636573733e78740007436f6d6d656e7474001174686973206973206120636f6d6d656e747400085461736b4e616d6574001053637265656e696e672052657669657774000747726f75704964740015536572766963652041646d696e6973747261746f7278'));
COMMIT;

-- ----------------------------
--  Table structure for "PERSISTENT_LOGINS"
-- ----------------------------
CREATE TABLE "PERSISTENT_LOGINS" (   "USERNAME" VARCHAR2(64BYTE) NOT NULL, "SERIES" VARCHAR2(64BYTE) NOT NULL, "TOKEN" VARCHAR2(64BYTE) NOT NULL, "LAST_USED" TIMESTAMP(6) NOT NULL);

-- ----------------------------
--  Table structure for "PEOPLEASSIGNMENTS_STAKEHOLDERS"
-- ----------------------------
CREATE TABLE "PEOPLEASSIGNMENTS_STAKEHOLDERS" (   "TASK_ID" NUMBER(19,0) NOT NULL, "ENTITY_ID" VARCHAR2(255CHAR) NOT NULL);

-- ----------------------------
--  Table structure for "TASK_COMMENT"
-- ----------------------------
CREATE TABLE "TASK_COMMENT" (   "ID" NUMBER(19,0) NOT NULL, "ADDEDAT" TIMESTAMP(6) NULL, "TEXT" CLOB, "ADDEDBY_ID" VARCHAR2(255CHAR), "TASKDATA_COMMENTS_ID" NUMBER(19,0));

-- ----------------------------
--  Table structure for "REASSIGNMENT_POTENTIALOWNERS"
-- ----------------------------
CREATE TABLE "REASSIGNMENT_POTENTIALOWNERS" (   "TASK_ID" NUMBER(19,0) NOT NULL, "ENTITY_ID" VARCHAR2(255CHAR) NOT NULL);

-- ----------------------------
--  Table structure for "LU_OWNERSHIP_TYP"
-- ----------------------------
CREATE TABLE "LU_OWNERSHIP_TYP" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Table structure for "LU_CORP_STRUCTURE_TYP"
-- ----------------------------
CREATE TABLE "LU_CORP_STRUCTURE_TYP" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "LU_CORP_STRUCTURE_TYP"
-- ----------------------------
INSERT INTO "LU_CORP_STRUCTURE_TYP" VALUES ('01', 'Sole Proprietorship');
INSERT INTO "LU_CORP_STRUCTURE_TYP" VALUES ('02', 'Partnership');
INSERT INTO "LU_CORP_STRUCTURE_TYP" VALUES ('03', 'Corporation');
INSERT INTO "LU_CORP_STRUCTURE_TYP" VALUES ('04', 'Non-Profit');
INSERT INTO "LU_CORP_STRUCTURE_TYP" VALUES ('05', 'Hospital Based');
INSERT INTO "LU_CORP_STRUCTURE_TYP" VALUES ('06', 'State');
INSERT INTO "LU_CORP_STRUCTURE_TYP" VALUES ('07', 'Public');
INSERT INTO "LU_CORP_STRUCTURE_TYP" VALUES ('08', 'Professional Association');
INSERT INTO "LU_CORP_STRUCTURE_TYP" VALUES ('99', 'Other');
COMMIT;

-- ----------------------------
--  Table structure for "AGREEMENT_DOCUMENT"
-- ----------------------------
CREATE TABLE "AGREEMENT_DOCUMENT" (   "AGREEMENT_DOCUMENT_ID" NUMBER(19,0) NOT NULL, "DOC_TYPE" VARCHAR2(45CHAR), "TITLE" VARCHAR2(100CHAR), "VERSION" NUMBER(10,0), "DOC_TEXT" CLOB, "CREATED_BY" VARCHAR2(45CHAR), "CREATE_TS" TIMESTAMP(6) NULL);

-- ----------------------------
--  Records of "AGREEMENT_DOCUMENT"
-- ----------------------------
INSERT INTO "AGREEMENT_DOCUMENT" VALUES ('3', '03', 'Child And Teen Checkup Agreement (DHS-4646)', '1', 'This is some text', 'SYSTEM', TO_TIMESTAMP('2013-04-04 20:26:57.000000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "AGREEMENT_DOCUMENT" VALUES ('1', '01', 'Provider Agreement', '1', 'This is some text', 'SYSTEM', TO_TIMESTAMP('2013-04-04 20:38:13.000000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "AGREEMENT_DOCUMENT" VALUES ('2', '02', 'Provider Agreement Addendum', '1', 'This is some text', 'SYSTEM', TO_TIMESTAMP('2013-04-04 20:38:13.000000','YYYY-MM-DD HH24:MI:SS.FF'));
COMMIT;
-- data-fixes-11-19-13.sql
update agreement_document set doc_type = '01' where agreement_document_id = 3;
COMMIT;


-- ----------------------------
--  Table structure for "CMS_ATTACHMENT"
-- ----------------------------
CREATE TABLE "CMS_ATTACHMENT" (   "ATTACHMENT_ID" NUMBER(19,0) NOT NULL, "PROFILE_ID" NUMBER(19,0), "TICKET_ID" NUMBER(19,0), "TYPE" VARCHAR2(45CHAR), "FILE_NAME" VARCHAR2(300BYTE), "DESCRIPTION" VARCHAR2(45CHAR), "CONTENT_ID" VARCHAR2(255CHAR), "CREATED_BY" VARCHAR2(45CHAR), "CREATE_TS" TIMESTAMP(6) NULL);

-- ----------------------------
--  Records of "CMS_ATTACHMENT"
-- ----------------------------
INSERT INTO "CMS_ATTACHMENT" VALUES ('1', '0', '0', 'text/x-sql', 'pesp-281.sql', null, 'ae50f0fc-2b4d-4f56-bcf1-f29c90bb4789', 'XXXXCMSO00000000000000032768', TO_TIMESTAMP('2013-04-04 23:15:18.312000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "CMS_ATTACHMENT" VALUES ('32768', '0', '0', 'text/x-sql', 'pesp-281.sql', null, '8f224cb7-d702-4dd8-8920-5dbbd02177e7', 'XXXXCMSO00000000000000032768', TO_TIMESTAMP('2013-04-08 10:26:31.002000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "CMS_ATTACHMENT" VALUES ('131072', '0', '0', 'text/x-sql', 'pesp-281.sql', null, '9d5576a6-024a-431f-b5b7-4df279c5e735', 'XXXXCMSO00000000000000032768', TO_TIMESTAMP('2013-04-08 11:46:09.695000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "CMS_ATTACHMENT" VALUES ('163840', '0', '0', 'text/x-sql', 'pesp-281.sql', null, '19bc8c7c-4d50-4d73-ac69-e262967f44e9', 'XXXXCMSO00000000000000065536', TO_TIMESTAMP('2013-04-08 13:07:57.765000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "CMS_ATTACHMENT" VALUES ('163841', '0', '0', 'text/x-sql', 'pesp-281.sql', null, '2633cb95-c29a-461d-b2d7-224b557f0cf5', 'XXXXCMSO00000000000000065536', TO_TIMESTAMP('2013-04-08 13:07:57.777000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "CMS_ATTACHMENT" VALUES ('196608', '0', '0', 'application/octet-stream', 'Corrections', null, 'd513ca45-88cd-4c93-b090-e078b19a7115', 'XXXXCMSO00000000000000065536', TO_TIMESTAMP('2013-04-10 23:23:19.119000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "CMS_ATTACHMENT" VALUES ('229376', '0', '0', 'application/octet-stream', 'BPM', null, 'ed2e2e67-cf76-4bc2-81fc-2e3a20980be6', 'XXXXCMSO00000000000000065536', TO_TIMESTAMP('2013-04-15 18:25:13.463000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "CMS_ATTACHMENT" VALUES ('229377', '0', '0', 'application/octet-stream', 'BPM', null, '854131c2-0fd4-40ae-ad53-2ee917a3e75c', 'XXXXCMSO00000000000000065536', TO_TIMESTAMP('2013-04-15 18:25:13.639000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "CMS_ATTACHMENT" VALUES ('262144', '0', '0', 'application/octet-stream', 'BPM', null, '51587ca1-6c34-4d64-bcec-ac90f8a141ea', 'XXXXCMSO00000000000000065536', TO_TIMESTAMP('2013-04-15 19:06:25.464000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "CMS_ATTACHMENT" VALUES ('262145', '0', '0', 'application/octet-stream', 'BPM', null, 'd4a72c15-20e8-4711-be8d-c82d2b5c4d65', 'XXXXCMSO00000000000000065536', TO_TIMESTAMP('2013-04-15 19:06:25.528000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "CMS_ATTACHMENT" VALUES ('262148', '0', '32768', 'application/octet-stream', 'BPM', null, '51587ca1-6c34-4d64-bcec-ac90f8a141ea', 'XXXXCMSO00000000000000065536', TO_TIMESTAMP('2013-04-15 19:06:25.464000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "CMS_ATTACHMENT" VALUES ('262149', '0', '32768', 'application/octet-stream', 'BPM', null, 'd4a72c15-20e8-4711-be8d-c82d2b5c4d65', 'XXXXCMSO00000000000000065536', TO_TIMESTAMP('2013-04-15 19:06:25.528000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "CMS_ATTACHMENT" VALUES ('65536', '0', '0', 'text/x-sql', 'pesp-281.sql', null, '33017dfc-fa0d-45bb-af41-50e37d664c21', 'XXXXCMSO00000000000000032768', TO_TIMESTAMP('2013-04-08 11:16:48.656000','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "CMS_ATTACHMENT" VALUES ('98304', '0', '0', 'text/x-sql', 'pesp-281.sql', null, '2ce5d022-2b47-411a-8f01-9ef65863eb40', 'XXXXCMSO00000000000000032768', TO_TIMESTAMP('2013-04-08 11:23:26.354000','YYYY-MM-DD HH24:MI:SS.FF'));
COMMIT;

-- ----------------------------
--  Table structure for "LU_STATE"
-- ----------------------------
CREATE TABLE "LU_STATE" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "LU_STATE"
-- ----------------------------
INSERT INTO "LU_STATE" VALUES ('AK', 'ALASKA');
INSERT INTO "LU_STATE" VALUES ('AL', 'ALABAMA');
INSERT INTO "LU_STATE" VALUES ('AR', 'ARKANSAS');
INSERT INTO "LU_STATE" VALUES ('AZ', 'ARIZONA');
INSERT INTO "LU_STATE" VALUES ('CA', 'CALIFORNIA');
INSERT INTO "LU_STATE" VALUES ('CO', 'COLORADO');
INSERT INTO "LU_STATE" VALUES ('CT', 'CONNECTICUT');
INSERT INTO "LU_STATE" VALUES ('DC', 'DISTRICT OF COLUMBIA');
INSERT INTO "LU_STATE" VALUES ('DE', 'DELAWARE');
INSERT INTO "LU_STATE" VALUES ('FL', 'FLORIDA');
INSERT INTO "LU_STATE" VALUES ('GA', 'GEORGIA');
INSERT INTO "LU_STATE" VALUES ('HI', 'HAWAII');
INSERT INTO "LU_STATE" VALUES ('IA', 'IOWA');
INSERT INTO "LU_STATE" VALUES ('ID', 'IDAHO');
INSERT INTO "LU_STATE" VALUES ('IL', 'ILLINOIS');
INSERT INTO "LU_STATE" VALUES ('IN', 'INDIANA');
INSERT INTO "LU_STATE" VALUES ('KS', 'KANSAS');
INSERT INTO "LU_STATE" VALUES ('KY', 'KENTUCKY');
INSERT INTO "LU_STATE" VALUES ('LA', 'LOUISIANA');
INSERT INTO "LU_STATE" VALUES ('MA', 'MASSACHUSETTS');
INSERT INTO "LU_STATE" VALUES ('MD', 'MARYLAND');
INSERT INTO "LU_STATE" VALUES ('ME', 'MAINE');
INSERT INTO "LU_STATE" VALUES ('MI', 'MICHIGAN');
INSERT INTO "LU_STATE" VALUES ('MN', 'MINNESOTA');
INSERT INTO "LU_STATE" VALUES ('MO', 'MISSOURI');
INSERT INTO "LU_STATE" VALUES ('MS', 'MISSISSIPPI');
INSERT INTO "LU_STATE" VALUES ('MT', 'MONTANA');
INSERT INTO "LU_STATE" VALUES ('NE', 'NEBRASKA');
INSERT INTO "LU_STATE" VALUES ('NC', 'NORTH CAROLINA');
INSERT INTO "LU_STATE" VALUES ('ND', 'NORTH DAKOTA');
INSERT INTO "LU_STATE" VALUES ('NH', 'NEW HAMPSHIRE');
INSERT INTO "LU_STATE" VALUES ('NJ', 'NEW JERSEY');
INSERT INTO "LU_STATE" VALUES ('NM', 'NEW MEXICO');
INSERT INTO "LU_STATE" VALUES ('NY', 'NEW YORK');
INSERT INTO "LU_STATE" VALUES ('NV', 'NEVADA');
INSERT INTO "LU_STATE" VALUES ('OH', 'OHIO');
INSERT INTO "LU_STATE" VALUES ('OK', 'OKLAHOMA');
INSERT INTO "LU_STATE" VALUES ('OR', 'OREGON');
INSERT INTO "LU_STATE" VALUES ('PA', 'PENNSYLVANIA');
INSERT INTO "LU_STATE" VALUES ('RI', 'RHODE ISLAND');
INSERT INTO "LU_STATE" VALUES ('SC', 'SOUTH CAROLINA');
INSERT INTO "LU_STATE" VALUES ('TN', 'TENNESSEE');
INSERT INTO "LU_STATE" VALUES ('TX', 'TEXAS');
INSERT INTO "LU_STATE" VALUES ('UT', 'UTAH');
INSERT INTO "LU_STATE" VALUES ('VA', 'VIRGINIA');
INSERT INTO "LU_STATE" VALUES ('VT', 'VERMONT');
INSERT INTO "LU_STATE" VALUES ('WA', 'WASHINGTON');
INSERT INTO "LU_STATE" VALUES ('WI', 'WISCONSIN');
INSERT INTO "LU_STATE" VALUES ('WV', 'WEST VIRGINIA');
INSERT INTO "LU_STATE" VALUES ('WY', 'WYOMING');
INSERT INTO "LU_STATE" VALUES ('XX', 'XX');
COMMIT;
-- data-fixes-11-19-13.sql
DELETE FROM LU_STATE WHERE CODE = 'XX';
commit;

-- ----------------------------
--  Table structure for "LU_LICENSE_TYPE"
-- ----------------------------
CREATE TABLE "LU_LICENSE_TYPE" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));
ALTER TABLE "LU_LICENSE_TYPE" ADD CONSTRAINT "SYS_C004063" PRIMARY KEY("CODE");

-- ----------------------------
--  Records of "LU_LICENSE_TYPE"
-- ----------------------------
INSERT INTO "LU_LICENSE_TYPE" VALUES ('CA', 'Adult Rehabilitative Mental Health Services');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('CB', 'Children''s Therapeutic Services and Supports (CTSS)');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('CC', 'Adult Crisis Response Services - Crisis Assessment and Crisis Intervention');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('CD', 'Adult Crisis Response Services - Crisis Stabilization');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('CE', 'Adult Crisis Response Services - Short-Term Residential');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AN', 'Day Training and Habilitation License');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AO', 'License and Transmittal (CMS 1539 Form) from MN Department of Health');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AP', 'Approval by Kent Dufresne to enroll new facility');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AQ', 'Hospice license from the MN Dept of Health');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AR', 'CMS Medicare Certification Letter');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AS', 'Ambulance Services - Basic Service');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AT', 'Ambulance Services - Advanced Life Support');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AU', 'Ambulance Services - Air Transport with FAA Air Worthiness Certificate');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AV', 'State License to operate as a Hospital');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AW', 'CMS PECOS Website Verification');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AX', 'CLIA Certificate if billing Lab Services');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AY', 'CMS 1539 from MN Dept of Health');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AZ', 'Renal Dialysis Facility Approval letter from regional CMS office');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('B0', 'Hospital Based Clinic Designation:  approval letter from CMS');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('L1', 'Audiologist License');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('L2', 'Registration with the Department Of Health');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('L3', 'Optometrist License');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('L4', 'Registered Nurse');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('L5', 'PCA Training Certificate');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('L6', 'Traditional Midwife');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('L7', 'MnSCU Certification');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('L8', 'Chiropractic Examiner');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('L9', 'License To Practice Podiatric Medicine');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('L0', 'Marriage And Family Therapist');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('M1', 'Professional Clinical Counselor');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('M2', 'Occupational Therapy');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('M3', 'Physician Assistant');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('M4', 'Physical Therapist');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('M5', 'Speech Language Pathologist');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('M6', 'Acupuncturist');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('M7', 'Dental Hygienist');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('M8', 'Mental Health Rehab Professional');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('M9', 'Dental');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('M0', 'Hearing Aid Dispenser');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('N1', 'Dietician or Nutritionist');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('N2', 'Clinical Social Worker');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('N3', 'Pharmacist License');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('N4', 'Psychologist');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('N5', 'Physician');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('A1', 'Head Start Agency Certification');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('A2', 'Class A Professional Home Care License');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('A3', 'HCFA Medicare Certification');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('A4', 'Housing with Services');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('A5', 'Off-site Approval Letter From Medicare');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('A6', 'Verification of IHS status');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('A7', 'County Contract to Provider IRTS');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('A8', 'Rule 36 Licensed Facility');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('A9', 'Class A License');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('A0', 'Background Study');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AA', 'Pharmacy License');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AB', 'Class A License For Private Duty Nursing Services');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AC', 'Medicare Certification For Home Health Aide And Skilled Nursing Services');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AD', 'Regional Treatment Center Certification');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AE', 'Medicare Approval Letter');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AF', 'Comprehensive Outpatient Rehabilitation Facility Certification');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AG', 'Independent or Portable X-ray Certification from CMS');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AH', 'FDA Certification Â¿ Mammography services');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AI', 'PCA 1 or 3 day Steps for Success Training');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AJ', 'Medicare Certification');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AK', 'Rule 5 License issued from MN Department of Human Services');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AL', 'Certificate of Compliance from MN Department of Human Rights');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('AM', 'Rule 29 License');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('B1', 'Birth Center license from the MN Department of Health');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('B2', 'Accreditation from the Commission for the Accreditation of Birth Centers ');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('B3', 'Special Transportation (STS) - Transportation Certificate from the MN Department of Transportation');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('B4', 'Ambulance - Licensure as Emergency Medical Transportation Provider from the state of practice');
INSERT INTO "LU_LICENSE_TYPE" VALUES ('B5', 'Air - FAA Certificate of airworthiness plus Ambulance License');
commit;
-- data-fixes-11-19-13.sql
delete from LU_LICENSE_TYPE where CODE = 'M8';
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('H1', 'Rehab Counselor Certification');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('H2', 'Psychosocial Rehab Practitioner Certification');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('H3', 'Licensed Practical Nurse');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('H4', 'Class A License');
// collides
// INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('B1', 'Adult Day Care License');
// INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('B2', '245B License');
delete from LU_LICENSE_TYPE where code = 'AP';
COMMIT;

-- ----------------------------
--  Table structure for "PROVIDER_PROFILE"
-- ----------------------------
CREATE TABLE "PROVIDER_PROFILE" (   "CONTROL_NO" NUMBER(19,0) NOT NULL, "PROFILE_ID" NUMBER(19,0) DEFAULT 0 NOT NULL, "TICKET_ID" NUMBER(19,0) DEFAULT 0 NOT NULL, "EFFECTIVE_DT" DATE, "PROFILE_STATUS_CD" VARCHAR2(2CHAR), "REFERENCE_TICKET_ID" NUMBER(19,0) DEFAULT 0 NOT NULL, "RESERVATION_EMP_IND" VARCHAR2(1CHAR), "PRIVATE_PRACTICE_IND" VARCHAR2(1CHAR), "GROUP_PRACTICE_IND" VARCHAR2(1CHAR), "CRIMINAL_CONVICTION_IND" VARCHAR2(1CHAR), "CIVIL_PENALTY_IND" VARCHAR2(1CHAR), "PREV_EXCLUSION_IND" VARCHAR2(1CHAR), "ADULT_IND" VARCHAR2(1CHAR), "COUNTY_NAME" VARCHAR2(200BYTE), "CONT_EMPLY_IND" VARCHAR2(1CHAR), "RISK_LEVEL_CD" VARCHAR2(2CHAR), "OWNER_ID" VARCHAR2(45CHAR), "CREATED_BY" VARCHAR2(45CHAR), "CREATE_TS" TIMESTAMP(6) NULL, "LAST_UPDATED_BY" VARCHAR2(45CHAR), "LAST_UPDATED_TS" TIMESTAMP(6) NULL, "EMP_CRIMINAL_CONVICTION_IND" CHAR(1BYTE), "EMP_CIVIL_PENALTY_IND" CHAR(1BYTE), "EMP_PREV_EXCLUSION_IND" CHAR(1BYTE), "BED_COUNT" NUMBER, "BED_COUNT_DT" DATE, "FORM_COMPLETED_BY" VARCHAR2(200BYTE), "HLTH_BRD_IND" CHAR(1BYTE), "TITLE_18_BED_COUNT" NUMBER, "TITLE_19_BED_COUNT" NUMBER, "DUAL_CERT_BED_COUNT" NUMBER, "ICF_BED_COUNT" NUMBER, "PT_OT_IND" CHAR(1BYTE));

-- ----------------------------
--  Records of "PROVIDER_PROFILE"
-- ----------------------------
INSERT INTO "PROVIDER_PROFILE" VALUES ('2', '0', '1', TO_DATE('2013-05-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), null, '0', null, null, null, 'N', 'N', 'N', null, null, null, null, null, null, null, null, null, 'N', 'N', 'N', null, null, null, null, null, null, null, null, null);
INSERT INTO "PROVIDER_PROFILE" VALUES ('32769', '0', '32768', TO_DATE('2013-05-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), null, '0', null, null, null, 'N', 'N', 'N', null, null, null, null, null, null, null, null, null, 'N', 'N', 'N', null, null, null, null, null, null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for "CMS_USER"
-- ----------------------------
CREATE TABLE "CMS_USER" (   "USER_ID" VARCHAR2(255CHAR) NOT NULL, "USER_NAME" VARCHAR2(255CHAR), "FIRST_NAME" VARCHAR2(255CHAR), "LAST_NAME" VARCHAR2(255CHAR), "MIDDLE_NAME" VARCHAR2(255CHAR), "PHONE_NUMBER" VARCHAR2(255CHAR), "EMAIL" VARCHAR2(255CHAR), "STATUS" VARCHAR2(255CHAR), "ROLE_CD" VARCHAR2(2CHAR));

-- ----------------------------
--  Records of "CMS_USER"
-- ----------------------------
INSERT INTO "CMS_USER" VALUES ('XXXXCMSO00000000000000065536', 'jag', 'Jerrish', 'Varghese', null, null, 'jerrishissac@gmail.com', 'ACTIVE', 'R1');
INSERT INTO "CMS_USER" VALUES ('SYSTEM', 'system', 'system', 'system', null, null, 'cmsmailer@gmail.com', 'ACTIVE', 'R4');
INSERT INTO "CMS_USER" VALUES ('ADMIN', 'admin', 'admin', 'admin', null, null, 'cmsmailer@gmail.com', 'ACTIVE', 'R3');
COMMIT;

-- ----------------------------
--  Table structure for "HELP_ITEM"
-- ----------------------------
CREATE TABLE "HELP_ITEM" (   "HELP_ITEM_ID" NUMBER(19,0) NOT NULL, "TITLE" VARCHAR2(45CHAR), "DESCRIPTION" VARCHAR2(2048CHAR));

-- ----------------------------
--  Table structure for "EVENT"
-- ----------------------------
CREATE TABLE "EVENT" (   "EVENT_ID" NUMBER(19,0) NOT NULL, "NPI" VARCHAR2(10CHAR), "TICKET_ID" NUMBER(19,0), "STATUS_CD" VARCHAR2(2CHAR), "CREATED_BY" VARCHAR2(50CHAR), "CREATE_TS" TIMESTAMP(6) NULL);

-- ----------------------------
--  Table structure for "BOOLEANEXPRESSION"
-- ----------------------------
CREATE TABLE "BOOLEANEXPRESSION" (   "ID" NUMBER(19,0) NOT NULL, "EXPRESSION" CLOB, "TYPE" VARCHAR2(255CHAR), "ESCALATION_CONSTRAINTS_ID" NUMBER(19,0));

-- ----------------------------
--  Table structure for "LU_ROLE"
-- ----------------------------
CREATE TABLE "LU_ROLE" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "LU_ROLE"
-- ----------------------------
INSERT INTO "LU_ROLE" VALUES ('R1', 'Provider');
INSERT INTO "LU_ROLE" VALUES ('R2', 'Service Agent');
INSERT INTO "LU_ROLE" VALUES ('R3', 'Service Administrator');
INSERT INTO "LU_ROLE" VALUES ('R4', 'System Administrator');
COMMIT;

-- ----------------------------
--  Table structure for "EXTERNAL_PROFILE_LINK"
-- ----------------------------
CREATE TABLE "EXTERNAL_PROFILE_LINK" (   "EXTERNAL_PROFILE_LINK_ID" NUMBER(19,0) NOT NULL, "PROFILE_ID" NUMBER(19,0), "SYSTEM_ID" VARCHAR2(255CHAR), "EXTERNAL_PROFILE_ID" VARCHAR2(255CHAR));

-- ----------------------------
--  Table structure for "WORKITEMINFO"
-- ----------------------------
CREATE TABLE "WORKITEMINFO" (   "WORKITEMID" NUMBER(19,0) NOT NULL, "CREATIONDATE" TIMESTAMP(6) NULL, "NAME" VARCHAR2(255CHAR), "PROCESSINSTANCEID" NUMBER(19,0) NOT NULL, "STATE" NUMBER(19,0) NOT NULL, "OPTLOCK" NUMBER(10,0), "WORKITEMBYTEARRAY" BLOB);

-- ----------------------------
--  Records of "WORKITEMINFO"
-- ----------------------------
INSERT INTO "WORKITEMINFO" VALUES ('709', TO_TIMESTAMP('2013-04-15 17:43:56.192000','YYYY-MM-DD HH24:MI:SS.FF'), 'Human Task', '321', '0', '1', null); -- HEXTORAW('aced0005777600000000000002c50000000000000141000a48756d616e205461736b000000000000000500074163746f724964fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567797400007757000c50726f636573734d6f64656cfffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567797372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b78707425723c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e3236313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031332d30352d30312b30353a33303c2f456666656374697665446174653e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e546573743c2f4e616d653e3c50686f6e654e756d6265723e313231203531322d313235313c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e58585858434d534f30303030303030303030303030303036353533363c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031332d30342d31352b30353a33303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031332d30342d31352b30353a33303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e436869726f7072616374696320436c696e69633c2f50726f7669646572547970653e3c4e50493e313536383730393937303c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e313231203431332d313435313c2f50686f6e654e756d6265723e3c4661784e756d6265723e313331203235312d333132313c2f4661784e756d6265723e3c416464726573733e3c416464726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f64653e31323133313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e333235343633323c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c4c6963656e7365496e666f726d6174696f6e2f3e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e546573743c2f4e616d653e3c5469746c653e546573743c2f5469746c653e3c5369676e446174653e323031332d30342d31352b30353a33303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475733e3c4c6963656e7365733e593c2f4c6963656e7365733e3c4e6f6e4578636c7573696f6e3e593c2f4e6f6e4578636c7573696f6e3e3c2f566572696669636174696f6e5374617475733e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313135343332343235393c2f4e50493e3c46756c6c4e616d653e546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3234353233343334333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938322d30312d30312b30353a33303c2f446174654f6642697274683e3c50726f7669646572547970653e436869726f70726163746f723c2f50726f7669646572547970653e3c5374617274446174653e323031312d30312d30312b30353a33303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c47726f75704d656d6265723e3c4e50493e313536383730393937303c2f4e50493e3c46756c6c4e616d653e546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3233343233363433353c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938312d31302d31302b30353a33303c2f446174654f6642697274683e3c50726f7669646572547970653e436869726f70726163746f723c2f50726f7669646572547970653e3c5374617274446174653e323031312d30312d30312b30353a33303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4f776e6572202d203525206f72206d6f7265206f66204f776e65727368697020496e7465726573743c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e546573743c2f46697273744e616d653e3c4d6964646c654e616d653e3c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3332343233353432333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938322d30312d30312b30353a33303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f64653e31323132313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323031312d30312d30312b30353a33303c2f48697265446174653e3c4f74686572496e746572657374496e643e4e3c2f4f74686572496e746572657374496e643e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c466163696c69747943726564656e7469616c732f3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431373a34333a35362e3139312b30353a33303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031332d30342d31355431373a34333a34392e3535372b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e58585858434d534f30303030303030303030303030303036353533363c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431373a34333a35362e3139312b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c4578636c7573696f6e566572696669636174696f6e526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e3332313c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3033302b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3033332b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3535382b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3835312b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3837312b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35302e3138342b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35302e3138342b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c6973743c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35302e3138392b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35332e3131332b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131332b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131332b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35332e3131362b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131352b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131362b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35332e3334392b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3334392b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3334392b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35342e3132382b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35342e3132382b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436342b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35362e3139312b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436342b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35362e3139322b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e7877520007436f6d6d656e74fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c766572537472617465677974001174686973206973206120636f6d6d656e74775300085461736b4e616d65fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c766572537472617465677974001053637265656e696e67205265766965777752000747726f75704964fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c7665725374726174656779740015536572766963652041646d696e6973747261746f72'));
INSERT INTO "WORKITEMINFO" VALUES ('718', TO_TIMESTAMP('2013-04-15 19:07:45.189000','YYYY-MM-DD HH24:MI:SS.FF'), 'Human Task', '323', '0', '1', null); -- HEXTORAW('aced0005777600000000000002ce0000000000000143000a48756d616e205461736b000000000000000500074163746f724964fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567797400007757000c50726f636573734d6f64656cfffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567797372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b78707429693c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73333a456e726f6c6c6d656e7450726f6365737320786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e536572766963652220786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f63657373223e3c6e73333a53657373696f6e49643e3236323c2f6e73333a53657373696f6e49643e3c6e73333a456e726f6c6c6d656e743e3c4f626a65637449643e33323736383c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031332d30352d30312b30353a33303c2f456666656374697665446174653e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e546573743c2f4e616d653e3c50686f6e654e756d6265723e313231203231342d323131323c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e58585858434d534f30303030303030303030303030303036353533363c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031332d30342d31352b30353a33303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031332d30342d31352b30353a33303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73333a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e4269727468696e672043656e7465723c2f50726f7669646572547970653e3c4e50493e313036333431373535383c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e313231203231342d343132313c2f50686f6e654e756d6265723e3c4661784e756d6265723e333132203132312d323135313c2f4661784e756d6265723e3c416464726573733e3c416464726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f64653e31323132313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e323435333433343c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c4c6963656e7365496e666f726d6174696f6e2f3e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74733e3c50726f766964657241677265656d656e743e3c41677265656d656e74446f63756d656e7449643e313c2f41677265656d656e74446f63756d656e7449643e3c41677265656d656e74446f63756d656e74547970653e30313c2f41677265656d656e74446f63756d656e74547970653e3c41677265656d656e74446f63756d656e745469746c653e50726f76696465722041677265656d656e743c2f41677265656d656e74446f63756d656e745469746c653e3c41677265656d656e74446f63756d656e7456657273696f6e3e313c2f41677265656d656e74446f63756d656e7456657273696f6e3e3c4163636570746564446174653e323031332d30342d31352b30353a33303c2f4163636570746564446174653e3c2f50726f766964657241677265656d656e743e3c50726f766964657241677265656d656e743e3c41677265656d656e74446f63756d656e7449643e323c2f41677265656d656e74446f63756d656e7449643e3c41677265656d656e74446f63756d656e74547970653e30323c2f41677265656d656e74446f63756d656e74547970653e3c41677265656d656e74446f63756d656e745469746c653e50726f76696465722041677265656d656e7420416464656e64756d3c2f41677265656d656e74446f63756d656e745469746c653e3c41677265656d656e74446f63756d656e7456657273696f6e3e313c2f41677265656d656e74446f63756d656e7456657273696f6e3e3c4163636570746564446174653e323031332d30342d31352b30353a33303c2f4163636570746564446174653e3c2f50726f766964657241677265656d656e743e3c2f416363657074656441677265656d656e74733e3c50726f766964657253746174656d656e743e3c4e616d653e546573743c2f4e616d653e3c5469746c653e546573743c2f5469746c653e3c5369676e446174653e323031332d30342d31352b30353a33303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74733e3c4174746163686d656e743e3c4f626a65637449643e3236323134363c2f4f626a65637449643e3c4e616d653e42504d3c2f4e616d653e3c4d696d65547970653e6170706c69636174696f6e2f6f637465742d73747265616d3c2f4d696d65547970653e3c2f4174746163686d656e743e3c4174746163686d656e743e3c4f626a65637449643e3236323134373c2f4f626a65637449643e3c4e616d653e42504d3c2f4e616d653e3c4d696d65547970653e6170706c69636174696f6e2f6f637465742d73747265616d3c2f4d696d65547970653e3c2f4174746163686d656e743e3c2f4174746163686564446f63756d656e74733e3c566572696669636174696f6e5374617475733e3c4c6963656e7365733e593c2f4c6963656e7365733e3c4e6f6e4578636c7573696f6e3e593c2f4e6f6e4578636c7573696f6e3e3c2f566572696669636174696f6e5374617475733e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4f776e6572202d203525206f72206d6f7265206f66204f776e65727368697020496e7465726573743c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e546573743c2f46697273744e616d653e3c4d6964646c654e616d653e3c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132333231333132333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938322d30312d30312b30353a33303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f64653e31323132313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323031312d30312d30312b30353a33303c2f48697265446174653e3c4f74686572496e746572657374496e643e4e3c2f4f74686572496e746572657374496e643e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c466163696c69747943726564656e7469616c733e3c4c6963656e73653e3c4f626a65637449643e313c2f4f626a65637449643e3c4f626a656374547970653e4c3c2f4f626a656374547970653e3c4c6963656e7365547970653e42697274682043656e746572206c6963656e73652066726f6d20746865204d4e204465706172746d656e74206f66204865616c74683c2f4c6963656e7365547970653e3c4c6963656e73654e756d6265723e313233313233323c2f4c6963656e73654e756d6265723e3c4f726967696e616c4973737565446174653e323031312d30312d30312b30353a33303c2f4f726967696e616c4973737565446174653e3c52656e6577616c446174653e323031342d30312d30312b30353a33303c2f52656e6577616c446174653e3c49737375696e6753746174653e4d4e3c2f49737375696e6753746174653e3c4174746163686d656e744f626a65637449643e3236323134363c2f4174746163686d656e744f626a65637449643e3c2f4c6963656e73653e3c4c6963656e73653e3c4f626a65637449643e323c2f4f626a65637449643e3c4f626a656374547970653e4c3c2f4f626a656374547970653e3c4c6963656e73654e756d6265723e3332343332343c2f4c6963656e73654e756d6265723e3c4f726967696e616c4973737565446174653e323031312d30312d30312b30353a33303c2f4f726967696e616c4973737565446174653e3c52656e6577616c446174653e323031342d30312d30312b30353a33303c2f52656e6577616c446174653e3c49737375696e6753746174653e4d4e3c2f49737375696e6753746174653e3c4174746163686d656e744f626a65637449643e3236323134373c2f4174746163686d656e744f626a65637449643e3c2f4c6963656e73653e3c2f466163696c69747943726564656e7469616c733e3c43617465676f726965734f66536572766963652f3e3c2f6e73333a50726f7669646572496e666f726d6174696f6e3e3c2f6e73333a456e726f6c6c6d656e743e3c6e73333a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431393a30373a34352e3138382b30353a33303c2f537461747573446174653e3c2f6e73333a456e726f6c6c6d656e745374617475733e3c6e73333a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031332d30342d31355431393a30373a34312e3232352b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e58585858434d534f30303030303030303030303030303036353533363c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431393a30373a34352e3138382b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73333a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73333a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73333a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73333a50726f63657373526573756c74733e3c6e73333a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73333a56616c69646174696f6e526573756c743e3c6e73333a53637265656e696e67526573756c74733e3c6e73333a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73333a4175746f6d6174696353637265656e696e675374617475733e3c6e73333a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c4578636c7573696f6e566572696669636174696f6e526573756c742f3e3c2f6e73333a53637265656e696e67526573756c743e3c6e73333a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73333a53637265656e696e67526573756c743e3c2f6e73333a53637265656e696e67526573756c74733e3c2f6e73333a50726f63657373526573756c74733e3c6e73333a50726f6365737341756469743e3c6e73333a50726f63657373496e7374616e636549643e3332333c2f6e73333a50726f63657373496e7374616e636549643e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e303c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e537461727450726f636573733c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34302e3736312b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e313c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e50726550726f636573733c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34302e3736342b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e323c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e56616c69646174653c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3232362b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e333c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3531332b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e343c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3531372b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34312e3833372b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3833372b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e353c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c6973743c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3834322b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34342e3031322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031322b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e363c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031322b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34342e3031342b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031342b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e373c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e5665726966792053534e3c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031352b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34342e3232342b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3232342b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e383c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3232342b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3430312b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e31303c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3430312b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e31313c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34352e3138382b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e31323c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34352e3138392b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c2f6e73333a50726f6365737341756469743e3c2f6e73333a456e726f6c6c6d656e7450726f636573733e7877520007436f6d6d656e74fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c766572537472617465677974001174686973206973206120636f6d6d656e74775300085461736b4e616d65fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c766572537472617465677974001053637265656e696e67205265766965777752000747726f75704964fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c7665725374726174656779740015536572766963652041646d696e6973747261746f72'));
COMMIT;

-- ----------------------------
--  Table structure for "EMAIL_HEADER"
-- ----------------------------
CREATE TABLE "EMAIL_HEADER" (   "ID" NUMBER(19,0) NOT NULL, "BODY" CLOB, "FROMADDRESS" VARCHAR2(255CHAR), "LANGUAGE" VARCHAR2(255CHAR), "REPLYTOADDRESS" VARCHAR2(255CHAR), "SUBJECT" VARCHAR2(255CHAR));

-- ----------------------------
--  Table structure for "LU_RELATIONSHIP_TYP"
-- ----------------------------
CREATE TABLE "LU_RELATIONSHIP_TYP" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "LU_RELATIONSHIP_TYP"
-- ----------------------------
INSERT INTO "LU_RELATIONSHIP_TYP" VALUES ('01', 'Spouse');
INSERT INTO "LU_RELATIONSHIP_TYP" VALUES ('02', 'Child');
INSERT INTO "LU_RELATIONSHIP_TYP" VALUES ('03', 'Parent');
INSERT INTO "LU_RELATIONSHIP_TYP" VALUES ('04', 'Sibling');
COMMIT;

-- ----------------------------
--  Table structure for "LU_RISK_LEVEL"
-- ----------------------------
CREATE TABLE "LU_RISK_LEVEL" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "SORT_IDX" NUMBER(10,0), "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "LU_RISK_LEVEL"
-- ----------------------------
INSERT INTO "LU_RISK_LEVEL" VALUES ('01', '1', 'Limited');
INSERT INTO "LU_RISK_LEVEL" VALUES ('02', '2', 'Moderate');
INSERT INTO "LU_RISK_LEVEL" VALUES ('03', '3', 'High');
COMMIT;

-- ----------------------------
--  Table structure for "CMS_SEQUENCE"
-- ----------------------------
CREATE TABLE "CMS_SEQUENCE" (   "SEQ_NAME" VARCHAR2(255BYTE) NOT NULL, "NEXT_HI" NUMBER(19,0));

-- ----------------------------
--  Records of "CMS_SEQUENCE"
-- ----------------------------
INSERT INTO "CMS_SEQUENCE" VALUES ('CMS_USER_SEQ', '3');
INSERT INTO "CMS_SEQUENCE" VALUES ('ATTACHMENT_SEQ', '9');
INSERT INTO "CMS_SEQUENCE" VALUES ('AUDIT_ID', '3');
INSERT INTO "CMS_SEQUENCE" VALUES ('AUDIT_DETAIL_ID', '3');
INSERT INTO "CMS_SEQUENCE" VALUES ('TICKET_SEQ', '2');
INSERT INTO "CMS_SEQUENCE" VALUES ('PROFILE_SEQ', '2');
INSERT INTO "CMS_SEQUENCE" VALUES ('ADDRESS_SEQ', '2');
INSERT INTO "CMS_SEQUENCE" VALUES ('CONTACT_INFO_SEQ', '2');
INSERT INTO "CMS_SEQUENCE" VALUES ('ENTITY_SEQ', '2');
INSERT INTO "CMS_SEQUENCE" VALUES ('DESIGNATED_CONTACT_SEQ', '2');
INSERT INTO "CMS_SEQUENCE" VALUES ('PROV_GRP_SEQ', '1');
INSERT INTO "CMS_SEQUENCE" VALUES ('STATEMENT_ID', '2');
INSERT INTO "CMS_SEQUENCE" VALUES ('OWNERSHIP_SEQ', '2');
INSERT INTO "CMS_SEQUENCE" VALUES ('BEN_OWNER_SEQ', '2');
INSERT INTO "CMS_SEQUENCE" VALUES ('LICENSE_SEQ', '1');
INSERT INTO "CMS_SEQUENCE" VALUES ('AGREEMENT_SEQ', '1');
COMMIT;

-- ----------------------------
--  Table structure for "ATTACHMENT"
-- ----------------------------
CREATE TABLE "ATTACHMENT" (   "ID" NUMBER(19,0) NOT NULL, "ACCESSTYPE" NUMBER(10,0), "ATTACHEDAT" TIMESTAMP(6) NULL, "ATTACHMENTCONTENTID" NUMBER(19,0) NOT NULL, "CONTENTTYPE" VARCHAR2(255CHAR), "NAME" VARCHAR2(255CHAR), "ATTACHMENT_SIZE" NUMBER(10,0), "ATTACHEDBY_ID" VARCHAR2(255CHAR), "TASKDATA_ATTACHMENTS_ID" NUMBER(19,0));

-- ----------------------------
--  Table structure for "PROFILE_NOTES"
-- ----------------------------
CREATE TABLE "PROFILE_NOTES" (   "PROVIDER_NOTE_ID" NUMBER(19,0) NOT NULL, "PROFILE_ID" NUMBER(19,0), "TICKET_ID" NUMBER(19,0), "NOTE_TXT" VARCHAR2(255CHAR), "CREATED_BY" VARCHAR2(255CHAR), "CREATE_TS" DATE);

-- ----------------------------
--  Table structure for "LU_DEGREE"
-- ----------------------------
CREATE TABLE "LU_DEGREE" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "LU_DEGREE"
-- ----------------------------
INSERT INTO "LU_DEGREE" VALUES ('D1', 'MASTERS');
INSERT INTO "LU_DEGREE" VALUES ('D2', 'DOCTORATE');
COMMIT;

-- ----------------------------
--  Table structure for "LU_BEN_OWNER_TYP"
-- ----------------------------
CREATE TABLE "LU_BEN_OWNER_TYP" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR), "OWNER_TYPE" CHAR(1BYTE));

-- ----------------------------
--  Records of "LU_BEN_OWNER_TYP"
-- ----------------------------
INSERT INTO "LU_BEN_OWNER_TYP" VALUES ('05', 'Program Manager', 'P');
INSERT INTO "LU_BEN_OWNER_TYP" VALUES ('06', 'Managing Director', 'P');
INSERT INTO "LU_BEN_OWNER_TYP" VALUES ('01', 'Subcontractor', 'A');
INSERT INTO "LU_BEN_OWNER_TYP" VALUES ('02', 'Managing Employee', 'P');
INSERT INTO "LU_BEN_OWNER_TYP" VALUES ('03', 'Owner - 5% or more of Ownership Interest', 'A');
INSERT INTO "LU_BEN_OWNER_TYP" VALUES ('04', 'Board Member or Officer', 'P');
INSERT INTO "LU_BEN_OWNER_TYP" VALUES ('99', 'Other', 'A');
COMMIT;

-- ----------------------------
--  Table structure for "PEOPLEASSIGNMENTS_EXCLOWNERS"
-- ----------------------------
CREATE TABLE "PEOPLEASSIGNMENTS_EXCLOWNERS" (   "TASK_ID" NUMBER(19,0) NOT NULL, "ENTITY_ID" VARCHAR2(255CHAR) NOT NULL);

-- ----------------------------
--  Table structure for "PROCESSINSTANCEINFO"
-- ----------------------------
CREATE TABLE "PROCESSINSTANCEINFO" (   "INSTANCEID" NUMBER(19,0) NOT NULL, "OPTLOCK" NUMBER(10,0), "PROCESSID" VARCHAR2(255CHAR), "STARTDATE" TIMESTAMP(6) NULL, "LASTREADDATE" TIMESTAMP(6) NULL, "LASTMODIFICATIONDATE" TIMESTAMP(6) NULL, "STATE" NUMBER(10,0) NOT NULL, "PROCESSINSTANCEBYTEARRAY" BLOB);

-- ----------------------------
--  Records of "PROCESSINSTANCEINFO"
-- ----------------------------
// PROCESSINSTANCEBYTEARRAY removed
INSERT INTO "PROCESSINSTANCEINFO" VALUES ('321', '1', 'gov.medicaid.process.enrollment', TO_TIMESTAMP('2013-04-15 17:43:48.952000','YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2013-04-15 17:43:48.984000','YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2013-04-15 17:43:58.280000','YYYY-MM-DD HH24:MI:SS.FF'), '1', null); -- HEXTORAW('aced00057a00000400000852756c65466c6f770a060805100418004ab751080012436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567791aed50aced0005737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a6578700000000177040000000a7372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b78707425723c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733d22687474703a2f2f676f762e6d656469636169642e73686172657a00000400642f456e7469746965732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e3236313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031332d30352d30312b30353a33303c2f456666656374697665446174653e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e546573743c2f4e616d653e3c50686f6e654e756d6265723e313231203531322d313235313c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e58585858434d534f30303030303030303030303030303036353533363c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031332d30342d31352b30353a33303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031332d30342d31352b30353a33303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e436869726f7072616374696320436c696e69633c2f50726f7669646572547970653e3c4e50493e313536383730393937303c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e313231203431332d313435313c2f50686f6e654e756d6265723e3c4661784e756d6265723e313331203235312d333132313c2f4661784e756d6265723e3c416464726573733e3c416464726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f647a00000400653e31323133313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e333235343633323c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c4c6963656e7365496e666f726d6174696f6e2f3e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e546573743c2f4e616d653e3c5469746c653e546573743c2f5469746c653e3c5369676e446174653e323031332d30342d31352b30353a33303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475733e3c4c6963656e7365733e593c2f4c6963656e7365733e3c4e6f6e4578636c7573696f6e3e593c2f4e6f6e4578636c7573696f6e3e3c2f566572696669636174696f6e5374617475733e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313135343332343235393c2f4e50493e3c46756c6c4e616d653e546573743c2f46756c6c4e616d657a000004003e3c536f6369616c53656375726974794e756d6265723e3234353233343334333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938322d30312d30312b30353a33303c2f446174654f6642697274683e3c50726f7669646572547970653e436869726f70726163746f723c2f50726f7669646572547970653e3c5374617274446174653e323031312d30312d30312b30353a33303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c47726f75704d656d6265723e3c4e50493e313536383730393937303c2f4e50493e3c46756c6c4e616d653e546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3233343233363433353c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938312d31302d31302b30353a33303c2f446174654f6642697274683e3c50726f7669646572547970653e436869726f70726163746f723c2f50726f7669646572547970653e3c5374617274446174653e323031312d30312d30312b30353a33303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4f776e6572202d203525206f72206d6f7265206f66204f776e65727368697020496e7465726573743c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e546573743c2f46697273744e616d653e3c4d6964646c654e616d653e3c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3332343233353432333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938322d30312d30312b30353a33303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c4164647a00000400726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f64653e31323132313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323031312d30312d30312b30353a33303c2f48697265446174653e3c4f74686572496e746572657374496e643e4e3c2f4f74686572496e746572657374496e643e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c466163696c69747943726564656e7469616c732f3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431373a34333a35362e3139312b30353a33303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031332d30342d31355431373a34333a34392e3535372b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e58585858434d534f30303030303030303030303030303036353533363c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431373a34333a35362e3139312b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e745374617475737a00000400486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c4578636c7573696f6e566572696669636174696f6e526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e7a000004003c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e3332313c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3033302b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3033332b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3535382b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3835312b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e347a0000040036352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a34392e3837312b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35302e3138342b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35302e3138342b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c6973743c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35302e3138392b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35332e3131332b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131332b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c7a000004002f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131332b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35332e3131362b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131352b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3131362b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35332e3334392b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3334392b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e7a0000040073323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35332e3334392b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35342e3132382b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436352b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35342e3132382b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436342b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35362e3139312b30353a33303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031332d30342d31355431373a34333a35372e3436342b30353a33303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73327a000001203a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031332d30342d31355431373a34333a35362e3139322b30353a33303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e787852520a0852756c65466c6f7710c1021a1f676f762e6d656469636169642e70726f636573732e656e726f6c6c6d656e742001280d3a0d080c1003220708011a0308c505420f0a056d6f64656c10001a0400000000'));
INSERT INTO "PROCESSINSTANCEINFO" VALUES ('323', '1', 'gov.medicaid.process.enrollment', TO_TIMESTAMP('2013-04-15 19:07:40.702000','YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2013-04-15 19:07:40.710000','YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2013-04-15 19:07:46.519000','YYYY-MM-DD HH24:MI:SS.FF'), '1', null); -- HEXTORAW('aced00057a00000400000852756c65466c6f770a060805100418004aae59080012436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567791ae458aced0005737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a6578700000000177040000000a7372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b78707429693c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73333a456e726f6c6c6d656e7450726f6365737320786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e536572766963652220786d6c6e733d22687474703a2f2f676f762e6d657a000004006469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f63657373223e3c6e73333a53657373696f6e49643e3236323c2f6e73333a53657373696f6e49643e3c6e73333a456e726f6c6c6d656e743e3c4f626a65637449643e33323736383c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031332d30352d30312b30353a33303c2f456666656374697665446174653e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e546573743c2f4e616d653e3c50686f6e654e756d6265723e313231203231342d323131323c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e58585858434d534f30303030303030303030303030303036353533363c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031332d30342d31352b30353a33303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031332d30342d31352b30353a33303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73333a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e4269727468696e672043656e7465723c2f50726f7669646572547970653e3c4e50493e313036333431373535383c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e313231203231342d343132313c2f50686f6e654e756d6265723e3c4661784e756d6265723e333132203132312d323135313c2f4661784e756d6265723e3c416464726573733e3c416464726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f647a00000400653e31323132313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e323435333433343c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c4c6963656e7365496e666f726d6174696f6e2f3e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74733e3c50726f766964657241677265656d656e743e3c41677265656d656e74446f63756d656e7449643e313c2f41677265656d656e74446f63756d656e7449643e3c41677265656d656e74446f63756d656e74547970653e30313c2f41677265656d656e74446f63756d656e74547970653e3c41677265656d656e74446f63756d656e745469746c653e50726f76696465722041677265656d656e743c2f41677265656d656e74446f63756d656e745469746c653e3c41677265656d656e74446f63756d656e7456657273696f6e3e313c2f41677265656d656e74446f63756d656e7456657273696f6e3e3c4163636570746564446174653e323031332d30342d31352b30353a33303c2f4163636570746564446174653e3c2f50726f766964657241677265656d656e743e3c50726f767a000004006964657241677265656d656e743e3c41677265656d656e74446f63756d656e7449643e323c2f41677265656d656e74446f63756d656e7449643e3c41677265656d656e74446f63756d656e74547970653e30323c2f41677265656d656e74446f63756d656e74547970653e3c41677265656d656e74446f63756d656e745469746c653e50726f76696465722041677265656d656e7420416464656e64756d3c2f41677265656d656e74446f63756d656e745469746c653e3c41677265656d656e74446f63756d656e7456657273696f6e3e313c2f41677265656d656e74446f63756d656e7456657273696f6e3e3c4163636570746564446174653e323031332d30342d31352b30353a33303c2f4163636570746564446174653e3c2f50726f766964657241677265656d656e743e3c2f416363657074656441677265656d656e74733e3c50726f766964657253746174656d656e743e3c4e616d653e546573743c2f4e616d653e3c5469746c653e546573743c2f5469746c653e3c5369676e446174653e323031332d30342d31352b30353a33303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74733e3c4174746163686d656e743e3c4f626a65637449643e3236323134363c2f4f626a65637449643e3c4e616d653e42504d3c2f4e616d653e3c4d696d65547970653e6170706c69636174696f6e2f6f637465742d73747265616d3c2f4d696d65547970653e3c2f4174746163686d656e743e3c4174746163686d656e743e3c4f626a65637449643e3236323134373c2f4f626a65637449643e3c4e616d653e42504d3c2f4e616d653e3c4d696d65547970653e6170706c69636174696f6e2f6f637465742d73747265616d3c2f4d696d65547970653e3c2f4174746163686d656e743e3c2f4174746163686564446f63756d656e74733e3c566572696669636174696f6e5374617475733e3c4c6963656e7365733e593c2f4c6963656e7365733e3c4e6f6e4578636c7573696f6e3e593c2f4e6f6e4578636c7573696f6e3e3c2f566572696669636174696f6e5374617475733e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4f776e6572202d203525206f72206d6f7265206f66204f776e65727368697020496e7465726573743c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f74686572427a00000400656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e546573743c2f46697273744e616d653e3c4d6964646c654e616d653e3c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132333231333132333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313938322d30312d30312b30353a33303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e546573743c2f416464726573734c696e65323e3c436974793e546573743c2f436974793e3c53746174653e4d4e3c2f53746174653e3c5a6970436f64653e31323132313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323031312d30312d30312b30353a33303c2f48697265446174653e3c4f74686572496e746572657374496e643e4e3c2f4f74686572496e746572657374496e643e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c466163696c69747943726564656e7469616c733e3c4c6963656e73653e3c4f626a65637449643e313c2f4f626a65637449643e3c4f626a656374547970653e4c3c2f4f626a656374547970653e3c4c6963656e7365547970653e42697274682043656e746572206c6963656e73652066726f6d20746865204d4e204465706172746d656e74206f66204865616c74683c2f4c6963656e7365547970653e3c4c6963656e73654e756d6265723e313233313233323c2f4c6963656e73654e756d6265723e3c4f726967696e616c4973737565446174653e323031312d30312d30312b30353a33303c2f4f726967696e616c4973737565446174653e3c52656e6577616c446174653e323031342d30312d30312b30353a33303c2f52656e6577616c446174653e3c49737375696e6753746174653e4d4e3c2f49737375696e6753746174653e3c4174746163686d656e744f626a65637449643e3236323134363c2f4174746163686d656e744f626a65637449643e3c2f4c6963656e73653e3c4c6963656e73653e3c4f626a65637449643e323c2f4f626a65637449643e3c4f626a65637454797a0000040070653e4c3c2f4f626a656374547970653e3c4c6963656e73654e756d6265723e3332343332343c2f4c6963656e73654e756d6265723e3c4f726967696e616c4973737565446174653e323031312d30312d30312b30353a33303c2f4f726967696e616c4973737565446174653e3c52656e6577616c446174653e323031342d30312d30312b30353a33303c2f52656e6577616c446174653e3c49737375696e6753746174653e4d4e3c2f49737375696e6753746174653e3c4174746163686d656e744f626a65637449643e3236323134373c2f4174746163686d656e744f626a65637449643e3c2f4c6963656e73653e3c2f466163696c69747943726564656e7469616c733e3c43617465676f726965734f66536572766963652f3e3c2f6e73333a50726f7669646572496e666f726d6174696f6e3e3c2f6e73333a456e726f6c6c6d656e743e3c6e73333a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431393a30373a34352e3138382b30353a33303c2f537461747573446174653e3c2f6e73333a456e726f6c6c6d656e745374617475733e3c6e73333a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031332d30342d31355431393a30373a34312e3232352b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e58585858434d534f30303030303030303030303030303036353533363c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031332d30342d31355431393a30373a34352e3138382b30353a33303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73333a456e726f6c6c6d656e74537461747573486973746f72793e3c7a000004006e73333a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73333a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73333a50726f63657373526573756c74733e3c6e73333a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73333a56616c69646174696f6e526573756c743e3c6e73333a53637265656e696e67526573756c74733e3c6e73333a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73333a4175746f6d6174696353637265656e696e675374617475733e3c6e73333a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c4578636c7573696f6e566572696669636174696f6e526573756c742f3e3c2f6e73333a53637265656e696e67526573756c743e3c6e73333a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73333a53637265656e696e67526573756c743e3c2f6e73333a5363727a0000040065656e696e67526573756c74733e3c2f6e73333a50726f63657373526573756c74733e3c6e73333a50726f6365737341756469743e3c6e73333a50726f63657373496e7374616e636549643e3332333c2f6e73333a50726f63657373496e7374616e636549643e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e303c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e537461727450726f636573733c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34302e3736312b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e313c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e50726550726f636573733c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34302e3736342b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e323c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e56616c69646174653c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3232362b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e333c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3531332b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c7a000004002f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e343c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3531372b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34312e3833372b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3833372b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e353c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c6973743c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34312e3834322b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34342e3031322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031322b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934322b30353a33303c2f6e73333a456e64547a00000400696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e363c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031322b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34342e3031342b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031342b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e373c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e5665726966792053534e3c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3031352b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34342e3232342b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3232342b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f6365737a0000040073457865637574696f6e733e3c6e73333a4f626a65637449643e383c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3232342b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e393c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3430312b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934332b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e31303c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34342e3430312b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449643e31313c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34352e3138382b30353a33303c2f6e73333a537461727454696d653e3c6e73333a456e6454696d653e323031332d30342d31355431393a30373a34352e3934322b30353a33303c2f6e73333a456e6454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c6e73333a50726f63657373457865637574696f6e733e3c6e73333a4f626a65637449647a000001173e31323c2f6e73333a4f626a65637449643e3c6e73333a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73333a50726f636573734e616d653e3c6e73333a537461727454696d653e323031332d30342d31355431393a30373a34352e3138392b30353a33303c2f6e73333a537461727454696d653e3c2f6e73333a50726f63657373457865637574696f6e733e3c2f6e73333a50726f6365737341756469743e3c2f6e73333a456e726f6c6c6d656e7450726f636573733e787852520a0852756c65466c6f7710c3021a1f676f762e6d656469636169642e70726f636573732e656e726f6c6c6d656e742001280d3a0d080c1003220708011a0308ce05420f0a056d6f64656c10001a0400000000'));
COMMIT;


-- ----------------------------
--  Table structure for "DEADLINE"
-- ----------------------------
CREATE TABLE "DEADLINE" (   "ID" NUMBER(19,0) NOT NULL, "DEADLINE_DATE" TIMESTAMP(6) NULL, "ESCALATED" NUMBER(5,0), "DEADLINES_STARTDEADLINE_ID" NUMBER(19,0), "DEADLINES_ENDDEADLINE_ID" NUMBER(19,0));

-- ----------------------------
--  Table structure for "LU_PROFILE_STATUS"
-- ----------------------------
CREATE TABLE "LU_PROFILE_STATUS" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "LU_PROFILE_STATUS"
-- ----------------------------
INSERT INTO "LU_PROFILE_STATUS" VALUES ('01', 'Active');
INSERT INTO "LU_PROFILE_STATUS" VALUES ('02', 'Suspended');
INSERT INTO "LU_PROFILE_STATUS" VALUES ('03', 'Expired');
COMMIT;

-- ----------------------------
--  Table structure for "LU_PAYTO_TYPE"
-- ----------------------------
CREATE TABLE "LU_PAYTO_TYPE" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "LU_PAYTO_TYPE"
-- ----------------------------
INSERT INTO "LU_PAYTO_TYPE" VALUES ('01', 'Claim');
INSERT INTO "LU_PAYTO_TYPE" VALUES ('02', 'ERA');
INSERT INTO "LU_PAYTO_TYPE" VALUES ('03', 'Both');
COMMIT;

-- ----------------------------
--  Table structure for "ESCALATION"
-- ----------------------------
CREATE TABLE "ESCALATION" (   "ID" NUMBER(19,0) NOT NULL, "NAME" VARCHAR2(255CHAR), "DEADLINE_ESCALATION_ID" NUMBER(19,0));

-- ----------------------------
--  Table structure for "OWNERSHIP_INFO"
-- ----------------------------
CREATE TABLE "OWNERSHIP_INFO" (   "OWNERSHIP_INFO_ID" NUMBER(19,0) NOT NULL, "PROFILE_ID" NUMBER(19,0), "TICKET_ID" NUMBER(19,0), "ENTITY_TYP_CD" VARCHAR2(2CHAR), "ENTITY_SUBTYP_CD" VARCHAR2(2CHAR), "OTH_ENTITY_TYP_DESC" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "OWNERSHIP_INFO"
-- ----------------------------
INSERT INTO "OWNERSHIP_INFO" VALUES ('2', '0', '1', '01', null, null);
INSERT INTO "OWNERSHIP_INFO" VALUES ('32769', '0', '32768', '01', null, null);
COMMIT;

-- ----------------------------
--  Table structure for "AUDIT_RECORD"
-- ----------------------------
CREATE TABLE "AUDIT_RECORD" (   "AUDIT_RECORD_ID" NUMBER(19,0) NOT NULL, "USERNAME" VARCHAR2(45CHAR), "AUDIT_TS" TIMESTAMP(6) NULL, "SYSTEM_ID" VARCHAR2(8CHAR));

-- ----------------------------
--  Records of "AUDIT_RECORD"
-- ----------------------------
INSERT INTO "AUDIT_RECORD" VALUES ('3', 'XXXXCMSO00000000000000000003', TO_TIMESTAMP('2013-04-04 23:08:53.790000','YYYY-MM-DD HH24:MI:SS.FF'), 'CMSO');
INSERT INTO "AUDIT_RECORD" VALUES ('4', 'XXXXCMSO00000000000000000004', TO_TIMESTAMP('2013-04-04 23:09:07.484000','YYYY-MM-DD HH24:MI:SS.FF'), 'CMSO');
INSERT INTO "AUDIT_RECORD" VALUES ('32768', 'XXXXCMSO00000000000000032768', TO_TIMESTAMP('2013-04-04 23:11:20.997000','YYYY-MM-DD HH24:MI:SS.FF'), 'CMSO');
INSERT INTO "AUDIT_RECORD" VALUES ('65536', 'XXXXCMSO00000000000000065536', TO_TIMESTAMP('2013-04-08 13:03:12.380000','YYYY-MM-DD HH24:MI:SS.FF'), 'CMSO');
COMMIT;

-- ----------------------------
--  Table structure for "REQUIRED_FLD"
-- ----------------------------
CREATE TABLE "REQUIRED_FLD" (   "CODE" VARCHAR2(2CHAR) NOT NULL, "DESCRIPTION" VARCHAR2(255CHAR), "REQUIRED_FLD_TYPE_ID" VARCHAR2(2CHAR));

-- ----------------------------
--  Table structure for "DELEGATION_DELEGATES"
-- ----------------------------
CREATE TABLE "DELEGATION_DELEGATES" (   "TASK_ID" NUMBER(19,0) NOT NULL, "ENTITY_ID" VARCHAR2(255CHAR) NOT NULL);

-- ----------------------------
--  Table structure for "SCREENING_SCHEDULE"
-- ----------------------------
CREATE TABLE "SCREENING_SCHEDULE" (   "SCREENING_SCHEDULE_ID" NUMBER(19,0) NOT NULL, "UPCOMING_SCREENING_DT" TIMESTAMP(6) NULL, "INTERVAL_TYPE" VARCHAR2(255CHAR), "INTERVAL_VALUE" NUMBER(10,0) DEFAULT 0
    NOT NULL);

-- ----------------------------
--  Records of "SCREENING_SCHEDULE"
-- ----------------------------
INSERT INTO "SCREENING_SCHEDULE" VALUES ('1', null, null, '0');
COMMIT;

-- ----------------------------
--  Table structure for "PROCESSINSTANCELOG"
-- ----------------------------
CREATE TABLE "PROCESSINSTANCELOG" (   "ID" NUMBER(19,0) NOT NULL, "END_DATE" TIMESTAMP(6) NULL, "PROCESSID" VARCHAR2(255CHAR), "PROCESSINSTANCEID" NUMBER(19,0) NOT NULL, "START_DATE" TIMESTAMP(6) NULL);

-- ----------------------------
--  Table structure for "PROVIDER_SETTING"
-- ----------------------------
CREATE TABLE "PROVIDER_SETTING" (   "PROVIDER_SETTING_ID" NUMBER(19,0) NOT NULL, "PROVIDER_TYP_CD" VARCHAR2(255CHAR), "REL_TYP" VARCHAR2(2CHAR), "RELATED_ENTITY_TYP" VARCHAR2(255CHAR), "RELATED_ENTITY_CD" VARCHAR2(255CHAR));

-- ----------------------------
--  Records of "PROVIDER_SETTING"
-- ----------------------------
INSERT INTO "PROVIDER_SETTING" VALUES ('9901', '04', 'BT', 'BeneficialOwnerType', '04');
INSERT INTO "PROVIDER_SETTING" VALUES ('9902', '04', 'BT', 'BeneficialOwnerType', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9903', '04', 'BT', 'BeneficialOwnerType', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9904', '01', 'BT', 'BeneficialOwnerType', '03');
INSERT INTO "PROVIDER_SETTING" VALUES ('9905', '01', 'BT', 'BeneficialOwnerType', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9906', '01', 'BT', 'BeneficialOwnerType', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9907', '05', 'BT', 'BeneficialOwnerType', '04');
INSERT INTO "PROVIDER_SETTING" VALUES ('9908', '05', 'BT', 'BeneficialOwnerType', '03');
INSERT INTO "PROVIDER_SETTING" VALUES ('9909', '05', 'BT', 'BeneficialOwnerType', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9910', '05', 'BT', 'BeneficialOwnerType', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9911', '03', 'BT', 'BeneficialOwnerType', '03');
INSERT INTO "PROVIDER_SETTING" VALUES ('9912', '03', 'BT', 'BeneficialOwnerType', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9914', '02', 'BT', 'BeneficialOwnerType', '03');
INSERT INTO "PROVIDER_SETTING" VALUES ('9915', '02', 'BT', 'BeneficialOwnerType', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9916', '02', 'BT', 'BeneficialOwnerType', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9917', '06', 'BT', 'BeneficialOwnerType', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9918', '06', 'BT', 'BeneficialOwnerType', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9919', '07', 'BT', 'BeneficialOwnerType', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9920', '07', 'BT', 'BeneficialOwnerType', '05');
INSERT INTO "PROVIDER_SETTING" VALUES ('9921', '07', 'BT', 'BeneficialOwnerType', '06');
INSERT INTO "PROVIDER_SETTING" VALUES ('5401', '54', 'RA', 'AgreementDocument', '03');
INSERT INTO "PROVIDER_SETTING" VALUES ('5901', '59', 'LO', 'LicenseType', 'AN');
INSERT INTO "PROVIDER_SETTING" VALUES ('6101', '61', 'LO', 'LicenseType', 'A1');
INSERT INTO "PROVIDER_SETTING" VALUES ('6102', '61', 'LO', 'LicenseType', 'A2');
INSERT INTO "PROVIDER_SETTING" VALUES ('6103', '61', 'LO', 'LicenseType', 'A3');
INSERT INTO "PROVIDER_SETTING" VALUES ('6104', '61', 'LO', 'LicenseType', 'A4');
INSERT INTO "PROVIDER_SETTING" VALUES ('6105', '61', 'LO', 'LicenseType', 'A5');
INSERT INTO "PROVIDER_SETTING" VALUES ('6106', '61', 'LO', 'LicenseType', 'A6');
INSERT INTO "PROVIDER_SETTING" VALUES ('6107', '61', 'LO', 'LicenseType', 'A7');
INSERT INTO "PROVIDER_SETTING" VALUES ('6108', '61', 'LO', 'LicenseType', 'A8');
INSERT INTO "PROVIDER_SETTING" VALUES ('6109', '61', 'LO', 'LicenseType', 'A9');
INSERT INTO "PROVIDER_SETTING" VALUES ('6110', '61', 'LO', 'LicenseType', 'A0');
INSERT INTO "PROVIDER_SETTING" VALUES ('6111', '61', 'LO', 'LicenseType', 'AA');
INSERT INTO "PROVIDER_SETTING" VALUES ('6112', '61', 'LO', 'LicenseType', 'AB');
INSERT INTO "PROVIDER_SETTING" VALUES ('6113', '61', 'LO', 'LicenseType', 'AC');
INSERT INTO "PROVIDER_SETTING" VALUES ('6114', '61', 'LO', 'LicenseType', 'AD');
INSERT INTO "PROVIDER_SETTING" VALUES ('6115', '61', 'LO', 'LicenseType', 'AE');
INSERT INTO "PROVIDER_SETTING" VALUES ('6116', '61', 'LO', 'LicenseType', 'AF');
INSERT INTO "PROVIDER_SETTING" VALUES ('6117', '61', 'LO', 'LicenseType', 'AG');
INSERT INTO "PROVIDER_SETTING" VALUES ('6118', '61', 'LO', 'LicenseType', 'AH');
INSERT INTO "PROVIDER_SETTING" VALUES ('6119', '61', 'LO', 'LicenseType', 'AI');
INSERT INTO "PROVIDER_SETTING" VALUES ('6120', '61', 'LO', 'LicenseType', 'AJ');
INSERT INTO "PROVIDER_SETTING" VALUES ('6121', '61', 'LO', 'LicenseType', 'AK');
INSERT INTO "PROVIDER_SETTING" VALUES ('6122', '61', 'LO', 'LicenseType', 'AL');
INSERT INTO "PROVIDER_SETTING" VALUES ('6123', '61', 'LO', 'LicenseType', 'AM');
INSERT INTO "PROVIDER_SETTING" VALUES ('6501', '65', 'LO', 'LicenseType', 'AO');
INSERT INTO "PROVIDER_SETTING" VALUES ('6502', '65', 'LO', 'LicenseType', 'AP');
INSERT INTO "PROVIDER_SETTING" VALUES ('6601', '66', 'LO', 'LicenseType', 'AQ');
INSERT INTO "PROVIDER_SETTING" VALUES ('6602', '66', 'LO', 'LicenseType', 'AR');
INSERT INTO "PROVIDER_SETTING" VALUES ('6701', '67', 'LO', 'LicenseType', 'AV');
INSERT INTO "PROVIDER_SETTING" VALUES ('6702', '67', 'LO', 'LicenseType', 'AR');
INSERT INTO "PROVIDER_SETTING" VALUES ('6703', '67', 'LO', 'LicenseType', 'AW');
INSERT INTO "PROVIDER_SETTING" VALUES ('6704', '67', 'LO', 'LicenseType', 'AX');
INSERT INTO "PROVIDER_SETTING" VALUES ('6901', '69', 'LO', 'LicenseType', 'AO');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000003', '03', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000004', '04', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000005', '05', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000006', '06', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000007', '07', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000008', '08', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000009', '09', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000010', '10', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000011', '11', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000012', '12', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000013', '13', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000014', '14', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000015', '15', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000016', '16', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000017', '17', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000018', '18', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000019', '19', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000020', '20', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000021', '21', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000022', '22', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000023', '23', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000024', '24', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000025', '25', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000026', '26', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000027', '27', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000028', '28', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000029', '29', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000030', '30', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000031', '31', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000032', '32', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000033', '33', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000034', '34', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000035', '35', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000036', '36', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000037', '37', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000038', '38', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000039', '39', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000040', '40', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000041', '41', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000042', '42', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000043', '43', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000044', '44', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000045', '45', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000046', '46', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000047', '47', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000048', '48', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000049', '49', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000050', '50', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000051', '51', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000052', '52', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000053', '53', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000054', '54', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000055', '55', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000056', '56', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000057', '57', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000058', '58', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000059', '59', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000060', '60', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000061', '61', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000062', '62', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000063', '63', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000064', '64', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000065', '65', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000066', '66', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000067', '67', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000068', '68', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000069', '69', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000070', '70', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000071', '71', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000072', '72', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000073', '73', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9000074', '74', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100003', '03', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100004', '04', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100005', '05', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100006', '06', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100007', '07', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100008', '08', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100009', '09', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100010', '10', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100011', '11', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100012', '12', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100013', '13', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100014', '14', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100015', '15', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100016', '16', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100017', '17', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100018', '18', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100019', '19', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100020', '20', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100021', '21', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100022', '22', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100023', '23', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100024', '24', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100025', '25', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100026', '26', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100027', '27', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100028', '28', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100029', '29', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100030', '30', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100031', '31', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100032', '32', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100033', '33', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100034', '34', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100035', '35', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100036', '36', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100037', '37', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100038', '38', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100039', '39', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100040', '40', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100041', '41', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100042', '42', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100043', '43', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100044', '44', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100045', '45', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100046', '46', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100047', '47', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100048', '48', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100049', '49', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100050', '50', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100051', '51', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100052', '52', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100053', '53', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100054', '54', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100055', '55', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100056', '56', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100057', '57', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100058', '58', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100059', '59', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100060', '60', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100061', '61', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100062', '62', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100063', '63', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100064', '64', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100065', '65', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100066', '66', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100067', '67', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100068', '68', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100069', '69', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100070', '70', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100071', '71', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100072', '72', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100073', '73', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100074', '74', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('2403', '24', 'SO', 'SpecialtyType', 'S3');
INSERT INTO "PROVIDER_SETTING" VALUES ('2404', '24', 'SB', 'IssuingBoard', 'B3');
INSERT INTO "PROVIDER_SETTING" VALUES ('1', '01', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('2', '01', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('3', '02', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('4', '02', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('101', '01', 'LO', 'LicenseType', 'L1');
INSERT INTO "PROVIDER_SETTING" VALUES ('102', '01', 'LO', 'LicenseType', 'L2');
INSERT INTO "PROVIDER_SETTING" VALUES ('103', '01', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('104', '01', 'LS', 'StateType', 'XX');
INSERT INTO "PROVIDER_SETTING" VALUES ('201', '02', 'LO', 'LicenseType', 'L3');
INSERT INTO "PROVIDER_SETTING" VALUES ('202', '02', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('301', '03', 'LO', 'LicenseType', 'L4');
INSERT INTO "PROVIDER_SETTING" VALUES ('302', '03', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('303', '03', 'SO', 'SpecialtyType', 'S1');
INSERT INTO "PROVIDER_SETTING" VALUES ('304', '03', 'SB', 'IssuingBoard', 'B1');
INSERT INTO "PROVIDER_SETTING" VALUES ('401', '04', 'LO', 'LicenseType', 'L5');
INSERT INTO "PROVIDER_SETTING" VALUES ('402', '04', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('501', '05', 'LO', 'LicenseType', 'L6');
INSERT INTO "PROVIDER_SETTING" VALUES ('502', '05', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('503', '05', 'SO', 'SpecialtyType', 'S2');
INSERT INTO "PROVIDER_SETTING" VALUES ('504', '05', 'SB', 'IssuingBoard', 'B2');
INSERT INTO "PROVIDER_SETTING" VALUES ('601', '06', 'LO', 'LicenseType', 'L7');
INSERT INTO "PROVIDER_SETTING" VALUES ('602', '06', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('701', '07', 'LO', 'LicenseType', 'L4');
INSERT INTO "PROVIDER_SETTING" VALUES ('702', '07', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('703', '07', 'SO', 'SpecialtyType', 'S3');
INSERT INTO "PROVIDER_SETTING" VALUES ('704', '07', 'SB', 'IssuingBoard', 'B3');
INSERT INTO "PROVIDER_SETTING" VALUES ('801', '08', 'LO', 'LicenseType', 'L8');
INSERT INTO "PROVIDER_SETTING" VALUES ('802', '08', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('901', '09', 'LO', 'LicenseType', 'L9');
INSERT INTO "PROVIDER_SETTING" VALUES ('902', '09', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('1001', '10', 'LO', 'LicenseType', 'L0');
INSERT INTO "PROVIDER_SETTING" VALUES ('1002', '10', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('1101', '11', 'LO', 'LicenseType', 'M1');
INSERT INTO "PROVIDER_SETTING" VALUES ('1102', '11', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('1201', '12', 'LO', 'LicenseType', 'L4');
INSERT INTO "PROVIDER_SETTING" VALUES ('1202', '12', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('1203', '12', 'SO', 'SpecialtyType', 'S3');
INSERT INTO "PROVIDER_SETTING" VALUES ('1204', '12', 'SB', 'IssuingBoard', 'B3');
INSERT INTO "PROVIDER_SETTING" VALUES ('1301', '13', 'LO', 'LicenseType', 'M2');
INSERT INTO "PROVIDER_SETTING" VALUES ('1302', '13', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('1303', '13', 'SO', 'SpecialtyType', 'S3');
INSERT INTO "PROVIDER_SETTING" VALUES ('1304', '13', 'SO', 'SpecialtyType', 'S4');
INSERT INTO "PROVIDER_SETTING" VALUES ('1305', '13', 'SO', 'SpecialtyType', 'S5');
INSERT INTO "PROVIDER_SETTING" VALUES ('1306', '13', 'SO', 'SpecialtyType', 'S6');
INSERT INTO "PROVIDER_SETTING" VALUES ('1307', '13', 'SB', 'IssuingBoard', 'B4');
INSERT INTO "PROVIDER_SETTING" VALUES ('1401', '14', 'LO', 'LicenseType', 'M3');
INSERT INTO "PROVIDER_SETTING" VALUES ('1402', '14', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('1501', '15', 'LO', 'LicenseType', 'L4');
INSERT INTO "PROVIDER_SETTING" VALUES ('1502', '15', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('1601', '16', 'LO', 'LicenseType', 'M4');
INSERT INTO "PROVIDER_SETTING" VALUES ('1602', '16', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('1701', '17', 'LO', 'LicenseType', 'M5');
INSERT INTO "PROVIDER_SETTING" VALUES ('1702', '17', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('1801', '18', 'LO', 'LicenseType', 'M6');
INSERT INTO "PROVIDER_SETTING" VALUES ('1802', '18', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('1901', '19', 'LO', 'LicenseType', 'M7');
INSERT INTO "PROVIDER_SETTING" VALUES ('1902', '19', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('2001', '20', 'LO', 'LicenseType', 'M8');
INSERT INTO "PROVIDER_SETTING" VALUES ('2002', '20', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('2101', '21', 'LO', 'LicenseType', 'M9');
INSERT INTO "PROVIDER_SETTING" VALUES ('2102', '21', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('2103', '21', 'SO', 'SpecialtyType', 'D1');
INSERT INTO "PROVIDER_SETTING" VALUES ('2104', '21', 'SO', 'SpecialtyType', 'D2');
INSERT INTO "PROVIDER_SETTING" VALUES ('2105', '21', 'SO', 'SpecialtyType', 'D3');
INSERT INTO "PROVIDER_SETTING" VALUES ('2106', '21', 'SO', 'SpecialtyType', 'D4');
INSERT INTO "PROVIDER_SETTING" VALUES ('2107', '21', 'SO', 'SpecialtyType', 'D5');
INSERT INTO "PROVIDER_SETTING" VALUES ('2108', '21', 'SO', 'SpecialtyType', 'D6');
INSERT INTO "PROVIDER_SETTING" VALUES ('2109', '21', 'SB', 'IssuingBoard', 'B5');
INSERT INTO "PROVIDER_SETTING" VALUES ('2201', '22', 'LO', 'LicenseType', 'M0');
INSERT INTO "PROVIDER_SETTING" VALUES ('2202', '22', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('2301', '23', 'LO', 'LicenseType', 'N1');
INSERT INTO "PROVIDER_SETTING" VALUES ('2302', '23', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('2401', '24', 'LO', 'LicenseType', 'N2');
INSERT INTO "PROVIDER_SETTING" VALUES ('2402', '24', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('2501', '25', 'LO', 'LicenseType', 'L4');
INSERT INTO "PROVIDER_SETTING" VALUES ('2502', '25', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('2503', '25', 'SO', 'SpecialtyType', 'S2');
INSERT INTO "PROVIDER_SETTING" VALUES ('2504', '25', 'SB', 'IssuingBoard', 'B2');
INSERT INTO "PROVIDER_SETTING" VALUES ('2601', '26', 'LO', 'LicenseType', 'N3');
INSERT INTO "PROVIDER_SETTING" VALUES ('2602', '26', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('2701', '27', 'LO', 'LicenseType', 'N4');
INSERT INTO "PROVIDER_SETTING" VALUES ('2702', '27', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('2703', '27', 'SO', 'SpecialtyType', 'P1');
INSERT INTO "PROVIDER_SETTING" VALUES ('2801', '28', 'LO', 'LicenseType', 'N5');
INSERT INTO "PROVIDER_SETTING" VALUES ('2802', '28', 'LS', 'StateType', 'MN');
INSERT INTO "PROVIDER_SETTING" VALUES ('2803', '28', 'SB', 'IssuingBoard', 'B6');
INSERT INTO "PROVIDER_SETTING" VALUES ('2804', '28', 'SB', 'IssuingBoard', 'B7');
INSERT INTO "PROVIDER_SETTING" VALUES ('2805', '28', 'SO', 'SpecialtyType', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('2806', '28', 'SO', 'SpecialtyType', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('2807', '28', 'SO', 'SpecialtyType', '03');
INSERT INTO "PROVIDER_SETTING" VALUES ('2808', '28', 'SO', 'SpecialtyType', '04');
INSERT INTO "PROVIDER_SETTING" VALUES ('2809', '28', 'SO', 'SpecialtyType', '05');
INSERT INTO "PROVIDER_SETTING" VALUES ('2810', '28', 'SO', 'SpecialtyType', '06');
INSERT INTO "PROVIDER_SETTING" VALUES ('2811', '28', 'SO', 'SpecialtyType', '07');
INSERT INTO "PROVIDER_SETTING" VALUES ('2812', '28', 'SO', 'SpecialtyType', '08');
INSERT INTO "PROVIDER_SETTING" VALUES ('2813', '28', 'SO', 'SpecialtyType', '09');
INSERT INTO "PROVIDER_SETTING" VALUES ('2814', '28', 'SO', 'SpecialtyType', '10');
INSERT INTO "PROVIDER_SETTING" VALUES ('2815', '28', 'SO', 'SpecialtyType', '11');
INSERT INTO "PROVIDER_SETTING" VALUES ('2816', '28', 'SO', 'SpecialtyType', '12');
INSERT INTO "PROVIDER_SETTING" VALUES ('2817', '28', 'SO', 'SpecialtyType', '13');
INSERT INTO "PROVIDER_SETTING" VALUES ('2818', '28', 'SO', 'SpecialtyType', '14');
INSERT INTO "PROVIDER_SETTING" VALUES ('2819', '28', 'SO', 'SpecialtyType', '15');
INSERT INTO "PROVIDER_SETTING" VALUES ('2820', '28', 'SO', 'SpecialtyType', '16');
INSERT INTO "PROVIDER_SETTING" VALUES ('2821', '28', 'SO', 'SpecialtyType', '17');
INSERT INTO "PROVIDER_SETTING" VALUES ('2822', '28', 'SO', 'SpecialtyType', '18');
INSERT INTO "PROVIDER_SETTING" VALUES ('2823', '28', 'SO', 'SpecialtyType', '19');
INSERT INTO "PROVIDER_SETTING" VALUES ('2824', '28', 'SO', 'SpecialtyType', '20');
INSERT INTO "PROVIDER_SETTING" VALUES ('2825', '28', 'SO', 'SpecialtyType', '21');
INSERT INTO "PROVIDER_SETTING" VALUES ('2826', '28', 'SO', 'SpecialtyType', '22');
INSERT INTO "PROVIDER_SETTING" VALUES ('2827', '28', 'SO', 'SpecialtyType', '23');
INSERT INTO "PROVIDER_SETTING" VALUES ('2828', '28', 'SO', 'SpecialtyType', '24');
INSERT INTO "PROVIDER_SETTING" VALUES ('2829', '28', 'SO', 'SpecialtyType', '25');
INSERT INTO "PROVIDER_SETTING" VALUES ('2830', '28', 'SO', 'SpecialtyType', '26');
INSERT INTO "PROVIDER_SETTING" VALUES ('2831', '28', 'SO', 'SpecialtyType', '27');
INSERT INTO "PROVIDER_SETTING" VALUES ('2832', '28', 'SO', 'SpecialtyType', '28');
INSERT INTO "PROVIDER_SETTING" VALUES ('2833', '28', 'SO', 'SpecialtyType', '29');
INSERT INTO "PROVIDER_SETTING" VALUES ('2834', '28', 'SO', 'SpecialtyType', '30');
INSERT INTO "PROVIDER_SETTING" VALUES ('2835', '28', 'SO', 'SpecialtyType', '31');
INSERT INTO "PROVIDER_SETTING" VALUES ('2836', '28', 'SO', 'SpecialtyType', '32');
INSERT INTO "PROVIDER_SETTING" VALUES ('2837', '28', 'SO', 'SpecialtyType', '33');
INSERT INTO "PROVIDER_SETTING" VALUES ('2838', '28', 'SO', 'SpecialtyType', '34');
INSERT INTO "PROVIDER_SETTING" VALUES ('2839', '28', 'SO', 'SpecialtyType', '35');
INSERT INTO "PROVIDER_SETTING" VALUES ('2840', '28', 'SO', 'SpecialtyType', '36');
INSERT INTO "PROVIDER_SETTING" VALUES ('2841', '28', 'SO', 'SpecialtyType', '37');
INSERT INTO "PROVIDER_SETTING" VALUES ('2842', '28', 'SO', 'SpecialtyType', '38');
INSERT INTO "PROVIDER_SETTING" VALUES ('2843', '28', 'SO', 'SpecialtyType', '39');
INSERT INTO "PROVIDER_SETTING" VALUES ('3401', '34', 'LO', 'LicenseType', 'A1');
INSERT INTO "PROVIDER_SETTING" VALUES ('3501', '35', 'LO', 'LicenseType', 'A2');
INSERT INTO "PROVIDER_SETTING" VALUES ('3502', '35', 'LO', 'LicenseType', 'A3');
INSERT INTO "PROVIDER_SETTING" VALUES ('3503', '35', 'LO', 'LicenseType', 'A4');
INSERT INTO "PROVIDER_SETTING" VALUES ('3601', '36', 'LO', 'LicenseType', 'A5');
INSERT INTO "PROVIDER_SETTING" VALUES ('3801', '38', 'LO', 'LicenseType', 'A6');
INSERT INTO "PROVIDER_SETTING" VALUES ('3901', '39', 'LO', 'LicenseType', 'A7');
INSERT INTO "PROVIDER_SETTING" VALUES ('3902', '39', 'LO', 'LicenseType', 'A8');
INSERT INTO "PROVIDER_SETTING" VALUES ('4101', '41', 'LO', 'LicenseType', 'A9');
INSERT INTO "PROVIDER_SETTING" VALUES ('4102', '41', 'LO', 'LicenseType', 'A0');
INSERT INTO "PROVIDER_SETTING" VALUES ('4201', '42', 'LO', 'LicenseType', 'AA');
INSERT INTO "PROVIDER_SETTING" VALUES ('4301', '43', 'LO', 'LicenseType', 'AB');
INSERT INTO "PROVIDER_SETTING" VALUES ('4501', '45', 'LO', 'LicenseType', 'AB');
INSERT INTO "PROVIDER_SETTING" VALUES ('4502', '45', 'LO', 'LicenseType', 'AC');
INSERT INTO "PROVIDER_SETTING" VALUES ('4601', '46', 'LO', 'LicenseType', 'AD');
INSERT INTO "PROVIDER_SETTING" VALUES ('4701', '47', 'LO', 'LicenseType', 'AE');
INSERT INTO "PROVIDER_SETTING" VALUES ('4702', '47', 'LO', 'LicenseType', 'AF');
INSERT INTO "PROVIDER_SETTING" VALUES ('4801', '48', 'LO', 'LicenseType', 'AE');
INSERT INTO "PROVIDER_SETTING" VALUES ('5101', '51', 'LO', 'LicenseType', 'AG');
INSERT INTO "PROVIDER_SETTING" VALUES ('5102', '51', 'LO', 'LicenseType', 'AH');
INSERT INTO "PROVIDER_SETTING" VALUES ('5201', '52', 'LO', 'LicenseType', 'AJ');
INSERT INTO "PROVIDER_SETTING" VALUES ('5501', '55', 'LO', 'LicenseType', 'AK');
INSERT INTO "PROVIDER_SETTING" VALUES ('5502', '55', 'LO', 'LicenseType', 'AL');
INSERT INTO "PROVIDER_SETTING" VALUES ('100001', '41', 'QL', 'LicenseType', 'L4');
INSERT INTO "PROVIDER_SETTING" VALUES ('100002', '41', 'QL', 'LicenseType', 'N2');
INSERT INTO "PROVIDER_SETTING" VALUES ('100003', '41', 'QL', 'LicenseType', 'M2');
INSERT INTO "PROVIDER_SETTING" VALUES ('100004', '41', 'QL', 'LicenseType', 'M4');
INSERT INTO "PROVIDER_SETTING" VALUES ('100005', '41', 'QL', 'LicenseType', 'M8');
INSERT INTO "PROVIDER_SETTING" VALUES ('9913', '03', 'BT', 'BeneficialOwnerType', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('5701', '57', 'LO', 'LicenseType', 'AM');
INSERT INTO "PROVIDER_SETTING" VALUES ('6801', '68', 'LO', 'LicenseType', 'AZ');
INSERT INTO "PROVIDER_SETTING" VALUES ('6802', '68', 'LO', 'LicenseType', 'AO');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100075', '75', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100076', '75', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100077', '76', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100078', '76', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('7601', '76', 'LO', 'LicenseType', 'B1');
INSERT INTO "PROVIDER_SETTING" VALUES ('7602', '76', 'LO', 'LicenseType', 'B2');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100079', '77', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100080', '77', 'RA', 'AgreementDocument', '02');
INSERT INTO "PROVIDER_SETTING" VALUES ('7701', '77', 'LO', 'LicenseType', 'B3');
INSERT INTO "PROVIDER_SETTING" VALUES ('7702', '77', 'LO', 'LicenseType', 'B4');
INSERT INTO "PROVIDER_SETTING" VALUES ('7703', '77', 'LO', 'LicenseType', 'B5');
INSERT INTO "PROVIDER_SETTING" VALUES ('7706', '77', 'SO', 'SpecialtyType', '88');
INSERT INTO "PROVIDER_SETTING" VALUES ('7707', '77', 'SO', 'SpecialtyType', '89');
INSERT INTO "PROVIDER_SETTING" VALUES ('7708', '77', 'SO', 'SpecialtyType', 'WC');
INSERT INTO "PROVIDER_SETTING" VALUES ('7709', '77', 'SB', 'IssuingBoard', 'B8');
INSERT INTO "PROVIDER_SETTING" VALUES ('7710', '77', 'SB', 'IssuingBoard', 'B9');
INSERT INTO "PROVIDER_SETTING" VALUES ('7704', '77', 'SO', 'SpecialtyType', '86');
INSERT INTO "PROVIDER_SETTING" VALUES ('7705', '77', 'SO', 'SpecialtyType', '87');
INSERT INTO "PROVIDER_SETTING" VALUES ('7711', '77', 'SB', 'IssuingBoard', 'N1');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100081', '78', 'RA', 'AgreementDocument', '01');
INSERT INTO "PROVIDER_SETTING" VALUES ('9100082', '78', 'RA', 'AgreementDocument', '02');
commit;
-- data-fixes-11-19-13.sql
delete from PROVIDER_SETTING where RELATED_ENTITY_CD = 'M8';
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (2003, '20', 'LicenseType', 'H1', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (2004, '20', 'LicenseType', 'H2', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (100006, '41', 'LicenseType', 'H1', 'QL');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (100007, '41', 'LicenseType', 'H2', 'QL');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (14001, '12', 'SpecialtyType', '41', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (14002, '12', 'SpecialtyType', '42', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (14003, '12', 'SpecialtyType', '43', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (14004, '12', 'SpecialtyType', '44', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (14005, '12', 'SpecialtyType', '45', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (14006, '12', 'SpecialtyType', '46', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (14007, '12', 'SpecialtyType', '47', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (14008, '12', 'SpecialtyType', '48', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (1503, '15', 'LicenseType', 'H3', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (1504, '15', 'LicenseType', 'H4', 'LO');
DELETE FROM PROVIDER_SETTING WHERE PROVIDER_SETTING_ID = 104;
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (2844, '28', 'SpecialtyType', '49', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (2845, '28', 'SpecialtyType', '50', 'SO');
delete from PROVIDER_SETTING where RELATED_ENTITY_CD = 'L2' and PROVIDER_TYP_CD = '01';
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (705, '07', 'SpecialtyType', 'C1', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (706, '07', 'SpecialtyType', 'C2', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (707, '07', 'SpecialtyType', 'C3', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (708, '07', 'SpecialtyType', 'C4', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (709, '07', 'SpecialtyType', 'C5', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (5902, '59', 'LicenseType', 'B1', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (5903, '59', 'LicenseType', 'B2', 'LO');
delete from PROVIDER_SETTING where provider_setting_id = 6502;
DELETE FROM PROVIDER_SETTING WHERE PROVIDER_SETTING_ID = 2504;
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (2504, '25', 'IssuingBoard', 'B8', 'SB');
DELETE FROM PROVIDER_SETTING WHERE PROVIDER_SETTING_ID = 2503;
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (2503, '25', 'SpecialtyType', 'S9', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP) VALUES (2110, '21', 'IssuingBoard', 'C1', 'SB');
DELETE FROM PROVIDER_SETTING WHERE PROVIDER_SETTING_ID = 102;
COMMIT;

-- ----------------------------
--  Table structure for "NOTIFICATION"
-- ----------------------------
CREATE TABLE "NOTIFICATION" (   "DTYPE" VARCHAR2(31CHAR) NOT NULL, "ID" NUMBER(19,0) NOT NULL, "PRIORITY" NUMBER(10,0) NOT NULL, "ESCALATION_NOTIFICATIONS_ID" NUMBER(19,0));

-- ----------------------------
--  Sequence structure for "ATTACHMENT_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "ATTACHMENT_ID_SEQ" INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "BOOLEANEXPR_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "BOOLEANEXPR_ID_SEQ" INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "COMMENT_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "COMMENT_ID_SEQ" INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "CONTENT_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "CONTENT_ID_SEQ" INCREMENT BY 1 START WITH 341 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "DEADLINE_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "DEADLINE_ID_SEQ" INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "EMAILNOTIFHEAD_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "EMAILNOTIFHEAD_ID_SEQ" INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "ESCALATION_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "ESCALATION_ID_SEQ" INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "HIBERNATE_SEQUENCE"
-- ----------------------------
CREATE SEQUENCE "HIBERNATE_SEQUENCE" INCREMENT BY 1 START WITH 341 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "I18NTEXT_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "I18NTEXT_ID_SEQ" INCREMENT BY 1 START WITH 421 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "NODE_INST_LOG_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "NODE_INST_LOG_ID_SEQ" INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "NOTIFICATION_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "NOTIFICATION_ID_SEQ" INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "PROC_INST_LOG_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "PROC_INST_LOG_ID_SEQ" INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "REASSIGNMENT_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "REASSIGNMENT_ID_SEQ" INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "SESSIONINFO_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "SESSIONINFO_ID_SEQ" INCREMENT BY 1 START WITH 281 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "VAR_INST_LOG_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "VAR_INST_LOG_ID_SEQ" INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Sequence structure for "WORKITEMINFO_ID_SEQ"
-- ----------------------------
CREATE SEQUENCE "WORKITEMINFO_ID_SEQ" INCREMENT BY 1 START WITH 721 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER;

-- ----------------------------
--  Primary key structure for table "LU_PROVIDER_TYPE"
-- ----------------------------
ALTER TABLE "LU_PROVIDER_TYPE" ADD CONSTRAINT "SYS_C0072362" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "EXTERNAL_ACCOUNT_LINK"
-- ----------------------------
ALTER TABLE "EXTERNAL_ACCOUNT_LINK" ADD CONSTRAINT "SYS_C004038" PRIMARY KEY("EXTERNAL_ACCOUNT_LINK_ID");

-- ----------------------------
--  Primary key structure for table "NOTIFICATION_EMAIL_HEADER"
-- ----------------------------
ALTER TABLE "NOTIFICATION_EMAIL_HEADER" ADD CONSTRAINT "SYS_C004181" PRIMARY KEY("NOTIFICATION_ID","MAPKEY");

-- ----------------------------
--  Primary key structure for table "OWNER_ASSET"
-- ----------------------------
ALTER TABLE "OWNER_ASSET" ADD CONSTRAINT "SYS_C004116" PRIMARY KEY("OWNER_ASSET_ID");

-- ----------------------------
--  Primary key structure for table "ENTITY"
-- ----------------------------
ALTER TABLE "ENTITY" ADD CONSTRAINT "SYS_C004124" PRIMARY KEY("ENTITY_ID");

-- ----------------------------
--  Primary key structure for table "CONTACT_INFO"
-- ----------------------------
ALTER TABLE "CONTACT_INFO" ADD CONSTRAINT "SYS_C004067" PRIMARY KEY("CONTACT_INFO_ID");

-- ----------------------------
--  Primary key structure for table "LU_REQUEST_TYP"
-- ----------------------------
ALTER TABLE "LU_REQUEST_TYP" ADD CONSTRAINT "SYS_C004121" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "TICKET"
-- ----------------------------
ALTER TABLE "TICKET" ADD CONSTRAINT "SYS_C004128" PRIMARY KEY("TICKET_ID");

-- ----------------------------
--  Primary key structure for table "PROVIDER_STATEMENT"
-- ----------------------------
ALTER TABLE "PROVIDER_STATEMENT" ADD CONSTRAINT "SYS_C004158" PRIMARY KEY("PROVIDER_STATEMENT_ID");

-- ----------------------------
--  Primary key structure for table "DESIGNATED_CONTACT"
-- ----------------------------
ALTER TABLE "DESIGNATED_CONTACT" ADD CONSTRAINT "SYS_C004058" PRIMARY KEY("CONTROL_NO");

-- ----------------------------
--  Primary key structure for table "LU_SPECIALTY_TYPE"
-- ----------------------------
ALTER TABLE "LU_SPECIALTY_TYPE" ADD CONSTRAINT "SYS_C004001" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "LU_COUNTY"
-- ----------------------------
ALTER TABLE "LU_COUNTY" ADD CONSTRAINT "SYS_C004269" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "PROVIDER_AGREEMENT_XREF"
-- ----------------------------
ALTER TABLE "PROVIDER_AGREEMENT_XREF" ADD CONSTRAINT "SYS_C004082" PRIMARY KEY("PROVIDER_AGREEMENT_XREF_ID");

-- ----------------------------
--  Primary key structure for table "LU_QP_TYP"
-- ----------------------------
ALTER TABLE "LU_QP_TYP" ADD CONSTRAINT "SYS_C004028" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "ORGANIZATIONALENTITY"
-- ----------------------------
ALTER TABLE "ORGANIZATIONALENTITY" ADD CONSTRAINT "SYS_C004139" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "NODEINSTANCELOG"
-- ----------------------------
ALTER TABLE "NODEINSTANCELOG" ADD CONSTRAINT "SYS_C004164" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "DOCUMENT_CONTENT"
-- ----------------------------
ALTER TABLE "DOCUMENT_CONTENT" ADD CONSTRAINT "SYS_C004047" PRIMARY KEY("CONTENT_ID");

-- ----------------------------
--  Primary key structure for table "LU_TICKET_STATUS"
-- ----------------------------
ALTER TABLE "LU_TICKET_STATUS" ADD CONSTRAINT "SYS_C004018" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "AUDIT_DETAIL"
-- ----------------------------
ALTER TABLE "AUDIT_DETAIL" ADD CONSTRAINT "SYS_C004114" PRIMARY KEY("AUDIT_DETAIL_ID");



-- ----------------------------
--  Primary key structure for table "PROFILE_PAYTO_XREF"
-- ----------------------------
ALTER TABLE "PROFILE_PAYTO_XREF" ADD CONSTRAINT "SYS_C003997" PRIMARY KEY("PROFILE_PAYTO_XREF_ID");

-- ----------------------------
--  Primary key structure for table "PROVIDER_SVCS"
-- ----------------------------
ALTER TABLE "PROVIDER_SVCS" ADD CONSTRAINT "SYS_C004104" PRIMARY KEY("PROVIDER_SVCS_ID");

-- ----------------------------
--  Primary key structure for table "ADDRESS"
-- ----------------------------
ALTER TABLE "ADDRESS" ADD CONSTRAINT "SYS_C004101" PRIMARY KEY("ADDRESS_ID");

-- ----------------------------
--  Primary key structure for table "PROFILE_GRP_XREF"
-- ----------------------------
ALTER TABLE "PROFILE_GRP_XREF" ADD CONSTRAINT "SYS_C004052" PRIMARY KEY("PROFILE_GRP_XREF_ID");

-- ----------------------------
--  Primary key structure for table "I18NTEXT"
-- ----------------------------
ALTER TABLE "I18NTEXT" ADD CONSTRAINT "SYS_C004153" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "VARIABLEINSTANCELOG"
-- ----------------------------
ALTER TABLE "VARIABLEINSTANCELOG" ADD CONSTRAINT "SYS_C004119" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "SUBTASKSSTRATEGY"
-- ----------------------------
ALTER TABLE "SUBTASKSSTRATEGY" ADD CONSTRAINT "SYS_C004061" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "LU_LICENSE_STATUS"
-- ----------------------------
ALTER TABLE "LU_LICENSE_STATUS" ADD CONSTRAINT "SYS_C004010" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "REQUIRED_FLD_TYPE"
-- ----------------------------
ALTER TABLE "REQUIRED_FLD_TYPE" ADD CONSTRAINT "SYS_C003995" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "TASK"
-- ----------------------------
ALTER TABLE "TASK" ADD CONSTRAINT "SYS_C004080" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "REASSIGNMENT"
-- ----------------------------
ALTER TABLE "REASSIGNMENT" ADD CONSTRAINT "SYS_C004056" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "LICENSE"
-- ----------------------------
ALTER TABLE "LICENSE" ADD CONSTRAINT "SYS_C004151" PRIMARY KEY("LICENSE_ID");

-- ----------------------------
--  Primary key structure for table "SESSIONINFO"
-- ----------------------------
ALTER TABLE "SESSIONINFO" ADD CONSTRAINT "SYS_C004032" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "LU_SVC_CAT"
-- ----------------------------
ALTER TABLE "LU_SVC_CAT" ADD CONSTRAINT "SYS_C004050" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "BENEFICIAL_OWNER"
-- ----------------------------
ALTER TABLE "BENEFICIAL_OWNER" ADD CONSTRAINT "SYS_C004167" PRIMARY KEY("BENEFICIAL_OWNER_ID");

-- ----------------------------
--  Primary key structure for table "CONTENT"
-- ----------------------------
ALTER TABLE "CONTENT" ADD CONSTRAINT "SYS_C004141" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "PERSISTENT_LOGINS"
-- ----------------------------
ALTER TABLE "PERSISTENT_LOGINS" ADD CONSTRAINT "SYS_C004022" PRIMARY KEY("SERIES");

-- ----------------------------
--  Primary key structure for table "TASK_COMMENT"
-- ----------------------------
ALTER TABLE "TASK_COMMENT" ADD CONSTRAINT "SYS_C004169" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "LU_OWNERSHIP_TYP"
-- ----------------------------
ALTER TABLE "LU_OWNERSHIP_TYP" ADD CONSTRAINT "SYS_C004134" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "LU_CORP_STRUCTURE_TYP"
-- ----------------------------
ALTER TABLE "LU_CORP_STRUCTURE_TYP" ADD CONSTRAINT "SYS_C004155" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "AGREEMENT_DOCUMENT"
-- ----------------------------
ALTER TABLE "AGREEMENT_DOCUMENT" ADD CONSTRAINT "SYS_C004160" PRIMARY KEY("AGREEMENT_DOCUMENT_ID");

-- ----------------------------
--  Primary key structure for table "CMS_ATTACHMENT"
-- ----------------------------
ALTER TABLE "CMS_ATTACHMENT" ADD CONSTRAINT "SYS_C004175" PRIMARY KEY("ATTACHMENT_ID");

-- ----------------------------
--  Primary key structure for table "LU_STATE"
-- ----------------------------
ALTER TABLE "LU_STATE" ADD CONSTRAINT "SYS_C004012" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "PROVIDER_PROFILE"
-- ----------------------------
ALTER TABLE "PROVIDER_PROFILE" ADD CONSTRAINT "SYS_C004112" PRIMARY KEY("CONTROL_NO");

-- ----------------------------
--  Primary key structure for table "CMS_USER"
-- ----------------------------
ALTER TABLE "CMS_USER" ADD CONSTRAINT "SYS_C004147" PRIMARY KEY("USER_ID");

-- ----------------------------
--  Primary key structure for table "HELP_ITEM"
-- ----------------------------
ALTER TABLE "HELP_ITEM" ADD CONSTRAINT "SYS_C004084" PRIMARY KEY("HELP_ITEM_ID");

-- ----------------------------
--  Primary key structure for table "EVENT"
-- ----------------------------
ALTER TABLE "EVENT" ADD CONSTRAINT "SYS_C004177" PRIMARY KEY("EVENT_ID");

-- ----------------------------
--  Primary key structure for table "BOOLEANEXPRESSION"
-- ----------------------------
ALTER TABLE "BOOLEANEXPRESSION" ADD CONSTRAINT "SYS_C004027" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "LU_ROLE"
-- ----------------------------
ALTER TABLE "LU_ROLE" ADD CONSTRAINT "SYS_C004089" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "EXTERNAL_PROFILE_LINK"
-- ----------------------------
ALTER TABLE "EXTERNAL_PROFILE_LINK" ADD CONSTRAINT "SYS_C004014" PRIMARY KEY("EXTERNAL_PROFILE_LINK_ID");

-- ----------------------------
--  Primary key structure for table "WORKITEMINFO"
-- ----------------------------
ALTER TABLE "WORKITEMINFO" ADD CONSTRAINT "SYS_C004093" PRIMARY KEY("WORKITEMID");

-- ----------------------------
--  Primary key structure for table "EMAIL_HEADER"
-- ----------------------------
ALTER TABLE "EMAIL_HEADER" ADD CONSTRAINT "SYS_C004036" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "LU_RELATIONSHIP_TYP"
-- ----------------------------
ALTER TABLE "LU_RELATIONSHIP_TYP" ADD CONSTRAINT "SYS_C004034" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "LU_RISK_LEVEL"
-- ----------------------------
ALTER TABLE "LU_RISK_LEVEL" ADD CONSTRAINT "SYS_C004099" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "CMS_SEQUENCE"
-- ----------------------------
ALTER TABLE "CMS_SEQUENCE" ADD CONSTRAINT "SYS_C0071426" PRIMARY KEY("SEQ_NAME");

-- ----------------------------
--  Primary key structure for table "ATTACHMENT"
-- ----------------------------
ALTER TABLE "ATTACHMENT" ADD CONSTRAINT "SYS_C004044" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "PROFILE_NOTES"
-- ----------------------------
ALTER TABLE "PROFILE_NOTES" ADD CONSTRAINT "SYS_C004149" PRIMARY KEY("PROVIDER_NOTE_ID");

-- ----------------------------
--  Primary key structure for table "LU_DEGREE"
-- ----------------------------
ALTER TABLE "LU_DEGREE" ADD CONSTRAINT "SYS_C004173" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "LU_BEN_OWNER_TYP"
-- ----------------------------
ALTER TABLE "LU_BEN_OWNER_TYP" ADD CONSTRAINT "SYS_C004103" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "PROCESSINSTANCEINFO"
-- ----------------------------
ALTER TABLE "PROCESSINSTANCEINFO" ADD CONSTRAINT "SYS_C004006" PRIMARY KEY("INSTANCEID");

-- ----------------------------
--  Primary key structure for table "DEADLINE"
-- ----------------------------
ALTER TABLE "DEADLINE" ADD CONSTRAINT "SYS_C004008" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "LU_PROFILE_STATUS"
-- ----------------------------
ALTER TABLE "LU_PROFILE_STATUS" ADD CONSTRAINT "SYS_C004186" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "LU_PAYTO_TYPE"
-- ----------------------------
ALTER TABLE "LU_PAYTO_TYPE" ADD CONSTRAINT "SYS_C004069" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "ESCALATION"
-- ----------------------------
ALTER TABLE "ESCALATION" ADD CONSTRAINT "SYS_C004054" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "OWNERSHIP_INFO"
-- ----------------------------
ALTER TABLE "OWNERSHIP_INFO" ADD CONSTRAINT "SYS_C004190" PRIMARY KEY("OWNERSHIP_INFO_ID");

-- ----------------------------
--  Primary key structure for table "AUDIT_RECORD"
-- ----------------------------
ALTER TABLE "AUDIT_RECORD" ADD CONSTRAINT "SYS_C004184" PRIMARY KEY("AUDIT_RECORD_ID");

-- ----------------------------
--  Primary key structure for table "REQUIRED_FLD"
-- ----------------------------
ALTER TABLE "REQUIRED_FLD" ADD CONSTRAINT "SYS_C004145" PRIMARY KEY("CODE");

-- ----------------------------
--  Primary key structure for table "SCREENING_SCHEDULE"
-- ----------------------------
ALTER TABLE "SCREENING_SCHEDULE" ADD CONSTRAINT "SYS_C004087" PRIMARY KEY("SCREENING_SCHEDULE_ID");

-- ----------------------------
--  Primary key structure for table "PROCESSINSTANCELOG"
-- ----------------------------
ALTER TABLE "PROCESSINSTANCELOG" ADD CONSTRAINT "SYS_C004041" PRIMARY KEY("ID");

-- ----------------------------
--  Primary key structure for table "PROVIDER_SETTING"
-- ----------------------------
ALTER TABLE "PROVIDER_SETTING" ADD CONSTRAINT "SYS_C004136" PRIMARY KEY("PROVIDER_SETTING_ID");

-- ----------------------------
--  Primary key structure for table "NOTIFICATION"
-- ----------------------------
ALTER TABLE "NOTIFICATION" ADD CONSTRAINT "SYS_C004097" PRIMARY KEY("ID");
commit;



-- data-fixes-11-19-13.sql
CREATE SEQUENCE AGREEMENT_DOC_SEQ  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 4 CACHE 20 NOORDER  NOCYCLE;
commit;



CREATE TABLE "CMS"."LEGACY_MAPPING"
 (	"LEGACY_MAPPING_ID" NUMBER(19,0),
"SYSTEM_NM" VARCHAR2(200 CHAR),
"CODE_TYPE" VARCHAR2(200 CHAR),
"INTERNAL_CODE" VARCHAR2(200 CHAR),
"EXTERNAL_CODE" VARCHAR2(200 CHAR)
 ) ;

ALTER TABLE "CMS"."LEGACY_MAPPING" ADD PRIMARY KEY ("LEGACY_MAPPING_ID") ENABLE;
ALTER TABLE ENTITY add LEGACY_ID VARCHAR(9);
