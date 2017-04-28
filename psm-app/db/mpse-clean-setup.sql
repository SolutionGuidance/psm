--------------------------------------------------------
--  File created - Monday-June-17-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence ATTACHMENT_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."ATTACHMENT_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence BOOLEANEXPR_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."BOOLEANEXPR_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence COMMENT_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."COMMENT_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence CONTENT_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."CONTENT_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 581 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence DEADLINE_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."DEADLINE_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence EMAILNOTIFHEAD_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."EMAILNOTIFHEAD_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence ESCALATION_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."ESCALATION_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence HIBERNATE_SEQUENCE
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."HIBERNATE_SEQUENCE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 541 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence I18NTEXT_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."I18NTEXT_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 661 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence NODE_INST_LOG_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."NODE_INST_LOG_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence NOTIFICATION_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."NOTIFICATION_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence PROC_INST_LOG_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."PROC_INST_LOG_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence PROVIDER_COS_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."PROVIDER_COS_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence REASSIGNMENT_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."REASSIGNMENT_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SESSIONINFO_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."SESSIONINFO_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 421 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence VAR_INST_LOG_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."VAR_INST_LOG_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence WORKITEMINFO_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CMS"."WORKITEMINFO_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1561 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table ADDRESS
--------------------------------------------------------

  CREATE TABLE "CMS"."ADDRESS" 
   (	"ADDRESS_ID" NUMBER(19,0), 
	"ATTN_TO" VARCHAR2(30 CHAR), 
	"LINE1" VARCHAR2(30 CHAR), 
	"LINE2" VARCHAR2(30 CHAR), 
	"CITY" VARCHAR2(20 CHAR), 
	"STATE" VARCHAR2(2 CHAR), 
	"ZIPCODE" VARCHAR2(10 CHAR), 
	"COUNTY" VARCHAR2(20 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table AGREEMENT_DOCUMENT
--------------------------------------------------------

  CREATE TABLE "CMS"."AGREEMENT_DOCUMENT" 
   (	"AGREEMENT_DOCUMENT_ID" NUMBER(19,0), 
	"DOC_TYPE" VARCHAR2(45 CHAR), 
	"TITLE" VARCHAR2(100 CHAR), 
	"VERSION" NUMBER(10,0), 
	"DOC_TEXT" CLOB, 
	"CREATED_BY" VARCHAR2(45 CHAR), 
	"CREATE_TS" TIMESTAMP (6)
   ) ;
--------------------------------------------------------
--  DDL for Table ATTACHMENT
--------------------------------------------------------

  CREATE TABLE "CMS"."ATTACHMENT" 
   (	"ID" NUMBER(19,0), 
	"ACCESSTYPE" NUMBER(10,0), 
	"ATTACHEDAT" TIMESTAMP (6), 
	"ATTACHMENTCONTENTID" NUMBER(19,0), 
	"CONTENTTYPE" VARCHAR2(255 CHAR), 
	"NAME" VARCHAR2(255 CHAR), 
	"ATTACHMENT_SIZE" NUMBER(10,0), 
	"ATTACHEDBY_ID" VARCHAR2(255 CHAR), 
	"TASKDATA_ATTACHMENTS_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table AUDIT_DETAIL
--------------------------------------------------------

  CREATE TABLE "CMS"."AUDIT_DETAIL" 
   (	"AUDIT_DETAIL_ID" NUMBER(19,0), 
	"AUDIT_RECORD_ID" NUMBER(19,0), 
	"TABLE_NAME" VARCHAR2(200 CHAR), 
	"COLUMN_NAME" VARCHAR2(200 CHAR), 
	"OLD_DATA" VARCHAR2(500 CHAR), 
	"NEW_DATA" VARCHAR2(500 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table AUDIT_RECORD
--------------------------------------------------------

  CREATE TABLE "CMS"."AUDIT_RECORD" 
   (	"AUDIT_RECORD_ID" NUMBER(19,0), 
	"USERNAME" VARCHAR2(45 CHAR), 
	"AUDIT_TS" TIMESTAMP (6), 
	"SYSTEM_ID" VARCHAR2(8 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table BENEFICIAL_OWNER
--------------------------------------------------------

  CREATE TABLE "CMS"."BENEFICIAL_OWNER" 
   (	"BENEFICIAL_OWNER_ID" NUMBER(19,0), 
	"PERSON_IND" VARCHAR2(1 CHAR), 
	"BEN_TYPE_CD" VARCHAR2(2 CHAR), 
	"OTH_TYPE_DESC" VARCHAR2(255 CHAR), 
	"SUBCONTRACTOR_NAME" VARCHAR2(255 CHAR), 
	"OWN_INTEREST_PCT" NUMBER(19,2), 
	"ADDRESS_ID" NUMBER(19,0), 
	"OTH_PROV_INTRST_IND" VARCHAR2(255 CHAR), 
	"OTH_PROV_NAME" VARCHAR2(255 CHAR), 
	"OTH_PROV_OWN_PCT" NUMBER(19,2), 
	"OTH_PROV_ADDRESS_ID" NUMBER(19,0), 
	"MIDDLE_NAME" VARCHAR2(255 CHAR), 
	"FIRST_NAME" VARCHAR2(255 CHAR), 
	"LAST_NAME" VARCHAR2(255 CHAR), 
	"SSN" VARCHAR2(255 CHAR), 
	"BIRTH_DT" DATE, 
	"HIRE_DT" DATE, 
	"RELATIONSHIP_TYP_CD" VARCHAR2(2 CHAR), 
	"OWNERSHIP_INFO_ID" NUMBER(19,0), 
	"IDX" NUMBER(10,0), 
	"FEIN" VARCHAR2(20 BYTE), 
	"LEGAL_NAME" VARCHAR2(400 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table BOOLEANEXPRESSION
--------------------------------------------------------

  CREATE TABLE "CMS"."BOOLEANEXPRESSION" 
   (	"ID" NUMBER(19,0), 
	"EXPRESSION" CLOB, 
	"TYPE" VARCHAR2(255 CHAR), 
	"ESCALATION_CONSTRAINTS_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table CMS_ATTACHMENT
--------------------------------------------------------

  CREATE TABLE "CMS"."CMS_ATTACHMENT" 
   (	"ATTACHMENT_ID" NUMBER(19,0), 
	"PROFILE_ID" NUMBER(19,0), 
	"TICKET_ID" NUMBER(19,0), 
	"TYPE" VARCHAR2(45 CHAR), 
	"FILE_NAME" VARCHAR2(300 BYTE), 
	"DESCRIPTION" VARCHAR2(45 CHAR), 
	"CONTENT_ID" VARCHAR2(255 CHAR), 
	"CREATED_BY" VARCHAR2(45 CHAR), 
	"CREATE_TS" TIMESTAMP (6)
   ) ;
--------------------------------------------------------
--  DDL for Table CMS_AUTHENTICATION
--------------------------------------------------------

  CREATE TABLE "CMS"."CMS_AUTHENTICATION" 
   (	"USERNAME" VARCHAR2(200 BYTE), 
	"PASSWORD" VARCHAR2(200 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table CMS_SEQUENCE
--------------------------------------------------------

  CREATE TABLE "CMS"."CMS_SEQUENCE" 
   (	"SEQ_NAME" VARCHAR2(255 BYTE), 
	"NEXT_HI" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table CMS_USER
--------------------------------------------------------

  CREATE TABLE "CMS"."CMS_USER" 
   (	"USER_ID" VARCHAR2(255 CHAR), 
	"USER_NAME" VARCHAR2(255 CHAR), 
	"FIRST_NAME" VARCHAR2(255 CHAR), 
	"LAST_NAME" VARCHAR2(255 CHAR), 
	"MIDDLE_NAME" VARCHAR2(255 CHAR), 
	"PHONE_NUMBER" VARCHAR2(255 CHAR), 
	"EMAIL" VARCHAR2(255 CHAR), 
	"STATUS" VARCHAR2(255 CHAR), 
	"ROLE_CD" VARCHAR2(2 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table CONTACT_INFO
--------------------------------------------------------

  CREATE TABLE "CMS"."CONTACT_INFO" 
   (	"CONTACT_INFO_ID" NUMBER(19,0), 
	"PHONE_NUMBER" VARCHAR2(30 CHAR), 
	"FAX_NUMBER" VARCHAR2(30 CHAR), 
	"EMAIL" VARCHAR2(50 CHAR), 
	"ADDRESS_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table CONTENT
--------------------------------------------------------

  CREATE TABLE "CMS"."CONTENT" 
   (	"ID" NUMBER(19,0), 
	"CONTENT" BLOB
   ) ;
--------------------------------------------------------
--  DDL for Table DEADLINE
--------------------------------------------------------

  CREATE TABLE "CMS"."DEADLINE" 
   (	"ID" NUMBER(19,0), 
	"DEADLINE_DATE" TIMESTAMP (6), 
	"ESCALATED" NUMBER(5,0), 
	"DEADLINES_STARTDEADLINE_ID" NUMBER(19,0), 
	"DEADLINES_ENDDEADLINE_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table DELEGATION_DELEGATES
--------------------------------------------------------

  CREATE TABLE "CMS"."DELEGATION_DELEGATES" 
   (	"TASK_ID" NUMBER(19,0), 
	"ENTITY_ID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table DESIGNATED_CONTACT
--------------------------------------------------------

  CREATE TABLE "CMS"."DESIGNATED_CONTACT" 
   (	"CONTROL_NO" NUMBER(19,0), 
	"PROFILE_ID" NUMBER(19,0), 
	"TICKET_ID" NUMBER(19,0), 
	"SAME_AS_PROVIDER_IND" VARCHAR2(1 CHAR), 
	"HIRE_DT" DATE, 
	"TYPE" VARCHAR2(255 CHAR), 
	"PERSON_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table DOCUMENT_CONTENT
--------------------------------------------------------

  CREATE TABLE "CMS"."DOCUMENT_CONTENT" 
   (	"CONTENT_ID" VARCHAR2(255 CHAR), 
	"RAW_CONTENT" BLOB
   ) ;
--------------------------------------------------------
--  DDL for Table EMAIL_HEADER
--------------------------------------------------------

  CREATE TABLE "CMS"."EMAIL_HEADER" 
   (	"ID" NUMBER(19,0), 
	"BODY" CLOB, 
	"FROMADDRESS" VARCHAR2(255 CHAR), 
	"LANGUAGE" VARCHAR2(255 CHAR), 
	"REPLYTOADDRESS" VARCHAR2(255 CHAR), 
	"SUBJECT" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table ENTITY
--------------------------------------------------------

  CREATE TABLE "CMS"."ENTITY" 
   (	"ENTITY_ID" NUMBER(19,0), 
	"PERSON_IND" VARCHAR2(1 CHAR), 
	"ENROLLED_IND" VARCHAR2(1 CHAR), 
	"PROFILE_ID" NUMBER(19,0), 
	"TICKET_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(100 CHAR), 
	"LEGAL_NAME" VARCHAR2(100 CHAR), 
	"LEGACY_IND" VARCHAR2(1 CHAR), 
	"NPI" VARCHAR2(10 CHAR), 
	"NPI_VERIFIED_IND" VARCHAR2(1 CHAR), 
	"NONEXCL_VERIFIED_IND" VARCHAR2(1 CHAR), 
	"PROVIDER_TYP_CD" VARCHAR2(2 CHAR), 
	"PRIMARY_CONTACT_ID" NUMBER(19,0), 
	"MIDDLE_NAME" VARCHAR2(50 CHAR), 
	"SSN" VARCHAR2(9 CHAR), 
	"SSN_VERIFIED_IND" VARCHAR2(1 CHAR), 
	"BIRTH_DT" DATE, 
	"DEGREE_CD" VARCHAR2(2 CHAR), 
	"DEGREE_AWARD_DT" DATE, 
	"PREFIX" VARCHAR2(50 CHAR), 
	"SUFFIX" VARCHAR2(50 CHAR), 
	"FIRST_NAME" VARCHAR2(50 CHAR), 
	"LAST_NAME" VARCHAR2(50 CHAR), 
	"STATE_TAX_ID" VARCHAR2(10 CHAR), 
	"FEIN" VARCHAR2(10 BYTE), 
	"AGENCY_ID" VARCHAR2(100 CHAR), 
	"BGS_ID" VARCHAR2(100 CHAR), 
	"BGS_CLEARANCE_DT" DATE, 
	"SAME_BILLING_ADDRESS_IND" VARCHAR2(1 CHAR), 
	"SAME_REIMBURSEMENT_ADDRESS_IND" VARCHAR2(1 CHAR), 
	"SAME_1099_ADDRESS_IND" VARCHAR2(1 CHAR), 
	"BILLING_ADDRESS_ID" NUMBER(19,0), 
	"REIMBURSEMENT_ADDRESS_ID" NUMBER(19,0), 
	"TEN99_ADDRESS_ID" NUMBER(19,0), 
	"FISCAL_YEAR_END" VARCHAR2(5 CHAR), 
	"REMITTANCE_SEQUENCE_ORDER" VARCHAR2(255 CHAR), 
	"EFT_VENDOR_NUMBER" VARCHAR2(14 CHAR), 
	"SUB_TYP" VARCHAR2(100 BYTE), 
	"NPI_LU_VERIFIED_IND" VARCHAR2(1 CHAR), 
	"LEGACY_ID" VARCHAR2(9 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table ESCALATION
--------------------------------------------------------

  CREATE TABLE "CMS"."ESCALATION" 
   (	"ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255 CHAR), 
	"DEADLINE_ESCALATION_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table EVENT
--------------------------------------------------------

  CREATE TABLE "CMS"."EVENT" 
   (	"EVENT_ID" NUMBER(19,0), 
	"NPI" VARCHAR2(10 CHAR), 
	"TICKET_ID" NUMBER(19,0), 
	"STATUS_CD" VARCHAR2(2 CHAR), 
	"CREATED_BY" VARCHAR2(50 CHAR), 
	"CREATE_TS" TIMESTAMP (6)
   ) ;
--------------------------------------------------------
--  DDL for Table EVENTTYPES
--------------------------------------------------------

  CREATE TABLE "CMS"."EVENTTYPES" 
   (	"INSTANCEID" NUMBER(19,0), 
	"EVENTTYPES" VARCHAR2(255 CHAR), 
	"ELEMENT" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table EXTERNAL_ACCOUNT_LINK
--------------------------------------------------------

  CREATE TABLE "CMS"."EXTERNAL_ACCOUNT_LINK" 
   (	"EXTERNAL_ACCOUNT_LINK_ID" NUMBER(19,0), 
	"USER_ID" VARCHAR2(255 CHAR), 
	"SYSTEM_ID" VARCHAR2(255 CHAR), 
	"EXTERNAL_USER_ID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table EXTERNAL_PROFILE_LINK
--------------------------------------------------------

  CREATE TABLE "CMS"."EXTERNAL_PROFILE_LINK" 
   (	"EXTERNAL_PROFILE_LINK_ID" NUMBER(19,0), 
	"PROFILE_ID" NUMBER(19,0), 
	"SYSTEM_ID" VARCHAR2(255 CHAR), 
	"EXTERNAL_PROFILE_ID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table HELP_ITEM
--------------------------------------------------------

  CREATE TABLE "CMS"."HELP_ITEM" 
   (	"HELP_ITEM_ID" NUMBER(19,0), 
	"TITLE" VARCHAR2(45 CHAR), 
	"DESCRIPTION" VARCHAR2(2048 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table I18NTEXT
--------------------------------------------------------

  CREATE TABLE "CMS"."I18NTEXT" 
   (	"ID" NUMBER(19,0), 
	"LANGUAGE" VARCHAR2(255 CHAR), 
	"TEXT" CLOB, 
	"TASK_SUBJECTS_ID" NUMBER(19,0), 
	"TASK_NAMES_ID" NUMBER(19,0), 
	"TASK_DESCRIPTIONS_ID" NUMBER(19,0), 
	"DEADLINE_DOCUMENTATION_ID" NUMBER(19,0), 
	"NOTIFICATION_SUBJECTS_ID" NUMBER(19,0), 
	"NOTIFICATION_NAMES_ID" NUMBER(19,0), 
	"NOTIFICATION_DOCUMENTATION_ID" NUMBER(19,0), 
	"NOTIFICATION_DESCRIPTIONS_ID" NUMBER(19,0), 
	"REASSIGNMENT_DOCUMENTATION_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table LEGACY_MAPPING
--------------------------------------------------------

  CREATE TABLE "CMS"."LEGACY_MAPPING" 
   (	"LEGACY_MAPPING_ID" NUMBER(19,0), 
	"SYSTEM_NM" VARCHAR2(200 CHAR), 
	"CODE_TYPE" VARCHAR2(200 CHAR), 
	"INTERNAL_CODE" VARCHAR2(200 CHAR), 
	"EXTERNAL_CODE" VARCHAR2(200 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LICENSE
--------------------------------------------------------

  CREATE TABLE "CMS"."LICENSE" 
   (	"LICENSE_ID" NUMBER(19,0), 
	"PROFILE_ID" NUMBER(19,0), 
	"TICKET_ID" NUMBER(19,0), 
	"OBJECT_TYP" VARCHAR2(1 CHAR), 
	"SPECIALTY_TYP_CD" VARCHAR2(2 CHAR), 
	"LICENSE_TYP_CD" VARCHAR2(2 CHAR), 
	"LICENSE_NUMBER" VARCHAR2(45 CHAR), 
	"ORIGINAL_ISSUE_DT" DATE, 
	"RENEWAL_END_DT" DATE, 
	"ISSUING_US_STATE" VARCHAR2(2 CHAR), 
	"ATTACHMENT_ID" NUMBER(19,0), 
	"LICENSE_STATUS_CD" VARCHAR2(2 CHAR), 
	"ISSUING_BOARD_CD" VARCHAR2(2 CHAR), 
	"AFFILIATE_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_BEN_OWNER_TYP
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_BEN_OWNER_TYP" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR), 
	"OWNER_TYPE" CHAR(1 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_CORP_STRUCTURE_TYP
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_CORP_STRUCTURE_TYP" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_COS
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_COS" 
   (	"CODE" VARCHAR2(3 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_COUNTY
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_COUNTY" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_DEGREE
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_DEGREE" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_ISSUING_BOARD
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_ISSUING_BOARD" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_LICENSE_STATUS
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_LICENSE_STATUS" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_LICENSE_TYPE
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_LICENSE_TYPE" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_OWNERSHIP_TYP
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_OWNERSHIP_TYP" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_PAYTO_TYPE
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_PAYTO_TYPE" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_PROFILE_STATUS
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_PROFILE_STATUS" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_PROVIDER_TYPE
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_PROVIDER_TYPE" 
   (	"CODE" VARCHAR2(2 BYTE), 
	"DESCRIPTION" VARCHAR2(255 BYTE), 
	"APPLICANT_TYP" NUMBER(10,0) DEFAULT 0, 
	"AGREEMENT_ID" NUMBER(19,0), 
	"ADDENDUM_ID" NUMBER(19,0), 
	"PRIVATE_OFFICE_FLG" CHAR(1 CHAR), 
	"EMPLOYED_CONTRACTED_FLG" CHAR(1 CHAR), 
	"ADDITONAL_PRACTICE_FLG" CHAR(1 CHAR), 
	"PAYMENT_REQUIRED_FLG" CHAR(1 CHAR), 
	"AGREEMENT_FLG" CHAR(1 CHAR), 
	"ADDENDUM_FLG" CHAR(1 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_QP_TYP
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_QP_TYP" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_RELATIONSHIP_TYP
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_RELATIONSHIP_TYP" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_REQUEST_TYP
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_REQUEST_TYP" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_RISK_LEVEL
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_RISK_LEVEL" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"SORT_IDX" NUMBER(10,0), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_ROLE
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_ROLE" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_SPECIALTY_TYPE
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_SPECIALTY_TYPE" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR), 
	"SUB_CAT_CD" VARCHAR2(2 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_STATE
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_STATE" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_SVC_ASSURANCE_EXT_TYP
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_SVC_ASSURANCE_EXT_TYP" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR), 
	"SVC_ASSURANCE_CD" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_SVC_ASSURANCE_TYP
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_SVC_ASSURANCE_TYP" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR), 
	"PATIENT_IND" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_SVC_CAT
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_SVC_CAT" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LU_TICKET_STATUS
--------------------------------------------------------

  CREATE TABLE "CMS"."LU_TICKET_STATUS" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table NODEINSTANCELOG
--------------------------------------------------------

  CREATE TABLE "CMS"."NODEINSTANCELOG" 
   (	"ID" NUMBER(19,0), 
	"LOG_DATE" TIMESTAMP (6), 
	"NODEID" VARCHAR2(255 CHAR), 
	"NODEINSTANCEID" VARCHAR2(255 CHAR), 
	"NODENAME" VARCHAR2(255 CHAR), 
	"PROCESSID" VARCHAR2(255 CHAR), 
	"PROCESSINSTANCEID" NUMBER(19,0), 
	"TYPE" NUMBER(10,0)
   ) ;
--------------------------------------------------------
--  DDL for Table NOTIFICATION
--------------------------------------------------------

  CREATE TABLE "CMS"."NOTIFICATION" 
   (	"DTYPE" VARCHAR2(31 CHAR), 
	"ID" NUMBER(19,0), 
	"PRIORITY" NUMBER(10,0), 
	"ESCALATION_NOTIFICATIONS_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table NOTIFICATION_BAS
--------------------------------------------------------

  CREATE TABLE "CMS"."NOTIFICATION_BAS" 
   (	"TASK_ID" NUMBER(19,0), 
	"ENTITY_ID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table NOTIFICATION_EMAIL_HEADER
--------------------------------------------------------

  CREATE TABLE "CMS"."NOTIFICATION_EMAIL_HEADER" 
   (	"NOTIFICATION_ID" NUMBER(19,0), 
	"EMAILHEADERS_ID" NUMBER(19,0), 
	"MAPKEY" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table NOTIFICATION_RECIPIENTS
--------------------------------------------------------

  CREATE TABLE "CMS"."NOTIFICATION_RECIPIENTS" 
   (	"TASK_ID" NUMBER(19,0), 
	"ENTITY_ID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table ORGANIZATIONALENTITY
--------------------------------------------------------

  CREATE TABLE "CMS"."ORGANIZATIONALENTITY" 
   (	"DTYPE" VARCHAR2(31 CHAR), 
	"ID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table OWNERSHIP_INFO
--------------------------------------------------------

  CREATE TABLE "CMS"."OWNERSHIP_INFO" 
   (	"OWNERSHIP_INFO_ID" NUMBER(19,0), 
	"PROFILE_ID" NUMBER(19,0), 
	"TICKET_ID" NUMBER(19,0), 
	"ENTITY_TYP_CD" VARCHAR2(2 CHAR), 
	"ENTITY_SUBTYP_CD" VARCHAR2(2 CHAR), 
	"OTH_ENTITY_TYP_DESC" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table OWNER_ASSET
--------------------------------------------------------

  CREATE TABLE "CMS"."OWNER_ASSET" 
   (	"OWNER_ASSET_ID" NUMBER(19,0), 
	"TYPE" VARCHAR2(255 CHAR), 
	"NAME" VARCHAR2(255 CHAR), 
	"ADDRESS_ID" NUMBER(19,0), 
	"OWNERSHIP_TYP_CD" VARCHAR2(2 CHAR), 
	"OWNERSHIP_INFO_ID" NUMBER(19,0), 
	"IDX" NUMBER(10,0)
   ) ;
--------------------------------------------------------
--  DDL for Table PEOPLEASSIGNMENTS_BAS
--------------------------------------------------------

  CREATE TABLE "CMS"."PEOPLEASSIGNMENTS_BAS" 
   (	"TASK_ID" NUMBER(19,0), 
	"ENTITY_ID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table PEOPLEASSIGNMENTS_EXCLOWNERS
--------------------------------------------------------

  CREATE TABLE "CMS"."PEOPLEASSIGNMENTS_EXCLOWNERS" 
   (	"TASK_ID" NUMBER(19,0), 
	"ENTITY_ID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table PEOPLEASSIGNMENTS_POTOWNERS
--------------------------------------------------------

  CREATE TABLE "CMS"."PEOPLEASSIGNMENTS_POTOWNERS" 
   (	"TASK_ID" NUMBER(19,0), 
	"ENTITY_ID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table PEOPLEASSIGNMENTS_RECIPIENTS
--------------------------------------------------------

  CREATE TABLE "CMS"."PEOPLEASSIGNMENTS_RECIPIENTS" 
   (	"TASK_ID" NUMBER(19,0), 
	"ENTITY_ID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table PEOPLEASSIGNMENTS_STAKEHOLDERS
--------------------------------------------------------

  CREATE TABLE "CMS"."PEOPLEASSIGNMENTS_STAKEHOLDERS" 
   (	"TASK_ID" NUMBER(19,0), 
	"ENTITY_ID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table PERSISTENT_LOGINS
--------------------------------------------------------

  CREATE TABLE "CMS"."PERSISTENT_LOGINS" 
   (	"USERNAME" VARCHAR2(64 BYTE), 
	"SERIES" VARCHAR2(64 BYTE), 
	"TOKEN" VARCHAR2(64 BYTE), 
	"LAST_USED" TIMESTAMP (6)
   ) ;
--------------------------------------------------------
--  DDL for Table PROCESSINSTANCEINFO
--------------------------------------------------------

  CREATE TABLE "CMS"."PROCESSINSTANCEINFO" 
   (	"INSTANCEID" NUMBER(19,0), 
	"OPTLOCK" NUMBER(10,0), 
	"PROCESSID" VARCHAR2(255 CHAR), 
	"STARTDATE" TIMESTAMP (6), 
	"LASTREADDATE" TIMESTAMP (6), 
	"LASTMODIFICATIONDATE" TIMESTAMP (6), 
	"STATE" NUMBER(10,0), 
	"PROCESSINSTANCEBYTEARRAY" BLOB, 
	"ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table PROCESSINSTANCELOG
--------------------------------------------------------

  CREATE TABLE "CMS"."PROCESSINSTANCELOG" 
   (	"ID" NUMBER(19,0), 
	"END_DATE" TIMESTAMP (6), 
	"PROCESSID" VARCHAR2(255 CHAR), 
	"PROCESSINSTANCEID" NUMBER(19,0), 
	"START_DATE" TIMESTAMP (6)
   ) ;
--------------------------------------------------------
--  DDL for Table PROFILE_ASSURED_EXT_SVCS
--------------------------------------------------------

  CREATE TABLE "CMS"."PROFILE_ASSURED_EXT_SVCS" 
   (	"PROFILE_ASSURED_SVC_ID" NUMBER(19,0), 
	"ELT" VARCHAR2(2 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table PROFILE_ASSURED_SVC_XREF
--------------------------------------------------------

  CREATE TABLE "CMS"."PROFILE_ASSURED_SVC_XREF" 
   (	"PROFILE_ASSURED_SVC_ID" NUMBER(19,0), 
	"EFF_DT" DATE, 
	"SVC_ASSURANCE_CD" VARCHAR2(2 CHAR), 
	"PROFILE_ID" NUMBER(19,0), 
	"TICKET_ID" NUMBER(19,0), 
	"STATUS" NUMBER(10,0)
   ) ;
--------------------------------------------------------
--  DDL for Table PROFILE_GRP_XREF
--------------------------------------------------------

  CREATE TABLE "CMS"."PROFILE_GRP_XREF" 
   (	"PROFILE_GRP_XREF_ID" NUMBER(19,0), 
	"PRIMARY_IND" VARCHAR2(1 CHAR), 
	"EFF_DT" DATE, 
	"PROFILE_ID" NUMBER(19,0), 
	"TICKET_ID" NUMBER(19,0), 
	"OBJECT_TYP" VARCHAR2(1 CHAR), 
	"TARGET_PROFILE_ID" NUMBER(19,0), 
	"TARGET_ENTITY_ID" NUMBER(19,0), 
	"QP_TYP_CD" CHAR(2 BYTE), 
	"TERM_IND" CHAR(1 BYTE), 
	"TERM_DT" DATE, 
	"ACK_ID" VARCHAR2(200 BYTE), 
	"MHP_TYPE" VARCHAR2(75 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table PROFILE_NOTES
--------------------------------------------------------

  CREATE TABLE "CMS"."PROFILE_NOTES" 
   (	"PROVIDER_NOTE_ID" NUMBER(19,0), 
	"PROFILE_ID" NUMBER(19,0), 
	"TICKET_ID" NUMBER(19,0), 
	"NOTE_TXT" VARCHAR2(255 CHAR), 
	"CREATED_BY" VARCHAR2(255 CHAR), 
	"CREATE_TS" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table PROFILE_PAYTO_XREF
--------------------------------------------------------

  CREATE TABLE "CMS"."PROFILE_PAYTO_XREF" 
   (	"PROFILE_PAYTO_XREF_ID" NUMBER(19,0), 
	"EFF_DT" DATE, 
	"PAYTO_TYP_CD" VARCHAR2(2 CHAR), 
	"PROFILE_ID" NUMBER(19,0), 
	"TICKET_ID" NUMBER(19,0), 
	"TARGET_PROFILE_ID" NUMBER(19,0), 
	"NAME" VARCHAR2(200 BYTE), 
	"CONTACT_NAME" VARCHAR2(200 BYTE), 
	"NPI" VARCHAR2(10 BYTE), 
	"PHONE_NUMBER" VARCHAR2(100 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table PROVIDER_AGREEMENT_XREF
--------------------------------------------------------

  CREATE TABLE "CMS"."PROVIDER_AGREEMENT_XREF" 
   (	"PROVIDER_AGREEMENT_XREF_ID" NUMBER(19,0), 
	"PROFILEID" NUMBER(19,0), 
	"TICKETID" NUMBER(19,0), 
	"ACCEPTED_DATE" DATE, 
	"AGREEMENT_DOCUMENT_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table PROVIDER_COS
--------------------------------------------------------

  CREATE TABLE "CMS"."PROVIDER_COS" 
   (	"PROVIDER_COS_ID" NUMBER(19,0), 
	"PROVIDER_COS_CD" VARCHAR2(3 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table PROVIDER_COS_XREF
--------------------------------------------------------

  CREATE TABLE "CMS"."PROVIDER_COS_XREF" 
   (	"PROVIDER_COS_ID" NUMBER(19,0), 
	"PROFILE_ID" NUMBER(19,0) DEFAULT 0, 
	"TICKET_ID" NUMBER(19,0) DEFAULT 0, 
	"START_DT" TIMESTAMP (6), 
	"END_DT" TIMESTAMP (6)
   ) ;
--------------------------------------------------------
--  DDL for Table PROVIDER_PROFILE
--------------------------------------------------------

  CREATE TABLE "CMS"."PROVIDER_PROFILE" 
   (	"CONTROL_NO" NUMBER(19,0), 
	"PROFILE_ID" NUMBER(19,0) DEFAULT 0, 
	"TICKET_ID" NUMBER(19,0) DEFAULT 0, 
	"EFFECTIVE_DT" DATE, 
	"PROFILE_STATUS_CD" VARCHAR2(2 CHAR), 
	"REFERENCE_TICKET_ID" NUMBER(19,0) DEFAULT 0, 
	"RESERVATION_EMP_IND" VARCHAR2(1 CHAR), 
	"PRIVATE_PRACTICE_IND" VARCHAR2(1 CHAR), 
	"GROUP_PRACTICE_IND" VARCHAR2(1 CHAR), 
	"CRIMINAL_CONVICTION_IND" VARCHAR2(1 CHAR), 
	"CIVIL_PENALTY_IND" VARCHAR2(1 CHAR), 
	"PREV_EXCLUSION_IND" VARCHAR2(1 CHAR), 
	"ADULT_IND" VARCHAR2(1 CHAR), 
	"COUNTY_NAME" VARCHAR2(200 BYTE), 
	"CONT_EMPLY_IND" VARCHAR2(1 CHAR), 
	"RISK_LEVEL_CD" VARCHAR2(2 CHAR), 
	"OWNER_ID" VARCHAR2(45 CHAR), 
	"CREATED_BY" VARCHAR2(45 CHAR), 
	"CREATE_TS" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(45 CHAR), 
	"LAST_UPDATED_TS" TIMESTAMP (6), 
	"EMP_CRIMINAL_CONVICTION_IND" CHAR(1 BYTE), 
	"EMP_CIVIL_PENALTY_IND" CHAR(1 BYTE), 
	"EMP_PREV_EXCLUSION_IND" CHAR(1 BYTE), 
	"BED_COUNT" NUMBER, 
	"BED_COUNT_DT" DATE, 
	"FORM_COMPLETED_BY" VARCHAR2(200 BYTE), 
	"HLTH_BRD_IND" CHAR(1 BYTE), 
	"TITLE_18_BED_COUNT" NUMBER, 
	"TITLE_19_BED_COUNT" NUMBER, 
	"DUAL_CERT_BED_COUNT" NUMBER, 
	"ICF_BED_COUNT" NUMBER, 
	"PT_OT_IND" CHAR(1 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table PROVIDER_SETTING
--------------------------------------------------------

  CREATE TABLE "CMS"."PROVIDER_SETTING" 
   (	"PROVIDER_SETTING_ID" NUMBER(19,0), 
	"PROVIDER_TYP_CD" VARCHAR2(255 CHAR), 
	"REL_TYP" VARCHAR2(2 CHAR), 
	"RELATED_ENTITY_TYP" VARCHAR2(255 CHAR), 
	"RELATED_ENTITY_CD" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table PROVIDER_STATEMENT
--------------------------------------------------------

  CREATE TABLE "CMS"."PROVIDER_STATEMENT" 
   (	"PROVIDER_STATEMENT_ID" NUMBER(19,0), 
	"PROFILEID" NUMBER(19,0), 
	"TICKETID" NUMBER(19,0), 
	"NAME" VARCHAR2(45 CHAR), 
	"TITLE" VARCHAR2(45 CHAR), 
	"STATEMENT_DT" DATE, 
	"SIGN_ATTACHEMENT_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table PROVIDER_SVCS
--------------------------------------------------------

  CREATE TABLE "CMS"."PROVIDER_SVCS" 
   (	"PROVIDER_SVCS_ID" NUMBER(19,0), 
	"PROFILE_ID" NUMBER(19,0), 
	"TICKET_ID" NUMBER(19,0), 
	"SVC_CAT_CD" VARCHAR2(2 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table PROVIDER_TYPE_REQ_FIELDS
--------------------------------------------------------

  CREATE TABLE "CMS"."PROVIDER_TYPE_REQ_FIELDS" 
   (	"PROVIDER_TYPE_CD" VARCHAR2(2 CHAR), 
	"REQUIRED_FIELD_CD" VARCHAR2(2 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table REASSIGNMENT
--------------------------------------------------------

  CREATE TABLE "CMS"."REASSIGNMENT" 
   (	"ID" NUMBER(19,0), 
	"ESCALATION_REASSIGNMENTS_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table REASSIGNMENT_POTENTIALOWNERS
--------------------------------------------------------

  CREATE TABLE "CMS"."REASSIGNMENT_POTENTIALOWNERS" 
   (	"TASK_ID" NUMBER(19,0), 
	"ENTITY_ID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table REQUIRED_FLD
--------------------------------------------------------

  CREATE TABLE "CMS"."REQUIRED_FLD" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR), 
	"REQUIRED_FLD_TYPE_ID" VARCHAR2(2 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table REQUIRED_FLD_TYPE
--------------------------------------------------------

  CREATE TABLE "CMS"."REQUIRED_FLD_TYPE" 
   (	"CODE" VARCHAR2(2 CHAR), 
	"DESCRIPTION" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table SCREENING_SCHEDULE
--------------------------------------------------------

  CREATE TABLE "CMS"."SCREENING_SCHEDULE" 
   (	"SCREENING_SCHEDULE_ID" NUMBER(19,0), 
	"UPCOMING_SCREENING_DT" TIMESTAMP (6), 
	"INTERVAL_TYPE" VARCHAR2(255 CHAR), 
	"INTERVAL_VALUE" NUMBER(10,0) DEFAULT 0
   ) ;
--------------------------------------------------------
--  DDL for Table SESSIONINFO
--------------------------------------------------------

  CREATE TABLE "CMS"."SESSIONINFO" 
   (	"ID" NUMBER(10,0), 
	"LASTMODIFICATIONDATE" TIMESTAMP (6), 
	"RULESBYTEARRAY" BLOB, 
	"STARTDATE" TIMESTAMP (6), 
	"OPTLOCK" NUMBER(10,0)
   ) ;
--------------------------------------------------------
--  DDL for Table SUBTASKSSTRATEGY
--------------------------------------------------------

  CREATE TABLE "CMS"."SUBTASKSSTRATEGY" 
   (	"DTYPE" VARCHAR2(100 CHAR), 
	"ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255 CHAR), 
	"TASK_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table TASK
--------------------------------------------------------

  CREATE TABLE "CMS"."TASK" 
   (	"ID" NUMBER(19,0), 
	"ARCHIVED" NUMBER(5,0), 
	"ALLOWEDTODELEGATE" VARCHAR2(255 CHAR), 
	"PRIORITY" NUMBER(10,0), 
	"ACTIVATIONTIME" TIMESTAMP (6), 
	"CREATEDON" TIMESTAMP (6), 
	"DOCUMENTACCESSTYPE" NUMBER(10,0), 
	"DOCUMENTCONTENTID" NUMBER(19,0), 
	"DOCUMENTTYPE" VARCHAR2(255 CHAR), 
	"EXPIRATIONTIME" TIMESTAMP (6), 
	"FAULTACCESSTYPE" NUMBER(10,0), 
	"FAULTCONTENTID" NUMBER(19,0), 
	"FAULTNAME" VARCHAR2(255 CHAR), 
	"FAULTTYPE" VARCHAR2(255 CHAR), 
	"OUTPUTACCESSTYPE" NUMBER(10,0), 
	"OUTPUTCONTENTID" NUMBER(19,0), 
	"OUTPUTTYPE" VARCHAR2(255 CHAR), 
	"PARENTID" NUMBER(19,0), 
	"PREVIOUSSTATUS" NUMBER(10,0), 
	"PROCESSID" VARCHAR2(255 CHAR), 
	"PROCESSINSTANCEID" NUMBER(19,0), 
	"PROCESSSESSIONID" NUMBER(10,0), 
	"SKIPABLE" NUMBER(1,0), 
	"STATUS" VARCHAR2(255 CHAR), 
	"WORKITEMID" NUMBER(19,0), 
	"OPTLOCK" NUMBER(10,0), 
	"TASKINITIATOR_ID" VARCHAR2(255 CHAR), 
	"ACTUALOWNER_ID" VARCHAR2(255 CHAR), 
	"CREATEDBY_ID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table TASK_COMMENT
--------------------------------------------------------

  CREATE TABLE "CMS"."TASK_COMMENT" 
   (	"ID" NUMBER(19,0), 
	"ADDEDAT" TIMESTAMP (6), 
	"TEXT" CLOB, 
	"ADDEDBY_ID" VARCHAR2(255 CHAR), 
	"TASKDATA_COMMENTS_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table TICKET
--------------------------------------------------------

  CREATE TABLE "CMS"."TICKET" 
   (	"TICKET_ID" NUMBER(19,0), 
	"STATUS_CD" VARCHAR2(2 CHAR), 
	"REQUEST_TYP_CD" VARCHAR2(2 CHAR), 
	"PROCESS_INSTANCE_ID" NUMBER(19,0) DEFAULT 0, 
	"REF_PROFILE_ID" NUMBER(19,0) DEFAULT 0, 
	"SUBMISSION_TS" TIMESTAMP (6), 
	"STATUS_TS" TIMESTAMP (6), 
	"STATUS_NOTE_TXT" VARCHAR2(1000 CHAR), 
	"SUBMITTED_BY" VARCHAR2(50 CHAR), 
	"CREATED_BY" VARCHAR2(50 CHAR), 
	"CREATE_TS" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(50 CHAR), 
	"PROGRESS_PAGE" VARCHAR2(100 CHAR), 
	"REF_PROFILE_TS" TIMESTAMP (6)
   ) ;
--------------------------------------------------------
--  DDL for Table VARIABLEINSTANCELOG
--------------------------------------------------------

  CREATE TABLE "CMS"."VARIABLEINSTANCELOG" 
   (	"ID" NUMBER(19,0), 
	"LOG_DATE" TIMESTAMP (6), 
	"PROCESSID" VARCHAR2(255 CHAR), 
	"PROCESSINSTANCEID" NUMBER(19,0), 
	"VALUE" VARCHAR2(255 CHAR), 
	"VARIABLEID" VARCHAR2(255 CHAR), 
	"VARIABLEINSTANCEID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table WORKITEMINFO
--------------------------------------------------------

  CREATE TABLE "CMS"."WORKITEMINFO" 
   (	"WORKITEMID" NUMBER(19,0), 
	"CREATIONDATE" TIMESTAMP (6), 
	"NAME" VARCHAR2(255 CHAR), 
	"PROCESSINSTANCEID" NUMBER(19,0), 
	"STATE" NUMBER(19,0), 
	"OPTLOCK" NUMBER(10,0), 
	"WORKITEMBYTEARRAY" BLOB
   ) ;
--------------------------------------------------------
--  DDL for Index SYS_C004087
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004087" ON "CMS"."SCREENING_SCHEDULE" ("SCREENING_SCHEDULE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004028
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004028" ON "CMS"."LU_QP_TYP" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004018
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004018" ON "CMS"."LU_TICKET_STATUS" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004184
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004184" ON "CMS"."AUDIT_RECORD" ("AUDIT_RECORD_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004128
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004128" ON "CMS"."TICKET" ("TICKET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004014
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004014" ON "CMS"."EXTERNAL_PROFILE_LINK" ("EXTERNAL_PROFILE_LINK_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004175
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004175" ON "CMS"."CMS_ATTACHMENT" ("ATTACHMENT_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004155
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004155" ON "CMS"."LU_CORP_STRUCTURE_TYP" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004149
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004149" ON "CMS"."PROFILE_NOTES" ("PROVIDER_NOTE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004121
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004121" ON "CMS"."LU_REQUEST_TYP" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004012
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004012" ON "CMS"."LU_STATE" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004169
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004169" ON "CMS"."TASK_COMMENT" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004054
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004054" ON "CMS"."ESCALATION" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004069
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004069" ON "CMS"."LU_PAYTO_TYPE" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004190
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004190" ON "CMS"."OWNERSHIP_INFO" ("OWNERSHIP_INFO_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004112
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004112" ON "CMS"."PROVIDER_PROFILE" ("CONTROL_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004001
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004001" ON "CMS"."LU_SPECIALTY_TYPE" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004151
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004151" ON "CMS"."LICENSE" ("LICENSE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C003997
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C003997" ON "CMS"."PROFILE_PAYTO_XREF" ("PROFILE_PAYTO_XREF_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0072362
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C0072362" ON "CMS"."LU_PROVIDER_TYPE" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004116
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004116" ON "CMS"."OWNER_ASSET" ("OWNER_ASSET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004047
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004047" ON "CMS"."DOCUMENT_CONTENT" ("CONTENT_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004269
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004269" ON "CMS"."LU_COUNTY" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004158
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004158" ON "CMS"."PROVIDER_STATEMENT" ("PROVIDER_STATEMENT_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004181
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004181" ON "CMS"."NOTIFICATION_EMAIL_HEADER" ("NOTIFICATION_ID", "MAPKEY") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004093
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004093" ON "CMS"."WORKITEMINFO" ("WORKITEMID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004036
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004036" ON "CMS"."EMAIL_HEADER" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004038
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004038" ON "CMS"."EXTERNAL_ACCOUNT_LINK" ("EXTERNAL_ACCOUNT_LINK_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004058
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004058" ON "CMS"."DESIGNATED_CONTACT" ("CONTROL_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004153
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004153" ON "CMS"."I18NTEXT" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004119
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004119" ON "CMS"."VARIABLEINSTANCELOG" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004103
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004103" ON "CMS"."LU_BEN_OWNER_TYP" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004177
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004177" ON "CMS"."EVENT" ("EVENT_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004173
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004173" ON "CMS"."LU_DEGREE" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0071426
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C0071426" ON "CMS"."CMS_SEQUENCE" ("SEQ_NAME") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004097
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004097" ON "CMS"."NOTIFICATION" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004010
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004010" ON "CMS"."LU_LICENSE_STATUS" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004186
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004186" ON "CMS"."LU_PROFILE_STATUS" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004164
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004164" ON "CMS"."NODEINSTANCELOG" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004089
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004089" ON "CMS"."LU_ROLE" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004101
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004101" ON "CMS"."ADDRESS" ("ADDRESS_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004027
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004027" ON "CMS"."BOOLEANEXPRESSION" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004145
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004145" ON "CMS"."REQUIRED_FLD" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004008
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004008" ON "CMS"."DEADLINE" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004061
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004061" ON "CMS"."SUBTASKSSTRATEGY" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004136
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004136" ON "CMS"."PROVIDER_SETTING" ("PROVIDER_SETTING_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004056
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004056" ON "CMS"."REASSIGNMENT" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004063
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004063" ON "CMS"."LU_LICENSE_TYPE" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004099
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004099" ON "CMS"."LU_RISK_LEVEL" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C003995
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C003995" ON "CMS"."REQUIRED_FLD_TYPE" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004041
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004041" ON "CMS"."PROCESSINSTANCELOG" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004134
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004134" ON "CMS"."LU_OWNERSHIP_TYP" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004082
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004082" ON "CMS"."PROVIDER_AGREEMENT_XREF" ("PROVIDER_AGREEMENT_XREF_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004022
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004022" ON "CMS"."PERSISTENT_LOGINS" ("SERIES") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004006
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004006" ON "CMS"."PROCESSINSTANCEINFO" ("INSTANCEID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004050
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004050" ON "CMS"."LU_SVC_CAT" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004167
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004167" ON "CMS"."BENEFICIAL_OWNER" ("BENEFICIAL_OWNER_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004032
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004032" ON "CMS"."SESSIONINFO" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004139
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004139" ON "CMS"."ORGANIZATIONALENTITY" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004147
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004147" ON "CMS"."CMS_USER" ("USER_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004124
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004124" ON "CMS"."ENTITY" ("ENTITY_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004084
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004084" ON "CMS"."HELP_ITEM" ("HELP_ITEM_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004114
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004114" ON "CMS"."AUDIT_DETAIL" ("AUDIT_DETAIL_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004052
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004052" ON "CMS"."PROFILE_GRP_XREF" ("PROFILE_GRP_XREF_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004141
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004141" ON "CMS"."CONTENT" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004104
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004104" ON "CMS"."PROVIDER_SVCS" ("PROVIDER_SVCS_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004034
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004034" ON "CMS"."LU_RELATIONSHIP_TYP" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004065
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004065" ON "CMS"."LU_ISSUING_BOARD" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004080
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004080" ON "CMS"."TASK" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004160
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004160" ON "CMS"."AGREEMENT_DOCUMENT" ("AGREEMENT_DOCUMENT_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004044
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004044" ON "CMS"."ATTACHMENT" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C004067
--------------------------------------------------------

  CREATE UNIQUE INDEX "CMS"."SYS_C004067" ON "CMS"."CONTACT_INFO" ("CONTACT_INFO_ID") 
  ;
--------------------------------------------------------
--  Constraints for Table REQUIRED_FLD_TYPE
--------------------------------------------------------

  ALTER TABLE "CMS"."REQUIRED_FLD_TYPE" ADD CONSTRAINT "SYS_C003995" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."REQUIRED_FLD_TYPE" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROFILE_PAYTO_XREF
--------------------------------------------------------

  ALTER TABLE "CMS"."PROFILE_PAYTO_XREF" ADD CONSTRAINT "SYS_C003997" PRIMARY KEY ("PROFILE_PAYTO_XREF_ID") ENABLE;
 
  ALTER TABLE "CMS"."PROFILE_PAYTO_XREF" MODIFY ("PROFILE_PAYTO_XREF_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table NOTIFICATION_BAS
--------------------------------------------------------

  ALTER TABLE "CMS"."NOTIFICATION_BAS" MODIFY ("TASK_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."NOTIFICATION_BAS" MODIFY ("ENTITY_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_SPECIALTY_TYPE
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_SPECIALTY_TYPE" ADD CONSTRAINT "SYS_C004001" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_SPECIALTY_TYPE" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CMS_SEQUENCE
--------------------------------------------------------

  ALTER TABLE "CMS"."CMS_SEQUENCE" ADD CONSTRAINT "SYS_C0071426" PRIMARY KEY ("SEQ_NAME") ENABLE;
 
  ALTER TABLE "CMS"."CMS_SEQUENCE" MODIFY ("SEQ_NAME" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROCESSINSTANCEINFO
--------------------------------------------------------

  ALTER TABLE "CMS"."PROCESSINSTANCEINFO" ADD CONSTRAINT "SYS_C004006" PRIMARY KEY ("INSTANCEID") ENABLE;
 
  ALTER TABLE "CMS"."PROCESSINSTANCEINFO" MODIFY ("INSTANCEID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PROCESSINSTANCEINFO" MODIFY ("STATE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DEADLINE
--------------------------------------------------------

  ALTER TABLE "CMS"."DEADLINE" ADD CONSTRAINT "SYS_C004008" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."DEADLINE" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_LICENSE_STATUS
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_LICENSE_STATUS" ADD CONSTRAINT "SYS_C004010" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_LICENSE_STATUS" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_STATE
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_STATE" ADD CONSTRAINT "SYS_C004012" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_STATE" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table EXTERNAL_PROFILE_LINK
--------------------------------------------------------

  ALTER TABLE "CMS"."EXTERNAL_PROFILE_LINK" ADD CONSTRAINT "SYS_C004014" PRIMARY KEY ("EXTERNAL_PROFILE_LINK_ID") ENABLE;
 
  ALTER TABLE "CMS"."EXTERNAL_PROFILE_LINK" MODIFY ("EXTERNAL_PROFILE_LINK_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PEOPLEASSIGNMENTS_RECIPIENTS
--------------------------------------------------------

  ALTER TABLE "CMS"."PEOPLEASSIGNMENTS_RECIPIENTS" MODIFY ("TASK_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PEOPLEASSIGNMENTS_RECIPIENTS" MODIFY ("ENTITY_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_TICKET_STATUS
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_TICKET_STATUS" ADD CONSTRAINT "SYS_C004018" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_TICKET_STATUS" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PERSISTENT_LOGINS
--------------------------------------------------------

  ALTER TABLE "CMS"."PERSISTENT_LOGINS" ADD CONSTRAINT "SYS_C004022" PRIMARY KEY ("SERIES") ENABLE;
 
  ALTER TABLE "CMS"."PERSISTENT_LOGINS" MODIFY ("USERNAME" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PERSISTENT_LOGINS" MODIFY ("SERIES" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PERSISTENT_LOGINS" MODIFY ("TOKEN" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PERSISTENT_LOGINS" MODIFY ("LAST_USED" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table EVENTTYPES
--------------------------------------------------------

  ALTER TABLE "CMS"."EVENTTYPES" MODIFY ("INSTANCEID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DELEGATION_DELEGATES
--------------------------------------------------------

  ALTER TABLE "CMS"."DELEGATION_DELEGATES" MODIFY ("TASK_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."DELEGATION_DELEGATES" MODIFY ("ENTITY_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BOOLEANEXPRESSION
--------------------------------------------------------

  ALTER TABLE "CMS"."BOOLEANEXPRESSION" ADD CONSTRAINT "SYS_C004027" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."BOOLEANEXPRESSION" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_QP_TYP
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_QP_TYP" ADD CONSTRAINT "SYS_C004028" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_QP_TYP" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PEOPLEASSIGNMENTS_EXCLOWNERS
--------------------------------------------------------

  ALTER TABLE "CMS"."PEOPLEASSIGNMENTS_EXCLOWNERS" MODIFY ("TASK_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PEOPLEASSIGNMENTS_EXCLOWNERS" MODIFY ("ENTITY_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SESSIONINFO
--------------------------------------------------------

  ALTER TABLE "CMS"."SESSIONINFO" ADD CONSTRAINT "SYS_C004032" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."SESSIONINFO" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_RELATIONSHIP_TYP
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_RELATIONSHIP_TYP" ADD CONSTRAINT "SYS_C004034" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_RELATIONSHIP_TYP" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table EMAIL_HEADER
--------------------------------------------------------

  ALTER TABLE "CMS"."EMAIL_HEADER" ADD CONSTRAINT "SYS_C004036" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."EMAIL_HEADER" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table EXTERNAL_ACCOUNT_LINK
--------------------------------------------------------

  ALTER TABLE "CMS"."EXTERNAL_ACCOUNT_LINK" ADD CONSTRAINT "SYS_C004038" PRIMARY KEY ("EXTERNAL_ACCOUNT_LINK_ID") ENABLE;
 
  ALTER TABLE "CMS"."EXTERNAL_ACCOUNT_LINK" MODIFY ("EXTERNAL_ACCOUNT_LINK_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROCESSINSTANCELOG
--------------------------------------------------------

  ALTER TABLE "CMS"."PROCESSINSTANCELOG" ADD CONSTRAINT "SYS_C004041" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."PROCESSINSTANCELOG" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PROCESSINSTANCELOG" MODIFY ("PROCESSINSTANCEID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ATTACHMENT
--------------------------------------------------------

  ALTER TABLE "CMS"."ATTACHMENT" ADD CONSTRAINT "SYS_C004044" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."ATTACHMENT" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."ATTACHMENT" MODIFY ("ATTACHMENTCONTENTID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_COUNTY
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_COUNTY" ADD CONSTRAINT "SYS_C004269" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_COUNTY" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DOCUMENT_CONTENT
--------------------------------------------------------

  ALTER TABLE "CMS"."DOCUMENT_CONTENT" ADD CONSTRAINT "SYS_C004047" PRIMARY KEY ("CONTENT_ID") ENABLE;
 
  ALTER TABLE "CMS"."DOCUMENT_CONTENT" MODIFY ("CONTENT_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table REASSIGNMENT_POTENTIALOWNERS
--------------------------------------------------------

  ALTER TABLE "CMS"."REASSIGNMENT_POTENTIALOWNERS" MODIFY ("TASK_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."REASSIGNMENT_POTENTIALOWNERS" MODIFY ("ENTITY_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_SVC_CAT
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_SVC_CAT" ADD CONSTRAINT "SYS_C004050" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_SVC_CAT" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROFILE_GRP_XREF
--------------------------------------------------------

  ALTER TABLE "CMS"."PROFILE_GRP_XREF" ADD CONSTRAINT "SYS_C004052" PRIMARY KEY ("PROFILE_GRP_XREF_ID") ENABLE;
 
  ALTER TABLE "CMS"."PROFILE_GRP_XREF" MODIFY ("PROFILE_GRP_XREF_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ESCALATION
--------------------------------------------------------

  ALTER TABLE "CMS"."ESCALATION" ADD CONSTRAINT "SYS_C004054" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."ESCALATION" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table REASSIGNMENT
--------------------------------------------------------

  ALTER TABLE "CMS"."REASSIGNMENT" ADD CONSTRAINT "SYS_C004056" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."REASSIGNMENT" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DESIGNATED_CONTACT
--------------------------------------------------------

  ALTER TABLE "CMS"."DESIGNATED_CONTACT" ADD CONSTRAINT "SYS_C004058" PRIMARY KEY ("CONTROL_NO") ENABLE;
 
  ALTER TABLE "CMS"."DESIGNATED_CONTACT" MODIFY ("CONTROL_NO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_COS
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_COS" MODIFY ("CODE" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."LU_COS" ADD PRIMARY KEY ("CODE") ENABLE;
--------------------------------------------------------
--  Constraints for Table LEGACY_MAPPING
--------------------------------------------------------

  ALTER TABLE "CMS"."LEGACY_MAPPING" ADD PRIMARY KEY ("LEGACY_MAPPING_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table SUBTASKSSTRATEGY
--------------------------------------------------------

  ALTER TABLE "CMS"."SUBTASKSSTRATEGY" ADD CONSTRAINT "SYS_C004061" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."SUBTASKSSTRATEGY" MODIFY ("DTYPE" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."SUBTASKSSTRATEGY" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_LICENSE_TYPE
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_LICENSE_TYPE" ADD CONSTRAINT "SYS_C004063" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_LICENSE_TYPE" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_ISSUING_BOARD
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_ISSUING_BOARD" ADD CONSTRAINT "SYS_C004065" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_ISSUING_BOARD" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CONTACT_INFO
--------------------------------------------------------

  ALTER TABLE "CMS"."CONTACT_INFO" ADD CONSTRAINT "SYS_C004067" PRIMARY KEY ("CONTACT_INFO_ID") ENABLE;
 
  ALTER TABLE "CMS"."CONTACT_INFO" MODIFY ("CONTACT_INFO_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_PAYTO_TYPE
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_PAYTO_TYPE" ADD CONSTRAINT "SYS_C004069" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_PAYTO_TYPE" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TASK
--------------------------------------------------------

  ALTER TABLE "CMS"."TASK" ADD CONSTRAINT "SYS_C004080" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."TASK" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."TASK" MODIFY ("PRIORITY" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."TASK" MODIFY ("DOCUMENTCONTENTID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."TASK" MODIFY ("FAULTCONTENTID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."TASK" MODIFY ("OUTPUTCONTENTID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."TASK" MODIFY ("PARENTID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."TASK" MODIFY ("PROCESSINSTANCEID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."TASK" MODIFY ("PROCESSSESSIONID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."TASK" MODIFY ("SKIPABLE" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."TASK" MODIFY ("WORKITEMID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROVIDER_AGREEMENT_XREF
--------------------------------------------------------

  ALTER TABLE "CMS"."PROVIDER_AGREEMENT_XREF" ADD CONSTRAINT "SYS_C004082" PRIMARY KEY ("PROVIDER_AGREEMENT_XREF_ID") ENABLE;
 
  ALTER TABLE "CMS"."PROVIDER_AGREEMENT_XREF" MODIFY ("PROVIDER_AGREEMENT_XREF_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table HELP_ITEM
--------------------------------------------------------

  ALTER TABLE "CMS"."HELP_ITEM" ADD CONSTRAINT "SYS_C004084" PRIMARY KEY ("HELP_ITEM_ID") ENABLE;
 
  ALTER TABLE "CMS"."HELP_ITEM" MODIFY ("HELP_ITEM_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SCREENING_SCHEDULE
--------------------------------------------------------

  ALTER TABLE "CMS"."SCREENING_SCHEDULE" ADD CONSTRAINT "SYS_C004087" PRIMARY KEY ("SCREENING_SCHEDULE_ID") ENABLE;
 
  ALTER TABLE "CMS"."SCREENING_SCHEDULE" MODIFY ("SCREENING_SCHEDULE_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."SCREENING_SCHEDULE" MODIFY ("INTERVAL_VALUE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_ROLE
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_ROLE" ADD CONSTRAINT "SYS_C004089" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_ROLE" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table WORKITEMINFO
--------------------------------------------------------

  ALTER TABLE "CMS"."WORKITEMINFO" ADD CONSTRAINT "SYS_C004093" PRIMARY KEY ("WORKITEMID") ENABLE;
 
  ALTER TABLE "CMS"."WORKITEMINFO" MODIFY ("WORKITEMID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."WORKITEMINFO" MODIFY ("PROCESSINSTANCEID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."WORKITEMINFO" MODIFY ("STATE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table NOTIFICATION
--------------------------------------------------------

  ALTER TABLE "CMS"."NOTIFICATION" ADD CONSTRAINT "SYS_C004097" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."NOTIFICATION" MODIFY ("DTYPE" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."NOTIFICATION" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."NOTIFICATION" MODIFY ("PRIORITY" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CMS_AUTHENTICATION
--------------------------------------------------------

  ALTER TABLE "CMS"."CMS_AUTHENTICATION" MODIFY ("USERNAME" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."CMS_AUTHENTICATION" MODIFY ("PASSWORD" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."CMS_AUTHENTICATION" ADD PRIMARY KEY ("USERNAME") ENABLE;
--------------------------------------------------------
--  Constraints for Table LU_RISK_LEVEL
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_RISK_LEVEL" ADD CONSTRAINT "SYS_C004099" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_RISK_LEVEL" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ADDRESS
--------------------------------------------------------

  ALTER TABLE "CMS"."ADDRESS" ADD CONSTRAINT "SYS_C004101" PRIMARY KEY ("ADDRESS_ID") ENABLE;
 
  ALTER TABLE "CMS"."ADDRESS" MODIFY ("ADDRESS_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_BEN_OWNER_TYP
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_BEN_OWNER_TYP" ADD CONSTRAINT "SYS_C004103" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_BEN_OWNER_TYP" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROVIDER_SVCS
--------------------------------------------------------

  ALTER TABLE "CMS"."PROVIDER_SVCS" ADD CONSTRAINT "SYS_C004104" PRIMARY KEY ("PROVIDER_SVCS_ID") ENABLE;
 
  ALTER TABLE "CMS"."PROVIDER_SVCS" MODIFY ("PROVIDER_SVCS_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_PROVIDER_TYPE
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_PROVIDER_TYPE" ADD CONSTRAINT "SYS_C0072362" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_PROVIDER_TYPE" MODIFY ("CODE" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."LU_PROVIDER_TYPE" MODIFY ("APPLICANT_TYP" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROVIDER_PROFILE
--------------------------------------------------------

  ALTER TABLE "CMS"."PROVIDER_PROFILE" ADD CONSTRAINT "SYS_C004112" PRIMARY KEY ("CONTROL_NO") ENABLE;
 
  ALTER TABLE "CMS"."PROVIDER_PROFILE" MODIFY ("CONTROL_NO" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PROVIDER_PROFILE" MODIFY ("PROFILE_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PROVIDER_PROFILE" MODIFY ("TICKET_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PROVIDER_PROFILE" MODIFY ("REFERENCE_TICKET_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROVIDER_COS
--------------------------------------------------------

  ALTER TABLE "CMS"."PROVIDER_COS" MODIFY ("PROVIDER_COS_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PROVIDER_COS" MODIFY ("PROVIDER_COS_CD" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table AUDIT_DETAIL
--------------------------------------------------------

  ALTER TABLE "CMS"."AUDIT_DETAIL" ADD CONSTRAINT "SYS_C004114" PRIMARY KEY ("AUDIT_DETAIL_ID") ENABLE;
 
  ALTER TABLE "CMS"."AUDIT_DETAIL" MODIFY ("AUDIT_DETAIL_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table OWNER_ASSET
--------------------------------------------------------

  ALTER TABLE "CMS"."OWNER_ASSET" ADD CONSTRAINT "SYS_C004116" PRIMARY KEY ("OWNER_ASSET_ID") ENABLE;
 
  ALTER TABLE "CMS"."OWNER_ASSET" MODIFY ("OWNER_ASSET_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table VARIABLEINSTANCELOG
--------------------------------------------------------

  ALTER TABLE "CMS"."VARIABLEINSTANCELOG" ADD CONSTRAINT "SYS_C004119" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."VARIABLEINSTANCELOG" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."VARIABLEINSTANCELOG" MODIFY ("PROCESSINSTANCEID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_REQUEST_TYP
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_REQUEST_TYP" ADD CONSTRAINT "SYS_C004121" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_REQUEST_TYP" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ENTITY
--------------------------------------------------------

  ALTER TABLE "CMS"."ENTITY" ADD CONSTRAINT "SYS_C004124" PRIMARY KEY ("ENTITY_ID") ENABLE;
 
  ALTER TABLE "CMS"."ENTITY" MODIFY ("ENTITY_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."ENTITY" MODIFY ("PERSON_IND" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TICKET
--------------------------------------------------------

  ALTER TABLE "CMS"."TICKET" ADD CONSTRAINT "SYS_C004128" PRIMARY KEY ("TICKET_ID") ENABLE;
 
  ALTER TABLE "CMS"."TICKET" MODIFY ("TICKET_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."TICKET" MODIFY ("PROCESS_INSTANCE_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."TICKET" MODIFY ("REF_PROFILE_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PEOPLEASSIGNMENTS_STAKEHOLDERS
--------------------------------------------------------

  ALTER TABLE "CMS"."PEOPLEASSIGNMENTS_STAKEHOLDERS" MODIFY ("TASK_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PEOPLEASSIGNMENTS_STAKEHOLDERS" MODIFY ("ENTITY_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table NOTIFICATION_RECIPIENTS
--------------------------------------------------------

  ALTER TABLE "CMS"."NOTIFICATION_RECIPIENTS" MODIFY ("TASK_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."NOTIFICATION_RECIPIENTS" MODIFY ("ENTITY_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_OWNERSHIP_TYP
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_OWNERSHIP_TYP" ADD CONSTRAINT "SYS_C004134" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_OWNERSHIP_TYP" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROVIDER_SETTING
--------------------------------------------------------

  ALTER TABLE "CMS"."PROVIDER_SETTING" ADD CONSTRAINT "SYS_C004136" PRIMARY KEY ("PROVIDER_SETTING_ID") ENABLE;
 
  ALTER TABLE "CMS"."PROVIDER_SETTING" MODIFY ("PROVIDER_SETTING_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ORGANIZATIONALENTITY
--------------------------------------------------------

  ALTER TABLE "CMS"."ORGANIZATIONALENTITY" ADD CONSTRAINT "SYS_C004139" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."ORGANIZATIONALENTITY" MODIFY ("DTYPE" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."ORGANIZATIONALENTITY" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CONTENT
--------------------------------------------------------

  ALTER TABLE "CMS"."CONTENT" ADD CONSTRAINT "SYS_C004141" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."CONTENT" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PEOPLEASSIGNMENTS_BAS
--------------------------------------------------------

  ALTER TABLE "CMS"."PEOPLEASSIGNMENTS_BAS" MODIFY ("TASK_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PEOPLEASSIGNMENTS_BAS" MODIFY ("ENTITY_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table REQUIRED_FLD
--------------------------------------------------------

  ALTER TABLE "CMS"."REQUIRED_FLD" ADD CONSTRAINT "SYS_C004145" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."REQUIRED_FLD" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CMS_USER
--------------------------------------------------------

  ALTER TABLE "CMS"."CMS_USER" ADD CONSTRAINT "SYS_C004147" PRIMARY KEY ("USER_ID") ENABLE;
 
  ALTER TABLE "CMS"."CMS_USER" MODIFY ("USER_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROFILE_NOTES
--------------------------------------------------------

  ALTER TABLE "CMS"."PROFILE_NOTES" ADD CONSTRAINT "SYS_C004149" PRIMARY KEY ("PROVIDER_NOTE_ID") ENABLE;
 
  ALTER TABLE "CMS"."PROFILE_NOTES" MODIFY ("PROVIDER_NOTE_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LICENSE
--------------------------------------------------------

  ALTER TABLE "CMS"."LICENSE" ADD CONSTRAINT "SYS_C004151" PRIMARY KEY ("LICENSE_ID") ENABLE;
 
  ALTER TABLE "CMS"."LICENSE" MODIFY ("LICENSE_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table I18NTEXT
--------------------------------------------------------

  ALTER TABLE "CMS"."I18NTEXT" ADD CONSTRAINT "SYS_C004153" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."I18NTEXT" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_CORP_STRUCTURE_TYP
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_CORP_STRUCTURE_TYP" ADD CONSTRAINT "SYS_C004155" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_CORP_STRUCTURE_TYP" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROVIDER_STATEMENT
--------------------------------------------------------

  ALTER TABLE "CMS"."PROVIDER_STATEMENT" ADD CONSTRAINT "SYS_C004158" PRIMARY KEY ("PROVIDER_STATEMENT_ID") ENABLE;
 
  ALTER TABLE "CMS"."PROVIDER_STATEMENT" MODIFY ("PROVIDER_STATEMENT_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PROVIDER_STATEMENT" MODIFY ("SIGN_ATTACHEMENT_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROVIDER_COS_XREF
--------------------------------------------------------

  ALTER TABLE "CMS"."PROVIDER_COS_XREF" MODIFY ("PROVIDER_COS_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PROVIDER_COS_XREF" MODIFY ("START_DT" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PROVIDER_COS_XREF" ADD PRIMARY KEY ("PROVIDER_COS_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table AGREEMENT_DOCUMENT
--------------------------------------------------------

  ALTER TABLE "CMS"."AGREEMENT_DOCUMENT" ADD CONSTRAINT "SYS_C004160" PRIMARY KEY ("AGREEMENT_DOCUMENT_ID") ENABLE;
 
  ALTER TABLE "CMS"."AGREEMENT_DOCUMENT" MODIFY ("AGREEMENT_DOCUMENT_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table NODEINSTANCELOG
--------------------------------------------------------

  ALTER TABLE "CMS"."NODEINSTANCELOG" ADD CONSTRAINT "SYS_C004164" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."NODEINSTANCELOG" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."NODEINSTANCELOG" MODIFY ("PROCESSINSTANCEID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."NODEINSTANCELOG" MODIFY ("TYPE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BENEFICIAL_OWNER
--------------------------------------------------------

  ALTER TABLE "CMS"."BENEFICIAL_OWNER" ADD CONSTRAINT "SYS_C004167" PRIMARY KEY ("BENEFICIAL_OWNER_ID") ENABLE;
 
  ALTER TABLE "CMS"."BENEFICIAL_OWNER" MODIFY ("BENEFICIAL_OWNER_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."BENEFICIAL_OWNER" MODIFY ("PERSON_IND" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TASK_COMMENT
--------------------------------------------------------

  ALTER TABLE "CMS"."TASK_COMMENT" ADD CONSTRAINT "SYS_C004169" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "CMS"."TASK_COMMENT" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PEOPLEASSIGNMENTS_POTOWNERS
--------------------------------------------------------

  ALTER TABLE "CMS"."PEOPLEASSIGNMENTS_POTOWNERS" MODIFY ("TASK_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PEOPLEASSIGNMENTS_POTOWNERS" MODIFY ("ENTITY_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_DEGREE
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_DEGREE" ADD CONSTRAINT "SYS_C004173" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_DEGREE" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CMS_ATTACHMENT
--------------------------------------------------------

  ALTER TABLE "CMS"."CMS_ATTACHMENT" ADD CONSTRAINT "SYS_C004175" PRIMARY KEY ("ATTACHMENT_ID") ENABLE;
 
  ALTER TABLE "CMS"."CMS_ATTACHMENT" MODIFY ("ATTACHMENT_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table EVENT
--------------------------------------------------------

  ALTER TABLE "CMS"."EVENT" ADD CONSTRAINT "SYS_C004177" PRIMARY KEY ("EVENT_ID") ENABLE;
 
  ALTER TABLE "CMS"."EVENT" MODIFY ("EVENT_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table NOTIFICATION_EMAIL_HEADER
--------------------------------------------------------

  ALTER TABLE "CMS"."NOTIFICATION_EMAIL_HEADER" ADD CONSTRAINT "SYS_C004181" PRIMARY KEY ("NOTIFICATION_ID", "MAPKEY") ENABLE;
 
  ALTER TABLE "CMS"."NOTIFICATION_EMAIL_HEADER" MODIFY ("NOTIFICATION_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."NOTIFICATION_EMAIL_HEADER" MODIFY ("EMAILHEADERS_ID" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."NOTIFICATION_EMAIL_HEADER" MODIFY ("MAPKEY" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table AUDIT_RECORD
--------------------------------------------------------

  ALTER TABLE "CMS"."AUDIT_RECORD" ADD CONSTRAINT "SYS_C004184" PRIMARY KEY ("AUDIT_RECORD_ID") ENABLE;
 
  ALTER TABLE "CMS"."AUDIT_RECORD" MODIFY ("AUDIT_RECORD_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LU_PROFILE_STATUS
--------------------------------------------------------

  ALTER TABLE "CMS"."LU_PROFILE_STATUS" ADD CONSTRAINT "SYS_C004186" PRIMARY KEY ("CODE") ENABLE;
 
  ALTER TABLE "CMS"."LU_PROFILE_STATUS" MODIFY ("CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROVIDER_TYPE_REQ_FIELDS
--------------------------------------------------------

  ALTER TABLE "CMS"."PROVIDER_TYPE_REQ_FIELDS" MODIFY ("PROVIDER_TYPE_CD" NOT NULL ENABLE);
 
  ALTER TABLE "CMS"."PROVIDER_TYPE_REQ_FIELDS" MODIFY ("REQUIRED_FIELD_CD" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table OWNERSHIP_INFO
--------------------------------------------------------

  ALTER TABLE "CMS"."OWNERSHIP_INFO" ADD CONSTRAINT "SYS_C004190" PRIMARY KEY ("OWNERSHIP_INFO_ID") ENABLE;
 
  ALTER TABLE "CMS"."OWNERSHIP_INFO" MODIFY ("OWNERSHIP_INFO_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table PROVIDER_COS
--------------------------------------------------------

  ALTER TABLE "CMS"."PROVIDER_COS" ADD CONSTRAINT "FK7137CA197920405B" FOREIGN KEY ("PROVIDER_COS_ID")
	  REFERENCES "CMS"."PROVIDER_COS_XREF" ("PROVIDER_COS_ID") ENABLE;
 
  ALTER TABLE "CMS"."PROVIDER_COS" ADD CONSTRAINT "FK7137CA19DAE7A092" FOREIGN KEY ("PROVIDER_COS_CD")
	  REFERENCES "CMS"."LU_COS" ("CODE") ENABLE;


insert into OrganizationalEntity (DTYPE, id) values ('Group', 'Service Agent');
insert into OrganizationalEntity (DTYPE, id) values ('Group', 'Service Administrator');
insert into OrganizationalEntity (DTYPE, id) values ('Group', 'System Administrator');
insert into OrganizationalEntity (DTYPE, id) values ('User', 'Administrator');

INSERT INTO LU_ROLE(CODE, DESCRIPTION) VALUES ('R1', 'Provider');
INSERT INTO LU_ROLE(CODE, DESCRIPTION) VALUES ('R2', 'Service Agent');
INSERT INTO LU_ROLE(CODE, DESCRIPTION) VALUES ('R3', 'Service Administrator');
INSERT INTO LU_ROLE(CODE, DESCRIPTION) VALUES ('R4', 'System Administrator');

INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('01', 'Audiologist');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('02', 'Optometrist');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('03', 'Certified Registered Nurse Anesthetist');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('04', 'Personal Care Assistant');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('05', 'Certified Professional Midwife');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('06', 'Community Health Care Worker');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('07', 'Clinical Nurse Specialist');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('08', 'Chiropractor');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('09', 'Podiatrist');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('10', 'Licensed Marriage and Family Therapist');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('11', 'Licensed Professional Clinical Counselor');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('12', 'Nurse Practitioner');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('13', 'Occupational Therapist');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('14', 'Physician Assistant');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('15', 'Private Duty Nurse');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('16', 'Physical Therapist');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('17', 'Speech Language Pathologist');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('18', 'Acupuncturist');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('19', 'Allied Dental Professional');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('20', 'Certified Mental Health Rehab Prof - CPRP');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('21', 'Dentist');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('22', 'Hearing Aid Dispenser');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('23', 'Licensed Dietician or Licensed Nutritionist');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('24', 'Licensed Independent Clinical Social Worker');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('25', 'Nurse Midwife');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('26', 'Pharmacist');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('27', 'Licensed Psychologist');
INSERT INTO LU_PROVIDER_TYPE(CODE, DESCRIPTION) VALUES ('28', 'Physician');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('L1', 'Audiologist License');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('L2', 'Registration with the Department Of Health');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('L3', 'Optometrist License');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('L4', 'Registered Nurse');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('L5', 'PCA Training Certificate');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('L6', 'Traditional Midwife');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('L7', 'MnSCU Certification');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('L8', 'Chiropractic Examiner');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('L9', 'License To Practice Podiatric Medicine');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('L0', 'Marriage And Family Therapist');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('M1', 'Professional Clinical Counselor');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('M2', 'Occupational Therapy');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('M3', 'Physician Assistant');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('M4', 'Physical Therapist');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('M5', 'Speech Language Pathologist');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('M6', 'Acupuncturist');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('M7', 'Dental Hygienist');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('M8', 'Mental Health Rehab Professional');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('M9', 'Dental');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('M0', 'Hearing Aid Dispenser');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('N1', 'Dietician or Nutritionist');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('N2', 'Clinical Social Worker');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('N3', 'Pharmacist License');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('N4', 'Psychologist');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('N5', 'Physician');


INSERT INTO LU_DEGREE(CODE, DESCRIPTION) VALUES ('D1', 'MASTERS');
INSERT INTO LU_DEGREE(CODE, DESCRIPTION) VALUES ('D2', 'DOCTORATE');

INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('S1', 'CRNA Certification');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('S2', 'Certified Professional Midwife');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('S3', 'Psychiatric/Mental Health');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('S4', 'Gerontology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('S5', 'Pediatrics');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('S6', 'Physical Rehabilitation');

INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('D1', 'General Dentistry');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('D2', 'Endodontist');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('D3', 'Oral Surgery');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('D4', 'Orthodontics');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('D5', 'Pedodontics');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('D6', 'Periodontics');

INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('P1', 'Neuropsychology');

INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('01', 'Allergy');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('02', 'Anesthesiology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('03', 'Cardiovascular Disease');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('04', 'Cardiovascular Surgery');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('05', 'Child Psychiatry');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('06', 'Colon and Rectal Surgery');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('07', 'Dermatology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('08', 'Diabetes');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('09', 'Emergency Services');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('10', 'Endocrinology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('11', 'Family Practice');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('12', 'Gastroenterology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('13', 'General Practice');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('14', 'General Surgery');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('15', 'Gynecology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('16', 'Immunology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('17', 'Infectious Disease');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('18', 'Internal Medicine');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('19', 'Nephrology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('20', 'Neurological Surgery');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('21', 'Neurology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('22', 'Nuclear Medicine');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('23', 'Obstetrics');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('24', 'Obstetrics and Gynecology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('25', 'Oncology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('26', 'Ophthalmology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('27', 'Pathology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('28', 'Peripheral Vascular Diseases or Surgery');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('29', 'Physical Medicine and Rehabilitation');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('30', 'Plastic Surgery');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('31', 'Preventive Medicine');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('32', 'Psychiatry');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('33', 'Pulmonary Disease');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('34', 'Radiology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('35', 'Radiology and Radiation Therapy');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('36', 'Rheumatology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('37', 'Thoracic Surgery');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('38', 'Urology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('39', 'Other');

INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION, SUB_CAT_CD) VALUES ('FL', 'Fond Du Lac Indian Reservation', 'TC');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION, SUB_CAT_CD) VALUES ('GP', 'Grand Portage Indian Reservation', 'TC');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION, SUB_CAT_CD) VALUES ('LL', 'Leech Lake Indian Reservation', 'TC');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION, SUB_CAT_CD) VALUES ('LS', 'Lower Sioux Indian Reservation', 'TC');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION, SUB_CAT_CD) VALUES ('ML', 'Mille Lacs Indian Reservation', 'TC');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION, SUB_CAT_CD) VALUES ('NL', 'Net Lake Indian Reservation"', 'TC');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION, SUB_CAT_CD) VALUES ('PI', 'Prairie Island Indian Reservation', 'TC');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION, SUB_CAT_CD) VALUES ('RL', 'Red Lake Reservation', 'TC');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION, SUB_CAT_CD) VALUES ('US', 'Upper Sioux Indian Reservation', 'TC');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION, SUB_CAT_CD) VALUES ('WE', 'White Earth Indian Reservation', 'TC');

INSERT INTO LU_ISSUING_BOARD(CODE, DESCRIPTION) VALUES ('B1', 'AANA');
INSERT INTO LU_ISSUING_BOARD(CODE, DESCRIPTION) VALUES ('B2', 'NARM');
INSERT INTO LU_ISSUING_BOARD(CODE, DESCRIPTION) VALUES ('B3', 'ANCC');
INSERT INTO LU_ISSUING_BOARD(CODE, DESCRIPTION) VALUES ('B4', 'AOTA');
INSERT INTO LU_ISSUING_BOARD(CODE, DESCRIPTION) VALUES ('B5', 'ADA');
INSERT INTO LU_ISSUING_BOARD(CODE, DESCRIPTION) VALUES ('B6', 'ABMS');
INSERT INTO LU_ISSUING_BOARD(CODE, DESCRIPTION) VALUES ('B7', 'ABPS');

INSERT INTO LU_LICENSE_STATUS(CODE, DESCRIPTION) VALUES ('01', 'Active');
INSERT INTO LU_LICENSE_STATUS(CODE, DESCRIPTION) VALUES ('02', 'Suspended');
INSERT INTO LU_LICENSE_STATUS(CODE, DESCRIPTION) VALUES ('03', 'Expired');

INSERT INTO LU_REQUEST_TYP(CODE, DESCRIPTION) VALUES ('01', 'Import Profile');
INSERT INTO LU_REQUEST_TYP(CODE, DESCRIPTION) VALUES ('02', 'Enrollment');
INSERT INTO LU_REQUEST_TYP(CODE, DESCRIPTION) VALUES ('03', 'Renewal');
INSERT INTO LU_REQUEST_TYP(CODE, DESCRIPTION) VALUES ('04', 'Suspend');
INSERT INTO LU_REQUEST_TYP(CODE, DESCRIPTION) VALUES ('05', 'Update');

INSERT INTO LU_TICKET_STATUS(CODE, DESCRIPTION) VALUES ('01', 'Draft');
INSERT INTO LU_TICKET_STATUS(CODE, DESCRIPTION) VALUES ('02', 'Pending');
INSERT INTO LU_TICKET_STATUS(CODE, DESCRIPTION) VALUES ('03', 'Rejected');
INSERT INTO LU_TICKET_STATUS(CODE, DESCRIPTION) VALUES ('04', 'Approved');

INSERT INTO LU_PROFILE_STATUS(CODE, DESCRIPTION) VALUES ('01', 'Active');
INSERT INTO LU_PROFILE_STATUS(CODE, DESCRIPTION) VALUES ('02', 'Suspended');
INSERT INTO LU_PROFILE_STATUS(CODE, DESCRIPTION) VALUES ('03', 'Expired');

INSERT INTO LU_RISK_LEVEL(CODE, SORT_IDX, DESCRIPTION) VALUES ('01', 1, 'Limited');
INSERT INTO LU_RISK_LEVEL(CODE, SORT_IDX, DESCRIPTION) VALUES ('02', 2, 'Moderate');
INSERT INTO LU_RISK_LEVEL(CODE, SORT_IDX, DESCRIPTION) VALUES ('03', 3, 'High');


INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('AK', 'ALASKA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('AL', 'ALABAMA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('AR', 'ARKANSAS');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('AZ', 'ARIZONA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('CA', 'CALIFORNIA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('CO', 'COLORADO');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('CT', 'CONNECTICUT');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('DC', 'DISTRICT OF COLUMBIA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('DE', 'DELAWARE');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('FL', 'FLORIDA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('GA', 'GEORGIA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('HI', 'HAWAII');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('IA', 'IOWA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('ID', 'IDAHO');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('IL', 'ILLINOIS');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('IN', 'INDIANA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('KS', 'KANSAS');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('KY', 'KENTUCKY');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('LA', 'LOUISIANA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('MA', 'MASSACHUSETTS');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('MD', 'MARYLAND');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('ME', 'MAINE');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('MI', 'MICHIGAN');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('MN', 'MINNESOTA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('MO', 'MISSOURI');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('MS', 'MISSISSIPPI');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('MT', 'MONTANA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('NE', 'NEBRASKA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('NC', 'NORTH CAROLINA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('ND', 'NORTH DAKOTA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('NH', 'NEW HAMPSHIRE');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('NJ', 'NEW JERSEY');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('NM', 'NEW MEXICO');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('NY', 'NEW YORK');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('NV', 'NEVADA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('OH', 'OHIO');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('OK', 'OKLAHOMA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('OR', 'OREGON');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('PA', 'PENNSYLVANIA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('RI', 'RHODE ISLAND');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('SC', 'SOUTH CAROLINA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('TN', 'TENNESSEE');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('TX', 'TEXAS');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('UT', 'UTAH');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('VA', 'VIRGINIA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('VT', 'VERMONT');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('WA', 'WASHINGTON');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('WI', 'WISCONSIN');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('WV', 'WEST VIRGINIA');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('WY', 'WYOMING');
INSERT INTO LU_STATE(CODE, DESCRIPTION) VALUES ('XX', 'XX');


INSERT INTO AGREEMENT_DOCUMENT(AGREEMENT_DOCUMENT_ID, DOC_TYPE, TITLE, VERSION, DOC_TEXT, CREATED_BY, CREATE_TS)
    VALUES (1, '01', 'Provider Agreement', 1, 'This is some text', 'SYSTEM', SYSDATE);

INSERT INTO AGREEMENT_DOCUMENT(AGREEMENT_DOCUMENT_ID, DOC_TYPE, TITLE, VERSION, DOC_TEXT, CREATED_BY, CREATE_TS)
    VALUES (2, '02', 'Provider Agreement Addendum', 1, 'This is some text', 'SYSTEM', SYSDATE);

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1, '01', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2, '01', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (3, '02', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (4, '02', 'AgreementDocument', '02', 'RA');

-- audiologist license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (101, '01', 'LicenseType', 'L1', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (102, '01', 'LicenseType', 'L2', 'LO');
    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (103, '01', 'StateType', 'MN', 'LS');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (104, '01', 'StateType', 'XX', 'LS');
    
-- optometrist license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (201, '02', 'LicenseType', 'L3', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (202, '02', 'StateType', 'MN', 'LS');
    
-- CRNA license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (301, '03', 'LicenseType', 'L4', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (302, '03', 'StateType', 'MN', 'LS');
-- CRNA specialty options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (303, '03', 'SpecialtyType', 'S1', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (304, '03', 'IssuingBoard', 'B1', 'SB');
    
-- PCA Ind license options
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (401, '04', 'LicenseType', 'L5', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (402, '04', 'StateType', 'MN', 'LS');
    
-- Midwife license options
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (501, '05', 'LicenseType', 'L6', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (502, '05', 'StateType', 'MN', 'LS');
-- Midwife specialty options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (503, '05', 'SpecialtyType', 'S2', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (504, '05', 'IssuingBoard', 'B2', 'SB');

-- CHCW license options
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (601, '06', 'LicenseType', 'L7', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (602, '06', 'StateType', 'MN', 'LS');

-- CNS license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (701, '07', 'LicenseType', 'L4', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (702, '07', 'StateType', 'MN', 'LS');
    
-- CNS specialty options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (703, '07', 'SpecialtyType', 'S3', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (704, '07', 'IssuingBoard', 'B3', 'SB');

-- Chiropractic license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (801, '08', 'LicenseType', 'L8', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (802, '08', 'StateType', 'MN', 'LS');

-- Podiatrist license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (901, '09', 'LicenseType', 'L9', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (902, '09', 'StateType', 'MN', 'LS');
    
-- MFT license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1001, '10', 'LicenseType', 'L0', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1002, '10', 'StateType', 'MN', 'LS');
    
-- LPCC license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1101, '11', 'LicenseType', 'M1', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1102, '11', 'StateType', 'MN', 'LS');


-- Nurse Practitioner license options
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1201, '12', 'LicenseType', 'L4', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1202, '12', 'StateType', 'MN', 'LS');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1203, '12', 'SpecialtyType', 'S3', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1204, '12', 'IssuingBoard', 'B3', 'SB');

-- OT license options
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1301, '13', 'LicenseType', 'M2', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1302, '13', 'StateType', 'MN', 'LS');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1303, '13', 'SpecialtyType', 'S3', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1304, '13', 'SpecialtyType', 'S4', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1305, '13', 'SpecialtyType', 'S5', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1306, '13', 'SpecialtyType', 'S6', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1307, '13', 'IssuingBoard', 'B4', 'SB');

-- Physician Assistant license options
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1401, '14', 'LicenseType', 'M3', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1402, '14', 'StateType', 'MN', 'LS');
    
-- Private Duty Nurse license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1501, '15', 'LicenseType', 'L4', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1502, '15', 'StateType', 'MN', 'LS');
    
-- PT license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1601, '16', 'LicenseType', 'M4', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1602, '16', 'StateType', 'MN', 'LS');
    
-- SLP license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1701, '17', 'LicenseType', 'M5', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1702, '17', 'StateType', 'MN', 'LS');
    
-- Acupuncturist license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1801, '18', 'LicenseType', 'M6', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1802, '18', 'StateType', 'MN', 'LS');
    
-- ADP license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1901, '19', 'LicenseType', 'M7', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1902, '19', 'StateType', 'MN', 'LS');
    
-- CPRP license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2001, '20', 'LicenseType', 'M8', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2002, '20', 'StateType', 'MN', 'LS');
    
-- Dental license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2101, '21', 'LicenseType', 'M9', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2102, '21', 'StateType', 'MN', 'LS');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2103, '21', 'SpecialtyType', 'D1', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2104, '21', 'SpecialtyType', 'D2', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2105, '21', 'SpecialtyType', 'D3', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2106, '21', 'SpecialtyType', 'D4', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2107, '21', 'SpecialtyType', 'D5', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2108, '21', 'SpecialtyType', 'D6', 'SO');
    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2109, '21', 'IssuingBoard', 'B5', 'SB');

-- Hearing Aid license options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2201, '22', 'LicenseType', 'M0', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2202, '22', 'StateType', 'MN', 'LS');
    
-- Dietician or Nutritionist options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2301, '23', 'LicenseType', 'N1', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2302, '23', 'StateType', 'MN', 'LS');
    
-- LICSW options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2401, '24', 'LicenseType', 'N2', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2402, '24', 'StateType', 'MN', 'LS');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2403, '24', 'SpecialtyType', 'S3', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2404, '24', 'IssuingBoard', 'B3', 'SB');

-- Nurse Midwife
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2501, '25', 'LicenseType', 'L4', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2502, '25', 'StateType', 'MN', 'LS');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2503, '25', 'SpecialtyType', 'S2', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2504, '25', 'IssuingBoard', 'B2', 'SB');

-- Pharmacist options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2601, '26', 'LicenseType', 'N3', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2602, '26', 'StateType', 'MN', 'LS');
    
-- Psychologist options    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2701, '27', 'LicenseType', 'N4', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2702, '27', 'StateType', 'MN', 'LS');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2703, '27', 'SpecialtyType', 'P1', 'SO');
    
-- Physician License    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2801, '28', 'LicenseType', 'N5', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2802, '28', 'StateType', 'MN', 'LS');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2803, '28', 'IssuingBoard', 'B6', 'SB');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2804, '28', 'IssuingBoard', 'B7', 'SB');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2805, '28', 'SpecialtyType', '01', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2806, '28', 'SpecialtyType', '02', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2807, '28', 'SpecialtyType', '03', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2808, '28', 'SpecialtyType', '04', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2809, '28', 'SpecialtyType', '05', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2810, '28', 'SpecialtyType', '06', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2811, '28', 'SpecialtyType', '07', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2812, '28', 'SpecialtyType', '08', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2813, '28', 'SpecialtyType', '09', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2814, '28', 'SpecialtyType', '10', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2815, '28', 'SpecialtyType', '11', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2816, '28', 'SpecialtyType', '12', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2817, '28', 'SpecialtyType', '13', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2818, '28', 'SpecialtyType', '14', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2819, '28', 'SpecialtyType', '15', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2820, '28', 'SpecialtyType', '16', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2821, '28', 'SpecialtyType', '17', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2822, '28', 'SpecialtyType', '18', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2823, '28', 'SpecialtyType', '19', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2824, '28', 'SpecialtyType', '20', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2825, '28', 'SpecialtyType', '21', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2826, '28', 'SpecialtyType', '22', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2827, '28', 'SpecialtyType', '23', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2828, '28', 'SpecialtyType', '24', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2829, '28', 'SpecialtyType', '25', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2830, '28', 'SpecialtyType', '26', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2831, '28', 'SpecialtyType', '27', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2832, '28', 'SpecialtyType', '28', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2833, '28', 'SpecialtyType', '29', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2834, '28', 'SpecialtyType', '30', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2835, '28', 'SpecialtyType', '31', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2836, '28', 'SpecialtyType', '32', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2837, '28', 'SpecialtyType', '33', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2838, '28', 'SpecialtyType', '34', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2839, '28', 'SpecialtyType', '35', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2840, '28', 'SpecialtyType', '36', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2841, '28', 'SpecialtyType', '37', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2842, '28', 'SpecialtyType', '38', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2843, '28', 'SpecialtyType', '39', 'SO');

    
-- system administrator    
INSERT INTO CMS_USER(USER_ID, USER_NAME, FIRST_NAME, LAST_NAME, EMAIL, STATUS, ROLE_CD)
    VALUES('SYSTEM', 'system', 'system', 'system', 'cmsmailer@gmail.com', 'ACTIVE', 'R4');
INSERT INTO CMS_USER(USER_ID, USER_NAME, FIRST_NAME, LAST_NAME, EMAIL, STATUS, ROLE_CD)
    VALUES('ADMIN', 'admin', 'admin', 'admin', 'cmsmailer@gmail.com', 'ACTIVE', 'R3');
    
INSERT INTO SCREENING_SCHEDULE(SCREENING_SCHEDULE_ID, UPCOMING_SCREENING_DT, INTERVAL_TYPE, INTERVAL_VALUE)
  VALUES (1, null, null, 0);
  
-- organization data
  
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('29', 1, 'Billing Entity for Physical Rehabilitative Providers');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('30', 1, 'Clearing House');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('31', 1, 'Durable Medical Equipment');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('32', 1, 'EDI Trading Partner');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('33', 1, 'Family Planning Agency');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('34', 1, 'Head Start');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('35', 1, 'Home Health Agency');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('36', 1, 'Independent Diagnostic Testing Facility');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('37', 1, 'Independent Laboratory');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('38', 1, 'Indian Health Service Facility');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('39', 1, 'Intensive Residential Treatment Facility');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('40', 1, 'Optical Supplier');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('41', 1, 'Personal Care Provider Organization');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('42', 1, 'Pharmacy');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('43', 1, 'Private Duty Nursing Agency');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('44', 1, 'Public Health Clinic');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('45', 1, 'Public Health Nursing Organization');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('46', 1, 'Regional Treatment Center');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('47', 1, 'Rehabilitation Agency');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('48', 1, 'Rural Health Clinic');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('49', 1, 'Targeted Case Management');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('50', 1, 'WIC Program');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('51', 1, 'X-Ray Services');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('52', 1, 'Ambulatory Surgical Center');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('53', 1, 'Certified Registered Nurse Anesthetist Group');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('54', 1, 'Child And Teen Checkup Clinic');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('55', 1, 'Childrens Mental Health Residential Treatment Facility');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('56', 1, 'Community Health Clinic');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('57', 1, 'Community Mental Health Center');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('58', 1, 'County Contracted Mental Health Rehab');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('59', 1, 'Day Training And Habilitation/Day Activity Center');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('60', 1, 'Day Treatment');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('61', 1, 'Home And Community Based Services (Waivered Services)');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('62', 1, 'Billing Intermediary');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION) VALUES ('63', 1, 'Federally Qualified Health Center');


--  head start agency
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('A1', 'Head Start Agency Certification');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (3401, '34', 'LicenseType', 'A1', 'LO');
    
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('A2', 'Class A Professional Home Care License');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('A3', 'HCFA Medicare Certification');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('A4', 'Housing with Services');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (3501, '35', 'LicenseType', 'A2', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (3502, '35', 'LicenseType', 'A3', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (3503, '35', 'LicenseType', 'A4', 'LO');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('A5', 'Off-site Approval Letter From Medicare');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (3601, '36', 'LicenseType', 'A5', 'LO');
    
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('A6', 'Verification of IHS status');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (3801, '38', 'LicenseType', 'A6', 'LO');
    
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('A7', 'County Contract to Provider IRTS');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('A8', 'Rule 36 Licensed Facility');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (3901, '39', 'LicenseType', 'A7', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (3902, '39', 'LicenseType', 'A8', 'LO');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('A9', 'Class A License');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('A0', 'Background Study');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (4101, '41', 'LicenseType', 'A9', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (4102, '41', 'LicenseType', 'A0', 'LO');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AA', 'Pharmacy License');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (4201, '42', 'LicenseType', 'AA', 'LO');
    
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AB', 'Class A License For Private Duty Nursing Services');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (4301, '43', 'LicenseType', 'AB', 'LO');
    
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AC', 'Medicare Certification For Home Health Aide And Skilled Nursing Services');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (4501, '45', 'LicenseType', 'AB', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (4502, '45', 'LicenseType', 'AC', 'LO');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AD', 'Regional Treatment Center Certification');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (4601, '46', 'LicenseType', 'AD', 'LO');
    
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AE', 'Medicare Approval Letter');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AF', 'Comprehensive Outpatient Rehabilitation Facility Certification');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (4701, '47', 'LicenseType', 'AE', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (4702, '47', 'LicenseType', 'AF', 'LO');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (4801, '48', 'LicenseType', 'AE', 'LO');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AG', 'Independent or Portable X-ray Certification from CMS');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AH', 'FDA Certification – Mammography services');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (5101, '51', 'LicenseType', 'AG', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (5102, '51', 'LicenseType', 'AH', 'LO');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AI', 'PCA 1 or 3 day Steps for Success Training');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AJ', 'Medicare Certification');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (5201, '52', 'LicenseType', 'AJ', 'LO');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AK', 'Rule 5 License issued from MN Department of Human Services');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AL', 'Certificate of Compliance from MN Department of Human Rights');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (5501, '55', 'LicenseType', 'AK', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (5502, '55', 'LicenseType', 'AL', 'LO');

INSERT INTO LU_CORP_STRUCTURE_TYP(CODE, DESCRIPTION) VALUES ('01', 'Sole Proprietorship');
INSERT INTO LU_CORP_STRUCTURE_TYP(CODE, DESCRIPTION) VALUES ('02', 'Partnership');
INSERT INTO LU_CORP_STRUCTURE_TYP(CODE, DESCRIPTION) VALUES ('03', 'Corporation');
INSERT INTO LU_CORP_STRUCTURE_TYP(CODE, DESCRIPTION) VALUES ('04', 'Non-Profit');
INSERT INTO LU_CORP_STRUCTURE_TYP(CODE, DESCRIPTION) VALUES ('05', 'Hospital Based');
INSERT INTO LU_CORP_STRUCTURE_TYP(CODE, DESCRIPTION) VALUES ('06', 'State');
INSERT INTO LU_CORP_STRUCTURE_TYP(CODE, DESCRIPTION) VALUES ('07', 'Public');
INSERT INTO LU_CORP_STRUCTURE_TYP(CODE, DESCRIPTION) VALUES ('08', 'Professional Association');
INSERT INTO LU_CORP_STRUCTURE_TYP(CODE, DESCRIPTION) VALUES ('99', 'Other');


INSERT INTO LU_RELATIONSHIP_TYP(CODE, DESCRIPTION) VALUES ('01', 'Spouse');
INSERT INTO LU_RELATIONSHIP_TYP(CODE, DESCRIPTION) VALUES ('02', 'Child');
INSERT INTO LU_RELATIONSHIP_TYP(CODE, DESCRIPTION) VALUES ('03', 'Parent');
INSERT INTO LU_RELATIONSHIP_TYP(CODE, DESCRIPTION) VALUES ('04', 'Sibling');

INSERT INTO LU_PAYTO_TYPE(CODE, DESCRIPTION) VALUES ('01', 'Claim');
INSERT INTO LU_PAYTO_TYPE(CODE, DESCRIPTION) VALUES ('02', 'ERA');
INSERT INTO LU_PAYTO_TYPE(CODE, DESCRIPTION) VALUES ('03', 'Both');

INSERT INTO LU_QP_TYP(CODE, DESCRIPTION) VALUES ('01', 'Registered Nurse');
INSERT INTO LU_QP_TYP(CODE, DESCRIPTION) VALUES ('02', 'Licensed Social Worker');
INSERT INTO LU_QP_TYP(CODE, DESCRIPTION) VALUES ('03', 'Mental Health Professional');
INSERT INTO LU_QP_TYP(CODE, DESCRIPTION) VALUES ('04', 'Qualified Developmental Disability Specialist');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (100001, '41', 'LicenseType', 'L4', 'QL');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (100002, '41', 'LicenseType', 'N2', 'QL');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (100003, '41', 'LicenseType', 'M2', 'QL');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (100004, '41', 'LicenseType', 'M4', 'QL');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (100005, '41', 'LicenseType', 'M8', 'QL');
    

INSERT INTO LU_BEN_OWNER_TYP(CODE, OWNER_TYPE, DESCRIPTION) VALUES ('01', 'A', 'Subcontractor');
INSERT INTO LU_BEN_OWNER_TYP(CODE, OWNER_TYPE, DESCRIPTION) VALUES ('02', 'P', 'Managing Employee');
INSERT INTO LU_BEN_OWNER_TYP(CODE, OWNER_TYPE, DESCRIPTION) VALUES ('03', 'A', 'Owner - 5% or more of Ownership Interest');
INSERT INTO LU_BEN_OWNER_TYP(CODE, OWNER_TYPE, DESCRIPTION) VALUES ('04', 'P', 'Board Member or Officer');
INSERT INTO LU_BEN_OWNER_TYP(CODE, OWNER_TYPE, DESCRIPTION) VALUES ('05', 'P', 'Program Manager');
INSERT INTO LU_BEN_OWNER_TYP(CODE, OWNER_TYPE, DESCRIPTION) VALUES ('06', 'P', 'Managing Director');
INSERT INTO LU_BEN_OWNER_TYP(CODE, OWNER_TYPE, DESCRIPTION) VALUES ('99', 'A', 'Other');

-- not profit org owner types
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9901, '04', 'BeneficialOwnerType', '04', 'BT');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9902, '04', 'BeneficialOwnerType', '02', 'BT');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9903, '04', 'BeneficialOwnerType', '01', 'BT');
    
-- sole proprietorship owner types
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9904, '01', 'BeneficialOwnerType', '03', 'BT');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9905, '01', 'BeneficialOwnerType', '02', 'BT');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9906, '01', 'BeneficialOwnerType', '01', 'BT');
    
-- hospital based owner types
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9907, '05', 'BeneficialOwnerType', '04', 'BT');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9908, '05', 'BeneficialOwnerType', '03', 'BT');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9909, '05', 'BeneficialOwnerType', '02', 'BT');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9910, '05', 'BeneficialOwnerType', '01', 'BT');
    
-- corporation owner types
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9911, '03', 'BeneficialOwnerType', '03', 'BT');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9912, '03', 'BeneficialOwnerType', '02', 'BT');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9913, '03', 'BeneficialOwnerType', '01', 'BT');
    
-- partnership
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9914, '02', 'BeneficialOwnerType', '03', 'BT');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9915, '02', 'BeneficialOwnerType', '02', 'BT');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9916, '02', 'BeneficialOwnerType', '01', 'BT');

-- state owned
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9917, '06', 'BeneficialOwnerType', '02', 'BT');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9918, '06', 'BeneficialOwnerType', '01', 'BT');
    
-- public
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9919, '07', 'BeneficialOwnerType', '01', 'BT');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9920, '07', 'BeneficialOwnerType', '05', 'BT');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9921, '07', 'BeneficialOwnerType', '06', 'BT');
    
INSERT INTO AGREEMENT_DOCUMENT(AGREEMENT_DOCUMENT_ID, DOC_TYPE, TITLE, VERSION, DOC_TEXT, CREATED_BY, CREATE_TS)
    VALUES (3, '03', 'Child And Teen Checkup Agreement (DHS-4646)', 1, 'This is some text', 'SYSTEM', SYSDATE);
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (5401, '54', 'AgreementDocument', '03', 'RA');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AM', 'Rule 29 License');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (5701, '57', 'LicenseType', 'AM', 'LO');

    
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('CA', 'Adult Rehabilitative Mental Health Services');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('CB', 'Children''s Therapeutic Services and Supports (CTSS)');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('CC', 'Adult Crisis Response Services - Crisis Assessment &' || ' Crisis Intervention');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('CD', 'Adult Crisis Response Services - Crisis Stabilization');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('CE', 'Adult Crisis Response Services - Short-Term Residential');


INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AN', 'Day Training &' || ' Habilitation License');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (5901, '59', 'LicenseType', 'AN', 'LO');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6101, '61', 'LicenseType', 'A1', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6102, '61', 'LicenseType', 'A2', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6103, '61', 'LicenseType', 'A3', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6104, '61', 'LicenseType', 'A4', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6105, '61', 'LicenseType', 'A5', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6106, '61', 'LicenseType', 'A6', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6107, '61', 'LicenseType', 'A7', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6108, '61', 'LicenseType', 'A8', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6109, '61', 'LicenseType', 'A9', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6110, '61', 'LicenseType', 'A0', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6111, '61', 'LicenseType', 'AA', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6112, '61', 'LicenseType', 'AB', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6113, '61', 'LicenseType', 'AC', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6114, '61', 'LicenseType', 'AD', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6115, '61', 'LicenseType', 'AE', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6116, '61', 'LicenseType', 'AF', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6117, '61', 'LicenseType', 'AG', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6118, '61', 'LicenseType', 'AH', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6119, '61', 'LicenseType', 'AI', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6120, '61', 'LicenseType', 'AJ', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6121, '61', 'LicenseType', 'AK', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6122, '61', 'LicenseType', 'AL', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6123, '61', 'LicenseType', 'AM', 'LO');
    
    
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('01', 'AC Transportation');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('02', 'Home Delivered Meals');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('03', 'Adult Day Services');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('04', 'Homemaker Services');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('05', 'Behavioral Program Services');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('06', 'In-home Family Support');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('07', 'Caregiver Training');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('08', 'Independent Living Skills');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('09', 'Case Management Waiver/Alternative Care');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('10', 'Modification and Adaptations');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('11', 'Chore');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('12', 'Nutritional Services');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('13', 'Cognitive Therapy');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('14', 'PERS and AC Supplies');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('15', 'Companion Services');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('16', 'Respite Care');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('17', 'Consumer Directed Community Support (CDCS)');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('18', 'Specialized Supplies &'|| ' Equipment (Waiver)');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('19', 'Spenddown Collection');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('20', 'Customized Living, 24 CL, Residential Care Services, Assisted Living Services');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('21', 'Structured Day Program Services');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('22', 'Supported Employment Services');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('23', 'Family Counseling and Training');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('24', 'Supported Living Services');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('25', 'Foster Care Services');
INSERT INTO LU_SVC_CAT(CODE, DESCRIPTION) VALUES ('26', 'Waiver Transportation');

INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('01', 'Aitkin');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('02', 'Anoka');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('03', 'Becker');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('04', 'Beltrami');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('05', 'Benton');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('06', 'Big Stone');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('07', 'Blue Earth');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('08', 'Brown');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('09', 'Carlton');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('10', 'Carver');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('11', 'Cass');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('12', 'Chippewa');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('13', 'Chisago');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('14', 'Clay');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('15', 'Clearwater');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('16', 'Cook');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('17', 'Cottonwood');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('18', 'Crow Wing');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('19', 'Dakota');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('20', 'Dodge');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('21', 'Douglas');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('22', 'Faribault');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('23', 'Fillmore');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('24', 'Freeborn');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('25', 'Goodhue');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('26', 'Grant');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('27', 'Hennepin');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('28', 'Houston');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('29', 'Hubbard');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('30', 'Isanti');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('31', 'Itasca');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('32', 'Jackson');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('33', 'Kanabec');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('34', 'Kandiyohi');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('35', 'Kittson');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('36', 'Koochiching');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('37', 'Lac qui Parle');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('38', 'Lake');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('39', 'Lake of the Woods');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('40', 'Le Sueur');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('41', 'Lincoln');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('42', 'Lyon');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('43', 'Mahnomen');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('44', 'Marshall');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('45', 'Martin');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('46', 'McLeod');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('47', 'Meeker');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('48', 'Mille Lacs');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('49', 'Morrison');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('50', 'Mower');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('51', 'Murray');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('52', 'Nicollet');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('53', 'Nobles');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('54', 'Norman');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('55', 'Olmsted');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('56', 'Otter Tail');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('57', 'Pennington');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('58', 'Pine');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('59', 'Pipestone');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('60', 'Polk');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('61', 'Pope');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('62', 'Ramsey');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('63', 'Red Lake');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('64', 'Redwood');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('65', 'Renville');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('66', 'Rice');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('67', 'Rock');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('68', 'Roseau');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('69', 'Scott');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('70', 'Sherburne');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('71', 'Sibley');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('72', 'St. Louis');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('73', 'Stearns');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('74', 'Steele');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('75', 'Stevens');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('76', 'Swift');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('77', 'Todd');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('78', 'Traverse');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('79', 'Wabasha');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('80', 'Wadena');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('81', 'Waseca');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('82', 'Washington');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('83', 'Watonwan');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('84', 'Wilkin');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('85', 'Winona');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('86', 'Wright');
INSERT INTO LU_COUNTY(CODE, DESCRIPTION) VALUES ('87', 'Yellow');

    
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION, PRIVATE_OFFICE_FLG, EMPLOYED_CONTRACTED_FLG, ADDITONAL_PRACTICE_FLG, PAYMENT_REQUIRED_FLG, AGREEMENT_FLG, ADDENDUM_FLG) VALUES ('64', 1, 'Individual Education Plan', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION, PRIVATE_OFFICE_FLG, EMPLOYED_CONTRACTED_FLG, ADDITONAL_PRACTICE_FLG, PAYMENT_REQUIRED_FLG, AGREEMENT_FLG, ADDENDUM_FLG) VALUES ('65', 1, 'Nursing Facility', 'N', 'N', 'N', 'N', 'N', 'N');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AO', 'License and Transmittal (CMS 1539 Form) from MN Department of Health');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AP', 'Approval by Kent Dufresne to enroll new facility');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6501, '65', 'LicenseType', 'AO', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6502, '65', 'LicenseType', 'AP', 'LO');



INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION, PRIVATE_OFFICE_FLG, EMPLOYED_CONTRACTED_FLG, ADDITONAL_PRACTICE_FLG, PAYMENT_REQUIRED_FLG, AGREEMENT_FLG, ADDENDUM_FLG) VALUES ('66', 1, 'Hospice', 'N', 'N', 'N', 'N', 'N', 'N');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AQ', 'Hospice license from the MN Dept of Health');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AR', 'CMS Medicare Certification Letter');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AS', 'Ambulance Services - Basic Service');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AT', 'Ambulance Services - Advanced Life Support');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AU', 'Ambulance Services - Air Transport with FAA Air Worthiness Certificate');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6601, '66', 'LicenseType', 'AQ', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6602, '66', 'LicenseType', 'AR', 'LO');
            
DELETE FROM LU_LICENSE_TYPE WHERE code = 'AP';
DELETE FROM Provider_Setting WHERE provider_setting_id = 6502;
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION, PRIVATE_OFFICE_FLG, EMPLOYED_CONTRACTED_FLG, ADDITONAL_PRACTICE_FLG, PAYMENT_REQUIRED_FLG, AGREEMENT_FLG, ADDENDUM_FLG) VALUES ('67', 1, 'Hospital', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AV', 'State License to operate as a Hospital');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AW', 'CMS PECOS Website Verification');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AX', 'CLIA Certificate if billing Lab Services');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6701, '67', 'LicenseType', 'AV', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6702, '67', 'LicenseType', 'AR', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6703, '67', 'LicenseType', 'AW', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6704, '67', 'LicenseType', 'AX', 'LO');
 
 INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION, PRIVATE_OFFICE_FLG, EMPLOYED_CONTRACTED_FLG, ADDITONAL_PRACTICE_FLG, PAYMENT_REQUIRED_FLG, AGREEMENT_FLG, ADDENDUM_FLG) VALUES ('68', 1, 'Renal Dialysis Facility', 'N', 'N', 'N', 'N', 'N', 'N');

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('AZ', 'Renal Dialysis Facility Approval letter from regional CMS office');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6801, '68', 'LicenseType', 'AZ', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6802, '68', 'LicenseType', 'AO', 'LO');

INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION, PRIVATE_OFFICE_FLG, EMPLOYED_CONTRACTED_FLG, ADDITONAL_PRACTICE_FLG, PAYMENT_REQUIRED_FLG, AGREEMENT_FLG, ADDENDUM_FLG) VALUES ('69', 1, 'Intermediate Care Facilities For Persons With Developmental Disabilities', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (6901, '69', 'LicenseType', 'AO', 'LO');
    
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION, PRIVATE_OFFICE_FLG, EMPLOYED_CONTRACTED_FLG, ADDITONAL_PRACTICE_FLG, PAYMENT_REQUIRED_FLG, AGREEMENT_FLG, ADDENDUM_FLG) VALUES ('70', 1, 'Physician Clinic', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('B0', 'Hospital Based Clinic Designation:  approval letter from CMS');

INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION, PRIVATE_OFFICE_FLG, EMPLOYED_CONTRACTED_FLG, ADDITONAL_PRACTICE_FLG, PAYMENT_REQUIRED_FLG, AGREEMENT_FLG, ADDENDUM_FLG) VALUES ('71', 1, 'Dental Clinic', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION, PRIVATE_OFFICE_FLG, EMPLOYED_CONTRACTED_FLG, ADDITONAL_PRACTICE_FLG, PAYMENT_REQUIRED_FLG, AGREEMENT_FLG, ADDENDUM_FLG) VALUES ('72', 1, 'Dental Hygienist Clinic', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION, PRIVATE_OFFICE_FLG, EMPLOYED_CONTRACTED_FLG, ADDITONAL_PRACTICE_FLG, PAYMENT_REQUIRED_FLG, AGREEMENT_FLG, ADDENDUM_FLG) VALUES ('73', 1, 'Podiatry Clinic', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO LU_PROVIDER_TYPE(CODE, APPLICANT_TYP, DESCRIPTION, PRIVATE_OFFICE_FLG, EMPLOYED_CONTRACTED_FLG, ADDITONAL_PRACTICE_FLG, PAYMENT_REQUIRED_FLG, AGREEMENT_FLG, ADDENDUM_FLG) VALUES ('74', 1, 'Billing Entity For Mental Health', 'N', 'N', 'N', 'N', 'N', 'N');
 
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000003, '03', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000004, '04', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000005, '05', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000006, '06', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000007, '07', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000008, '08', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000009, '09', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000010, '10', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000011, '11', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000012, '12', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000013, '13', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000014, '14', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000015, '15', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000016, '16', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000017, '17', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000018, '18', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000019, '19', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000020, '20', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000021, '21', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000022, '22', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000023, '23', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000024, '24', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000025, '25', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000026, '26', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000027, '27', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000028, '28', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000029, '29', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000030, '30', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000031, '31', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000032, '32', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000033, '33', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000034, '34', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000035, '35', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000036, '36', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000037, '37', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000038, '38', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000039, '39', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000040, '40', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000041, '41', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000042, '42', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000043, '43', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000044, '44', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000045, '45', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000046, '46', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000047, '47', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000048, '48', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000049, '49', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000050, '50', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000051, '51', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000052, '52', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000053, '53', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000054, '54', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000055, '55', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000056, '56', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000057, '57', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000058, '58', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000059, '59', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000060, '60', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000061, '61', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000062, '62', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000063, '63', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000064, '64', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000065, '65', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000066, '66', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000067, '67', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000068, '68', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000069, '69', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000070, '70', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000071, '71', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000072, '72', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000073, '73', 'AgreementDocument', '01', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9000074, '74', 'AgreementDocument', '01', 'RA');
    
    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100003, '03', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100004, '04', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100005, '05', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100006, '06', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100007, '07', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100008, '08', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100009, '09', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100010, '10', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100011, '11', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100012, '12', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100013, '13', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100014, '14', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100015, '15', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100016, '16', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100017, '17', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100018, '18', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100019, '19', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100020, '20', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100021, '21', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100022, '22', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100023, '23', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100024, '24', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100025, '25', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100026, '26', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100027, '27', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100028, '28', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100029, '29', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100030, '30', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100031, '31', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100032, '32', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100033, '33', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100034, '34', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100035, '35', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100036, '36', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100037, '37', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100038, '38', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100039, '39', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100040, '40', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100041, '41', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100042, '42', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100043, '43', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100044, '44', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100045, '45', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100046, '46', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100047, '47', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100048, '48', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100049, '49', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100050, '50', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100051, '51', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100052, '52', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100053, '53', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100054, '54', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100055, '55', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100056, '56', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100057, '57', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100058, '58', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100059, '59', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100060, '60', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100061, '61', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100062, '62', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100063, '63', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100064, '64', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100065, '65', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100066, '66', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100067, '67', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100068, '68', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100069, '69', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100070, '70', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100071, '71', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100072, '72', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100073, '73', 'AgreementDocument', '02', 'RA');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (9100074, '74', 'AgreementDocument', '02', 'RA');

UPDATE LU_PROVIDER_TYPE 
    SET PRIVATE_OFFICE_FLG = 'N',
    EMPLOYED_CONTRACTED_FLG = 'N',
    ADDITONAL_PRACTICE_FLG = 'N',
    PAYMENT_REQUIRED_FLG = 'N',
    AGREEMENT_FLG = 'N',
    ADDENDUM_FLG = 'N'
WHERE 1=1;


delete from LU_LICENSE_TYPE where CODE = 'M8';
delete from PROVIDER_SETTING where RELATED_ENTITY_CD = 'M8';

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('H1', 'Rehab Counselor Certification');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('H2', 'Psychosocial Rehab Practitioner Certification');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2003, '20', 'LicenseType', 'H1', 'LO');    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2004, '20', 'LicenseType', 'H2', 'LO');
    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (100006, '41', 'LicenseType', 'H1', 'QL');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (100007, '41', 'LicenseType', 'H2', 'QL');
    

INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('41', 'Gerontological');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('42', 'Pediatric');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('43', 'Family');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('44', 'Adult');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('45', 'OB/GYN');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('46', 'Neonatal');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('47', 'Women''s Health Care');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('48', 'Acute Care');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14001, '12', 'SpecialtyType', '41', 'SO');    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14002, '12', 'SpecialtyType', '42', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14003, '12', 'SpecialtyType', '43', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14004, '12', 'SpecialtyType', '44', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14005, '12', 'SpecialtyType', '45', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14006, '12', 'SpecialtyType', '46', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14007, '12', 'SpecialtyType', '47', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14008, '12', 'SpecialtyType', '48', 'SO');    

-- Added on 12-02-2013
    
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('H3', 'Licensed Practical Nurse');    
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('H4', 'Class A License');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1503, '15', 'LicenseType', 'H3', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1504, '15', 'LicenseType', 'H4', 'LO');
    
-- Added on 12-03-2013
ALTER TABLE PROFILE_GRP_XREF ADD (BGS_STUDY_ID VARCHAR2(75) );    
ALTER TABLE PROFILE_GRP_XREF ADD (BGS_CLEARANCE_DT DATE );    

-- Added on 12-09-2013
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

-- Added on 12-12-13
DELETE FROM LU_STATE WHERE CODE = 'XX'; 
DELETE FROM PROVIDER_SETTING WHERE PROVIDER_SETTING_ID = 104;

CREATE SEQUENCE AGREEMENT_DOC_SEQ  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 4 CACHE 20 NOORDER  NOCYCLE;

update agreement_document set doc_type = '01' where agreement_document_id = 3;

-- Added on 12-13-13
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('49', 'Gerontology');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('50', 'Pediatrics');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2844, '28', 'SpecialtyType', '49', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2845, '28', 'SpecialtyType', '50', 'SO');
    
-- Added on 12-17-13
delete from PROVIDER_SETTING where RELATED_ENTITY_CD = 'L2' and PROVIDER_TYP_CD = '01';    

INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('C1', 'Adult CNS');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('C2', 'Diabetes Management CNS');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('C3', 'Gerontological CNS');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('C4', 'Home Health CNS');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('C5', 'Pediatric CNS');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (705, '07', 'SpecialtyType', 'C1', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (706, '07', 'SpecialtyType', 'C2', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (707, '07', 'SpecialtyType', 'C3', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (708, '07', 'SpecialtyType', 'C4', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (709, '07', 'SpecialtyType', 'C5', 'SO');
    
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('B1', 'Adult Day Care License');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('B2', '245B License');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (5902, '59', 'LicenseType', 'B1', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (5903, '59', 'LicenseType', 'B2', 'LO');
    
delete from LU_LICENSE_TYPE where code = 'AP';
delete from PROVIDER_SETTING where provider_setting_id = 6502;   

-- Added on 12-20-2013
ALTER TABLE LICENSE MODIFY (ISSUING_US_STATE VARCHAR2(8 CHAR));

INSERT INTO LU_ISSUING_BOARD VALUES ('B8', 'AMCB');
DELETE FROM PROVIDER_SETTING WHERE PROVIDER_SETTING_ID = 2504;
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2504, '25', 'IssuingBoard', 'B8', 'SB');
    
INSERT INTO LU_SPECIALTY_TYPE (CODE, DESCRIPTION) VALUES ('S9', 'Certified Nurse Midwife');
DELETE FROM PROVIDER_SETTING WHERE PROVIDER_SETTING_ID = 2503;
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2503, '25', 'SpecialtyType', 'S9', 'SO');
    
INSERT INTO LU_ISSUING_BOARD(CODE, DESCRIPTION) VALUES ('C1', 'ABOMS');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2110, '21', 'IssuingBoard', 'C1', 'SB');
    
DELETE FROM PROVIDER_SETTING WHERE PROVIDER_SETTING_ID = 102;

INSERT INTO CMS_AUTHENTICATION VALUES ('localadmin','{SHA}Y8zCvwEPlya69etw51iEnUHT/L8=');
INSERT INTO CMS_USER(USER_ID, USER_NAME, FIRST_NAME, LAST_NAME, EMAIL, STATUS, ROLE_CD)
    VALUES('localadmin', 'localadmin', 'localadmin', 'localadmin', 'cmsmailer@gmail.com', 'ACTIVE', 'R3');
