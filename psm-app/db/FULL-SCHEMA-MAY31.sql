--------------------------------------------------------
--  File created - Friday-May-31-2013   
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
--  DDL for Table SVC_ASSURANCE_EXT_TYP
--------------------------------------------------------

  CREATE TABLE "CMS"."SVC_ASSURANCE_EXT_TYP" 
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
