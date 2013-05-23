--------------------------------------------------------
--  File created - Tuesday-December-18-2012   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence HIBERNATE_SEQUENCE
--------------------------------------------------------

   CREATE SEQUENCE  "EXTSOURCES"."HIBERNATE_SEQUENCE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence MITA3_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "EXTSOURCES"."MITA3_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 2121 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table AANA_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."AANA_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"SSN" VARCHAR2(255), 
	"AANA_NUMBER" NUMBER(19,0), 
	"RECERTIFICATION" NUMBER(1,0)
   ) ;
--------------------------------------------------------
--  DDL for Table BBHT_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."BBHT_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"LICENSE_TYPE_LU_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table BLS_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."BLS_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"SCOPE" NUMBER(10,0), 
	"FILING_STATUS" NUMBER(10,0), 
	"BUSINESS_NAME" VARCHAR2(255), 
	"FILE_NUMBER" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table CHIROPRACTIC_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."CHIROPRACTIC_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"CITY" VARCHAR2(255), 
	"ZIPCODE" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table CRED_STATUS_TYPE
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."CRED_STATUS_TYPE" 
   (	"CRED_STATUS_TYPE_LU_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table DEATH_MASTER_RECORD
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."DEATH_MASTER_RECORD" 
   (	"ID" NUMBER(19,0), 
	"SSN" VARCHAR2(9), 
	"LAST_NAME" VARCHAR2(20), 
	"NAME_SUFFIX" VARCHAR2(4), 
	"FIRST_NAME" VARCHAR2(15), 
	"MIDDLE_NAME" VARCHAR2(15), 
	"VP_CODE" VARCHAR2(1), 
	"DATE_OF_DEATH" DATE, 
	"DATE_OF_BIRTH" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table DENTISTRY_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."DENTISTRY_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"MIDDLENAME" VARCHAR2(255), 
	"CITY" VARCHAR2(255), 
	"LICENSE_TYPE_LU_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table DIETETICS_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."DIETETICS_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table DISCIPLINE_TYPE
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."DISCIPLINE_TYPE" 
   (	"DISCIPLINE_TYPE_LU_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table EPLS_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."EPLS_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"NPITYPE" NUMBER(10,0), 
	"NAME" VARCHAR2(255), 
	"ACT_FROM_DT" DATE, 
	"ACT_TO_DT" DATE, 
	"TERM_FROM_DT" DATE, 
	"TERM_TO_DT" DATE, 
	"CRTE_FROM_DT" DATE, 
	"CRTE_TO_DT" DATE, 
	"UPDT_FROM_DT" DATE, 
	"UPDT_TO_DT" DATE, 
	"RECIPROCAL_CD" VARCHAR2(255), 
	"PROCUREMENT_CD" VARCHAR2(255), 
	"NON_PROCUREMENT_CD" VARCHAR2(255), 
	"AGENCY" VARCHAR2(255), 
	"US_STATE" VARCHAR2(255), 
	"COUNTRY" VARCHAR2(255), 
	"DUNS" VARCHAR2(255), 
	"CAGE_CODE" VARCHAR2(255), 
	"EXCLUSION_TYPE_LU_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table EXCLUSION_TYPE_LU
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."EXCLUSION_TYPE_LU" 
   (	"EXCLUSION_TYPE_LU_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table HOPC_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."HOPC_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"CITY" VARCHAR2(255), 
	"COUNTY" VARCHAR2(255), 
	"CREDENTIAL_NUMBER" NUMBER(19,0), 
	"OCCUPATION_TYPE_LU_ID" NUMBER(19,0), 
	"CRED_STATUS_TYPE_LU_ID" NUMBER(19,0), 
	"DISCIPLINE_TYPE_LU_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table LICENSE_LEVEL_LU
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."LICENSE_LEVEL_LU" 
   (	"LICENSE_LEVEL_LU_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table LICENSE_TYPE_LU
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."LICENSE_TYPE_LU" 
   (	"LICENSE_TYPE_LU_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table MARRIAGE_FAMILY_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."MARRIAGE_FAMILY_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"CRITERIA" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table MEDICAID_CERT_PROV_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."MEDICAID_CERT_PROV_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"TYPE" VARCHAR2(255), 
	"CRITERIA" VARCHAR2(255), 
	"VALUE" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table MED_PRACTICE_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."MED_PRACTICE_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"CITY" VARCHAR2(255), 
	"ZIPCODE" VARCHAR2(255), 
	"SPECIALTY_LU_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table NURSING_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."NURSING_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table OCCUPATION_TYPE
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."OCCUPATION_TYPE" 
   (	"OCCUPATION_TYPE_LU_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table OIG_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."OIG_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"BUSINESS_NAME" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table OPTOMETRY_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."OPTOMETRY_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table ORG_CDP_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."ORG_CDP_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255), 
	"CITY" VARCHAR2(255), 
	"COUNTY" VARCHAR2(255), 
	"ZIP" VARCHAR2(255), 
	"LICENSE_NUMBER" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table ORG_CMHC_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."ORG_CMHC_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"CRITERIA" VARCHAR2(255), 
	"VALUE" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table ORG_CR_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."ORG_CR_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255), 
	"CITY" VARCHAR2(255), 
	"COUNTY" VARCHAR2(255), 
	"ZIP" VARCHAR2(255), 
	"LICENSE_NUMBER" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table ORG_DTHC_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."ORG_DTHC_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255), 
	"CITY" VARCHAR2(255), 
	"COUNTY" VARCHAR2(255), 
	"ZIP" VARCHAR2(255), 
	"LICENSE_NUMBER" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table ORG_HOSPICE_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."ORG_HOSPICE_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"CRITERIA" VARCHAR2(255), 
	"VALUE" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table ORG_HOSPITAL_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."ORG_HOSPITAL_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"CRITERIA" VARCHAR2(255), 
	"VALUE" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table ORG_IRTS_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."ORG_IRTS_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255), 
	"CITY" VARCHAR2(255), 
	"COUNTY" VARCHAR2(255), 
	"ZIP" VARCHAR2(255), 
	"LICENSE_NUMBER" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table ORG_PDNG_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."ORG_PDNG_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"CRITERIA" VARCHAR2(255), 
	"VALUE" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table ORG_PHARMACY_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."ORG_PHARMACY_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255), 
	"ADDRESS" VARCHAR2(255), 
	"CITY" VARCHAR2(255), 
	"COUNTY" VARCHAR2(255), 
	"ZIP" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table ORG_PHNO_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."ORG_PHNO_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"CRITERIA" VARCHAR2(255), 
	"VALUE" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table ORG_PWDDIC_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."ORG_PWDDIC_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255), 
	"CITY" VARCHAR2(255), 
	"COUNTY" VARCHAR2(255), 
	"ZIP" VARCHAR2(255), 
	"LICENSE_NUMBER" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table ORG_RDFS_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."ORG_RDFS_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"CRITERIA" VARCHAR2(255), 
	"VALUE" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table PECOS_RECORD
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."PECOS_RECORD" 
   (	"ID" NUMBER(19,0), 
	"NPI" VARCHAR2(50), 
	"LAST_NAME" VARCHAR2(50), 
	"FIRST_NAME" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table PHARMACY_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."PHARMACY_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"BUSINESS_NAME" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table PHYSICAL_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."PHYSICAL_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"CRITERIA" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table POD_MED_LIC_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."POD_MED_LIC_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"LICENSE_NUMBER" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table POD_MED_NAME_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."POD_MED_NAME_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table RESULT_LOG_ENTRY
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."RESULT_LOG_ENTRY" 
   (	"RESULT_LOG_ENTRY_ID" NUMBER(19,0), 
	"SEARCH_CRITERIA_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table SEARCH_CRITERIA
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."SEARCH_CRITERIA" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"IDENTIFIER" VARCHAR2(255), 
	"LAST_NAME" VARCHAR2(255), 
	"FIRST_NAME" VARCHAR2(255), 
	"STATE" VARCHAR2(255), 
	"PAGE_SIZE" NUMBER(10,0), 
	"PAGE_NUMBER" NUMBER(10,0), 
	"SORT_ORDER" NUMBER(10,0), 
	"SORT_COLUMN" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table SOCIAL_WORK_LIC_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."SOCIAL_WORK_LIC_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"CITY" VARCHAR2(255), 
	"COUNTY" VARCHAR2(255), 
	"LICENSE_NUMBER" NUMBER(19,0), 
	"LICENSE_LEVEL_LU_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table SOCIAL_WORK_NAME_CRIT
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."SOCIAL_WORK_NAME_CRIT" 
   (	"SEARCH_CRITERIA_ID" NUMBER(19,0), 
	"CITY" VARCHAR2(255), 
	"COUNTY" VARCHAR2(255), 
	"LICENSE_LEVEL_LU_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table SOURCE_STATS
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."SOURCE_STATS" 
   (	"SOURCE_STATS_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255), 
	"SUCCESS_COUNT" NUMBER(19,0), 
	"NOT_FOUND_COUNT" NUMBER(19,0), 
	"MOVED_COUNT" NUMBER(19,0), 
	"ERROR_COUNT" NUMBER(19,0), 
	"RELIABILITY" FLOAT(126)
   ) ;
--------------------------------------------------------
--  DDL for Table SPECIALTY_LU
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."SPECIALTY_LU" 
   (	"SPECIALTY_LU_ID" NUMBER(19,0), 
	"CODE" NUMBER(19,0), 
	"NAME" VARCHAR2(255), 
	"SPECIALTY_TYPE_LU_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table SPECIALTY_TYPE_LU
--------------------------------------------------------

  CREATE TABLE "EXTSOURCES"."SPECIALTY_TYPE_LU" 
   (	"SPECIALTY_TYPE_LU_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Index SYS_C0042326
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042326" ON "EXTSOURCES"."DISCIPLINE_TYPE" ("DISCIPLINE_TYPE_LU_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042368
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042368" ON "EXTSOURCES"."SOURCE_STATS" ("SOURCE_STATS_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042362
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042362" ON "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042364
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042364" ON "EXTSOURCES"."SOCIAL_WORK_LIC_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042330
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042330" ON "EXTSOURCES"."EXCLUSION_TYPE_LU" ("EXCLUSION_TYPE_LU_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042360
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042360" ON "EXTSOURCES"."RESULT_LOG_ENTRY" ("RESULT_LOG_ENTRY_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042372
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042372" ON "EXTSOURCES"."SPECIALTY_TYPE_LU" ("SPECIALTY_TYPE_LU_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042318
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042318" ON "EXTSOURCES"."CHIROPRACTIC_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042342
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042342" ON "EXTSOURCES"."MEDICAID_CERT_PROV_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042336
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042336" ON "EXTSOURCES"."LICENSE_TYPE_LU" ("LICENSE_TYPE_LU_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042316
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042316" ON "EXTSOURCES"."BLS_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042370
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042370" ON "EXTSOURCES"."SPECIALTY_LU" ("SPECIALTY_LU_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042356
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042356" ON "EXTSOURCES"."POD_MED_LIC_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042344
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042344" ON "EXTSOURCES"."NURSING_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042358
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042358" ON "EXTSOURCES"."POD_MED_NAME_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042389
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042389" ON "EXTSOURCES"."ORG_CR_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042340
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042340" ON "EXTSOURCES"."MED_PRACTICE_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042382
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042382" ON "EXTSOURCES"."ORG_CMHC_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042388
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042388" ON "EXTSOURCES"."ORG_CDP_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042381
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042381" ON "EXTSOURCES"."ORG_HOSPITAL_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042383
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042383" ON "EXTSOURCES"."ORG_HOSPICE_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042350
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042350" ON "EXTSOURCES"."OPTOMETRY_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042390
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042390" ON "EXTSOURCES"."ORG_DTHC_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042320
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042320" ON "EXTSOURCES"."CRED_STATUS_TYPE" ("CRED_STATUS_TYPE_LU_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042332
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042332" ON "EXTSOURCES"."HOPC_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042322
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042322" ON "EXTSOURCES"."DENTISTRY_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042387
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042387" ON "EXTSOURCES"."ORG_PHARMACY_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042334
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042334" ON "EXTSOURCES"."LICENSE_LEVEL_LU" ("LICENSE_LEVEL_LU_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042338
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042338" ON "EXTSOURCES"."MARRIAGE_FAMILY_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042366
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042366" ON "EXTSOURCES"."SOCIAL_WORK_NAME_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042312
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042312" ON "EXTSOURCES"."AANA_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042386
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042386" ON "EXTSOURCES"."ORG_RDFS_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042346
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042346" ON "EXTSOURCES"."OCCUPATION_TYPE" ("OCCUPATION_TYPE_LU_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042391
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042391" ON "EXTSOURCES"."ORG_IRTS_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042324
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042324" ON "EXTSOURCES"."DIETETICS_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042392
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042392" ON "EXTSOURCES"."ORG_PWDDIC_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042328
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042328" ON "EXTSOURCES"."EPLS_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042354
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042354" ON "EXTSOURCES"."PHYSICAL_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042352
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042352" ON "EXTSOURCES"."PHARMACY_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042314
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042314" ON "EXTSOURCES"."BBHT_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042348
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042348" ON "EXTSOURCES"."OIG_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042384
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042384" ON "EXTSOURCES"."ORG_PDNG_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0042385
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXTSOURCES"."SYS_C0042385" ON "EXTSOURCES"."ORG_PHNO_CRIT" ("SEARCH_CRITERIA_ID") 
  ;
--------------------------------------------------------
--  Constraints for Table EPLS_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."EPLS_CRIT" ADD CONSTRAINT "SYS_C0042328" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."EPLS_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ORG_PHARMACY_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_PHARMACY_CRIT" ADD CONSTRAINT "SYS_C0042387" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."ORG_PHARMACY_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table POD_MED_NAME_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."POD_MED_NAME_CRIT" ADD CONSTRAINT "SYS_C0042358" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."POD_MED_NAME_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BBHT_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."BBHT_CRIT" ADD CONSTRAINT "SYS_C0042314" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."BBHT_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MED_PRACTICE_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."MED_PRACTICE_CRIT" ADD CONSTRAINT "SYS_C0042340" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."MED_PRACTICE_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table OCCUPATION_TYPE
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."OCCUPATION_TYPE" ADD CONSTRAINT "SYS_C0042346" PRIMARY KEY ("OCCUPATION_TYPE_LU_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."OCCUPATION_TYPE" MODIFY ("OCCUPATION_TYPE_LU_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DENTISTRY_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."DENTISTRY_CRIT" ADD CONSTRAINT "SYS_C0042322" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."DENTISTRY_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ORG_CDP_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_CDP_CRIT" ADD CONSTRAINT "SYS_C0042388" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."ORG_CDP_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table EXCLUSION_TYPE_LU
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."EXCLUSION_TYPE_LU" ADD CONSTRAINT "SYS_C0042330" PRIMARY KEY ("EXCLUSION_TYPE_LU_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."EXCLUSION_TYPE_LU" MODIFY ("EXCLUSION_TYPE_LU_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SOURCE_STATS
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."SOURCE_STATS" ADD CONSTRAINT "SYS_C0042368" PRIMARY KEY ("SOURCE_STATS_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."SOURCE_STATS" MODIFY ("SOURCE_STATS_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ORG_CR_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_CR_CRIT" ADD CONSTRAINT "SYS_C0042389" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."ORG_CR_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SPECIALTY_TYPE_LU
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."SPECIALTY_TYPE_LU" ADD CONSTRAINT "SYS_C0042372" PRIMARY KEY ("SPECIALTY_TYPE_LU_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."SPECIALTY_TYPE_LU" MODIFY ("SPECIALTY_TYPE_LU_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CHIROPRACTIC_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."CHIROPRACTIC_CRIT" ADD CONSTRAINT "SYS_C0042318" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."CHIROPRACTIC_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SOCIAL_WORK_LIC_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."SOCIAL_WORK_LIC_CRIT" ADD CONSTRAINT "SYS_C0042364" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."SOCIAL_WORK_LIC_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ORG_PWDDIC_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_PWDDIC_CRIT" ADD CONSTRAINT "SYS_C0042392" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."ORG_PWDDIC_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LICENSE_TYPE_LU
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."LICENSE_TYPE_LU" ADD CONSTRAINT "SYS_C0042336" PRIMARY KEY ("LICENSE_TYPE_LU_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."LICENSE_TYPE_LU" MODIFY ("LICENSE_TYPE_LU_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ORG_IRTS_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_IRTS_CRIT" ADD CONSTRAINT "SYS_C0042391" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."ORG_IRTS_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ORG_PDNG_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_PDNG_CRIT" ADD CONSTRAINT "SYS_C0042384" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."ORG_PDNG_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LICENSE_LEVEL_LU
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."LICENSE_LEVEL_LU" ADD CONSTRAINT "SYS_C0042334" PRIMARY KEY ("LICENSE_LEVEL_LU_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."LICENSE_LEVEL_LU" MODIFY ("LICENSE_LEVEL_LU_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ORG_HOSPICE_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_HOSPICE_CRIT" ADD CONSTRAINT "SYS_C0042383" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."ORG_HOSPICE_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ORG_HOSPITAL_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_HOSPITAL_CRIT" ADD CONSTRAINT "SYS_C0042381" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."ORG_HOSPITAL_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table POD_MED_LIC_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."POD_MED_LIC_CRIT" ADD CONSTRAINT "SYS_C0042356" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."POD_MED_LIC_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SOCIAL_WORK_NAME_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."SOCIAL_WORK_NAME_CRIT" ADD CONSTRAINT "SYS_C0042366" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."SOCIAL_WORK_NAME_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CRED_STATUS_TYPE
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."CRED_STATUS_TYPE" ADD CONSTRAINT "SYS_C0042320" PRIMARY KEY ("CRED_STATUS_TYPE_LU_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."CRED_STATUS_TYPE" MODIFY ("CRED_STATUS_TYPE_LU_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ORG_PHNO_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_PHNO_CRIT" ADD CONSTRAINT "SYS_C0042385" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."ORG_PHNO_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ORG_CMHC_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_CMHC_CRIT" ADD CONSTRAINT "SYS_C0042382" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."ORG_CMHC_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PECOS_RECORD
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."PECOS_RECORD" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "EXTSOURCES"."PECOS_RECORD" MODIFY ("NPI" NOT NULL ENABLE);
 
  ALTER TABLE "EXTSOURCES"."PECOS_RECORD" MODIFY ("LAST_NAME" NOT NULL ENABLE);
 
  ALTER TABLE "EXTSOURCES"."PECOS_RECORD" MODIFY ("FIRST_NAME" NOT NULL ENABLE);
 
  ALTER TABLE "EXTSOURCES"."PECOS_RECORD" ADD PRIMARY KEY ("ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table PHYSICAL_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."PHYSICAL_CRIT" ADD CONSTRAINT "SYS_C0042354" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."PHYSICAL_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DEATH_MASTER_RECORD
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."DEATH_MASTER_RECORD" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "EXTSOURCES"."DEATH_MASTER_RECORD" MODIFY ("SSN" NOT NULL ENABLE);
 
  ALTER TABLE "EXTSOURCES"."DEATH_MASTER_RECORD" MODIFY ("LAST_NAME" NOT NULL ENABLE);
 
  ALTER TABLE "EXTSOURCES"."DEATH_MASTER_RECORD" MODIFY ("NAME_SUFFIX" NOT NULL ENABLE);
 
  ALTER TABLE "EXTSOURCES"."DEATH_MASTER_RECORD" MODIFY ("FIRST_NAME" NOT NULL ENABLE);
 
  ALTER TABLE "EXTSOURCES"."DEATH_MASTER_RECORD" MODIFY ("MIDDLE_NAME" NOT NULL ENABLE);
 
  ALTER TABLE "EXTSOURCES"."DEATH_MASTER_RECORD" MODIFY ("VP_CODE" NOT NULL ENABLE);
 
  ALTER TABLE "EXTSOURCES"."DEATH_MASTER_RECORD" MODIFY ("DATE_OF_DEATH" NOT NULL ENABLE);
 
  ALTER TABLE "EXTSOURCES"."DEATH_MASTER_RECORD" MODIFY ("DATE_OF_BIRTH" NOT NULL ENABLE);
 
  ALTER TABLE "EXTSOURCES"."DEATH_MASTER_RECORD" ADD PRIMARY KEY ("ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table ORG_DTHC_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_DTHC_CRIT" ADD CONSTRAINT "SYS_C0042390" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."ORG_DTHC_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MEDICAID_CERT_PROV_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."MEDICAID_CERT_PROV_CRIT" ADD CONSTRAINT "SYS_C0042342" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."MEDICAID_CERT_PROV_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MARRIAGE_FAMILY_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."MARRIAGE_FAMILY_CRIT" ADD CONSTRAINT "SYS_C0042338" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."MARRIAGE_FAMILY_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PHARMACY_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."PHARMACY_CRIT" ADD CONSTRAINT "SYS_C0042352" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."PHARMACY_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table RESULT_LOG_ENTRY
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."RESULT_LOG_ENTRY" ADD CONSTRAINT "SYS_C0042360" PRIMARY KEY ("RESULT_LOG_ENTRY_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."RESULT_LOG_ENTRY" MODIFY ("RESULT_LOG_ENTRY_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SPECIALTY_LU
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."SPECIALTY_LU" ADD CONSTRAINT "SYS_C0042370" PRIMARY KEY ("SPECIALTY_LU_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."SPECIALTY_LU" MODIFY ("SPECIALTY_LU_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DISCIPLINE_TYPE
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."DISCIPLINE_TYPE" ADD CONSTRAINT "SYS_C0042326" PRIMARY KEY ("DISCIPLINE_TYPE_LU_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."DISCIPLINE_TYPE" MODIFY ("DISCIPLINE_TYPE_LU_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table AANA_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."AANA_CRIT" ADD CONSTRAINT "SYS_C0042312" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."AANA_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table OPTOMETRY_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."OPTOMETRY_CRIT" ADD CONSTRAINT "SYS_C0042350" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."OPTOMETRY_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table HOPC_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."HOPC_CRIT" ADD CONSTRAINT "SYS_C0042332" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."HOPC_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SEARCH_CRITERIA
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."SEARCH_CRITERIA" ADD CONSTRAINT "SYS_C0042362" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."SEARCH_CRITERIA" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ORG_RDFS_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_RDFS_CRIT" ADD CONSTRAINT "SYS_C0042386" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."ORG_RDFS_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BLS_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."BLS_CRIT" ADD CONSTRAINT "SYS_C0042316" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."BLS_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table NURSING_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."NURSING_CRIT" ADD CONSTRAINT "SYS_C0042344" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."NURSING_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DIETETICS_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."DIETETICS_CRIT" ADD CONSTRAINT "SYS_C0042324" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."DIETETICS_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table OIG_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."OIG_CRIT" ADD CONSTRAINT "SYS_C0042348" PRIMARY KEY ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."OIG_CRIT" MODIFY ("SEARCH_CRITERIA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table AANA_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."AANA_CRIT" ADD CONSTRAINT "FKF01D0CC65B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table BBHT_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."BBHT_CRIT" ADD CONSTRAINT "FKCF4958ED5B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."BBHT_CRIT" ADD CONSTRAINT "FKCF4958EDD2A09F50" FOREIGN KEY ("LICENSE_TYPE_LU_ID")
	  REFERENCES "EXTSOURCES"."LICENSE_TYPE_LU" ("LICENSE_TYPE_LU_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table BLS_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."BLS_CRIT" ADD CONSTRAINT "FKDEFAEEF05B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table CHIROPRACTIC_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."CHIROPRACTIC_CRIT" ADD CONSTRAINT "FKB42FC4F05B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table DENTISTRY_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."DENTISTRY_CRIT" ADD CONSTRAINT "FK5B9A324F5B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."DENTISTRY_CRIT" ADD CONSTRAINT "FK5B9A324FD2A09F50" FOREIGN KEY ("LICENSE_TYPE_LU_ID")
	  REFERENCES "EXTSOURCES"."LICENSE_TYPE_LU" ("LICENSE_TYPE_LU_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table DIETETICS_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."DIETETICS_CRIT" ADD CONSTRAINT "FKF91EAC635B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table EPLS_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."EPLS_CRIT" ADD CONSTRAINT "FKC4B2E87467C67F0" FOREIGN KEY ("EXCLUSION_TYPE_LU_ID")
	  REFERENCES "EXTSOURCES"."EXCLUSION_TYPE_LU" ("EXCLUSION_TYPE_LU_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."EPLS_CRIT" ADD CONSTRAINT "FKC4B2E875B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table HOPC_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."HOPC_CRIT" ADD CONSTRAINT "FK1982B1BF31B1B2E6" FOREIGN KEY ("CRED_STATUS_TYPE_LU_ID")
	  REFERENCES "EXTSOURCES"."CRED_STATUS_TYPE" ("CRED_STATUS_TYPE_LU_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."HOPC_CRIT" ADD CONSTRAINT "FK1982B1BF5B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."HOPC_CRIT" ADD CONSTRAINT "FK1982B1BF8A44160" FOREIGN KEY ("DISCIPLINE_TYPE_LU_ID")
	  REFERENCES "EXTSOURCES"."DISCIPLINE_TYPE" ("DISCIPLINE_TYPE_LU_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."HOPC_CRIT" ADD CONSTRAINT "FK1982B1BFD32C3DDA" FOREIGN KEY ("OCCUPATION_TYPE_LU_ID")
	  REFERENCES "EXTSOURCES"."OCCUPATION_TYPE" ("OCCUPATION_TYPE_LU_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table MARRIAGE_FAMILY_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."MARRIAGE_FAMILY_CRIT" ADD CONSTRAINT "FK2C5AC5E05B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table MEDICAID_CERT_PROV_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."MEDICAID_CERT_PROV_CRIT" ADD CONSTRAINT "FK383085E5B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table MED_PRACTICE_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."MED_PRACTICE_CRIT" ADD CONSTRAINT "FKDC89E12B5B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."MED_PRACTICE_CRIT" ADD CONSTRAINT "FKDC89E12BEE08B7F9" FOREIGN KEY ("SPECIALTY_LU_ID")
	  REFERENCES "EXTSOURCES"."SPECIALTY_LU" ("SPECIALTY_LU_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table NURSING_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."NURSING_CRIT" ADD CONSTRAINT "FKC9C2765F5B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table OIG_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."OIG_CRIT" ADD CONSTRAINT "FK723D5D0C5B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table OPTOMETRY_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."OPTOMETRY_CRIT" ADD CONSTRAINT "FK4ADD38925B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ORG_CDP_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_CDP_CRIT" ADD CONSTRAINT "FK4D4749AF9A6A0E7" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ORG_CMHC_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_CMHC_CRIT" ADD CONSTRAINT "FK4B3476FB4C2EBD8" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ORG_CR_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_CR_CRIT" ADD CONSTRAINT "FK4C00301012192E4" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ORG_DTHC_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_DTHC_CRIT" ADD CONSTRAINT "FKD18B0588D7FEED9" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ORG_HOSPICE_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_HOSPICE_CRIT" ADD CONSTRAINT "FKB30FCD5B7D39D1B" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ORG_HOSPITAL_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_HOSPITAL_CRIT" ADD CONSTRAINT "FKC6CFB4AE462A3B5" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ORG_IRTS_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_IRTS_CRIT" ADD CONSTRAINT "FK12A61DB31C20521" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ORG_PDNG_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_PDNG_CRIT" ADD CONSTRAINT "FKC4D50576368B326" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ORG_PHARMACY_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_PHARMACY_CRIT" ADD CONSTRAINT "FKF3FF789F4B784FE" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ORG_PHNO_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_PHNO_CRIT" ADD CONSTRAINT "FK6480D6047B9010B" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ORG_PWDDIC_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_PWDDIC_CRIT" ADD CONSTRAINT "FK93A7E17D84852DD" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ORG_RDFS_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."ORG_RDFS_CRIT" ADD CONSTRAINT "FKF768023935D569E" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PHARMACY_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."PHARMACY_CRIT" ADD CONSTRAINT "FK733C25E65B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PHYSICAL_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."PHYSICAL_CRIT" ADD CONSTRAINT "FK5BAB80425B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table POD_MED_LIC_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."POD_MED_LIC_CRIT" ADD CONSTRAINT "FKDF014C05B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table POD_MED_NAME_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."POD_MED_NAME_CRIT" ADD CONSTRAINT "FKB48E4FE15B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table RESULT_LOG_ENTRY
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."RESULT_LOG_ENTRY" ADD CONSTRAINT "FK44DF8E155B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SOCIAL_WORK_LIC_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."SOCIAL_WORK_LIC_CRIT" ADD CONSTRAINT "FK5D72280F5B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."SOCIAL_WORK_LIC_CRIT" ADD CONSTRAINT "FK5D72280FD6BEC610" FOREIGN KEY ("LICENSE_LEVEL_LU_ID")
	  REFERENCES "EXTSOURCES"."LICENSE_LEVEL_LU" ("LICENSE_LEVEL_LU_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SOCIAL_WORK_NAME_CRIT
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."SOCIAL_WORK_NAME_CRIT" ADD CONSTRAINT "FK554EA6725B2C7000" FOREIGN KEY ("SEARCH_CRITERIA_ID")
	  REFERENCES "EXTSOURCES"."SEARCH_CRITERIA" ("SEARCH_CRITERIA_ID") ENABLE;
 
  ALTER TABLE "EXTSOURCES"."SOCIAL_WORK_NAME_CRIT" ADD CONSTRAINT "FK554EA672D6BEC610" FOREIGN KEY ("LICENSE_LEVEL_LU_ID")
	  REFERENCES "EXTSOURCES"."LICENSE_LEVEL_LU" ("LICENSE_LEVEL_LU_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SPECIALTY_LU
--------------------------------------------------------

  ALTER TABLE "EXTSOURCES"."SPECIALTY_LU" ADD CONSTRAINT "FKB5CA646ABD51F1F0" FOREIGN KEY ("SPECIALTY_TYPE_LU_ID")
	  REFERENCES "EXTSOURCES"."SPECIALTY_TYPE_LU" ("SPECIALTY_TYPE_LU_ID") ENABLE;
