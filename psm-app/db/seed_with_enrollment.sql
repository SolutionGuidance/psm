--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.task DROP CONSTRAINT task_taskinitiator_id_fkey;
ALTER TABLE ONLY public.task DROP CONSTRAINT task_createdby_id_fkey;
ALTER TABLE ONLY public.task_comment DROP CONSTRAINT task_comment_taskdata_comments_id_fkey;
ALTER TABLE ONLY public.task_comment DROP CONSTRAINT task_comment_addedby_id_fkey;
ALTER TABLE ONLY public.task DROP CONSTRAINT task_actualowner_id_fkey;
ALTER TABLE ONLY public.subtasksstrategy DROP CONSTRAINT subtasksstrategy_task_id_fkey;
ALTER TABLE ONLY public.reassignment_potentialowners DROP CONSTRAINT reassignment_potentialowners_task_id_fkey;
ALTER TABLE ONLY public.reassignment_potentialowners DROP CONSTRAINT reassignment_potentialowners_entity_id_fkey;
ALTER TABLE ONLY public.reassignment DROP CONSTRAINT reassignment_escalation_reassignments_id_fkey;
ALTER TABLE ONLY public.provider_type_settings DROP CONSTRAINT provider_type_settings_provider_type_code_fkey;
ALTER TABLE ONLY public.provider_type_license_types DROP CONSTRAINT provider_type_license_types_provider_type_code_fkey;
ALTER TABLE ONLY public.provider_type_license_types DROP CONSTRAINT provider_type_license_types_license_type_code_fkey;
ALTER TABLE ONLY public.provider_type_agreement_documents DROP CONSTRAINT provider_type_agreement_documents_provider_type_code_fkey;
ALTER TABLE ONLY public.provider_type_agreement_documents DROP CONSTRAINT provider_type_agreement_documents_agreement_document_id_fkey;
ALTER TABLE ONLY public.provider_services DROP CONSTRAINT provider_services_service_category_code_fkey;
ALTER TABLE ONLY public.provider_profiles DROP CONSTRAINT provider_profiles_risk_level_code_fkey;
ALTER TABLE ONLY public.provider_profiles DROP CONSTRAINT provider_profiles_profile_status_code_fkey;
ALTER TABLE ONLY public.provider_approved_categories_of_service DROP CONSTRAINT provider_approved_categories_of_s_category_of_service_code_fkey;
ALTER TABLE ONLY public.provider_approved_categories_of_service DROP CONSTRAINT provider_approved_categories__provider_category_of_service_fkey;
ALTER TABLE ONLY public.peopleassignments_stakeholders DROP CONSTRAINT peopleassignments_stakeholders_task_id_fkey;
ALTER TABLE ONLY public.peopleassignments_stakeholders DROP CONSTRAINT peopleassignments_stakeholders_entity_id_fkey;
ALTER TABLE ONLY public.peopleassignments_recipients DROP CONSTRAINT peopleassignments_recipients_task_id_fkey;
ALTER TABLE ONLY public.peopleassignments_recipients DROP CONSTRAINT peopleassignments_recipients_entity_id_fkey;
ALTER TABLE ONLY public.peopleassignments_potowners DROP CONSTRAINT peopleassignments_potowners_task_id_fkey;
ALTER TABLE ONLY public.peopleassignments_potowners DROP CONSTRAINT peopleassignments_potowners_entity_id_fkey;
ALTER TABLE ONLY public.peopleassignments_exclowners DROP CONSTRAINT peopleassignments_exclowners_task_id_fkey;
ALTER TABLE ONLY public.peopleassignments_exclowners DROP CONSTRAINT peopleassignments_exclowners_entity_id_fkey;
ALTER TABLE ONLY public.peopleassignments_bas DROP CONSTRAINT peopleassignments_bas_task_id_fkey;
ALTER TABLE ONLY public.peopleassignments_bas DROP CONSTRAINT peopleassignments_bas_entity_id_fkey;
ALTER TABLE ONLY public.people DROP CONSTRAINT people_entity_id_fkey;
ALTER TABLE ONLY public.people DROP CONSTRAINT people_degree_code_fkey;
ALTER TABLE ONLY public.pay_to_providers DROP CONSTRAINT pay_to_providers_pay_to_type_code_fkey;
ALTER TABLE ONLY public.ownership_info DROP CONSTRAINT ownership_info_entity_structure_type_code_fkey;
ALTER TABLE ONLY public.ownership_info DROP CONSTRAINT ownership_info_entity_structure_subtype_code_fkey;
ALTER TABLE ONLY public.owner_assets DROP CONSTRAINT owner_assets_ownership_type_code_fkey;
ALTER TABLE ONLY public.organizations DROP CONSTRAINT organizations_ten99_address_id_fkey;
ALTER TABLE ONLY public.organizations DROP CONSTRAINT organizations_reimbursement_address_id_fkey;
ALTER TABLE ONLY public.organizations DROP CONSTRAINT organizations_entity_id_fkey;
ALTER TABLE ONLY public.organizations DROP CONSTRAINT organizations_billing_address_id_fkey;
ALTER TABLE ONLY public.notification_recipients DROP CONSTRAINT notification_recipients_task_id_fkey;
ALTER TABLE ONLY public.notification_recipients DROP CONSTRAINT notification_recipients_entity_id_fkey;
ALTER TABLE ONLY public.notification DROP CONSTRAINT notification_escalation_notifications_id_fkey;
ALTER TABLE ONLY public.notification_email_header DROP CONSTRAINT notification_email_header_emailnotification_id_fkey;
ALTER TABLE ONLY public.notification_email_header DROP CONSTRAINT notification_email_header_emailheaders_id_fkey;
ALTER TABLE ONLY public.notification_bas DROP CONSTRAINT notification_bas_task_id_fkey;
ALTER TABLE ONLY public.notification_bas DROP CONSTRAINT notification_bas_entity_id_fkey;
ALTER TABLE ONLY public.licenses DROP CONSTRAINT licenses_specialty_type_code_fkey;
ALTER TABLE ONLY public.licenses DROP CONSTRAINT licenses_license_type_code_fkey;
ALTER TABLE ONLY public.licenses DROP CONSTRAINT licenses_license_status_code_fkey;
ALTER TABLE ONLY public.licenses DROP CONSTRAINT licenses_issuing_board_code_fkey;
ALTER TABLE ONLY public.i18ntext DROP CONSTRAINT i18ntext_task_subjects_id_fkey;
ALTER TABLE ONLY public.i18ntext DROP CONSTRAINT i18ntext_task_names_id_fkey;
ALTER TABLE ONLY public.i18ntext DROP CONSTRAINT i18ntext_task_descriptions_id_fkey;
ALTER TABLE ONLY public.i18ntext DROP CONSTRAINT i18ntext_reassignment_documentation_id_fkey;
ALTER TABLE ONLY public.i18ntext DROP CONSTRAINT i18ntext_notification_subjects_id_fkey;
ALTER TABLE ONLY public.i18ntext DROP CONSTRAINT i18ntext_notification_names_id_fkey;
ALTER TABLE ONLY public.i18ntext DROP CONSTRAINT i18ntext_notification_documentation_id_fkey;
ALTER TABLE ONLY public.i18ntext DROP CONSTRAINT i18ntext_notification_descriptions_id_fkey;
ALTER TABLE ONLY public.i18ntext DROP CONSTRAINT i18ntext_deadline_documentation_id_fkey;
ALTER TABLE ONLY public.profile_assured_ext_svcs DROP CONSTRAINT fknpq45dvbn0v9qxjrp3ccs81uy;
ALTER TABLE ONLY public.required_fld DROP CONSTRAINT fk3pj5itnxvpohvq0q8skilyal0;
ALTER TABLE ONLY public.provider_cos DROP CONSTRAINT fk2ciqibe0u9h2cmyeut8q5alir;
ALTER TABLE ONLY public.eventtypes DROP CONSTRAINT eventtypes_instanceid_fkey;
ALTER TABLE ONLY public.escalation DROP CONSTRAINT escalation_deadline_escalation_id_fkey;
ALTER TABLE ONLY public.entities DROP CONSTRAINT entities_provider_type_code_fkey;
ALTER TABLE ONLY public.entities DROP CONSTRAINT entities_contact_id_fkey;
ALTER TABLE ONLY public.enrollments DROP CONSTRAINT enrollments_request_type_code_fkey;
ALTER TABLE ONLY public.enrollments DROP CONSTRAINT enrollments_enrollment_status_code_fkey;
ALTER TABLE ONLY public.designated_contacts DROP CONSTRAINT designated_contacts_person_id_fkey;
ALTER TABLE ONLY public.delegation_delegates DROP CONSTRAINT delegation_delegates_task_id_fkey;
ALTER TABLE ONLY public.delegation_delegates DROP CONSTRAINT delegation_delegates_entity_id_fkey;
ALTER TABLE ONLY public.deadline DROP CONSTRAINT deadline_deadlines_startdeadline_id_fkey;
ALTER TABLE ONLY public.deadline DROP CONSTRAINT deadline_deadlines_enddeadline_id_fkey;
ALTER TABLE ONLY public.contacts DROP CONSTRAINT contacts_address_id_fkey;
ALTER TABLE ONLY public.cms_user DROP CONSTRAINT cms_user_role_code_fkey;
ALTER TABLE ONLY public.booleanexpression DROP CONSTRAINT booleanexpression_escalation_constraints_id_fkey;
ALTER TABLE ONLY public.beneficial_owner DROP CONSTRAINT beneficial_owner_relationship_type_code_fkey;
ALTER TABLE ONLY public.beneficial_owner DROP CONSTRAINT beneficial_owner_ownership_info_id_fkey;
ALTER TABLE ONLY public.beneficial_owner DROP CONSTRAINT beneficial_owner_oth_provider_address_id_fkey;
ALTER TABLE ONLY public.beneficial_owner DROP CONSTRAINT beneficial_owner_ben_type_cd_fkey;
ALTER TABLE ONLY public.beneficial_owner DROP CONSTRAINT beneficial_owner_address_id_fkey;
ALTER TABLE ONLY public.audit_details DROP CONSTRAINT audit_details_audit_record_id_fkey;
ALTER TABLE ONLY public.attachment DROP CONSTRAINT attachment_taskdata_attachments_id_fkey;
ALTER TABLE ONLY public.attachment DROP CONSTRAINT attachment_attachedby_id_fkey;
ALTER TABLE ONLY public.affiliations DROP CONSTRAINT affiliations_qualified_professional_type_code_fkey;
ALTER TABLE ONLY public.accepted_agreements DROP CONSTRAINT accepted_agreements_agreement_document_id_fkey;
ALTER TABLE ONLY public.workiteminfo DROP CONSTRAINT workiteminfo_pkey;
ALTER TABLE ONLY public.task DROP CONSTRAINT task_pkey;
ALTER TABLE ONLY public.task_comment DROP CONSTRAINT task_comment_pkey;
ALTER TABLE ONLY public.subtasksstrategy DROP CONSTRAINT subtasksstrategy_pkey;
ALTER TABLE ONLY public.states DROP CONSTRAINT states_pkey;
ALTER TABLE ONLY public.states DROP CONSTRAINT states_description_key;
ALTER TABLE ONLY public.specialty_types DROP CONSTRAINT specialty_types_pkey;
ALTER TABLE ONLY public.specialty_types DROP CONSTRAINT specialty_types_description_key;
ALTER TABLE ONLY public.sessioninfo DROP CONSTRAINT sessioninfo_pkey;
ALTER TABLE ONLY public.service_categories DROP CONSTRAINT service_categories_pkey;
ALTER TABLE ONLY public.service_categories DROP CONSTRAINT service_categories_description_key;
ALTER TABLE ONLY public.service_assurance_types DROP CONSTRAINT service_assurance_types_pkey;
ALTER TABLE ONLY public.service_assurance_types DROP CONSTRAINT service_assurance_types_description_key;
ALTER TABLE ONLY public.service_assurance_ext_types DROP CONSTRAINT service_assurance_ext_types_pkey;
ALTER TABLE ONLY public.service_assurance_ext_types DROP CONSTRAINT service_assurance_ext_types_description_key;
ALTER TABLE ONLY public.screening_schedules DROP CONSTRAINT screening_schedules_pkey;
ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_description_key;
ALTER TABLE ONLY public.risk_levels DROP CONSTRAINT risk_levels_sort_index_key;
ALTER TABLE ONLY public.risk_levels DROP CONSTRAINT risk_levels_pkey;
ALTER TABLE ONLY public.risk_levels DROP CONSTRAINT risk_levels_description_key;
ALTER TABLE ONLY public.required_fld DROP CONSTRAINT required_fld_pkey;
ALTER TABLE ONLY public.required_field_types DROP CONSTRAINT required_field_types_pkey;
ALTER TABLE ONLY public.required_field_types DROP CONSTRAINT required_field_types_description_key;
ALTER TABLE ONLY public.request_types DROP CONSTRAINT request_types_pkey;
ALTER TABLE ONLY public.request_types DROP CONSTRAINT request_types_description_key;
ALTER TABLE ONLY public.relationship_types DROP CONSTRAINT relationship_types_pkey;
ALTER TABLE ONLY public.relationship_types DROP CONSTRAINT relationship_types_description_key;
ALTER TABLE ONLY public.reassignment DROP CONSTRAINT reassignment_pkey;
ALTER TABLE ONLY public.qualified_professional_types DROP CONSTRAINT qualified_professional_types_pkey;
ALTER TABLE ONLY public.qualified_professional_types DROP CONSTRAINT qualified_professional_types_description_key;
ALTER TABLE ONLY public.provider_types DROP CONSTRAINT provider_types_pkey;
ALTER TABLE ONLY public.provider_types DROP CONSTRAINT provider_types_description_key;
ALTER TABLE ONLY public.provider_type_settings DROP CONSTRAINT provider_type_settings_pkey;
ALTER TABLE ONLY public.provider_type_license_types DROP CONSTRAINT provider_type_license_types_pkey;
ALTER TABLE ONLY public.provider_type_agreement_documents DROP CONSTRAINT provider_type_agreement_documents_pkey;
ALTER TABLE ONLY public.provider_svcs DROP CONSTRAINT provider_svcs_pkey;
ALTER TABLE ONLY public.provider_statements DROP CONSTRAINT provider_statements_pkey;
ALTER TABLE ONLY public.provider_services DROP CONSTRAINT provider_services_pkey;
ALTER TABLE ONLY public.provider_profiles DROP CONSTRAINT provider_profiles_pkey;
ALTER TABLE ONLY public.provider_cos_xref DROP CONSTRAINT provider_cos_xref_pkey;
ALTER TABLE ONLY public.provider_category_of_service_approvals DROP CONSTRAINT provider_category_of_service_approvals_pkey;
ALTER TABLE ONLY public.profile_statuses DROP CONSTRAINT profile_statuses_pkey;
ALTER TABLE ONLY public.profile_statuses DROP CONSTRAINT profile_statuses_description_key;
ALTER TABLE ONLY public.profile_assured_svc_xref DROP CONSTRAINT profile_assured_svc_xref_pkey;
ALTER TABLE ONLY public.processinstanceinfo DROP CONSTRAINT processinstanceinfo_pkey;
ALTER TABLE ONLY public.persistent_logins DROP CONSTRAINT persistent_logins_pkey;
ALTER TABLE ONLY public.peopleassignments_stakeholders DROP CONSTRAINT peopleassignments_stakeholders_pkey;
ALTER TABLE ONLY public.peopleassignments_recipients DROP CONSTRAINT peopleassignments_recipients_pkey;
ALTER TABLE ONLY public.peopleassignments_potowners DROP CONSTRAINT peopleassignments_potowners_pkey;
ALTER TABLE ONLY public.peopleassignments_exclowners DROP CONSTRAINT peopleassignments_exclowners_pkey;
ALTER TABLE ONLY public.peopleassignments_bas DROP CONSTRAINT peopleassignments_bas_pkey;
ALTER TABLE ONLY public.people DROP CONSTRAINT people_pkey;
ALTER TABLE ONLY public.pay_to_providers DROP CONSTRAINT pay_to_providers_pkey;
ALTER TABLE ONLY public.pay_to_provider_types DROP CONSTRAINT pay_to_provider_types_pkey;
ALTER TABLE ONLY public.pay_to_provider_types DROP CONSTRAINT pay_to_provider_types_description_key;
ALTER TABLE ONLY public.ownership_types DROP CONSTRAINT ownership_types_pkey;
ALTER TABLE ONLY public.ownership_types DROP CONSTRAINT ownership_types_description_key;
ALTER TABLE ONLY public.ownership_info DROP CONSTRAINT ownership_info_pkey;
ALTER TABLE ONLY public.owner_assets DROP CONSTRAINT owner_assets_pkey;
ALTER TABLE ONLY public.organizations DROP CONSTRAINT organizations_pkey;
ALTER TABLE ONLY public.organizationalentity DROP CONSTRAINT organizationalentity_pkey;
ALTER TABLE ONLY public.notification_recipients DROP CONSTRAINT notification_recipients_pkey;
ALTER TABLE ONLY public.notification DROP CONSTRAINT notification_pkey;
ALTER TABLE ONLY public.notification_email_header DROP CONSTRAINT notification_email_header_pkey;
ALTER TABLE ONLY public.notification_email_header DROP CONSTRAINT notification_email_header_emailheaders_id_key;
ALTER TABLE ONLY public.notification_bas DROP CONSTRAINT notification_bas_pkey;
ALTER TABLE ONLY public.notes DROP CONSTRAINT notes_pkey;
ALTER TABLE ONLY public.licenses DROP CONSTRAINT licenses_pkey;
ALTER TABLE ONLY public.license_types DROP CONSTRAINT license_types_pkey;
ALTER TABLE ONLY public.license_types DROP CONSTRAINT license_types_description_key;
ALTER TABLE ONLY public.license_statuses DROP CONSTRAINT license_statuses_pkey;
ALTER TABLE ONLY public.license_statuses DROP CONSTRAINT license_statuses_description_key;
ALTER TABLE ONLY public.legacy_mapping DROP CONSTRAINT legacy_mapping_pkey;
ALTER TABLE ONLY public.issuing_boards DROP CONSTRAINT issuing_boards_pkey;
ALTER TABLE ONLY public.issuing_boards DROP CONSTRAINT issuing_boards_description_key;
ALTER TABLE ONLY public.i18ntext DROP CONSTRAINT i18ntext_pkey;
ALTER TABLE ONLY public.help_items DROP CONSTRAINT help_items_pkey;
ALTER TABLE ONLY public.external_profile_links DROP CONSTRAINT external_profile_links_pkey;
ALTER TABLE ONLY public.external_profile_link DROP CONSTRAINT external_profile_link_pkey;
ALTER TABLE ONLY public.external_account_links DROP CONSTRAINT external_account_links_pkey;
ALTER TABLE ONLY public.external_account_link DROP CONSTRAINT external_account_link_pkey;
ALTER TABLE ONLY public.events DROP CONSTRAINT events_pkey;
ALTER TABLE ONLY public.escalation DROP CONSTRAINT escalation_pkey;
ALTER TABLE ONLY public.entity_structure_types DROP CONSTRAINT entity_structure_types_pkey;
ALTER TABLE ONLY public.entity_structure_types DROP CONSTRAINT entity_structure_types_description_key;
ALTER TABLE ONLY public.entities DROP CONSTRAINT entities_pkey;
ALTER TABLE ONLY public.enrollments DROP CONSTRAINT enrollments_pkey;
ALTER TABLE ONLY public.enrollment_statuses DROP CONSTRAINT enrollment_statuses_pkey;
ALTER TABLE ONLY public.enrollment_statuses DROP CONSTRAINT enrollment_statuses_description_key;
ALTER TABLE ONLY public.email_header DROP CONSTRAINT email_header_pkey;
ALTER TABLE ONLY public.documents DROP CONSTRAINT documents_pkey;
ALTER TABLE ONLY public.designated_contacts DROP CONSTRAINT designated_contacts_pkey;
ALTER TABLE ONLY public.delegation_delegates DROP CONSTRAINT delegation_delegates_pkey;
ALTER TABLE ONLY public.degrees DROP CONSTRAINT degrees_pkey;
ALTER TABLE ONLY public.degrees DROP CONSTRAINT degrees_description_key;
ALTER TABLE ONLY public.deadline DROP CONSTRAINT deadline_pkey;
ALTER TABLE ONLY public.counties DROP CONSTRAINT counties_pkey;
ALTER TABLE ONLY public.counties DROP CONSTRAINT counties_description_key;
ALTER TABLE ONLY public.content DROP CONSTRAINT content_pkey;
ALTER TABLE ONLY public.contacts DROP CONSTRAINT contacts_pkey;
ALTER TABLE ONLY public.cms_user DROP CONSTRAINT cms_user_username_key;
ALTER TABLE ONLY public.cms_user DROP CONSTRAINT cms_user_pkey;
ALTER TABLE ONLY public.cms_authentication DROP CONSTRAINT cms_authentication_pkey;
ALTER TABLE ONLY public.categories_of_service DROP CONSTRAINT categories_of_service_pkey;
ALTER TABLE ONLY public.categories_of_service DROP CONSTRAINT categories_of_service_description_key;
ALTER TABLE ONLY public.booleanexpression DROP CONSTRAINT booleanexpression_pkey;
ALTER TABLE ONLY public.binary_contents DROP CONSTRAINT binary_contents_pkey;
ALTER TABLE ONLY public.beneficial_owner_types DROP CONSTRAINT beneficial_owner_types_pkey;
ALTER TABLE ONLY public.beneficial_owner_types DROP CONSTRAINT beneficial_owner_types_description_key;
ALTER TABLE ONLY public.beneficial_owner DROP CONSTRAINT beneficial_owner_pkey;
ALTER TABLE ONLY public.audit_records DROP CONSTRAINT audit_records_pkey;
ALTER TABLE ONLY public.audit_details DROP CONSTRAINT audit_details_pkey;
ALTER TABLE ONLY public.attachment DROP CONSTRAINT attachment_pkey;
ALTER TABLE ONLY public.agreement_documents DROP CONSTRAINT agreement_documents_pkey;
ALTER TABLE ONLY public.affiliations DROP CONSTRAINT affiliations_pkey;
ALTER TABLE ONLY public.addresses DROP CONSTRAINT addresses_pkey;
ALTER TABLE ONLY public.accepted_agreements DROP CONSTRAINT accepted_agreements_pkey;
SELECT pg_catalog.lo_unlink('62443');
SELECT pg_catalog.lo_unlink('62442');
SELECT pg_catalog.lo_unlink('62441');
SELECT pg_catalog.lo_unlink('62440');
SELECT pg_catalog.lo_unlink('62439');
SELECT pg_catalog.lo_unlink('62438');
SELECT pg_catalog.lo_unlink('62437');
SELECT pg_catalog.lo_unlink('62436');
SELECT pg_catalog.lo_unlink('60218');
SELECT pg_catalog.lo_unlink('60217');
SELECT pg_catalog.lo_unlink('60216');
SELECT pg_catalog.lo_unlink('60215');
SELECT pg_catalog.lo_unlink('60214');
SELECT pg_catalog.lo_unlink('60213');
SELECT pg_catalog.lo_unlink('60212');
SELECT pg_catalog.lo_unlink('60211');
SELECT pg_catalog.lo_unlink('57994');
SELECT pg_catalog.lo_unlink('57993');
SELECT pg_catalog.lo_unlink('57992');
SELECT pg_catalog.lo_unlink('57991');
SELECT pg_catalog.lo_unlink('57990');
SELECT pg_catalog.lo_unlink('57989');
SELECT pg_catalog.lo_unlink('57988');
SELECT pg_catalog.lo_unlink('57987');
SELECT pg_catalog.lo_unlink('52447');
SELECT pg_catalog.lo_unlink('52446');
SELECT pg_catalog.lo_unlink('52445');
SELECT pg_catalog.lo_unlink('52444');
SELECT pg_catalog.lo_unlink('52443');
SELECT pg_catalog.lo_unlink('52442');
SELECT pg_catalog.lo_unlink('52441');
SELECT pg_catalog.lo_unlink('52440');
SELECT pg_catalog.lo_unlink('44760');
SELECT pg_catalog.lo_unlink('44759');
SELECT pg_catalog.lo_unlink('44758');
SELECT pg_catalog.lo_unlink('44757');
SELECT pg_catalog.lo_unlink('44756');
SELECT pg_catalog.lo_unlink('44755');
SELECT pg_catalog.lo_unlink('44754');
SELECT pg_catalog.lo_unlink('44753');
DROP SEQUENCE public.workiteminfo_id_seq;
DROP TABLE public.workiteminfo;
DROP TABLE public.task_comment;
DROP TABLE public.task;
DROP TABLE public.subtasksstrategy;
DROP TABLE public.states;
DROP TABLE public.specialty_types;
DROP SEQUENCE public.sessioninfo_id_seq;
DROP TABLE public.sessioninfo;
DROP TABLE public.service_categories;
DROP TABLE public.service_assurance_types;
DROP TABLE public.service_assurance_ext_types;
DROP TABLE public.screening_schedules;
DROP TABLE public.roles;
DROP TABLE public.risk_levels;
DROP TABLE public.required_fld;
DROP TABLE public.required_field_types;
DROP TABLE public.request_types;
DROP TABLE public.relationship_types;
DROP TABLE public.reassignment_potentialowners;
DROP SEQUENCE public.reassignment_id_seq;
DROP TABLE public.reassignment;
DROP TABLE public.qualified_professional_types;
DROP TABLE public.provider_types;
DROP TABLE public.provider_type_settings;
DROP TABLE public.provider_type_license_types;
DROP TABLE public.provider_type_agreement_documents;
DROP TABLE public.provider_svcs;
DROP TABLE public.provider_statements;
DROP TABLE public.provider_services;
DROP TABLE public.provider_profiles;
DROP TABLE public.provider_cos_xref;
DROP TABLE public.provider_cos;
DROP TABLE public.provider_category_of_service_approvals;
DROP TABLE public.provider_approved_categories_of_service;
DROP TABLE public.profile_statuses;
DROP TABLE public.profile_assured_svc_xref;
DROP TABLE public.profile_assured_ext_svcs;
DROP TABLE public.processinstanceinfo;
DROP TABLE public.persistent_logins;
DROP TABLE public.peopleassignments_stakeholders;
DROP TABLE public.peopleassignments_recipients;
DROP TABLE public.peopleassignments_potowners;
DROP TABLE public.peopleassignments_exclowners;
DROP TABLE public.peopleassignments_bas;
DROP TABLE public.people;
DROP TABLE public.pay_to_providers;
DROP TABLE public.pay_to_provider_types;
DROP TABLE public.ownership_types;
DROP TABLE public.ownership_info;
DROP TABLE public.owner_assets;
DROP TABLE public.organizations;
DROP TABLE public.organizationalentity;
DROP TABLE public.notification_recipients;
DROP SEQUENCE public.notification_id_seq;
DROP TABLE public.notification_email_header;
DROP TABLE public.notification_bas;
DROP TABLE public.notification;
DROP TABLE public.notes;
DROP TABLE public.licenses;
DROP TABLE public.license_types;
DROP TABLE public.license_statuses;
DROP TABLE public.legacy_mapping;
DROP TABLE public.issuing_boards;
DROP SEQUENCE public.i18ntext_id_seq;
DROP TABLE public.i18ntext;
DROP SEQUENCE public.hibernate_sequence;
DROP TABLE public.help_items;
DROP TABLE public.external_profile_links;
DROP TABLE public.external_profile_link;
DROP TABLE public.external_account_links;
DROP TABLE public.external_account_link;
DROP TABLE public.eventtypes;
DROP TABLE public.events;
DROP SEQUENCE public.escalation_id_seq;
DROP TABLE public.escalation;
DROP TABLE public.entity_structure_types;
DROP TABLE public.entities;
DROP TABLE public.enrollments;
DROP TABLE public.enrollment_statuses;
DROP SEQUENCE public.emailnotifhead_id_seq;
DROP TABLE public.email_header;
DROP TABLE public.documents;
DROP TABLE public.designated_contacts;
DROP TABLE public.delegation_delegates;
DROP TABLE public.degrees;
DROP SEQUENCE public.deadline_id_seq;
DROP TABLE public.deadline;
DROP TABLE public.counties;
DROP SEQUENCE public.content_id_seq;
DROP TABLE public.content;
DROP TABLE public.contacts;
DROP SEQUENCE public.comment_id_seq;
DROP TABLE public.cms_user;
DROP TABLE public.cms_authentication;
DROP TABLE public.categories_of_service;
DROP TABLE public.booleanexpression;
DROP SEQUENCE public.booleanexpr_id_seq;
DROP TABLE public.binary_contents;
DROP TABLE public.beneficial_owner_types;
DROP TABLE public.beneficial_owner;
DROP TABLE public.audit_records;
DROP TABLE public.audit_details;
DROP SEQUENCE public.attachment_id_seq;
DROP TABLE public.attachment;
DROP TABLE public.agreement_documents;
DROP TABLE public.affiliations;
DROP TABLE public.addresses;
DROP TABLE public.accepted_agreements;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accepted_agreements; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE accepted_agreements (
    accepted_agreement_id bigint NOT NULL,
    profile_id bigint,
    ticket_id bigint,
    accepted_date date,
    agreement_document_id bigint
);


ALTER TABLE accepted_agreements OWNER TO psm;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE addresses (
    address_id bigint NOT NULL,
    attention_line text,
    address_line_1 text,
    address_line_2 text,
    city text,
    state text,
    zip_code text,
    county text
);


ALTER TABLE addresses OWNER TO psm;

--
-- Name: affiliations; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE affiliations (
    affiliation_id bigint NOT NULL,
    is_primary character varying(1),
    profile_id bigint,
    object_type text,
    ticket_id bigint,
    effective_at date,
    target_profile_id bigint,
    target_entity_id bigint,
    qualified_professional_type_code character varying(2),
    mental_health_professional_type text,
    acknowledgement_attachment_id text,
    is_terminated character varying(1),
    terminated_at date,
    bgs_study_id text,
    bgs_clearance_date date
);


ALTER TABLE affiliations OWNER TO psm;

--
-- Name: agreement_documents; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE agreement_documents (
    agreement_document_id bigint NOT NULL,
    type text,
    title text,
    version integer,
    body text,
    created_by text,
    created_at timestamp with time zone
);


ALTER TABLE agreement_documents OWNER TO psm;

--
-- Name: attachment; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE attachment (
    id bigint NOT NULL,
    accesstype integer,
    attachedat timestamp with time zone,
    attachmentcontentid bigint NOT NULL,
    contenttype text,
    name text,
    attachment_size integer,
    attachedby_id text,
    taskdata_attachments_id bigint
);


ALTER TABLE attachment OWNER TO psm;

--
-- Name: attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: psm
--

CREATE SEQUENCE attachment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE attachment_id_seq OWNER TO psm;

--
-- Name: audit_details; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE audit_details (
    audit_detail_id bigint NOT NULL,
    audit_record_id bigint NOT NULL,
    table_name text,
    column_name text,
    old_value text,
    new_value text
);


ALTER TABLE audit_details OWNER TO psm;

--
-- Name: audit_records; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE audit_records (
    audit_record_id bigint NOT NULL,
    action text,
    date timestamp with time zone,
    system_id text,
    username text
);


ALTER TABLE audit_records OWNER TO psm;

--
-- Name: beneficial_owner; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE beneficial_owner (
    beneficial_owner_id bigint NOT NULL,
    person_ind character varying(1),
    ben_type_cd character varying(2),
    oth_type_desc text,
    subcontractor_name text,
    own_interest_pct double precision,
    address_id bigint,
    oth_provider_interest_ind text,
    oth_provider_name text,
    oth_provider_own_pct double precision,
    oth_provider_address_id bigint,
    middle_name text,
    first_name text,
    last_name text,
    ssn text,
    birth_dt date,
    hired_at date,
    relationship_type_code character varying(2),
    ownership_info_id bigint,
    fein character varying(20),
    legal_name text
);


ALTER TABLE beneficial_owner OWNER TO psm;

--
-- Name: beneficial_owner_types; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE beneficial_owner_types (
    code character varying(2) NOT NULL,
    description text,
    owner_type character varying(1)
);


ALTER TABLE beneficial_owner_types OWNER TO psm;

--
-- Name: binary_contents; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE binary_contents (
    binary_content_id text NOT NULL,
    content oid
);


ALTER TABLE binary_contents OWNER TO psm;

--
-- Name: booleanexpr_id_seq; Type: SEQUENCE; Schema: public; Owner: psm
--

CREATE SEQUENCE booleanexpr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE booleanexpr_id_seq OWNER TO psm;

--
-- Name: booleanexpression; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE booleanexpression (
    id bigint NOT NULL,
    expression text,
    type text,
    escalation_constraints_id bigint
);


ALTER TABLE booleanexpression OWNER TO psm;

--
-- Name: categories_of_service; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE categories_of_service (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE categories_of_service OWNER TO psm;

--
-- Name: cms_authentication; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE cms_authentication (
    username text NOT NULL,
    password text NOT NULL
);


ALTER TABLE cms_authentication OWNER TO psm;

--
-- Name: cms_user; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE cms_user (
    user_id text NOT NULL,
    username text NOT NULL,
    first_name text,
    middle_name text,
    last_name text,
    phone_number text,
    email text,
    status text,
    role_code character varying(2)
);


ALTER TABLE cms_user OWNER TO psm;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: psm
--

CREATE SEQUENCE comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comment_id_seq OWNER TO psm;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE contacts (
    contact_id bigint NOT NULL,
    phone_number text,
    fax_number text,
    email text,
    address_id bigint
);


ALTER TABLE contacts OWNER TO psm;

--
-- Name: content; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE content (
    id bigint NOT NULL,
    content oid
);


ALTER TABLE content OWNER TO psm;

--
-- Name: content_id_seq; Type: SEQUENCE; Schema: public; Owner: psm
--

CREATE SEQUENCE content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE content_id_seq OWNER TO psm;

--
-- Name: counties; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE counties (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE counties OWNER TO psm;

--
-- Name: deadline; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE deadline (
    id bigint NOT NULL,
    deadline_date timestamp with time zone,
    escalated smallint,
    deadlines_startdeadline_id bigint,
    deadlines_enddeadline_id bigint
);


ALTER TABLE deadline OWNER TO psm;

--
-- Name: deadline_id_seq; Type: SEQUENCE; Schema: public; Owner: psm
--

CREATE SEQUENCE deadline_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE deadline_id_seq OWNER TO psm;

--
-- Name: degrees; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE degrees (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE degrees OWNER TO psm;

--
-- Name: delegation_delegates; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE delegation_delegates (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE delegation_delegates OWNER TO psm;

--
-- Name: designated_contacts; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE designated_contacts (
    designated_contact_id bigint NOT NULL,
    profile_id bigint,
    ticket_id bigint,
    designated_contact_type text,
    same_as_provider character varying(1),
    hired_at date,
    person_id bigint
);


ALTER TABLE designated_contacts OWNER TO psm;

--
-- Name: documents; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE documents (
    document_id bigint NOT NULL,
    profile_id bigint,
    ticket_id bigint,
    type text,
    filename text,
    description text,
    binary_content_id text,
    created_by text,
    created_at timestamp with time zone
);


ALTER TABLE documents OWNER TO psm;

--
-- Name: email_header; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE email_header (
    id bigint NOT NULL,
    body text,
    fromaddress text,
    language text,
    replytoaddress text,
    subject text
);


ALTER TABLE email_header OWNER TO psm;

--
-- Name: emailnotifhead_id_seq; Type: SEQUENCE; Schema: public; Owner: psm
--

CREATE SEQUENCE emailnotifhead_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE emailnotifhead_id_seq OWNER TO psm;

--
-- Name: enrollment_statuses; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE enrollment_statuses (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE enrollment_statuses OWNER TO psm;

--
-- Name: enrollments; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE enrollments (
    enrollment_id bigint NOT NULL,
    enrollment_status_code character varying(2),
    request_type_code character varying(2),
    process_instance_id bigint DEFAULT 0 NOT NULL,
    profile_reference_id bigint DEFAULT 0 NOT NULL,
    reference_timestamp timestamp with time zone,
    progress_page text,
    created_by text,
    created_at timestamp with time zone,
    submitted_by text,
    submitted_at timestamp with time zone,
    changed_by text,
    changed_at timestamp with time zone,
    change_note text
);


ALTER TABLE enrollments OWNER TO psm;

--
-- Name: entities; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE entities (
    entity_id bigint NOT NULL,
    enrolled character varying(1),
    profile_id bigint NOT NULL,
    ticket_id bigint,
    name text,
    legal_name text,
    legacy_indicator character varying(1),
    legacy_id text,
    npi text,
    npi_verified character varying(1),
    npi_lookup_verified character varying(1),
    nonexclusion_verified character varying(1),
    provider_type_code character varying(2),
    provider_sub_type text,
    contact_id bigint,
    background_study_id text,
    background_clearance_date timestamp with time zone
);


ALTER TABLE entities OWNER TO psm;

--
-- Name: entity_structure_types; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE entity_structure_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE entity_structure_types OWNER TO psm;

--
-- Name: escalation; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE escalation (
    id bigint NOT NULL,
    name text,
    deadline_escalation_id bigint
);


ALTER TABLE escalation OWNER TO psm;

--
-- Name: escalation_id_seq; Type: SEQUENCE; Schema: public; Owner: psm
--

CREATE SEQUENCE escalation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE escalation_id_seq OWNER TO psm;

--
-- Name: events; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE events (
    event_id bigint NOT NULL,
    ticket_id bigint,
    npi text,
    status text,
    created_by text,
    created_at timestamp with time zone
);


ALTER TABLE events OWNER TO psm;

--
-- Name: eventtypes; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE eventtypes (
    instanceid bigint NOT NULL,
    eventtypes text
);


ALTER TABLE eventtypes OWNER TO psm;

--
-- Name: external_account_link; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE external_account_link (
    external_account_link_id bigint NOT NULL,
    user_id character varying(255),
    system_id character varying(255),
    external_user_id character varying(255)
);


ALTER TABLE external_account_link OWNER TO psm;

--
-- Name: external_account_links; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE external_account_links (
    external_account_link_id bigint NOT NULL,
    user_id text,
    system_id text,
    external_user_id text
);


ALTER TABLE external_account_links OWNER TO psm;

--
-- Name: external_profile_link; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE external_profile_link (
    external_profile_link_id bigint NOT NULL,
    profile_id bigint,
    system_id character varying(255),
    external_profile_id character varying(255)
);


ALTER TABLE external_profile_link OWNER TO psm;

--
-- Name: external_profile_links; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE external_profile_links (
    external_profile_link_id bigint NOT NULL,
    profile_id bigint,
    system_id text,
    external_profile_id text
);


ALTER TABLE external_profile_links OWNER TO psm;

--
-- Name: help_items; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE help_items (
    help_item_id bigint NOT NULL,
    title text,
    description text
);


ALTER TABLE help_items OWNER TO psm;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: psm
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO psm;

--
-- Name: i18ntext; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE i18ntext (
    id bigint NOT NULL,
    language text,
    shorttext text,
    text text,
    task_subjects_id bigint,
    task_names_id bigint,
    task_descriptions_id bigint,
    reassignment_documentation_id bigint,
    notification_subjects_id bigint,
    notification_names_id bigint,
    notification_documentation_id bigint,
    notification_descriptions_id bigint,
    deadline_documentation_id bigint
);


ALTER TABLE i18ntext OWNER TO psm;

--
-- Name: i18ntext_id_seq; Type: SEQUENCE; Schema: public; Owner: psm
--

CREATE SEQUENCE i18ntext_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE i18ntext_id_seq OWNER TO psm;

--
-- Name: issuing_boards; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE issuing_boards (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE issuing_boards OWNER TO psm;

--
-- Name: legacy_mapping; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE legacy_mapping (
    legacy_mapping_id bigint NOT NULL,
    system_nm character varying(255),
    code_type character varying(255),
    internal_code character varying(255),
    external_code character varying(255)
);


ALTER TABLE legacy_mapping OWNER TO psm;

--
-- Name: license_statuses; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE license_statuses (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE license_statuses OWNER TO psm;

--
-- Name: license_types; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE license_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE license_types OWNER TO psm;

--
-- Name: licenses; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE licenses (
    license_id bigint NOT NULL,
    profile_id bigint,
    ticket_id bigint,
    affiliate_id bigint,
    object_type text,
    license_number text,
    issued_at date,
    expires_at date,
    issuing_us_state text,
    issuing_board_code character varying(2),
    license_status_code character varying(2),
    license_type_code character varying(2),
    specialty_type_code character varying(2),
    attachment_id bigint
);


ALTER TABLE licenses OWNER TO psm;

--
-- Name: notes; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE notes (
    note_id bigint NOT NULL,
    profile_id bigint,
    ticket_id bigint,
    note_text text,
    created_by text,
    created_at timestamp with time zone
);


ALTER TABLE notes OWNER TO psm;

--
-- Name: notification; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE notification (
    id bigint NOT NULL,
    dtype text NOT NULL,
    priority integer NOT NULL,
    escalation_notifications_id bigint
);


ALTER TABLE notification OWNER TO psm;

--
-- Name: notification_bas; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE notification_bas (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE notification_bas OWNER TO psm;

--
-- Name: notification_email_header; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE notification_email_header (
    emailnotification_id bigint NOT NULL,
    emailheaders_id bigint NOT NULL,
    mapkey text NOT NULL
);


ALTER TABLE notification_email_header OWNER TO psm;

--
-- Name: notification_id_seq; Type: SEQUENCE; Schema: public; Owner: psm
--

CREATE SEQUENCE notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notification_id_seq OWNER TO psm;

--
-- Name: notification_recipients; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE notification_recipients (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE notification_recipients OWNER TO psm;

--
-- Name: organizationalentity; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE organizationalentity (
    id text NOT NULL,
    dtype text NOT NULL
);


ALTER TABLE organizationalentity OWNER TO psm;

--
-- Name: organizations; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE organizations (
    entity_id bigint NOT NULL,
    fein character varying(10),
    agency_id text,
    billing_same_as_primary character varying(1),
    reimbursement_same_as_primary character varying(1),
    ten99_same_as_primary character varying(1),
    billing_address_id bigint,
    reimbursement_address_id bigint,
    ten99_address_id bigint,
    state_tax_id text,
    fiscal_year_end text,
    remittance_sequence_order text,
    eft_vendor_number text
);


ALTER TABLE organizations OWNER TO psm;

--
-- Name: owner_assets; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE owner_assets (
    owner_asset_id bigint NOT NULL,
    name text,
    ownership_type_code character varying(2),
    address_id bigint,
    ownership_info_id bigint
);


ALTER TABLE owner_assets OWNER TO psm;

--
-- Name: ownership_info; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE ownership_info (
    ownership_info_id bigint NOT NULL,
    profile_id bigint,
    ticket_id bigint,
    entity_structure_type_code character varying(2),
    entity_structure_subtype_code character varying(2),
    other_entity_type_desc text
);


ALTER TABLE ownership_info OWNER TO psm;

--
-- Name: ownership_types; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE ownership_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE ownership_types OWNER TO psm;

--
-- Name: pay_to_provider_types; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE pay_to_provider_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE pay_to_provider_types OWNER TO psm;

--
-- Name: pay_to_providers; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE pay_to_providers (
    pay_to_providers_id bigint NOT NULL,
    effective_date date,
    pay_to_type_code character varying(2),
    profile_id bigint,
    ticket_id bigint,
    target_profile_id bigint,
    name text,
    contact_name text,
    npi text,
    phone text
);


ALTER TABLE pay_to_providers OWNER TO psm;

--
-- Name: people; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE people (
    entity_id bigint NOT NULL,
    prefix text,
    first_name text,
    middle_name text,
    last_name text,
    suffix text,
    ssn text,
    ssn_verified character varying(1),
    birth_date date,
    degree_code character varying(2),
    degree_award_date date
);


ALTER TABLE people OWNER TO psm;

--
-- Name: peopleassignments_bas; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE peopleassignments_bas (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE peopleassignments_bas OWNER TO psm;

--
-- Name: peopleassignments_exclowners; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE peopleassignments_exclowners (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE peopleassignments_exclowners OWNER TO psm;

--
-- Name: peopleassignments_potowners; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE peopleassignments_potowners (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE peopleassignments_potowners OWNER TO psm;

--
-- Name: peopleassignments_recipients; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE peopleassignments_recipients (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE peopleassignments_recipients OWNER TO psm;

--
-- Name: peopleassignments_stakeholders; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE peopleassignments_stakeholders (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE peopleassignments_stakeholders OWNER TO psm;

--
-- Name: persistent_logins; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE persistent_logins (
    series character varying(64) NOT NULL,
    username character varying(64) NOT NULL,
    token character varying(64) NOT NULL,
    last_used timestamp with time zone NOT NULL
);


ALTER TABLE persistent_logins OWNER TO psm;

--
-- Name: processinstanceinfo; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE processinstanceinfo (
    instanceid bigint NOT NULL,
    id bigint,
    lastmodificationdate timestamp with time zone,
    lastreaddate timestamp with time zone,
    processid text,
    processinstancebytearray oid,
    startdate timestamp with time zone,
    state integer NOT NULL,
    optlock integer
);


ALTER TABLE processinstanceinfo OWNER TO psm;

--
-- Name: profile_assured_ext_svcs; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE profile_assured_ext_svcs (
    profile_assured_svc_id bigint NOT NULL,
    elt character varying(255) NOT NULL
);


ALTER TABLE profile_assured_ext_svcs OWNER TO psm;

--
-- Name: profile_assured_svc_xref; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE profile_assured_svc_xref (
    profile_assured_svc_id bigint NOT NULL,
    eff_dt date,
    svc_assurance_cd character varying(255),
    profile_id bigint,
    ticket_id bigint,
    status integer
);


ALTER TABLE profile_assured_svc_xref OWNER TO psm;

--
-- Name: profile_statuses; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE profile_statuses (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE profile_statuses OWNER TO psm;

--
-- Name: provider_approved_categories_of_service; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE provider_approved_categories_of_service (
    provider_category_of_service_approval_id bigint,
    category_of_service_code character varying(2)
);


ALTER TABLE provider_approved_categories_of_service OWNER TO psm;

--
-- Name: provider_category_of_service_approvals; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE provider_category_of_service_approvals (
    provider_category_of_service_approval_id bigint NOT NULL,
    profile_id bigint,
    ticket_id bigint,
    start_date date,
    end_date date
);


ALTER TABLE provider_category_of_service_approvals OWNER TO psm;

--
-- Name: provider_cos; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE provider_cos (
    provider_cos_id bigint NOT NULL,
    provider_cos_cd character varying(255) NOT NULL
);


ALTER TABLE provider_cos OWNER TO psm;

--
-- Name: provider_cos_xref; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE provider_cos_xref (
    provider_cos_id bigint NOT NULL,
    profile_id bigint DEFAULT 0,
    ticket_id bigint DEFAULT 0,
    start_dt timestamp without time zone NOT NULL,
    end_dt timestamp without time zone
);


ALTER TABLE provider_cos_xref OWNER TO psm;

--
-- Name: provider_profiles; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE provider_profiles (
    control_no bigint NOT NULL,
    profile_id bigint DEFAULT 0 NOT NULL,
    ticket_id bigint DEFAULT 0 NOT NULL,
    effective_date date,
    profile_status_code character varying(2),
    works_on_reservation character varying(1),
    maintains_own_private_practice character varying(1),
    employed_or_contracted_by_group character varying(1),
    criminal_conviction character varying(1),
    civil_penalty character varying(1),
    previous_exclusion character varying(1),
    employee_criminal_conviction character varying(1),
    employee_civil_penalty character varying(1),
    employee_previous_exclusion character varying(1),
    adult character varying(1),
    county text,
    employed_since_clearance character varying(1),
    risk_level_code character varying(2),
    bed_count integer,
    bed_count_title_18 integer,
    bed_count_title_19 integer,
    bed_count_dual_certified integer,
    bed_count_icf integer,
    bed_count_effective_date date,
    physical_and_occupational_therapy character varying(1),
    reference_ticket_id bigint DEFAULT 0 NOT NULL,
    owner_id text,
    form_completed_by text,
    health_board character varying(1),
    created_by text,
    created_at timestamp with time zone,
    last_modified_by text,
    last_modified_at timestamp with time zone
);


ALTER TABLE provider_profiles OWNER TO psm;

--
-- Name: provider_services; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE provider_services (
    provider_service_id bigint NOT NULL,
    profile_id bigint DEFAULT 0 NOT NULL,
    ticket_id bigint DEFAULT 0 NOT NULL,
    service_category_code character varying(2)
);


ALTER TABLE provider_services OWNER TO psm;

--
-- Name: provider_statements; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE provider_statements (
    provider_statement_id bigint NOT NULL,
    profile_id bigint,
    ticket_id bigint,
    name text,
    title text,
    date date
);


ALTER TABLE provider_statements OWNER TO psm;

--
-- Name: provider_svcs; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE provider_svcs (
    provider_svcs_id bigint NOT NULL,
    profile_id bigint DEFAULT 0 NOT NULL,
    ticket_id bigint DEFAULT 0 NOT NULL,
    svc_cat_cd character varying(255)
);


ALTER TABLE provider_svcs OWNER TO psm;

--
-- Name: provider_type_agreement_documents; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE provider_type_agreement_documents (
    provider_type_code character varying(2) NOT NULL,
    agreement_document_id bigint NOT NULL
);


ALTER TABLE provider_type_agreement_documents OWNER TO psm;

--
-- Name: provider_type_license_types; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE provider_type_license_types (
    provider_type_code character varying(2) NOT NULL,
    license_type_code character varying(2) NOT NULL
);


ALTER TABLE provider_type_license_types OWNER TO psm;

--
-- Name: provider_type_settings; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE provider_type_settings (
    provider_type_setting_id integer NOT NULL,
    provider_type_code character varying(2) NOT NULL,
    related_entity_type text NOT NULL,
    related_entity_code text NOT NULL,
    relationship_type text NOT NULL
);


ALTER TABLE provider_type_settings OWNER TO psm;

--
-- Name: provider_types; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE provider_types (
    code character varying(2) NOT NULL,
    description text,
    applicant_type text DEFAULT 'INDIVIDUAL'::text NOT NULL
);


ALTER TABLE provider_types OWNER TO psm;

--
-- Name: qualified_professional_types; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE qualified_professional_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE qualified_professional_types OWNER TO psm;

--
-- Name: reassignment; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE reassignment (
    id bigint NOT NULL,
    escalation_reassignments_id bigint
);


ALTER TABLE reassignment OWNER TO psm;

--
-- Name: reassignment_id_seq; Type: SEQUENCE; Schema: public; Owner: psm
--

CREATE SEQUENCE reassignment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reassignment_id_seq OWNER TO psm;

--
-- Name: reassignment_potentialowners; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE reassignment_potentialowners (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE reassignment_potentialowners OWNER TO psm;

--
-- Name: relationship_types; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE relationship_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE relationship_types OWNER TO psm;

--
-- Name: request_types; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE request_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE request_types OWNER TO psm;

--
-- Name: required_field_types; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE required_field_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE required_field_types OWNER TO psm;

--
-- Name: required_fld; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE required_fld (
    code character varying(2) NOT NULL,
    description character varying(255),
    required_fld_type_id character varying(2)
);


ALTER TABLE required_fld OWNER TO psm;

--
-- Name: risk_levels; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE risk_levels (
    code character varying(2) NOT NULL,
    sort_index integer NOT NULL,
    description text
);


ALTER TABLE risk_levels OWNER TO psm;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE roles (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE roles OWNER TO psm;

--
-- Name: screening_schedules; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE screening_schedules (
    screening_schedule_id bigint NOT NULL,
    upcoming_screening_date date,
    interval_type text,
    interval_value bigint NOT NULL
);


ALTER TABLE screening_schedules OWNER TO psm;

--
-- Name: service_assurance_ext_types; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE service_assurance_ext_types (
    code character varying(2) NOT NULL,
    description text,
    service_assurance_code text
);


ALTER TABLE service_assurance_ext_types OWNER TO psm;

--
-- Name: service_assurance_types; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE service_assurance_types (
    code character varying(2) NOT NULL,
    description text,
    patient_indicator text
);


ALTER TABLE service_assurance_types OWNER TO psm;

--
-- Name: service_categories; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE service_categories (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE service_categories OWNER TO psm;

--
-- Name: sessioninfo; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE sessioninfo (
    id integer NOT NULL,
    lastmodificationdate timestamp with time zone,
    rulesbytearray oid,
    startdate timestamp with time zone,
    optlock integer
);


ALTER TABLE sessioninfo OWNER TO psm;

--
-- Name: sessioninfo_id_seq; Type: SEQUENCE; Schema: public; Owner: psm
--

CREATE SEQUENCE sessioninfo_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sessioninfo_id_seq OWNER TO psm;

--
-- Name: specialty_types; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE specialty_types (
    code character varying(2) NOT NULL,
    description text,
    sub_category character varying(2)
);


ALTER TABLE specialty_types OWNER TO psm;

--
-- Name: states; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE states (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE states OWNER TO psm;

--
-- Name: subtasksstrategy; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE subtasksstrategy (
    id bigint NOT NULL,
    dtype text NOT NULL,
    name text,
    task_id bigint
);


ALTER TABLE subtasksstrategy OWNER TO psm;

--
-- Name: task; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE task (
    id bigint NOT NULL,
    archived smallint,
    allowedtodelegate text,
    priority integer NOT NULL,
    activationtime timestamp with time zone,
    completedon timestamp with time zone,
    createdon timestamp with time zone,
    documentaccesstype integer,
    documentcontentid bigint NOT NULL,
    documenttype text,
    expirationtime timestamp with time zone,
    faultaccesstype integer,
    faultcontentid bigint NOT NULL,
    faultname text,
    faulttype text,
    outputaccesstype integer,
    outputcontentid bigint NOT NULL,
    outputtype text,
    parentid bigint NOT NULL,
    previousstatus integer,
    processid text,
    processinstanceid bigint NOT NULL,
    processsessionid integer NOT NULL,
    skipable boolean NOT NULL,
    status text,
    workitemid bigint NOT NULL,
    optlock integer,
    taskinitiator_id text,
    actualowner_id text,
    createdby_id text
);


ALTER TABLE task OWNER TO psm;

--
-- Name: task_comment; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE task_comment (
    id bigint NOT NULL,
    addedat timestamp with time zone,
    text text,
    addedby_id text,
    taskdata_comments_id bigint
);


ALTER TABLE task_comment OWNER TO psm;

--
-- Name: workiteminfo; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE workiteminfo (
    workitemid bigint NOT NULL,
    creationdate timestamp with time zone,
    name text,
    processinstanceid bigint NOT NULL,
    state bigint NOT NULL,
    optlock integer,
    workitembytearray oid
);


ALTER TABLE workiteminfo OWNER TO psm;

--
-- Name: workiteminfo_id_seq; Type: SEQUENCE; Schema: public; Owner: psm
--

CREATE SEQUENCE workiteminfo_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE workiteminfo_id_seq OWNER TO psm;

--
-- Name: 44753; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('44753');


ALTER LARGE OBJECT 44753 OWNER TO psm;

--
-- Name: 44754; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('44754');


ALTER LARGE OBJECT 44754 OWNER TO psm;

--
-- Name: 44755; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('44755');


ALTER LARGE OBJECT 44755 OWNER TO psm;

--
-- Name: 44756; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('44756');


ALTER LARGE OBJECT 44756 OWNER TO psm;

--
-- Name: 44757; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('44757');


ALTER LARGE OBJECT 44757 OWNER TO psm;

--
-- Name: 44758; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('44758');


ALTER LARGE OBJECT 44758 OWNER TO psm;

--
-- Name: 44759; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('44759');


ALTER LARGE OBJECT 44759 OWNER TO psm;

--
-- Name: 44760; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('44760');


ALTER LARGE OBJECT 44760 OWNER TO psm;

--
-- Name: 52440; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('52440');


ALTER LARGE OBJECT 52440 OWNER TO psm;

--
-- Name: 52441; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('52441');


ALTER LARGE OBJECT 52441 OWNER TO psm;

--
-- Name: 52442; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('52442');


ALTER LARGE OBJECT 52442 OWNER TO psm;

--
-- Name: 52443; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('52443');


ALTER LARGE OBJECT 52443 OWNER TO psm;

--
-- Name: 52444; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('52444');


ALTER LARGE OBJECT 52444 OWNER TO psm;

--
-- Name: 52445; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('52445');


ALTER LARGE OBJECT 52445 OWNER TO psm;

--
-- Name: 52446; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('52446');


ALTER LARGE OBJECT 52446 OWNER TO psm;

--
-- Name: 52447; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('52447');


ALTER LARGE OBJECT 52447 OWNER TO psm;

--
-- Name: 57987; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('57987');


ALTER LARGE OBJECT 57987 OWNER TO psm;

--
-- Name: 57988; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('57988');


ALTER LARGE OBJECT 57988 OWNER TO psm;

--
-- Name: 57989; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('57989');


ALTER LARGE OBJECT 57989 OWNER TO psm;

--
-- Name: 57990; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('57990');


ALTER LARGE OBJECT 57990 OWNER TO psm;

--
-- Name: 57991; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('57991');


ALTER LARGE OBJECT 57991 OWNER TO psm;

--
-- Name: 57992; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('57992');


ALTER LARGE OBJECT 57992 OWNER TO psm;

--
-- Name: 57993; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('57993');


ALTER LARGE OBJECT 57993 OWNER TO psm;

--
-- Name: 57994; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('57994');


ALTER LARGE OBJECT 57994 OWNER TO psm;

--
-- Name: 60211; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('60211');


ALTER LARGE OBJECT 60211 OWNER TO psm;

--
-- Name: 60212; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('60212');


ALTER LARGE OBJECT 60212 OWNER TO psm;

--
-- Name: 60213; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('60213');


ALTER LARGE OBJECT 60213 OWNER TO psm;

--
-- Name: 60214; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('60214');


ALTER LARGE OBJECT 60214 OWNER TO psm;

--
-- Name: 60215; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('60215');


ALTER LARGE OBJECT 60215 OWNER TO psm;

--
-- Name: 60216; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('60216');


ALTER LARGE OBJECT 60216 OWNER TO psm;

--
-- Name: 60217; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('60217');


ALTER LARGE OBJECT 60217 OWNER TO psm;

--
-- Name: 60218; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('60218');


ALTER LARGE OBJECT 60218 OWNER TO psm;

--
-- Name: 62436; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('62436');


ALTER LARGE OBJECT 62436 OWNER TO psm;

--
-- Name: 62437; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('62437');


ALTER LARGE OBJECT 62437 OWNER TO psm;

--
-- Name: 62438; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('62438');


ALTER LARGE OBJECT 62438 OWNER TO psm;

--
-- Name: 62439; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('62439');


ALTER LARGE OBJECT 62439 OWNER TO psm;

--
-- Name: 62440; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('62440');


ALTER LARGE OBJECT 62440 OWNER TO psm;

--
-- Name: 62441; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('62441');


ALTER LARGE OBJECT 62441 OWNER TO psm;

--
-- Name: 62442; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('62442');


ALTER LARGE OBJECT 62442 OWNER TO psm;

--
-- Name: 62443; Type: BLOB; Schema: -; Owner: psm
--

SELECT pg_catalog.lo_create('62443');


ALTER LARGE OBJECT 62443 OWNER TO psm;

--
-- Data for Name: accepted_agreements; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO addresses (address_id, attention_line, address_line_1, address_line_2, city, state, zip_code, county) VALUES (20, NULL, NULL, '123 Test ave', 'Chicago', 'IL', '60610', '04');
INSERT INTO addresses (address_id, attention_line, address_line_1, address_line_2, city, state, zip_code, county) VALUES (22, NULL, NULL, '123 Test ave', 'Chicago', 'IL', '60610', '04');
INSERT INTO addresses (address_id, attention_line, address_line_1, address_line_2, city, state, zip_code, county) VALUES (23, NULL, NULL, '123 Test ave', 'Chicago', 'IL', '60610', '04');
INSERT INTO addresses (address_id, attention_line, address_line_1, address_line_2, city, state, zip_code, county) VALUES (31, NULL, NULL, '123 Test Ave', 'Chicago', 'IL', '61801', '');
INSERT INTO addresses (address_id, attention_line, address_line_1, address_line_2, city, state, zip_code, county) VALUES (32, NULL, NULL, '123 Test Ave', 'Chicago', 'IL', '61801', '');


--
-- Data for Name: affiliations; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO affiliations (affiliation_id, is_primary, profile_id, object_type, ticket_id, effective_at, target_profile_id, target_entity_id, qualified_professional_type_code, mental_health_professional_type, acknowledgement_attachment_id, is_terminated, terminated_at, bgs_study_id, bgs_clearance_date) VALUES (29, NULL, 0, 'M', 1, '2000-01-01', 0, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: agreement_documents; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO agreement_documents (agreement_document_id, type, title, version, body, created_by, created_at) VALUES (1, '01', 'Agreement (1)', 0, 'This is the content of the agreement.', 'system', '2017-08-02 13:57:11.596877-05');
INSERT INTO agreement_documents (agreement_document_id, type, title, version, body, created_by, created_at) VALUES (2, '02', 'Addendum (2)', 0, 'This is the content of the addendum.', 'system', '2017-08-02 13:57:11.596877-05');


--
-- Data for Name: attachment; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Name: attachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: psm
--

SELECT pg_catalog.setval('attachment_id_seq', 1, false);


--
-- Data for Name: audit_details; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: audit_records; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: beneficial_owner; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO beneficial_owner (beneficial_owner_id, person_ind, ben_type_cd, oth_type_desc, subcontractor_name, own_interest_pct, address_id, oth_provider_interest_ind, oth_provider_name, oth_provider_own_pct, oth_provider_address_id, middle_name, first_name, last_name, ssn, birth_dt, hired_at, relationship_type_code, ownership_info_id, fein, legal_name) VALUES (33, 'Y', '02', '', '', 0, 31, 'Y', '12', 0, 32, 'T', 'Bob', 'Test', '121211211', '1970-01-01', '2000-01-01', NULL, 34, NULL, NULL);


--
-- Data for Name: beneficial_owner_types; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO beneficial_owner_types (code, description, owner_type) VALUES ('01', 'Subcontractor', 'A');
INSERT INTO beneficial_owner_types (code, description, owner_type) VALUES ('02', 'Managing Employee', 'P');
INSERT INTO beneficial_owner_types (code, description, owner_type) VALUES ('03', 'Owner - 5% or more of Ownership Interest', 'A');
INSERT INTO beneficial_owner_types (code, description, owner_type) VALUES ('04', 'Board Member or Officer', 'P');
INSERT INTO beneficial_owner_types (code, description, owner_type) VALUES ('05', 'Program Manager', 'P');
INSERT INTO beneficial_owner_types (code, description, owner_type) VALUES ('06', 'Managing Director', 'P');
INSERT INTO beneficial_owner_types (code, description, owner_type) VALUES ('99', 'Other', 'A');


--
-- Data for Name: binary_contents; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Name: booleanexpr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: psm
--

SELECT pg_catalog.setval('booleanexpr_id_seq', 1, false);


--
-- Data for Name: booleanexpression; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: categories_of_service; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO categories_of_service (code, description) VALUES ('01', 'AC Transportation');
INSERT INTO categories_of_service (code, description) VALUES ('02', 'Home Delivered Meals');
INSERT INTO categories_of_service (code, description) VALUES ('03', 'Adult Day Services');
INSERT INTO categories_of_service (code, description) VALUES ('04', 'Homemaker Services');
INSERT INTO categories_of_service (code, description) VALUES ('05', 'Behavioral Program Services');
INSERT INTO categories_of_service (code, description) VALUES ('06', 'In-home Family Support');
INSERT INTO categories_of_service (code, description) VALUES ('07', 'Caregiver Training');
INSERT INTO categories_of_service (code, description) VALUES ('08', 'Independent Living Skills');
INSERT INTO categories_of_service (code, description) VALUES ('09', 'Case Management Waiver/Alternative Care');
INSERT INTO categories_of_service (code, description) VALUES ('10', 'Modification and Adaptations');
INSERT INTO categories_of_service (code, description) VALUES ('11', 'Chore');
INSERT INTO categories_of_service (code, description) VALUES ('12', 'Nutritional Services');
INSERT INTO categories_of_service (code, description) VALUES ('13', 'Cognitive Therapy');
INSERT INTO categories_of_service (code, description) VALUES ('14', 'PERS and AC Supplies');
INSERT INTO categories_of_service (code, description) VALUES ('15', 'Companion Services');
INSERT INTO categories_of_service (code, description) VALUES ('16', 'Respite Care');
INSERT INTO categories_of_service (code, description) VALUES ('17', 'Consumer Directed Community Support (CDCS)');
INSERT INTO categories_of_service (code, description) VALUES ('18', 'Specialized Supplies & Equipment (Waiver)');
INSERT INTO categories_of_service (code, description) VALUES ('19', 'Spenddown Collection');
INSERT INTO categories_of_service (code, description) VALUES ('20', 'Customized Living, 24 CL, Residential Care Services, Assisted Living Services');
INSERT INTO categories_of_service (code, description) VALUES ('21', 'Structured Day Program Services');
INSERT INTO categories_of_service (code, description) VALUES ('22', 'Supported Employment Services');
INSERT INTO categories_of_service (code, description) VALUES ('23', 'Family Counseling and Training');
INSERT INTO categories_of_service (code, description) VALUES ('24', 'Supported Living Services');
INSERT INTO categories_of_service (code, description) VALUES ('25', 'Foster Care Services');
INSERT INTO categories_of_service (code, description) VALUES ('26', 'Waiver Transportation');


--
-- Data for Name: cms_authentication; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO cms_authentication (username, password) VALUES ('admin', '{SHA}0DPiKuNIrrVmD8IUCuw1hQxNqZc=');
INSERT INTO cms_authentication (username, password) VALUES ('p1', '{SHA}t49XZhHsBvlq88plTCIXKl10bEA=');
INSERT INTO cms_authentication (username, password) VALUES ('system', '{SHA}MX8edh8vqo2ngaR2K53MLFytIJo=');


--
-- Data for Name: cms_user; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO cms_user (user_id, username, first_name, middle_name, last_name, phone_number, email, status, role_code) VALUES ('p1', 'p1', 'p1', NULL, 'p1', NULL, 'p1@example.com', 'ACTIVE', 'R1');
INSERT INTO cms_user (user_id, username, first_name, middle_name, last_name, phone_number, email, status, role_code) VALUES ('ADMIN', 'admin', 'admin', NULL, 'admin', NULL, 'admin@example.com', 'ACTIVE', 'R3');
INSERT INTO cms_user (user_id, username, first_name, middle_name, last_name, phone_number, email, status, role_code) VALUES ('SYSTEM', 'system', 'system', NULL, 'system', NULL, 'system@example.com', 'ACTIVE', 'R4');


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: psm
--

SELECT pg_catalog.setval('comment_id_seq', 1, false);


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO contacts (contact_id, phone_number, fax_number, email, address_id) VALUES (21, '217 777-7777', NULL, NULL, 20);
INSERT INTO contacts (contact_id, phone_number, fax_number, email, address_id) VALUES (25, '121 121-1211', NULL, '', NULL);


--
-- Data for Name: content; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO content (id, content) VALUES (1, 62440);


--
-- Name: content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: psm
--

SELECT pg_catalog.setval('content_id_seq', 1, true);


--
-- Data for Name: counties; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO counties (code, description) VALUES ('01', 'Aitkin');
INSERT INTO counties (code, description) VALUES ('02', 'Anoka');
INSERT INTO counties (code, description) VALUES ('03', 'Becker');
INSERT INTO counties (code, description) VALUES ('04', 'Beltrami');
INSERT INTO counties (code, description) VALUES ('05', 'Benton');
INSERT INTO counties (code, description) VALUES ('06', 'Big Stone');
INSERT INTO counties (code, description) VALUES ('07', 'Blue Earth');
INSERT INTO counties (code, description) VALUES ('08', 'Brown');
INSERT INTO counties (code, description) VALUES ('09', 'Carlton');
INSERT INTO counties (code, description) VALUES ('10', 'Carver');
INSERT INTO counties (code, description) VALUES ('11', 'Cass');
INSERT INTO counties (code, description) VALUES ('12', 'Chippewa');
INSERT INTO counties (code, description) VALUES ('13', 'Chisago');
INSERT INTO counties (code, description) VALUES ('14', 'Clay');
INSERT INTO counties (code, description) VALUES ('15', 'Clearwater');
INSERT INTO counties (code, description) VALUES ('16', 'Cook');
INSERT INTO counties (code, description) VALUES ('17', 'Cottonwood');
INSERT INTO counties (code, description) VALUES ('18', 'Crow Wing');
INSERT INTO counties (code, description) VALUES ('19', 'Dakota');
INSERT INTO counties (code, description) VALUES ('20', 'Dodge');
INSERT INTO counties (code, description) VALUES ('21', 'Douglas');
INSERT INTO counties (code, description) VALUES ('22', 'Faribault');
INSERT INTO counties (code, description) VALUES ('23', 'Fillmore');
INSERT INTO counties (code, description) VALUES ('24', 'Freeborn');
INSERT INTO counties (code, description) VALUES ('25', 'Goodhue');
INSERT INTO counties (code, description) VALUES ('26', 'Grant');
INSERT INTO counties (code, description) VALUES ('27', 'Hennepin');
INSERT INTO counties (code, description) VALUES ('28', 'Houston');
INSERT INTO counties (code, description) VALUES ('29', 'Hubbard');
INSERT INTO counties (code, description) VALUES ('30', 'Isanti');
INSERT INTO counties (code, description) VALUES ('31', 'Itasca');
INSERT INTO counties (code, description) VALUES ('32', 'Jackson');
INSERT INTO counties (code, description) VALUES ('33', 'Kanabec');
INSERT INTO counties (code, description) VALUES ('34', 'Kandiyohi');
INSERT INTO counties (code, description) VALUES ('35', 'Kittson');
INSERT INTO counties (code, description) VALUES ('36', 'Koochiching');
INSERT INTO counties (code, description) VALUES ('37', 'Lac qui Parle');
INSERT INTO counties (code, description) VALUES ('38', 'Lake');
INSERT INTO counties (code, description) VALUES ('39', 'Lake of the Woods');
INSERT INTO counties (code, description) VALUES ('40', 'Le Sueur');
INSERT INTO counties (code, description) VALUES ('41', 'Lincoln');
INSERT INTO counties (code, description) VALUES ('42', 'Lyon');
INSERT INTO counties (code, description) VALUES ('43', 'Mahnomen');
INSERT INTO counties (code, description) VALUES ('44', 'Marshall');
INSERT INTO counties (code, description) VALUES ('45', 'Martin');
INSERT INTO counties (code, description) VALUES ('46', 'McLeod');
INSERT INTO counties (code, description) VALUES ('47', 'Meeker');
INSERT INTO counties (code, description) VALUES ('48', 'Mille Lacs');
INSERT INTO counties (code, description) VALUES ('49', 'Morrison');
INSERT INTO counties (code, description) VALUES ('50', 'Mower');
INSERT INTO counties (code, description) VALUES ('51', 'Murray');
INSERT INTO counties (code, description) VALUES ('52', 'Nicollet');
INSERT INTO counties (code, description) VALUES ('53', 'Nobles');
INSERT INTO counties (code, description) VALUES ('54', 'Norman');
INSERT INTO counties (code, description) VALUES ('55', 'Olmsted');
INSERT INTO counties (code, description) VALUES ('56', 'Otter Tail');
INSERT INTO counties (code, description) VALUES ('57', 'Pennington');
INSERT INTO counties (code, description) VALUES ('58', 'Pine');
INSERT INTO counties (code, description) VALUES ('59', 'Pipestone');
INSERT INTO counties (code, description) VALUES ('60', 'Polk');
INSERT INTO counties (code, description) VALUES ('61', 'Pope');
INSERT INTO counties (code, description) VALUES ('62', 'Ramsey');
INSERT INTO counties (code, description) VALUES ('63', 'Red Lake');
INSERT INTO counties (code, description) VALUES ('64', 'Redwood');
INSERT INTO counties (code, description) VALUES ('65', 'Renville');
INSERT INTO counties (code, description) VALUES ('66', 'Rice');
INSERT INTO counties (code, description) VALUES ('67', 'Rock');
INSERT INTO counties (code, description) VALUES ('68', 'Roseau');
INSERT INTO counties (code, description) VALUES ('69', 'Scott');
INSERT INTO counties (code, description) VALUES ('70', 'Sherburne');
INSERT INTO counties (code, description) VALUES ('71', 'Sibley');
INSERT INTO counties (code, description) VALUES ('72', 'St. Louis');
INSERT INTO counties (code, description) VALUES ('73', 'Stearns');
INSERT INTO counties (code, description) VALUES ('74', 'Steele');
INSERT INTO counties (code, description) VALUES ('75', 'Stevens');
INSERT INTO counties (code, description) VALUES ('76', 'Swift');
INSERT INTO counties (code, description) VALUES ('77', 'Todd');
INSERT INTO counties (code, description) VALUES ('78', 'Traverse');
INSERT INTO counties (code, description) VALUES ('79', 'Wabasha');
INSERT INTO counties (code, description) VALUES ('80', 'Wadena');
INSERT INTO counties (code, description) VALUES ('81', 'Waseca');
INSERT INTO counties (code, description) VALUES ('82', 'Washington');
INSERT INTO counties (code, description) VALUES ('83', 'Watonwan');
INSERT INTO counties (code, description) VALUES ('84', 'Wilkin');
INSERT INTO counties (code, description) VALUES ('85', 'Winona');
INSERT INTO counties (code, description) VALUES ('86', 'Wright');
INSERT INTO counties (code, description) VALUES ('87', 'Yellow');


--
-- Data for Name: deadline; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Name: deadline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: psm
--

SELECT pg_catalog.setval('deadline_id_seq', 1, false);


--
-- Data for Name: degrees; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO degrees (code, description) VALUES ('D1', 'MASTERS');
INSERT INTO degrees (code, description) VALUES ('D2', 'DOCTORATE');


--
-- Data for Name: delegation_delegates; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: designated_contacts; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO designated_contacts (designated_contact_id, profile_id, ticket_id, designated_contact_type, same_as_provider, hired_at, person_id) VALUES (27, 0, 1, 'ENROLLMENT', NULL, NULL, 26);


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: email_header; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Name: emailnotifhead_id_seq; Type: SEQUENCE SET; Schema: public; Owner: psm
--

SELECT pg_catalog.setval('emailnotifhead_id_seq', 1, false);


--
-- Data for Name: enrollment_statuses; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO enrollment_statuses (code, description) VALUES ('01', 'Draft');
INSERT INTO enrollment_statuses (code, description) VALUES ('02', 'Pending');
INSERT INTO enrollment_statuses (code, description) VALUES ('03', 'Rejected');
INSERT INTO enrollment_statuses (code, description) VALUES ('04', 'Approved');


--
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO enrollments (enrollment_id, enrollment_status_code, request_type_code, process_instance_id, profile_reference_id, reference_timestamp, progress_page, created_by, created_at, submitted_by, submitted_at, changed_by, changed_at, change_note) VALUES (1, '02', '02', 18, 0, NULL, 'Provider Statement', 'p1', '2017-08-02 14:21:42.189-05', 'p1', '2017-08-02 14:21:45.528-05', 'p1', '2017-08-02 14:21:45.528-05', NULL);


--
-- Data for Name: entities; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO entities (entity_id, enrolled, profile_id, ticket_id, name, legal_name, legacy_indicator, legacy_id, npi, npi_verified, npi_lookup_verified, nonexclusion_verified, provider_type_code, provider_sub_type, contact_id, background_study_id, background_clearance_date) VALUES (24, NULL, 0, 1, 'Test', 'Test', NULL, NULL, '1234567893', NULL, NULL, NULL, '71', NULL, 21, NULL, NULL);
INSERT INTO entities (entity_id, enrolled, profile_id, ticket_id, name, legal_name, legacy_indicator, legacy_id, npi, npi_verified, npi_lookup_verified, nonexclusion_verified, provider_type_code, provider_sub_type, contact_id, background_study_id, background_clearance_date) VALUES (26, NULL, 0, 0, 'Bob Test', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 25, NULL, NULL);
INSERT INTO entities (entity_id, enrolled, profile_id, ticket_id, name, legal_name, legacy_indicator, legacy_id, npi, npi_verified, npi_lookup_verified, nonexclusion_verified, provider_type_code, provider_sub_type, contact_id, background_study_id, background_clearance_date) VALUES (28, NULL, 0, 0, 'Bob Dentist', NULL, NULL, NULL, '1234567893', NULL, NULL, NULL, '21', NULL, NULL, NULL, NULL);


--
-- Data for Name: entity_structure_types; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO entity_structure_types (code, description) VALUES ('01', 'Sole Proprietorship');
INSERT INTO entity_structure_types (code, description) VALUES ('02', 'Partnership');
INSERT INTO entity_structure_types (code, description) VALUES ('03', 'Corporation');
INSERT INTO entity_structure_types (code, description) VALUES ('04', 'Non-Profit');
INSERT INTO entity_structure_types (code, description) VALUES ('05', 'Hospital Based');
INSERT INTO entity_structure_types (code, description) VALUES ('06', 'State');
INSERT INTO entity_structure_types (code, description) VALUES ('07', 'Public');
INSERT INTO entity_structure_types (code, description) VALUES ('08', 'Professional Association');
INSERT INTO entity_structure_types (code, description) VALUES ('99', 'Other');


--
-- Data for Name: escalation; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Name: escalation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: psm
--

SELECT pg_catalog.setval('escalation_id_seq', 1, false);


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: eventtypes; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO eventtypes (instanceid, eventtypes) VALUES (18, 'RuleFlowStateEvent-gov.medicaid.process.enrollment');


--
-- Data for Name: external_account_link; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: external_account_links; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: external_profile_link; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: external_profile_links; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: help_items; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: psm
--

SELECT pg_catalog.setval('hibernate_sequence', 35, true);


--
-- Data for Name: i18ntext; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO i18ntext (id, language, shorttext, text, task_subjects_id, task_names_id, task_descriptions_id, reassignment_documentation_id, notification_subjects_id, notification_names_id, notification_documentation_id, notification_descriptions_id, deadline_documentation_id) VALUES (2, 'en-UK', 'Screening Review', '62439', NULL, 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO i18ntext (id, language, shorttext, text, task_subjects_id, task_names_id, task_descriptions_id, reassignment_documentation_id, notification_subjects_id, notification_names_id, notification_documentation_id, notification_descriptions_id, deadline_documentation_id) VALUES (1, 'en-UK', '', '62438', 35, NULL, 35, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- Name: i18ntext_id_seq; Type: SEQUENCE SET; Schema: public; Owner: psm
--

SELECT pg_catalog.setval('i18ntext_id_seq', 2, true);


--
-- Data for Name: issuing_boards; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO issuing_boards (code, description) VALUES ('B1', 'AANA');
INSERT INTO issuing_boards (code, description) VALUES ('B2', 'NARM');
INSERT INTO issuing_boards (code, description) VALUES ('B3', 'ANCC');
INSERT INTO issuing_boards (code, description) VALUES ('B4', 'AOTA');
INSERT INTO issuing_boards (code, description) VALUES ('B5', 'ADA');
INSERT INTO issuing_boards (code, description) VALUES ('B6', 'ABMS');
INSERT INTO issuing_boards (code, description) VALUES ('B7', 'ABPS');


--
-- Data for Name: legacy_mapping; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: license_statuses; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO license_statuses (code, description) VALUES ('01', 'Active');
INSERT INTO license_statuses (code, description) VALUES ('02', 'Suspended');
INSERT INTO license_statuses (code, description) VALUES ('03', 'Expired');


--
-- Data for Name: license_types; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO license_types (code, description) VALUES ('A0', 'Background Study');
INSERT INTO license_types (code, description) VALUES ('A1', 'Head Start Agency Certification');
INSERT INTO license_types (code, description) VALUES ('A2', 'Class A Professional Home Care License');
INSERT INTO license_types (code, description) VALUES ('A3', 'HCFA Medicare Certification');
INSERT INTO license_types (code, description) VALUES ('A4', 'Housing with Services');
INSERT INTO license_types (code, description) VALUES ('A5', 'Off-site Approval Letter From Medicare');
INSERT INTO license_types (code, description) VALUES ('A6', 'Verification of IHS status');
INSERT INTO license_types (code, description) VALUES ('A7', 'County Contract to Provider IRTS');
INSERT INTO license_types (code, description) VALUES ('A8', 'Rule 36 Licensed Facility');
INSERT INTO license_types (code, description) VALUES ('A9', 'Class A License');
INSERT INTO license_types (code, description) VALUES ('AA', 'Pharmacy License');
INSERT INTO license_types (code, description) VALUES ('AB', 'Class A License For Private Duty Nursing Services');
INSERT INTO license_types (code, description) VALUES ('AC', 'Medicare Certification For Home Health Aide And Skilled Nursing Services');
INSERT INTO license_types (code, description) VALUES ('AD', 'Regional Treatment Center Certification');
INSERT INTO license_types (code, description) VALUES ('AE', 'Medicare Approval Letter');
INSERT INTO license_types (code, description) VALUES ('AF', 'Comprehensive Outpatient Rehabilitation Facility Certification');
INSERT INTO license_types (code, description) VALUES ('AG', 'Independent or Portable X-ray Certification from CMS');
INSERT INTO license_types (code, description) VALUES ('AH', 'FDA Certification - Mammography services');
INSERT INTO license_types (code, description) VALUES ('AI', 'PCA 1 or 3 day Steps for Success Training');
INSERT INTO license_types (code, description) VALUES ('AJ', 'Medicare Certification');
INSERT INTO license_types (code, description) VALUES ('AK', 'Rule 5 License issued from MN Department of Human Services');
INSERT INTO license_types (code, description) VALUES ('AL', 'Certificate of Compliance from MN Department of Human Rights');
INSERT INTO license_types (code, description) VALUES ('AM', 'Rule 29 License');
INSERT INTO license_types (code, description) VALUES ('AN', 'Day Training & Habilitation License');
INSERT INTO license_types (code, description) VALUES ('AO', 'License and Transmittal (CMS 1539 Form) from MN Department of Health');
INSERT INTO license_types (code, description) VALUES ('AP', 'Approval by Kent Dufresne to enroll new facility');
INSERT INTO license_types (code, description) VALUES ('AQ', 'Hospice license from the MN Dept of Health');
INSERT INTO license_types (code, description) VALUES ('AR', 'CMS Medicare Certification Letter');
INSERT INTO license_types (code, description) VALUES ('AS', 'Ambulance Services - Basic Service');
INSERT INTO license_types (code, description) VALUES ('AT', 'Ambulance Services - Advanced Life Support');
INSERT INTO license_types (code, description) VALUES ('AU', 'Ambulance Services - Air Transport with FAA Air Worthiness Certificate');
INSERT INTO license_types (code, description) VALUES ('AV', 'State License to operate as a Hospital');
INSERT INTO license_types (code, description) VALUES ('AW', 'CMS PECOS Website Verification');
INSERT INTO license_types (code, description) VALUES ('AX', 'CLIA Certificate if billing Lab Services');
INSERT INTO license_types (code, description) VALUES ('AZ', 'Renal Dialysis Facility Approval letter from regional CMS office');
INSERT INTO license_types (code, description) VALUES ('B0', 'Hospital Based Clinic Designation:  approval letter from CMS');
INSERT INTO license_types (code, description) VALUES ('B1', 'Adult Day Care License');
INSERT INTO license_types (code, description) VALUES ('B2', '245B License');
INSERT INTO license_types (code, description) VALUES ('CA', 'Adult Rehabilitative Mental Health Services');
INSERT INTO license_types (code, description) VALUES ('CB', 'Children''s Therapeutic Services and Supports (CTSS)');
INSERT INTO license_types (code, description) VALUES ('CC', 'Adult Crisis Response Services - Crisis Assessment & Crisis Intervention');
INSERT INTO license_types (code, description) VALUES ('CD', 'Adult Crisis Response Services - Crisis Stabilization');
INSERT INTO license_types (code, description) VALUES ('CE', 'Adult Crisis Response Services - Short-Term Residential');
INSERT INTO license_types (code, description) VALUES ('H1', 'Rehab Counselor Certification');
INSERT INTO license_types (code, description) VALUES ('H2', 'Psychosocial Rehab Practitioner Certification');
INSERT INTO license_types (code, description) VALUES ('H3', 'Licensed Practical Nurse');
INSERT INTO license_types (code, description) VALUES ('L0', 'Marriage And Family Therapist');
INSERT INTO license_types (code, description) VALUES ('L1', 'Audiologist License');
INSERT INTO license_types (code, description) VALUES ('L2', 'Registration with the Department Of Health');
INSERT INTO license_types (code, description) VALUES ('L3', 'Optometrist');
INSERT INTO license_types (code, description) VALUES ('L4', 'Registered Nurse');
INSERT INTO license_types (code, description) VALUES ('L5', 'PCA Training Certificate');
INSERT INTO license_types (code, description) VALUES ('L6', 'Traditional Midwife');
INSERT INTO license_types (code, description) VALUES ('L7', 'MnSCU Certification');
INSERT INTO license_types (code, description) VALUES ('L8', 'Chiropractic Examiner');
INSERT INTO license_types (code, description) VALUES ('L9', 'License To Practice Podiatric Medicine');
INSERT INTO license_types (code, description) VALUES ('M0', 'Hearing Aid Dispenser');
INSERT INTO license_types (code, description) VALUES ('M1', 'Professional Clinical Counselor');
INSERT INTO license_types (code, description) VALUES ('M2', 'Occupational Therapy');
INSERT INTO license_types (code, description) VALUES ('M3', 'Physician Assistant');
INSERT INTO license_types (code, description) VALUES ('M4', 'Physical Therapist');
INSERT INTO license_types (code, description) VALUES ('M5', 'Speech Language Pathologist');
INSERT INTO license_types (code, description) VALUES ('M6', 'Acupuncturist');
INSERT INTO license_types (code, description) VALUES ('M7', 'Dental Hygienist');
INSERT INTO license_types (code, description) VALUES ('M8', 'Mental Health Rehab Professional');
INSERT INTO license_types (code, description) VALUES ('M9', 'Dental');
INSERT INTO license_types (code, description) VALUES ('N1', 'Dietician or Nutritionist');
INSERT INTO license_types (code, description) VALUES ('N2', 'Clinical Social Worker');
INSERT INTO license_types (code, description) VALUES ('N3', 'Pharmacist License');
INSERT INTO license_types (code, description) VALUES ('N4', 'Psychologist');
INSERT INTO license_types (code, description) VALUES ('N5', 'Physician');


--
-- Data for Name: licenses; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: notification_bas; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: notification_email_header; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Name: notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: psm
--

SELECT pg_catalog.setval('notification_id_seq', 1, false);


--
-- Data for Name: notification_recipients; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: organizationalentity; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO organizationalentity (id, dtype) VALUES ('Administrator', 'User');
INSERT INTO organizationalentity (id, dtype) VALUES ('Service Administrator', 'Group');
INSERT INTO organizationalentity (id, dtype) VALUES ('Service Agent', 'Group');
INSERT INTO organizationalentity (id, dtype) VALUES ('System Administrator', 'Group');


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO organizations (entity_id, fein, agency_id, billing_same_as_primary, reimbursement_same_as_primary, ten99_same_as_primary, billing_address_id, reimbursement_address_id, ten99_address_id, state_tax_id, fiscal_year_end, remittance_sequence_order, eft_vendor_number) VALUES (24, '12-1212111', NULL, 'Y', NULL, 'Y', 22, NULL, 23, '', NULL, 'PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER', NULL);


--
-- Data for Name: owner_assets; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: ownership_info; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO ownership_info (ownership_info_id, profile_id, ticket_id, entity_structure_type_code, entity_structure_subtype_code, other_entity_type_desc) VALUES (34, 0, 1, '01', NULL, NULL);


--
-- Data for Name: ownership_types; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: pay_to_provider_types; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO pay_to_provider_types (code, description) VALUES ('01', 'Claim');
INSERT INTO pay_to_provider_types (code, description) VALUES ('02', 'ERA');
INSERT INTO pay_to_provider_types (code, description) VALUES ('03', 'Both');


--
-- Data for Name: pay_to_providers; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO people (entity_id, prefix, first_name, middle_name, last_name, suffix, ssn, ssn_verified, birth_date, degree_code, degree_award_date) VALUES (26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO people (entity_id, prefix, first_name, middle_name, last_name, suffix, ssn, ssn_verified, birth_date, degree_code, degree_award_date) VALUES (28, NULL, NULL, NULL, NULL, NULL, '121212121', NULL, '1970-01-01', NULL, NULL);


--
-- Data for Name: peopleassignments_bas; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO peopleassignments_bas (task_id, entity_id) VALUES (35, 'Administrator');


--
-- Data for Name: peopleassignments_exclowners; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: peopleassignments_potowners; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO peopleassignments_potowners (task_id, entity_id) VALUES (35, 'Service Administrator');
INSERT INTO peopleassignments_potowners (task_id, entity_id) VALUES (35, 'Service Agent');


--
-- Data for Name: peopleassignments_recipients; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: peopleassignments_stakeholders; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: persistent_logins; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: processinstanceinfo; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO processinstanceinfo (instanceid, id, lastmodificationdate, lastreaddate, processid, processinstancebytearray, startdate, state, optlock) VALUES (18, 18, '2017-08-02 14:21:49.798-05', '2017-08-02 14:21:45.987-05', 'gov.medicaid.process.enrollment', 62441, '2017-08-02 14:21:45.981-05', 1, 1);


--
-- Data for Name: profile_assured_ext_svcs; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: profile_assured_svc_xref; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: profile_statuses; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO profile_statuses (code, description) VALUES ('01', 'Active');
INSERT INTO profile_statuses (code, description) VALUES ('02', 'Suspended');
INSERT INTO profile_statuses (code, description) VALUES ('03', 'Expired');


--
-- Data for Name: provider_approved_categories_of_service; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: provider_category_of_service_approvals; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: provider_cos; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: provider_cos_xref; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: provider_profiles; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO provider_profiles (control_no, profile_id, ticket_id, effective_date, profile_status_code, works_on_reservation, maintains_own_private_practice, employed_or_contracted_by_group, criminal_conviction, civil_penalty, previous_exclusion, employee_criminal_conviction, employee_civil_penalty, employee_previous_exclusion, adult, county, employed_since_clearance, risk_level_code, bed_count, bed_count_title_18, bed_count_title_19, bed_count_dual_certified, bed_count_icf, bed_count_effective_date, physical_and_occupational_therapy, reference_ticket_id, owner_id, form_completed_by, health_board, created_by, created_at, last_modified_by, last_modified_at) VALUES (19, 0, 1, '2017-01-01', NULL, NULL, NULL, NULL, 'N', 'N', 'N', 'N', 'N', 'N', NULL, NULL, NULL, '01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: provider_services; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: provider_statements; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO provider_statements (provider_statement_id, profile_id, ticket_id, name, title, date) VALUES (30, 0, 1, 'Bob Test', 'Presidente', '2017-08-02');


--
-- Data for Name: provider_svcs; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: provider_type_agreement_documents; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO provider_type_agreement_documents (provider_type_code, agreement_document_id) VALUES ('18', 1);


--
-- Data for Name: provider_type_license_types; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('01', 'L1');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('01', 'L2');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('02', 'L3');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('03', 'L4');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('04', 'L5');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('05', 'L6');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('06', 'L7');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('07', 'L4');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('08', 'L8');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('09', 'L9');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('10', 'L0');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('11', 'M1');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('12', 'L4');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('13', 'M2');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('14', 'M3');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('15', 'H3');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('15', 'A9');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('15', 'L4');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('16', 'M4');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('17', 'M5');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('18', 'M6');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('19', 'M7');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('20', 'H1');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('20', 'H2');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('20', 'M8');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('21', 'M9');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('22', 'M0');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('23', 'N1');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('24', 'N2');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('25', 'L4');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('26', 'N3');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('27', 'N4');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('28', 'N5');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('34', 'A1');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('35', 'A2');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('35', 'A3');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('35', 'A4');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('36', 'A5');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('38', 'A6');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('39', 'A7');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('39', 'A8');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('41', 'A0');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('41', 'A9');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('42', 'AA');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('43', 'AB');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('45', 'AB');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('45', 'AC');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('46', 'AD');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('47', 'AE');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('47', 'AF');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('48', 'AE');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('51', 'AG');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('51', 'AH');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('52', 'AJ');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('55', 'AK');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('55', 'AL');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('57', 'AM');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('59', 'AN');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('59', 'B1');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('59', 'B2');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'A0');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'A1');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'A2');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'A3');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'A4');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'A5');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'A6');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'A7');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'A8');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'A9');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'AA');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'AB');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'AC');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'AD');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'AE');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'AF');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'AG');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'AH');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'AI');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'AJ');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'AK');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'AL');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('61', 'AM');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('65', 'AO');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('65', 'AP');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('66', 'AQ');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('66', 'AR');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('67', 'AR');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('67', 'AV');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('67', 'AW');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('67', 'AX');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('68', 'AO');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('68', 'AZ');
INSERT INTO provider_type_license_types (provider_type_code, license_type_code) VALUES ('69', 'AO');


--
-- Data for Name: provider_type_settings; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (103, '01', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (202, '02', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (302, '03', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (303, '03', 'SpecialtyType', 'S1', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (304, '03', 'IssuingBoard', 'B1', 'SB');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (402, '04', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (502, '05', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (503, '05', 'SpecialtyType', 'S2', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (504, '05', 'IssuingBoard', 'B2', 'SB');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (602, '06', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (702, '07', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (703, '07', 'SpecialtyType', 'S3', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (704, '07', 'IssuingBoard', 'B3', 'SB');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (705, '07', 'SpecialtyType', 'C1', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (706, '07', 'SpecialtyType', 'C2', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (707, '07', 'SpecialtyType', 'C3', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (708, '07', 'SpecialtyType', 'C4', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (709, '07', 'SpecialtyType', 'C5', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (802, '08', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (902, '09', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1002, '10', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1102, '11', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1202, '12', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1203, '12', 'SpecialtyType', 'S3', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1204, '12', 'IssuingBoard', 'B3', 'SB');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1302, '13', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1303, '13', 'SpecialtyType', 'S3', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1304, '13', 'SpecialtyType', 'S4', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1305, '13', 'SpecialtyType', 'S5', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1306, '13', 'SpecialtyType', 'S6', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1307, '13', 'IssuingBoard', 'B4', 'SB');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1402, '14', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1502, '15', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1602, '16', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1702, '17', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1802, '18', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (1902, '19', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2002, '20', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2102, '21', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2103, '21', 'SpecialtyType', 'D1', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2104, '21', 'SpecialtyType', 'D2', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2105, '21', 'SpecialtyType', 'D3', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2106, '21', 'SpecialtyType', 'D4', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2107, '21', 'SpecialtyType', 'D5', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2108, '21', 'SpecialtyType', 'D6', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2109, '21', 'IssuingBoard', 'B5', 'SB');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2110, '21', 'IssuingBoard', 'C1', 'SB');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2202, '22', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2302, '23', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2402, '24', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2403, '24', 'SpecialtyType', 'S3', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2404, '24', 'IssuingBoard', 'B3', 'SB');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2502, '25', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2503, '25', 'SpecialtyType', 'S9', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2504, '25', 'IssuingBoard', 'B8', 'SB');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2602, '26', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2702, '27', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2703, '27', 'SpecialtyType', 'P1', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2802, '28', 'StateType', 'MN', 'LS');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2803, '28', 'IssuingBoard', 'B6', 'SB');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2804, '28', 'IssuingBoard', 'B7', 'SB');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2805, '28', 'SpecialtyType', '01', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2806, '28', 'SpecialtyType', '02', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2807, '28', 'SpecialtyType', '03', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2808, '28', 'SpecialtyType', '04', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2809, '28', 'SpecialtyType', '05', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2810, '28', 'SpecialtyType', '06', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2811, '28', 'SpecialtyType', '07', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2812, '28', 'SpecialtyType', '08', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2813, '28', 'SpecialtyType', '09', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2814, '28', 'SpecialtyType', '10', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2815, '28', 'SpecialtyType', '11', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2816, '28', 'SpecialtyType', '12', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2817, '28', 'SpecialtyType', '13', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2818, '28', 'SpecialtyType', '14', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2819, '28', 'SpecialtyType', '15', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2820, '28', 'SpecialtyType', '16', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2821, '28', 'SpecialtyType', '17', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2822, '28', 'SpecialtyType', '18', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2823, '28', 'SpecialtyType', '19', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2824, '28', 'SpecialtyType', '20', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2825, '28', 'SpecialtyType', '21', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2826, '28', 'SpecialtyType', '22', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2827, '28', 'SpecialtyType', '23', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2828, '28', 'SpecialtyType', '24', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2829, '28', 'SpecialtyType', '25', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2830, '28', 'SpecialtyType', '26', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2831, '28', 'SpecialtyType', '27', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2832, '28', 'SpecialtyType', '28', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2833, '28', 'SpecialtyType', '29', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2834, '28', 'SpecialtyType', '30', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2835, '28', 'SpecialtyType', '31', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2836, '28', 'SpecialtyType', '32', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2837, '28', 'SpecialtyType', '33', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2838, '28', 'SpecialtyType', '34', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2839, '28', 'SpecialtyType', '35', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2840, '28', 'SpecialtyType', '36', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2841, '28', 'SpecialtyType', '37', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2842, '28', 'SpecialtyType', '38', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2843, '28', 'SpecialtyType', '39', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2844, '28', 'SpecialtyType', '49', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (2845, '28', 'SpecialtyType', '50', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9901, '04', 'BeneficialOwnerType', '04', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9902, '04', 'BeneficialOwnerType', '02', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9903, '04', 'BeneficialOwnerType', '01', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9904, '01', 'BeneficialOwnerType', '03', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9905, '01', 'BeneficialOwnerType', '02', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9906, '01', 'BeneficialOwnerType', '01', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9907, '05', 'BeneficialOwnerType', '04', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9908, '05', 'BeneficialOwnerType', '03', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9909, '05', 'BeneficialOwnerType', '02', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9910, '05', 'BeneficialOwnerType', '01', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9911, '03', 'BeneficialOwnerType', '03', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9912, '03', 'BeneficialOwnerType', '02', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9913, '03', 'BeneficialOwnerType', '01', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9914, '02', 'BeneficialOwnerType', '03', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9915, '02', 'BeneficialOwnerType', '02', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9916, '02', 'BeneficialOwnerType', '01', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9917, '06', 'BeneficialOwnerType', '02', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9918, '06', 'BeneficialOwnerType', '01', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9919, '07', 'BeneficialOwnerType', '01', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9920, '07', 'BeneficialOwnerType', '05', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (9921, '07', 'BeneficialOwnerType', '06', 'BT');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (14001, '12', 'SpecialtyType', '41', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (14002, '12', 'SpecialtyType', '42', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (14003, '12', 'SpecialtyType', '43', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (14004, '12', 'SpecialtyType', '44', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (14005, '12', 'SpecialtyType', '45', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (14006, '12', 'SpecialtyType', '46', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (14007, '12', 'SpecialtyType', '47', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (14008, '12', 'SpecialtyType', '48', 'SO');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (100001, '41', 'LicenseType', 'L4', 'QL');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (100002, '41', 'LicenseType', 'N2', 'QL');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (100003, '41', 'LicenseType', 'M2', 'QL');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (100004, '41', 'LicenseType', 'M4', 'QL');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (100006, '41', 'LicenseType', 'H1', 'QL');
INSERT INTO provider_type_settings (provider_type_setting_id, provider_type_code, related_entity_type, related_entity_code, relationship_type) VALUES (100007, '41', 'LicenseType', 'H2', 'QL');


--
-- Data for Name: provider_types; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO provider_types (code, description, applicant_type) VALUES ('01', 'Audiologist', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('02', 'Optometrist', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('03', 'Certified Registered Nurse Anesthetist', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('04', 'Personal Care Assistant', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('05', 'Certified Professional Midwife', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('06', 'Community Health Care Worker', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('07', 'Clinical Nurse Specialist', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('08', 'Chiropractor', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('09', 'Podiatrist', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('10', 'Licensed Marriage and Family Therapist', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('11', 'Licensed Professional Clinical Counselor', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('12', 'Nurse Practitioner', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('13', 'Occupational Therapist', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('14', 'Physician Assistant', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('15', 'Private Duty Nurse', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('16', 'Physical Therapist', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('17', 'Speech Language Pathologist', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('18', 'Acupuncturist', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('19', 'Allied Dental Professional', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('20', 'Certified Mental Health Rehab Prof - CPRP', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('21', 'Dentist', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('22', 'Hearing Aid Dispenser', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('23', 'Licensed Dietician or Licensed Nutritionist', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('24', 'Licensed Independent Clinical Social Worker', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('25', 'Nurse Midwife', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('26', 'Pharmacist', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('27', 'Licensed Psychologist', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('28', 'Physician', 'INDIVIDUAL');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('29', 'Billing Entity for Physical Rehabilitative Providers', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('30', 'Clearing House', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('31', 'Durable Medical Equipment', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('32', 'EDI Trading Partner', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('33', 'Family Planning Agency', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('34', 'Head Start', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('35', 'Home Health Agency', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('36', 'Independent Diagnostic Testing Facility', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('37', 'Independent Laboratory', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('38', 'Indian Health Service Facility', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('39', 'Intensive Residential Treatment Facility', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('40', 'Optical Supplier', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('41', 'Personal Care Provider Organization', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('42', 'Pharmacy', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('43', 'Private Duty Nursing Agency', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('44', 'Public Health Clinic', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('45', 'Public Health Nursing Organization', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('46', 'Regional Treatment Center', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('47', 'Rehabilitation Agency', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('48', 'Rural Health Clinic', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('49', 'Targeted Case Management', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('50', 'WIC Program', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('51', 'X-Ray Services', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('52', 'Ambulatory Surgical Center', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('53', 'Certified Registered Nurse Anesthetist Group', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('54', 'Child And Teen Checkup Clinic', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('55', 'Childrens Mental Health Residential Treatment Facility', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('56', 'Community Health Clinic', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('57', 'Community Mental Health Center', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('58', 'County Contracted Mental Health Rehab', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('59', 'Day Training And Habilitation/Day Activity Center', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('60', 'Day Treatment', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('61', 'Home And Community Based Services (Waivered Services)', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('62', 'Billing Intermediary', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('63', 'Federally Qualified Health Center', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('64', 'Individual Education Plan', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('65', 'Nursing Facility', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('66', 'Hospice', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('67', 'Hospital', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('68', 'Renal Dialysis Facility', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('69', 'Intermediate Care Facilities For Persons With Developmental Disabilities', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('70', 'Physician Clinic', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('71', 'Dental Clinic', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('72', 'Dental Hygienist Clinic', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('73', 'Podiatry Clinic', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('74', 'Billing Entity For Mental Health', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('75', 'Chiropractic Clinic', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('76', 'Birthing Center', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('77', 'Medical Transportation', 'ORGANIZATION');
INSERT INTO provider_types (code, description, applicant_type) VALUES ('78', 'Billing Entity for Physician Services', 'ORGANIZATION');


--
-- Data for Name: qualified_professional_types; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO qualified_professional_types (code, description) VALUES ('01', 'Registered Nurse');
INSERT INTO qualified_professional_types (code, description) VALUES ('02', 'Licensed Social Worker');
INSERT INTO qualified_professional_types (code, description) VALUES ('03', 'Mental Health Professional');
INSERT INTO qualified_professional_types (code, description) VALUES ('04', 'Qualified Developmental Disability Specialist');


--
-- Data for Name: reassignment; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Name: reassignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: psm
--

SELECT pg_catalog.setval('reassignment_id_seq', 1, false);


--
-- Data for Name: reassignment_potentialowners; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: relationship_types; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO relationship_types (code, description) VALUES ('01', 'Spouse');
INSERT INTO relationship_types (code, description) VALUES ('02', 'Child');
INSERT INTO relationship_types (code, description) VALUES ('03', 'Parent');
INSERT INTO relationship_types (code, description) VALUES ('04', 'Sibling');


--
-- Data for Name: request_types; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO request_types (code, description) VALUES ('01', 'Import Profile');
INSERT INTO request_types (code, description) VALUES ('02', 'Enrollment');
INSERT INTO request_types (code, description) VALUES ('03', 'Renewal');
INSERT INTO request_types (code, description) VALUES ('04', 'Suspend');
INSERT INTO request_types (code, description) VALUES ('05', 'Update');


--
-- Data for Name: required_field_types; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO required_field_types (code, description) VALUES ('01', 'Required');
INSERT INTO required_field_types (code, description) VALUES ('02', 'Optional');


--
-- Data for Name: required_fld; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: risk_levels; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO risk_levels (code, sort_index, description) VALUES ('01', 1, 'Limited');
INSERT INTO risk_levels (code, sort_index, description) VALUES ('02', 2, 'Moderate');
INSERT INTO risk_levels (code, sort_index, description) VALUES ('03', 3, 'High');


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO roles (code, description) VALUES ('R1', 'Provider');
INSERT INTO roles (code, description) VALUES ('R2', 'Service Agent');
INSERT INTO roles (code, description) VALUES ('R3', 'Service Administrator');
INSERT INTO roles (code, description) VALUES ('R4', 'System Administrator');


--
-- Data for Name: screening_schedules; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO screening_schedules (screening_schedule_id, upcoming_screening_date, interval_type, interval_value) VALUES (1, NULL, NULL, 0);


--
-- Data for Name: service_assurance_ext_types; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: service_assurance_types; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: service_categories; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO service_categories (code, description) VALUES ('01', 'AC Transportation');
INSERT INTO service_categories (code, description) VALUES ('02', 'Home Delivered Meals');
INSERT INTO service_categories (code, description) VALUES ('03', 'Adult Day Services');
INSERT INTO service_categories (code, description) VALUES ('04', 'Homemaker Services');
INSERT INTO service_categories (code, description) VALUES ('05', 'Behavioral Program Services');
INSERT INTO service_categories (code, description) VALUES ('06', 'In-home Family Support');
INSERT INTO service_categories (code, description) VALUES ('07', 'Caregiver Training');
INSERT INTO service_categories (code, description) VALUES ('08', 'Independent Living Skills');
INSERT INTO service_categories (code, description) VALUES ('09', 'Case Management Waiver/Alternative Care');
INSERT INTO service_categories (code, description) VALUES ('10', 'Modification and Adaptations');
INSERT INTO service_categories (code, description) VALUES ('11', 'Chore');
INSERT INTO service_categories (code, description) VALUES ('12', 'Nutritional Services');
INSERT INTO service_categories (code, description) VALUES ('13', 'Cognitive Therapy');
INSERT INTO service_categories (code, description) VALUES ('14', 'PERS and AC Supplies');
INSERT INTO service_categories (code, description) VALUES ('15', 'Companion Services');
INSERT INTO service_categories (code, description) VALUES ('16', 'Respite Care');
INSERT INTO service_categories (code, description) VALUES ('17', 'Consumer Directed Community Support (CDCS)');
INSERT INTO service_categories (code, description) VALUES ('18', 'Specialized Supplies & Equipment (Waiver)');
INSERT INTO service_categories (code, description) VALUES ('19', 'Spenddown Collection');
INSERT INTO service_categories (code, description) VALUES ('20', 'Customized Living, 24 CL, Residential Care Services, Assisted Living Services');
INSERT INTO service_categories (code, description) VALUES ('21', 'Structured Day Program Services');
INSERT INTO service_categories (code, description) VALUES ('22', 'Supported Employment Services');
INSERT INTO service_categories (code, description) VALUES ('23', 'Family Counseling and Training');
INSERT INTO service_categories (code, description) VALUES ('24', 'Supported Living Services');
INSERT INTO service_categories (code, description) VALUES ('25', 'Foster Care Services');
INSERT INTO service_categories (code, description) VALUES ('26', 'Waiver Transportation');


--
-- Data for Name: sessioninfo; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO sessioninfo (id, lastmodificationdate, rulesbytearray, startdate, optlock) VALUES (1, '2017-08-02 14:21:49.452-05', 62437, '2017-08-02 14:21:45.559-05', 1);


--
-- Name: sessioninfo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: psm
--

SELECT pg_catalog.setval('sessioninfo_id_seq', 51, true);


--
-- Data for Name: specialty_types; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO specialty_types (code, description, sub_category) VALUES ('01', 'Allergy', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('02', 'Anesthesiology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('03', 'Cardiovascular Disease', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('04', 'Cardiovascular Surgery', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('05', 'Child Psychiatry', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('06', 'Colon and Rectal Surgery', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('07', 'Dermatology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('08', 'Diabetes', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('09', 'Emergency Services', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('10', 'Endocrinology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('11', 'Family Practice', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('12', 'Gastroenterology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('13', 'General Practice', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('14', 'General Surgery', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('15', 'Gynecology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('16', 'Immunology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('17', 'Infectious Disease', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('18', 'Internal Medicine', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('19', 'Nephrology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('20', 'Neurological Surgery', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('21', 'Neurology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('22', 'Nuclear Medicine', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('23', 'Obstetrics', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('24', 'Obstetrics and Gynecology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('25', 'Oncology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('26', 'Ophthalmology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('27', 'Pathology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('28', 'Peripheral Vascular Diseases or Surgery', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('29', 'Physical Medicine and Rehabilitation', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('30', 'Plastic Surgery', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('31', 'Preventive Medicine', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('32', 'Psychiatry', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('33', 'Pulmonary Disease', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('34', 'Radiology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('35', 'Radiology and Radiation Therapy', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('36', 'Rheumatology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('37', 'Thoracic Surgery', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('38', 'Urology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('39', 'Other', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('41', 'Gerontological', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('42', 'Pediatric', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('43', 'Family', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('44', 'Adult', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('45', 'OB/GYN', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('46', 'Neonatal', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('47', 'Women''s Health Care', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('48', 'Acute Care', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('49', 'Gerontology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('50', 'Pediatrics', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('C1', 'Adult CNS', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('C2', 'Diabetes Management CNS', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('C3', 'Gerontological CNS', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('C4', 'Home Health CNS', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('C5', 'Pediatric CNS', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('D1', 'General Dentistry', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('D2', 'Endodontist', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('D3', 'Oral Surgery', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('D4', 'Orthodontics', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('D5', 'Pedodontics', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('D6', 'Periodontics', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('P1', 'Neuropsychology', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('S1', 'CRNA Certification', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('S2', 'Certified Professional Midwife', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('S3', 'Psychiatric/Mental Health', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('S6', 'Physical Rehabilitation', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('S9', 'Certified Nurse Midwife', NULL);
INSERT INTO specialty_types (code, description, sub_category) VALUES ('FL', 'Fond Du Lac Indian Reservation', 'TC');
INSERT INTO specialty_types (code, description, sub_category) VALUES ('GP', 'Grand Portage Indian Reservation', 'TC');
INSERT INTO specialty_types (code, description, sub_category) VALUES ('LL', 'Leech Lake Indian Reservation', 'TC');
INSERT INTO specialty_types (code, description, sub_category) VALUES ('LS', 'Lower Sioux Indian Reservation', 'TC');
INSERT INTO specialty_types (code, description, sub_category) VALUES ('ML', 'Mille Lacs Indian Reservation', 'TC');
INSERT INTO specialty_types (code, description, sub_category) VALUES ('NL', 'Net Lake Indian Reservation', 'TC');
INSERT INTO specialty_types (code, description, sub_category) VALUES ('PI', 'Prairie Island Indian Reservation', 'TC');
INSERT INTO specialty_types (code, description, sub_category) VALUES ('RL', 'Red Lake Reservation', 'TC');
INSERT INTO specialty_types (code, description, sub_category) VALUES ('US', 'Upper Sioux Indian Reservation', 'TC');
INSERT INTO specialty_types (code, description, sub_category) VALUES ('WE', 'White Earth Indian Reservation', 'TC');


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO states (code, description) VALUES ('AK', 'Alaska');
INSERT INTO states (code, description) VALUES ('AL', 'Alabama');
INSERT INTO states (code, description) VALUES ('AR', 'Arkansas');
INSERT INTO states (code, description) VALUES ('AZ', 'Arizona');
INSERT INTO states (code, description) VALUES ('CA', 'California');
INSERT INTO states (code, description) VALUES ('CO', 'Colorado');
INSERT INTO states (code, description) VALUES ('CT', 'Connecticut');
INSERT INTO states (code, description) VALUES ('DC', 'District of Columbia');
INSERT INTO states (code, description) VALUES ('DE', 'Delaware');
INSERT INTO states (code, description) VALUES ('FL', 'Florida');
INSERT INTO states (code, description) VALUES ('GA', 'Georgia');
INSERT INTO states (code, description) VALUES ('HI', 'Hawaii');
INSERT INTO states (code, description) VALUES ('IA', 'Iowa');
INSERT INTO states (code, description) VALUES ('ID', 'Idaho');
INSERT INTO states (code, description) VALUES ('IL', 'Illinois');
INSERT INTO states (code, description) VALUES ('IN', 'Indiana');
INSERT INTO states (code, description) VALUES ('KS', 'Kansas');
INSERT INTO states (code, description) VALUES ('KY', 'Kentucky');
INSERT INTO states (code, description) VALUES ('LA', 'Louisiana');
INSERT INTO states (code, description) VALUES ('MA', 'Massachusetts');
INSERT INTO states (code, description) VALUES ('MD', 'Maryland');
INSERT INTO states (code, description) VALUES ('ME', 'Maine');
INSERT INTO states (code, description) VALUES ('MI', 'Michigan');
INSERT INTO states (code, description) VALUES ('MN', 'Minnesota');
INSERT INTO states (code, description) VALUES ('MO', 'Missouri');
INSERT INTO states (code, description) VALUES ('MS', 'Mississippi');
INSERT INTO states (code, description) VALUES ('MT', 'Montana');
INSERT INTO states (code, description) VALUES ('NC', 'North Carolina');
INSERT INTO states (code, description) VALUES ('ND', 'North Dakota');
INSERT INTO states (code, description) VALUES ('NE', 'Nebraska');
INSERT INTO states (code, description) VALUES ('NH', 'New Hampshire');
INSERT INTO states (code, description) VALUES ('NJ', 'New Jersey');
INSERT INTO states (code, description) VALUES ('NM', 'New Mexico');
INSERT INTO states (code, description) VALUES ('NV', 'Nevada');
INSERT INTO states (code, description) VALUES ('NY', 'New York');
INSERT INTO states (code, description) VALUES ('OH', 'Ohio');
INSERT INTO states (code, description) VALUES ('OK', 'Oklahoma');
INSERT INTO states (code, description) VALUES ('OR', 'Oregon');
INSERT INTO states (code, description) VALUES ('PA', 'Pennsylvania');
INSERT INTO states (code, description) VALUES ('RI', 'Rhode Island');
INSERT INTO states (code, description) VALUES ('SC', 'South Carolina');
INSERT INTO states (code, description) VALUES ('SD', 'South Dakota');
INSERT INTO states (code, description) VALUES ('TN', 'Tennessee');
INSERT INTO states (code, description) VALUES ('TX', 'Texas');
INSERT INTO states (code, description) VALUES ('UT', 'Utah');
INSERT INTO states (code, description) VALUES ('VA', 'Virginia');
INSERT INTO states (code, description) VALUES ('VT', 'Vermont');
INSERT INTO states (code, description) VALUES ('WA', 'Washington');
INSERT INTO states (code, description) VALUES ('WI', 'Wisconsin');
INSERT INTO states (code, description) VALUES ('WV', 'West Virginia');
INSERT INTO states (code, description) VALUES ('WY', 'Wyoming');


--
-- Data for Name: subtasksstrategy; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO task (id, archived, allowedtodelegate, priority, activationtime, completedon, createdon, documentaccesstype, documentcontentid, documenttype, expirationtime, faultaccesstype, faultcontentid, faultname, faulttype, outputaccesstype, outputcontentid, outputtype, parentid, previousstatus, processid, processinstanceid, processsessionid, skipable, status, workitemid, optlock, taskinitiator_id, actualowner_id, createdby_id) VALUES (35, 0, NULL, 0, '2017-08-02 14:21:49.306-05', NULL, '2017-08-02 14:21:49.306-05', 0, 1, 'java.util.map', NULL, NULL, -1, NULL, NULL, NULL, -1, NULL, -1, 0, 'gov.medicaid.process.enrollment', 18, 1, false, 'Ready', 11, 1, NULL, NULL, 'Administrator');


--
-- Data for Name: task_comment; Type: TABLE DATA; Schema: public; Owner: psm
--



--
-- Data for Name: workiteminfo; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO workiteminfo (workitemid, creationdate, name, processinstanceid, state, optlock, workitembytearray) VALUES (11, '2017-08-02 14:21:49.013-05', 'Human Task', 18, 0, 1, 62442);
INSERT INTO workiteminfo (workitemid, creationdate, name, processinstanceid, state, optlock, workitembytearray) VALUES (12, '2017-08-02 14:21:49.315-05', 'Auto Disqualification', 18, 0, 1, 62443);


--
-- Name: workiteminfo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: psm
--

SELECT pg_catalog.setval('workiteminfo_id_seq', 51, true);


--
-- Data for Name: BLOBS; Type: BLOBS; Schema: -; Owner: 
--

SET search_path = pg_catalog;

BEGIN;

SELECT pg_catalog.lo_open('44753', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005774d0a060805100418005243080010001a3918002000320608011000180042121a080a044d41494e100022060a044d41494e52090a0744454641554c545a0c0a0a0805320608001000180122026800');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('44754', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057a000004000a060805100418004aca64080012436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567791a8064aced0005737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742f053c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573737a000004002220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f623c2f4e616d653e3c50686f6e654e756d6265723e323132203232322d323232323c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30372d32302d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30372d32302d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e54657374204c4c433c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203731312d313232313c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e313233204e204368757263682053743c2f416464726573734c696e65323e3c436974793e4368616d706169676e3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830333c2f5a6970436f64653e3c436f756e74793e30333c2f437a000004006f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e313231323132313c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f626f623c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30372d32302d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f623c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669647a000004006572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e506172746e6572736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e3c2f4d6964646c654e616d653e3c4c6173744e616d653e466f6f3c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e31323320532e204368757263683c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c52656c6174696f6e736869703e53706f7573653c2f52656c6174696f6e736869703e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e37383c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e747a000004006572657374416464726573733e3c416464726573734c696e65323e313132204e2053746174653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e4d413c2f53746174653e3c5a6970436f64653e4368696361676f3c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e4e3c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e537562636f6e74726163746f723c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e537562626f323c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c456e74697479496e666f726d6174696f6e3e3c4c6567616c4e616d653e53756262626f3c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3131322053746174653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e49413c2f53746174653e3c5a6970436f64653e3630363031303c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231313231323c2f4645494e3e3c2f456e74697479496e666f726d6174696f6e3e3c4f74686572496e7465726573744e616d653e3c2f4f74686572496e7465726573744e616d653e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747a000004007573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30372d32305431363a32343a34302e3031322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d7a000004006573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657a000004007373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e32303c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a33392e3739382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a33392e3830302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3031322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3131312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f636573737a00000400457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3131342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34302e3230352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3230352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3230372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657a000004007373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3339312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657a000004007373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f627a000004006a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3432392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3432392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d657a000002b13e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3737302d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34342e3033322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e7878525a080010001a5018012001320608011000180042271a080a044d41494e100022060a044d41494e2a130a0d44524f4f4c535f53595354454d1000180152190a0744454641554c54120e08021001180140004a040000000022026800');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('44755', 131072);
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('44756', 131072);
SELECT pg_catalog.lowrite(0, '\x53637265656e696e6720526576696577');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('44757', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000677080000000800000005740007436f6d6d656e7474001174686973206973206120636f6d6d656e7474000c50726f636573734d6f64656c7372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742b333c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f623c2f4e616d653e3c50686f6e654e756d6265723e323132203232322d323232323c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30372d32302d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30372d32302d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e54657374204c4c433c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203731312d313232313c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e313233204e204368757263682053743c2f416464726573734c696e65323e3c436974793e4368616d706169676e3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830333c2f5a6970436f64653e3c436f756e74793e30333c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e313231323132313c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f626f623c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30372d32302d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f623c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e506172746e6572736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e3c2f4d6964646c654e616d653e3c4c6173744e616d653e466f6f3c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e31323320532e204368757263683c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c52656c6174696f6e736869703e53706f7573653c2f52656c6174696f6e736869703e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e37383c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e313132204e2053746174653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e4d413c2f53746174653e3c5a6970436f64653e4368696361676f3c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e4e3c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e537562636f6e74726163746f723c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e537562626f323c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c456e74697479496e666f726d6174696f6e3e3c4c6567616c4e616d653e53756262626f3c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3131322053746174653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e49413c2f53746174653e3c5a6970436f64653e3630363031303c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231313231323c2f4645494e3e3c2f456e74697479496e666f726d6174696f6e3e3c4f74686572496e7465726573744e616d653e3c2f4f74686572496e7465726573744e616d653e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30372d32305431363a32343a34302e3031322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e32303c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a33392e3739382d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a33392e3830302d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3031322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3131312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3131342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34302e3230352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3230352d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3230372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3339312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339312d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3432392d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3432392d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3737302d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e787400074163746f7249647400007400085461736b4e616d6574001053637265656e696e672052657669657774000747726f75704964740024536572766963652041646d696e6973747261746f722c2053657276696365204167656e7478');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('44758', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057a00000400000852756c65466c6f770a060805100418004aca64080012436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567791a8064aced0005737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742f053c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d7a00000400656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f623c2f4e616d653e3c50686f6e654e756d6265723e323132203232322d323232323c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30372d32302d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30372d32302d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e54657374204c4c433c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203731312d313232313c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e313233204e204368757263682053743c2f416464726573734c696e65323e3c436974793e4368616d706169676e3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830333c2f5a6970436f64653e3c436f7a00000400756e74793e30333c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e313231323132313c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f626f623c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30372d32302d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f623c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f664269727a0000040074683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e506172746e6572736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e3c2f4d6964646c654e616d653e3c4c6173744e616d653e466f6f3c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e31323320532e204368757263683c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c52656c6174696f6e736869703e53706f7573653c2f52656c6174696f6e736869703e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e37383c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869707a000004003e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e313132204e2053746174653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e4d413c2f53746174653e3c5a6970436f64653e4368696361676f3c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e4e3c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e537562636f6e74726163746f723c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e537562626f323c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c456e74697479496e666f726d6174696f6e3e3c4c6567616c4e616d653e53756262626f3c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3131322053746174653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e49413c2f53746174653e3c5a6970436f64653e3630363031303c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231313231323c2f4645494e3e3c2f456e74697479496e666f726d6174696f6e3e3c4f74686572496e7465726573744e616d653e3c2f4f74686572496e7465726573744e616d653e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f7a000004006c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30372d32305431363a32343a34302e3031322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e303030307a00000400323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c7a000004002f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e32303c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a33392e3739382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a33392e3830302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3031322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3131312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e7a0000040073323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3131342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34302e3230352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3230352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3230372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e7a000004003c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3339312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e7a000004003c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e7a0000040031303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3432392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3432392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a507a000002bf726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3737302d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34342e3033322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e7878525e0a0852756c65466c6f7710141a1f676f762e6d656469636169642e70726f636573732e656e726f6c6c6d656e74200128113a0c080f1003220608011a02080b3a0c08101030220608022202080c420f0a056d6f64656c10001a0400000000');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('44759', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057776000000000000000b0000000000000014000a48756d616e205461736b00000000000000050007436f6d6d656e74fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c766572537472617465677974001174686973206973206120636f6d6d656e747757000c50726f636573734d6f64656cfffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567797372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742f053c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f623c2f4e616d653e3c50686f6e654e756d6265723e323132203232322d323232323c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30372d32302d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30372d32302d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e54657374204c4c433c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203731312d313232313c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e313233204e204368757263682053743c2f416464726573734c696e65323e3c436974793e4368616d706169676e3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830333c2f5a6970436f64653e3c436f756e74793e30333c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e313231323132313c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f626f623c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30372d32302d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f623c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e506172746e6572736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e3c2f4d6964646c654e616d653e3c4c6173744e616d653e466f6f3c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e31323320532e204368757263683c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c52656c6174696f6e736869703e53706f7573653c2f52656c6174696f6e736869703e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e37383c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e313132204e2053746174653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e4d413c2f53746174653e3c5a6970436f64653e4368696361676f3c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e4e3c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e537562636f6e74726163746f723c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e537562626f323c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c456e74697479496e666f726d6174696f6e3e3c4c6567616c4e616d653e53756262626f3c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3131322053746174653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e49413c2f53746174653e3c5a6970436f64653e3630363031303c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231313231323c2f4645494e3e3c2f456e74697479496e666f726d6174696f6e3e3c4f74686572496e7465726573744e616d653e3c2f4f74686572496e7465726573744e616d653e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30372d32305431363a32343a34302e3031322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e32303c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a33392e3739382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a33392e3830302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3031322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3131312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3131342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34302e3230352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3230352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3230372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3339312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3432392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3432392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3737302d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34342e3033322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e78775200074163746f724964fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c7665725374726174656779740000775300085461736b4e616d65fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c766572537472617465677974001053637265656e696e67205265766965777752000747726f75704964fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c7665725374726174656779740024536572766963652041646d696e6973747261746f722c2053657276696365204167656e74');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('44760', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005777f000000000000000c000000000000001400154175746f204469737175616c696669636174696f6e000000000000000100056d6f64656cfffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567797372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742f053c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f623c2f4e616d653e3c50686f6e654e756d6265723e323132203232322d323232323c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30372d32302d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30372d32302d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e54657374204c4c433c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203731312d313232313c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e313233204e204368757263682053743c2f416464726573734c696e65323e3c436974793e4368616d706169676e3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830333c2f5a6970436f64653e3c436f756e74793e30333c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e313231323132313c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f626f623c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30372d32302d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f623c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e506172746e6572736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e3c2f4d6964646c654e616d653e3c4c6173744e616d653e466f6f3c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e31323320532e204368757263683c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c52656c6174696f6e736869703e53706f7573653c2f52656c6174696f6e736869703e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e37383c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e313132204e2053746174653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e4d413c2f53746174653e3c5a6970436f64653e4368696361676f3c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e4e3c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e537562636f6e74726163746f723c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e537562626f323c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c456e74697479496e666f726d6174696f6e3e3c4c6567616c4e616d653e53756262626f3c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3131322053746174653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e49413c2f53746174653e3c5a6970436f64653e3630363031303c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231313231323c2f4645494e3e3c2f456e74697479496e666f726d6174696f6e3e3c4f74686572496e7465726573744e616d653e3c2f4f74686572496e7465726573744e616d653e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30372d32305431363a32343a34302e3031322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e32303c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a33392e3739382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a33392e3830302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3031322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3131312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3131342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34302e3230352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3230352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34302e3230372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34312e3835302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3035302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3339312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3339322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34322e3536382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3432392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3432392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3736392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30372d32305431363a32343a34342e3137302d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34332e3737302d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30372d32305431363a32343a34342e3033322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e78');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('52440', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005774d0a060805100418005243080010001a3918002000320608011000180042121a080a044d41494e100022060a044d41494e52090a0744454641554c545a0c0a0a0805320608001000180122026800');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('52441', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057a000004000a060805100418004a9560080012436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567791acb5faced0005737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742cd03c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573737a000004002220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f623c2f4e616d653e3c50686f6e654e756d6265723e313231203132312d313231323c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e313233204e20546573743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464727a000004006573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e313131313131313c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f6220546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3433333333333333333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f766964657254797a0000040070653e436869726f70726163746f723c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3433333333333333333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e313233342054657374204c6e3c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c52656c6174696f6e736869703e4368696c643c2f52656c6174696f6e736869703e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e54657374436f3c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e31302e303c2f4f74686572496e74657265737450657263656e744f776e65727a00000400736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e3132332054657374204c6e3c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431303a34303a34322e3338322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73327a000004003a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d7a00000400656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3038342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3038362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657a000004007373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3338332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3731362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3731392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34332e3131322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3131322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573737a000004004e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3131342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3137312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3137302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573737a000004004e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3137312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679207a0000040053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34362e3333362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3333342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3333362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3639392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a53747a0000040061727454696d653e323031372d30382d30325431303a34303a34362e3639392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3836342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f63657373777c41756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e7878525a080010001a5018012001320608011000180042271a080a044d41494e100022060a044d41494e2a130a0d44524f4f4c535f53595354454d1000180152190a0744454641554c54120e08021001180140004a040000000022026800');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('52442', 131072);
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('52443', 131072);
SELECT pg_catalog.lowrite(0, '\x53637265656e696e6720526576696577');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('52444', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000677080000000800000005740007436f6d6d656e7474001174686973206973206120636f6d6d656e7474000c50726f636573734d6f64656c7372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b78707428fe3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f623c2f4e616d653e3c50686f6e654e756d6265723e313231203132312d313231323c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e313233204e20546573743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e313131313131313c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f6220546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3433333333333333333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e436869726f70726163746f723c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3433333333333333333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e313233342054657374204c6e3c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c52656c6174696f6e736869703e4368696c643c2f52656c6174696f6e736869703e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e54657374436f3c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e31302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e3132332054657374204c6e3c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431303a34303a34322e3338322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3038342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3038362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3338332d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3731362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34362e3333362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3731392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34332e3131322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3131322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3131342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3137312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3137302d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3137312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34362e3333362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3333342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3333362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3639392d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3639392d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e787400074163746f7249647400007400085461736b4e616d6574001053637265656e696e672052657669657774000747726f75704964740024536572766963652041646d696e6973747261746f722c2053657276696365204167656e7478');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('52445', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057a00000400000852756c65466c6f770a060805100418004a9560080012436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567791acb5faced0005737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742cd03c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d7a00000400656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f623c2f4e616d653e3c50686f6e654e756d6265723e313231203132312d313231323c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e313233204e20546573743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e30343c2f436f757a000004006e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e313131313131313c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f6220546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3433333333333333333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c7a0000040050726f7669646572547970653e436869726f70726163746f723c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3433333333333333333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e313233342054657374204c6e3c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c52656c6174696f6e736869703e4368696c643c2f52656c6174696f6e736869703e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e54657374436f3c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e31302e303c2f4f74686572496e74657265737450657a000004007263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e3132332054657374204c6e3c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431303a34303a34322e3338322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d7a000004006174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f527a00000400656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3038342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3038362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e7a000004003c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3338332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3731362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3731392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34332e3131322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3131322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e7a0000040073323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3131342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3137312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3137302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e7a0000040073323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3137312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e617a000004006d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34362e3333362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3333342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3333362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3639392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e617a000004006d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3639392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3836342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e778a73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e7878525e0a0852756c65466c6f7710121a1f676f762e6d656469636169642e70726f636573732e656e726f6c6c6d656e74200128113a0c080f1003220608011a02080b3a0c08101030220608022202080c420f0a056d6f64656c10001a0400000000');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('52446', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057776000000000000000b0000000000000012000a48756d616e205461736b00000000000000050007436f6d6d656e74fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c766572537472617465677974001174686973206973206120636f6d6d656e747757000c50726f636573734d6f64656cfffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567797372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742cd03c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f623c2f4e616d653e3c50686f6e654e756d6265723e313231203132312d313231323c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e313233204e20546573743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e313131313131313c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f6220546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3433333333333333333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e436869726f70726163746f723c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3433333333333333333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e313233342054657374204c6e3c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c52656c6174696f6e736869703e4368696c643c2f52656c6174696f6e736869703e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e54657374436f3c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e31302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e3132332054657374204c6e3c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431303a34303a34322e3338322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3038342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3038362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3338332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3731362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3731392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34332e3131322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3131322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3131342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3137312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3137302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3137312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34362e3333362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3333342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3333362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3639392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3639392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3836342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e78775200074163746f724964fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c7665725374726174656779740000775300085461736b4e616d65fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c766572537472617465677974001053637265656e696e67205265766965777752000747726f75704964fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c7665725374726174656779740024536572766963652041646d696e6973747261746f722c2053657276696365204167656e74');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('52447', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005777f000000000000000c000000000000001200154175746f204469737175616c696669636174696f6e000000000000000100056d6f64656cfffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567797372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742cd03c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f623c2f4e616d653e3c50686f6e654e756d6265723e313231203132312d313231323c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e313233204e20546573743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e313131313131313c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f6220546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3433333333333333333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e436869726f70726163746f723c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3433333333333333333c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e313233342054657374204c6e3c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c52656c6174696f6e736869703e4368696c643c2f52656c6174696f6e736869703e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e54657374436f3c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e31302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e3132332054657374204c6e3c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431303a34303a34322e3338322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3038342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3038362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3338332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3731362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34322e3731392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34332e3131322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3131322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3131342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34332e3936312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3137312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3137302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3137312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34342e3633362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34362e3333362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3333342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3333362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3639392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34362e3639392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431303a34303a34382e3032322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3338362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431303a34303a34372e3836342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e78');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('57987', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005774d0a060805100418005243080010001a3918002000320608011000180042121a080a044d41494e100022060a044d41494e52090a0744454641554c545a0c0a0a0805320608001000180122026800');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('57988', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057a000004000a060805100418004aec5f080012436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567791aa25faced0005737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742ca73c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573737a000004002220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e323134203333332d333333333c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e31313220546573742053743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e7a000004003c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d333435363738393c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f622054657273743c2f4e616d653e3c5469746c653e507265736564656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f62207468652044656e746973743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3332333233323333323c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7a000004007669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323131313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e39303c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e7a0000040065323e546573742053743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e557262616e613c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a33343a34382e3130352d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431313a33343a34352e3930322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a33343a34382e3130352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c53747a00000400617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e7a000004003c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3435372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3436302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a656374497a00000400643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3930332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3034312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3034332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3136372d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3136372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c7a000004002f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3136382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3730322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3730322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3730332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3838372d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3838372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c7a000004002f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3838382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d7a0000040030382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3638352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3638352d30353a30303c2f6e737a00000400323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3437372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e7878525a080010001a50187753012001320608011000180042271a080a044d41494e100022060a044d41494e2a130a0d44524f4f4c535f53595354454d1000180152190a0744454641554c54120e08021001180140004a040000000022026800');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('57989', 131072);
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('57990', 131072);
SELECT pg_catalog.lowrite(0, '\x53637265656e696e6720526576696577');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('57991', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000677080000000800000005740007436f6d6d656e7474001174686973206973206120636f6d6d656e7474000c50726f636573734d6f64656c7372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b78707428d53c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e323134203333332d333333333c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e31313220546573742053743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d333435363738393c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f622054657273743c2f4e616d653e3c5469746c653e507265736564656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f62207468652044656e746973743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3332333233323333323c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323131313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e39303c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e546573742053743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e557262616e613c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a33343a34382e3130352d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431313a33343a34352e3930322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a33343a34382e3130352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3435372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3436302d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3930332d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3034312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3034332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3136372d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3136372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3136382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3730322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3730322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3730332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3838372d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3838372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3838382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3638352d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3638352d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e787400074163746f7249647400007400085461736b4e616d6574001053637265656e696e672052657669657774000747726f75704964740024536572766963652041646d696e6973747261746f722c2053657276696365204167656e7478');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('57992', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057a00000400000852756c65466c6f770a060805100418004aec5f080012436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567791aa25faced0005737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742ca73c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d7a00000400656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e323134203333332d333333333c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e31313220546573742053743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e307a00000400343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d333435363738393c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f622054657273743c2f4e616d653e3c5469746c653e507265736564656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f62207468652044656e746973743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3332333233323333323c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f667a0000040042697274683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323131313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e39303c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c7a00000400416464726573734c696e65323e546573742053743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e557262616e613c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a33343a34382e3130352d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431313a33343a34352e3930322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a33343a34382e3130352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e7a00000400526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f53746174757a00000400734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3435372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3436302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e7a0000040073323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3930332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3034312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3034332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3136372d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3136372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c697a00000400737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3136382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3730322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3730322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3730332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3838372d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3838372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c697a00000400737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3838382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a53746172747a0000040054696d653e323031372d30382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3638352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3638357a000004002d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3437372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e78776178525e0a0852756c65466c6f7710121a1f676f762e6d656469636169642e70726f636573732e656e726f6c6c6d656e74200128113a0c080f1003220608011a02080b3a0c08101030220608022202080c420f0a056d6f64656c10001a0400000000');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('57993', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057776000000000000000b0000000000000012000a48756d616e205461736b00000000000000050007436f6d6d656e74fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c766572537472617465677974001174686973206973206120636f6d6d656e747757000c50726f636573734d6f64656cfffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567797372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742ca73c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e323134203333332d333333333c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e31313220546573742053743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d333435363738393c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f622054657273743c2f4e616d653e3c5469746c653e507265736564656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f62207468652044656e746973743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3332333233323333323c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323131313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e39303c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e546573742053743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e557262616e613c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a33343a34382e3130352d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431313a33343a34352e3930322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a33343a34382e3130352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3435372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3436302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3930332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3034312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3034332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3136372d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3136372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3136382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3730322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3730322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3730332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3838372d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3838372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3838382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3638352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3638352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3437372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e78775200074163746f724964fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c7665725374726174656779740000775300085461736b4e616d65fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c766572537472617465677974001053637265656e696e67205265766965777752000747726f75704964fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c7665725374726174656779740024536572766963652041646d696e6973747261746f722c2053657276696365204167656e74');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('57994', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005777f000000000000000c000000000000001200154175746f204469737175616c696669636174696f6e000000000000000100056d6f64656cfffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567797372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742ca73c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e323134203333332d333333333c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e31313220546573742053743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d333435363738393c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f622054657273743c2f4e616d653e3c5469746c653e507265736564656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f62207468652044656e746973743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3332333233323333323c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323131313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e39303c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e546573742053743c2f416464726573734c696e65323e3c436974793e557262616e613c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e557262616e613c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a33343a34382e3130352d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431313a33343a34352e3930322d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a33343a34382e3130352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3435372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3436302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34352e3930332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3034312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3034332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3136372d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3136372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3136382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3730322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3730322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3730332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34362e3838372d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3838372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34362e3838382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3237362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3435392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3638352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34372e3638352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a33343a34382e3637322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3130372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a33343a34382e3437372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e78');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('60211', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005774d0a060805100418005243080010001a3918002000320608011000180042121a080a044d41494e100022060a044d41494e52090a0744454641554c545a0c0a0a0805320608001000180122026800');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('60212', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057a000004000a060805100418004add5f080012436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567791a935faced0005737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742c983c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573737a000004002220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e323132203132312d313132313c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203131312d313131313c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e31323320546573742041763c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e30333c2f436f756e74797a000004003e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e4448535f5452414e53414354494f4e5f434f4e54524f4c5f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f6220546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3233323332333233323c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e44656e7469737a00000400743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231313231313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3233332054657374204c6e3c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e31323c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e31323320546573743c2f4164647a00000400726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e434f3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431313a35383a32362e3436362d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f647a00000400653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a7a000004004175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32352e3830362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32352e3831312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e7a00000400616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3436372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3737362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3737382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32372e3034382d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32372e3034382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d7a00000400653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32372e3035302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d7a00000400653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3636332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e7a000004003636332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3038342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3038342d30353a30303c2f6e73323a537461727454696d653e3c6e737a00000400323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33312e3030372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e7878525a080010001a5018012001320608011000180042271a0877440a044d41494e100022060a044d41494e2a130a0d44524f4f4c535f53595354454d1000180152190a0744454641554c54120e08021001180140004a040000000022026800');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('60213', 131072);
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('60214', 131072);
SELECT pg_catalog.lowrite(0, '\x53637265656e696e6720526576696577');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('60215', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000677080000000800000005740007436f6d6d656e7474001174686973206973206120636f6d6d656e7474000c50726f636573734d6f64656c7372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b78707428c63c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e323132203132312d313132313c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203131312d313131313c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e31323320546573742041763c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e30333c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e4448535f5452414e53414354494f4e5f434f4e54524f4c5f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f6220546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3233323332333233323c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231313231313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3233332054657374204c6e3c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e31323c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e31323320546573743c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e434f3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431313a35383a32362e3436362d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32352e3830362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32352e3831312d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3436372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3737362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3737382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32372e3034382d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32372e3034382d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32372e3035302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3636332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636332d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3038342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3038342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e787400074163746f7249647400007400085461736b4e616d6574001053637265656e696e672052657669657774000747726f75704964740024536572766963652041646d696e6973747261746f722c2053657276696365204167656e7478');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('60216', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057a00000400000852756c65466c6f770a060805100418004add5f080012436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567791a935faced0005737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742c983c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d7a00000400656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e323132203132312d313132313c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203131312d313131313c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e31323320546573742041763c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e7a0000040030333c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e4448535f5452414e53414354494f4e5f434f4e54524f4c5f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f6220546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3233323332333233323c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547a000004007970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231313231313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3233332054657374204c6e3c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e31323c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e3132337a0000040020546573743c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e434f3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431313a35383a32362e3436362d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e7a000004003c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617a000004007475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32352e3830362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32352e3831312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e737a00000400323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3436372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3737362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3737382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32372e3034382d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32372e3034382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a7a0000040050726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32372e3035302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a7a0000040050726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3636332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30327a000004005431313a35383a32392e3636332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3038342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3038342d30353a30303c2f6e73323a5374617a00000400727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33312e3030372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e7878525e0a0852756c65466c6f77101277521a1f676f762e6d656469636169642e70726f636573732e656e726f6c6c6d656e74200128113a0c080f1003220608011a02080b3a0c08101030220608022202080c420f0a056d6f64656c10001a0400000000');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('60217', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057776000000000000000b0000000000000012000a48756d616e205461736b00000000000000050007436f6d6d656e74fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c766572537472617465677974001174686973206973206120636f6d6d656e747757000c50726f636573734d6f64656cfffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567797372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742c983c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e323132203132312d313132313c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203131312d313131313c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e31323320546573742041763c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e30333c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e4448535f5452414e53414354494f4e5f434f4e54524f4c5f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f6220546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3233323332333233323c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231313231313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3233332054657374204c6e3c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e31323c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e31323320546573743c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e434f3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431313a35383a32362e3436362d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32352e3830362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32352e3831312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3436372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3737362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3737382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32372e3034382d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32372e3034382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32372e3035302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3636332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3038342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3038342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33312e3030372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e78775200074163746f724964fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c7665725374726174656779740000775300085461736b4e616d65fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c766572537472617465677974001053637265656e696e67205265766965777752000747726f75704964fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c7665725374726174656779740024536572766963652041646d696e6973747261746f722c2053657276696365204167656e74');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('60218', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005777f000000000000000c000000000000001200154175746f204469737175616c696669636174696f6e000000000000000100056d6f64656cfffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567797372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742c983c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e323132203132312d313132313c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203131312d313131313c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e31323320546573742041763c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e30333c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323132313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e4448535f5452414e53414354494f4e5f434f4e54524f4c5f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f6220546573743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3233323332333233323c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231313231313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3233332054657374204c6e3c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e31323c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e31323320546573743c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e434f3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431313a35383a32362e3436362d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32352e3830362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32352e3831312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3436372d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3737362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32362e3737382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32372e3034382d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32372e3034382d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32372e3035302d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3137322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32382e3434342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3636332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3636332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a32392e3932362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3038342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3038342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431313a35383a33312e3137332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33302e3536342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431313a35383a33312e3030372d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e78');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('62436', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005774d0a060805100418005243080010001a3918002000320608011000180042121a080a044d41494e100022060a044d41494e52090a0744454641554c545a0c0a0a0805320608001000180122026800');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('62437', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057a000004000a060805100418004aeb5f080012436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567791aa15faced0005737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742ca63c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573737a000004002220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e313231203132312d313231313c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e3132332054657374206176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e747a00000400793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323131313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f622044656e746973743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669647a000004006572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231313231313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e31323c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65327a000004003e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431343a32313a34362e3432352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e7a000004003c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d65737361677a0000040065733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3030322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449647a000004003e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3432362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3830342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3830362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34372e3134332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3134332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f7a000004006e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3134352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f7a000004006e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d307a00000400382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3634342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3634342d30353a30303c2f6e73327a000004003a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3331352d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e7878525a080010001a50180177522001320608011000180042271a080a044d41494e100022060a044d41494e2a130a0d44524f4f4c535f53595354454d1000180152190a0744454641554c54120e08021001180140004a040000000022026800');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('62438', 131072);
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('62439', 131072);
SELECT pg_catalog.lowrite(0, '\x53637265656e696e6720526576696577');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('62440', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000677080000000800000005740007436f6d6d656e7474001174686973206973206120636f6d6d656e7474000c50726f636573734d6f64656c7372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b78707428d43c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e313231203132312d313231313c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e3132332054657374206176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323131313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f622044656e746973743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231313231313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e31323c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431343a32313a34362e3432352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3030322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3432362d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3830342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3830362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34372e3134332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3134332d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3134352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3634342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3634342d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e787400074163746f7249647400007400085461736b4e616d6574001053637265656e696e672052657669657774000747726f75704964740024536572766963652041646d696e6973747261746f722c2053657276696365204167656e7478');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('62441', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057a00000400000852756c65466c6f770a060805100418004aeb5f080012436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567791aa15faced0005737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742ca63c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d7a00000400656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e313231203132312d313231313c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e3132332054657374206176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74797a000004003e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323131313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f622044656e746973743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f664269727a0000040074683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231313231313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e31323c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c41647a0000040064726573734c696e65323e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431343a32313a34362e3432352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c696461747a00000400696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f53747a00000400617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3030322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e737a00000400323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3432362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3830342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3830362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34372e3134332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3134332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737a000004007420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3134352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737a000004007420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a5374617274547a00000400696d653e323031372d30382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3634342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3634342d7a0000040030353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3331352d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e78787760525e0a0852756c65466c6f7710121a1f676f762e6d656469636169642e70726f636573732e656e726f6c6c6d656e74200128113a0c080f1003220608011a02080b3a0c08101030220608022202080c420f0a056d6f64656c10001a0400000000');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('62442', 131072);
SELECT pg_catalog.lowrite(0, '\xaced00057776000000000000000b0000000000000012000a48756d616e205461736b00000000000000050007436f6d6d656e74fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c766572537472617465677974001174686973206973206120636f6d6d656e747757000c50726f636573734d6f64656cfffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567797372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742ca63c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e313231203132312d313231313c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e3132332054657374206176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323131313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f622044656e746973743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231313231313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e31323c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431343a32313a34362e3432352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3030322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3432362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3830342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3830362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34372e3134332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3134332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3134352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3634342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3634342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3331352d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e78775200074163746f724964fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c7665725374726174656779740000775300085461736b4e616d65fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c766572537472617465677974001053637265656e696e67205265766965777752000747726f75704964fffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c7665725374726174656779740024536572766963652041646d696e6973747261746f722c2053657276696365204167656e74');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('62443', 131072);
SELECT pg_catalog.lowrite(0, '\xaced0005777f000000000000000c000000000000001200154175746f204469737175616c696669636174696f6e000000000000000100056d6f64656cfffffffe00436f72672e64726f6f6c732e6d61727368616c6c696e672e696d706c2e53657269616c697a61626c65506c616365686f6c6465725265736f6c76657253747261746567797372003a676f762e6d656469636169642e73657276696365732e696d706c2e584d4c53657269616c697a696e67456e726f6c6c6d656e7450726f63657373984aad69a204ba920c00007872002b676f762e6d656469636169642e646f6d61696e2e6d6f64656c2e456e726f6c6c6d656e7450726f63657373824e61f7e3c45e170200094c000c61737365737365644665657374002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f417373657373656446656573547970653b4c000a656e726f6c6c6d656e7474002a4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74547970653b4c0010656e726f6c6c6d656e745374617475737400304c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573547970653b4c0017656e726f6c6c6d656e74537461747573486973746f72797400374c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f456e726f6c6c6d656e74537461747573486973746f7279547970653b4c0019706f73745375626d697373696f6e496e666f726d6174696f6e7400394c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f506f73745375626d697373696f6e496e666f726d6174696f6e547970653b4c0014707265417070726f76616c5175657374696f6e737400124c6a6176612f6c616e672f537472696e673b4c000c70726f63657373417564697474002c4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f636573734175646974547970653b4c000e70726f63657373526573756c747374002e4c676f762f6d656469636169642f646f6d61696e2f6d6f64656c2f50726f63657373526573756c7473547970653b4c000973657373696f6e49647400134c6a6176612f6c616e672f496e74656765723b7870742ca63c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e3c6e73323a456e726f6c6c6d656e7450726f6365737320786d6c6e733d22687474703a2f2f676f762e6d656469636169642e7368617265642f456e7469746965732220786d6c6e733a6e73323d22687474703a2f2f676f762e6d656469636169642e70726f636573732f456e726f6c6c6d656e7450726f636573732220786d6c6e733a6e73333d22687474703a2f2f676f762e6d656469636169642e73657276696365732e656e726f6c6c6d656e742f56616c69646174696f6e53657276696365223e3c6e73323a53657373696f6e49643e313c2f6e73323a53657373696f6e49643e3c6e73323a456e726f6c6c6d656e743e3c4f626a65637449643e313c2f4f626a65637449643e3c52657175657374547970653e456e726f6c6c6d656e743c2f52657175657374547970653e3c456666656374697665446174653e323031372d30312d30312d30363a30303c2f456666656374697665446174653e3c5269736b4c6576656c3e4c696d697465643c2f5269736b4c6576656c3e3c436f6e74616374496e666f726d6174696f6e3e3c4e616d653e426f6220546573743c2f4e616d653e3c50686f6e654e756d6265723e313231203132312d313231313c2f50686f6e654e756d6265723e3c456d61696c416464726573733e3c2f456d61696c416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c5375626d697474656442793e70313c2f5375626d697474656442793e3c5375626d69747465644f6e3e323031372d30382d30322d30353a30303c2f5375626d69747465644f6e3e3c50726f6772657373506167653e50726f76696465722053746174656d656e743c2f50726f6772657373506167653e3c5374617475733e50656e64696e673c2f5374617475733e3c537461747573446174653e323031372d30382d30322d30353a30303c2f537461747573446174653e3c50726f63657373496e7374616e636549643e303c2f50726f63657373496e7374616e636549643e3c6e73323a50726f7669646572496e666f726d6174696f6e3e3c4f626a65637449643e303c2f4f626a65637449643e3c4170706c6963616e74547970653e4f5247414e495a4154494f4e3c2f4170706c6963616e74547970653e3c50726f7669646572547970653e44656e74616c20436c696e69633c2f50726f7669646572547970653e3c4e50493e313233343536373839333c2f4e50493e3c4170706c6963616e74496e666f726d6174696f6e3e3c4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c4c6567616c4e616d653e546573743c2f4c6567616c4e616d653e3c436f6e74616374496e666f726d6174696f6e3e3c50686f6e654e756d6265723e323137203737372d373737373c2f50686f6e654e756d6265723e3c416464726573733e3c416464726573734c696e65323e3132332054657374206176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36303631303c2f5a6970436f64653e3c436f756e74793e30343c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c4645494e3e31322d313231323131313c2f4645494e3e3c4e616d653e546573743c2f4e616d653e3c537461746554617849443e3c2f537461746554617849443e3c54656e393941646472657373496e6465783e303c2f54656e393941646472657373496e6465783e3c42696c6c696e6741646472657373496e6465783e303c2f42696c6c696e6741646472657373496e6465783e3c2f4f7267616e697a6174696f6e496e666f726d6174696f6e3e3c2f4170706c6963616e74496e666f726d6174696f6e3e3c4861734372696d696e616c436f6e76696374696f6e3e4e3c2f4861734372696d696e616c436f6e76696374696f6e3e3c486173436976696c50656e616c74793e4e3c2f486173436976696c50656e616c74793e3c48617350726576696f75734578636c7573696f6e3e4e3c2f48617350726576696f75734578636c7573696f6e3e3c456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e4e3c2f456d706c6f7965654861734372696d696e616c436f6e76696374696f6e3e3c456d706c6f796565486173436976696c50656e616c74793e4e3c2f456d706c6f796565486173436976696c50656e616c74793e3c456d706c6f79656548617350726576696f75734578636c7573696f6e3e4e3c2f456d706c6f79656548617350726576696f75734578636c7573696f6e3e3c52656d697474616e636553657175656e63654e756d6265723e50415449454e545f4143434f554e545f4f525f4f574e5f5245464552454e43455f4f524445523c2f52656d697474616e636553657175656e63654e756d6265723e3c416c7465726e6174654164647265737365732f3e3c416363657074656441677265656d656e74732f3e3c50726f766964657253746174656d656e743e3c4e616d653e426f6220546573743c2f4e616d653e3c5469746c653e507265736964656e74653c2f5469746c653e3c5369676e446174653e323031372d30382d30322d30353a30303c2f5369676e446174653e3c2f50726f766964657253746174656d656e743e3c4174746163686564446f63756d656e74732f3e3c566572696669636174696f6e5374617475732f3e3c4d656d626572496e666f726d6174696f6e3e3c47726f75704d656d6265723e3c4e50493e313233343536373839333c2f4e50493e3c46756c6c4e616d653e426f622044656e746973743c2f46756c6c4e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231323132313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c50726f7669646572547970653e44656e746973743c2f50726f7669646572547970653e3c5374617274446174653e323030302d30312d30312d30363a30303c2f5374617274446174653e3c2f47726f75704d656d6265723e3c2f4d656d626572496e666f726d6174696f6e3e3c4f776e657273686970496e666f726d6174696f6e3e3c456e74697479547970653e536f6c652050726f70726965746f72736869703c2f456e74697479547970653e3c42656e6566696369616c4f776e65723e3c506572736f6e496e643e593c2f506572736f6e496e643e3c42656e6566696369616c4f776e6572547970653e4d616e6167696e6720456d706c6f7965653c2f42656e6566696369616c4f776e6572547970653e3c4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c2f4f7468657242656e6566696369616c4f776e65724465736372697074696f6e3e3c537562636f6e74726163746f724e616d653e3c2f537562636f6e74726163746f724e616d653e3c50657263656e744f776e6572736869703e302e303c2f50657263656e744f776e6572736869703e3c506572736f6e496e666f726d6174696f6e3e3c46697273744e616d653e426f623c2f46697273744e616d653e3c4d6964646c654e616d653e543c2f4d6964646c654e616d653e3c4c6173744e616d653e546573743c2f4c6173744e616d653e3c536f6369616c53656375726974794e756d6265723e3132313231313231313c2f536f6369616c53656375726974794e756d6265723e3c446174654f6642697274683e313937302d30312d30312d30363a30303c2f446174654f6642697274683e3c436f6e74616374496e666f726d6174696f6e3e3c416464726573733e3c416464726573734c696e65323e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f416464726573733e3c2f436f6e74616374496e666f726d6174696f6e3e3c2f506572736f6e496e666f726d6174696f6e3e3c48697265446174653e323030302d30312d30312d30363a30303c2f48697265446174653e3c4f74686572496e746572657374496e643e593c2f4f74686572496e746572657374496e643e3c4f74686572496e7465726573744e616d653e31323c2f4f74686572496e7465726573744e616d653e3c4f74686572496e74657265737450657263656e744f776e6572736869703e302e303c2f4f74686572496e74657265737450657263656e744f776e6572736869703e3c4f74686572496e746572657374416464726573733e3c416464726573734c696e65323e3132332054657374204176653c2f416464726573734c696e65323e3c436974793e4368696361676f3c2f436974793e3c53746174653e494c3c2f53746174653e3c5a6970436f64653e36313830313c2f5a6970436f64653e3c436f756e74793e3c2f436f756e74793e3c2f4f74686572496e746572657374416464726573733e3c2f42656e6566696369616c4f776e65723e3c2f4f776e657273686970496e666f726d6174696f6e3e3c2f6e73323a50726f7669646572496e666f726d6174696f6e3e3c2f6e73323a456e726f6c6c6d656e743e3c6e73323a456e726f6c6c6d656e745374617475733e3c5374617475733e50454e44494e47205245564945573c2f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f537461747573446174653e3c2f6e73323a456e726f6c6c6d656e745374617475733e3c6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c456e726f6c6c6d656e745374617475734368616e67653e3c546f5374617475733e5355424d49545445443c2f546f5374617475733e3c537461747573446174653e323031372d30382d30325431343a32313a34362e3432352d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e70313c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c456e726f6c6c6d656e745374617475734368616e67653e3c46726f6d5374617475733e5355424d49545445443c2f46726f6d5374617475733e3c546f5374617475733e50454e44494e47205245564945573c2f546f5374617475733e3c537461747573526561736f6e3e496e697469616c2053637265656e696e6720497320436f6d706c6574652e3c2f537461747573526561736f6e3e3c537461747573446174653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f537461747573446174653e3c4d6f64696669656442793e53595354454d3c2f4d6f64696669656442793e3c2f456e726f6c6c6d656e745374617475734368616e67653e3c2f6e73323a456e726f6c6c6d656e74537461747573486973746f72793e3c6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c52657175697265734d61696c626f783e593c2f52657175697265734d61696c626f783e3c2f6e73323a506f73745375626d697373696f6e496e666f726d6174696f6e3e3c6e73323a50726f63657373526573756c74733e3c6e73323a56616c69646174696f6e526573756c743e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a56616c69646174696f6e526573756c743e3c6e73323a53637265656e696e67526573756c74733e3c6e73323a4175746f6d6174696353637265656e696e675374617475733e3c5374617475733e3c537461747573436f64653e4641494c5552453c2f537461747573436f64653e3c5374617475734d657373616765733e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4e5049204d7573742042652056657269666965642e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4e50493c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c5374617475734d6573736167653e3c53657665726974793e4552524f523c2f53657665726974793e3c436f64653e30303030323c2f436f64653e3c4d6573736167653e4170706c6963616e74204d757374204e6f7420426520496e20746865204578636c756465642050726f766964657273204c6973742e3c2f4d6573736167653e3c52656c61746564456c656d656e74506174683e2f50726f7669646572496e666f726d6174696f6e2f4170706c69636174696f6e496e666f726d6174696f6e547970653c2f52656c61746564456c656d656e74506174683e3c2f5374617475734d6573736167653e3c2f5374617475734d657373616765733e3c2f5374617475733e3c2f6e73323a4175746f6d6174696353637265656e696e675374617475733e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e53414d204558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e4558434c554445442050524f5649444552533c2f53637265656e696e67547970653e3c5374617475733e3c537461747573436f64653e535543434553533c2f537461747573436f64653e3c2f5374617475733e3c2f6e73323a53637265656e696e67526573756c743e3c6e73323a53637265656e696e67526573756c743e3c53637265656e696e67547970653e454e524f4c4c4d454e5420484953544f52593c2f53637265656e696e67547970653e3c536561726368526573756c742f3e3c2f6e73323a53637265656e696e67526573756c743e3c2f6e73323a53637265656e696e67526573756c74733e3c2f6e73323a50726f63657373526573756c74733e3c6e73323a50726f6365737341756469743e3c6e73323a50726f63657373496e7374616e636549643e31383c2f6e73323a50726f63657373496e7374616e636549643e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e537461727450726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e50726550726f636573733c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3030322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e56616c69646174653c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3432362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e52656a656374204f72205665726966793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3830342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4e5049204c6f6f6b75703c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34362e3830362d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34372e3134332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3134332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e2053414d3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3134352d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696679204c6963656e7365206f722043657274696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34372e3930322d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e373c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e436865636b204578636c756465642050726f7669646572204c69737420696e204f49473c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3037392d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e383c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e44617461205472616e73666f726d6174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336332d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e393c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e5665726966792053534e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3336342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31303c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e47657420456e726f6c6c6d656e7420486973746f72793c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3530312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31313c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e566572696669636174696f6e20436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3634342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31323c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f2053637265656e696e673c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34382e3634342d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31333c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e496e697469616c2053637265656e696e6720436f6d706c657465643c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31343c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4265666f7265205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031312d30353a30303c2f6e73323a537461727454696d653e3c6e73323a456e6454696d653e323031372d30382d30325431343a32313a34392e3435312d30353a30303c2f6e73323a456e6454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31353c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4d616e75616c205265766965773c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3031322d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c6e73323a50726f63657373457865637574696f6e733e3c6e73323a4f626a65637449643e31363c2f6e73323a4f626a65637449643e3c6e73323a50726f636573734e616d653e4175746f204469737175616c696669636174696f6e3c2f6e73323a50726f636573734e616d653e3c6e73323a537461727454696d653e323031372d30382d30325431343a32313a34392e3331352d30353a30303c2f6e73323a537461727454696d653e3c2f6e73323a50726f63657373457865637574696f6e733e3c2f6e73323a50726f6365737341756469743e3c2f6e73323a456e726f6c6c6d656e7450726f636573733e78');
SELECT pg_catalog.lo_close(0);

COMMIT;

SET search_path = public, pg_catalog;

--
-- Name: accepted_agreements accepted_agreements_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY accepted_agreements
    ADD CONSTRAINT accepted_agreements_pkey PRIMARY KEY (accepted_agreement_id);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (address_id);


--
-- Name: affiliations affiliations_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY affiliations
    ADD CONSTRAINT affiliations_pkey PRIMARY KEY (affiliation_id);


--
-- Name: agreement_documents agreement_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY agreement_documents
    ADD CONSTRAINT agreement_documents_pkey PRIMARY KEY (agreement_document_id);


--
-- Name: attachment attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY attachment
    ADD CONSTRAINT attachment_pkey PRIMARY KEY (id);


--
-- Name: audit_details audit_details_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY audit_details
    ADD CONSTRAINT audit_details_pkey PRIMARY KEY (audit_detail_id);


--
-- Name: audit_records audit_records_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY audit_records
    ADD CONSTRAINT audit_records_pkey PRIMARY KEY (audit_record_id);


--
-- Name: beneficial_owner beneficial_owner_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY beneficial_owner
    ADD CONSTRAINT beneficial_owner_pkey PRIMARY KEY (beneficial_owner_id);


--
-- Name: beneficial_owner_types beneficial_owner_types_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY beneficial_owner_types
    ADD CONSTRAINT beneficial_owner_types_description_key UNIQUE (description);


--
-- Name: beneficial_owner_types beneficial_owner_types_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY beneficial_owner_types
    ADD CONSTRAINT beneficial_owner_types_pkey PRIMARY KEY (code);


--
-- Name: binary_contents binary_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY binary_contents
    ADD CONSTRAINT binary_contents_pkey PRIMARY KEY (binary_content_id);


--
-- Name: booleanexpression booleanexpression_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY booleanexpression
    ADD CONSTRAINT booleanexpression_pkey PRIMARY KEY (id);


--
-- Name: categories_of_service categories_of_service_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY categories_of_service
    ADD CONSTRAINT categories_of_service_description_key UNIQUE (description);


--
-- Name: categories_of_service categories_of_service_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY categories_of_service
    ADD CONSTRAINT categories_of_service_pkey PRIMARY KEY (code);


--
-- Name: cms_authentication cms_authentication_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY cms_authentication
    ADD CONSTRAINT cms_authentication_pkey PRIMARY KEY (username);


--
-- Name: cms_user cms_user_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY cms_user
    ADD CONSTRAINT cms_user_pkey PRIMARY KEY (user_id);


--
-- Name: cms_user cms_user_username_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY cms_user
    ADD CONSTRAINT cms_user_username_key UNIQUE (username);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (contact_id);


--
-- Name: content content_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY content
    ADD CONSTRAINT content_pkey PRIMARY KEY (id);


--
-- Name: counties counties_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY counties
    ADD CONSTRAINT counties_description_key UNIQUE (description);


--
-- Name: counties counties_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY counties
    ADD CONSTRAINT counties_pkey PRIMARY KEY (code);


--
-- Name: deadline deadline_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY deadline
    ADD CONSTRAINT deadline_pkey PRIMARY KEY (id);


--
-- Name: degrees degrees_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY degrees
    ADD CONSTRAINT degrees_description_key UNIQUE (description);


--
-- Name: degrees degrees_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY degrees
    ADD CONSTRAINT degrees_pkey PRIMARY KEY (code);


--
-- Name: delegation_delegates delegation_delegates_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY delegation_delegates
    ADD CONSTRAINT delegation_delegates_pkey PRIMARY KEY (task_id, entity_id);


--
-- Name: designated_contacts designated_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY designated_contacts
    ADD CONSTRAINT designated_contacts_pkey PRIMARY KEY (designated_contact_id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (document_id);


--
-- Name: email_header email_header_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY email_header
    ADD CONSTRAINT email_header_pkey PRIMARY KEY (id);


--
-- Name: enrollment_statuses enrollment_statuses_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY enrollment_statuses
    ADD CONSTRAINT enrollment_statuses_description_key UNIQUE (description);


--
-- Name: enrollment_statuses enrollment_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY enrollment_statuses
    ADD CONSTRAINT enrollment_statuses_pkey PRIMARY KEY (code);


--
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (enrollment_id);


--
-- Name: entities entities_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY entities
    ADD CONSTRAINT entities_pkey PRIMARY KEY (entity_id);


--
-- Name: entity_structure_types entity_structure_types_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY entity_structure_types
    ADD CONSTRAINT entity_structure_types_description_key UNIQUE (description);


--
-- Name: entity_structure_types entity_structure_types_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY entity_structure_types
    ADD CONSTRAINT entity_structure_types_pkey PRIMARY KEY (code);


--
-- Name: escalation escalation_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY escalation
    ADD CONSTRAINT escalation_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);


--
-- Name: external_account_link external_account_link_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY external_account_link
    ADD CONSTRAINT external_account_link_pkey PRIMARY KEY (external_account_link_id);


--
-- Name: external_account_links external_account_links_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY external_account_links
    ADD CONSTRAINT external_account_links_pkey PRIMARY KEY (external_account_link_id);


--
-- Name: external_profile_link external_profile_link_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY external_profile_link
    ADD CONSTRAINT external_profile_link_pkey PRIMARY KEY (external_profile_link_id);


--
-- Name: external_profile_links external_profile_links_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY external_profile_links
    ADD CONSTRAINT external_profile_links_pkey PRIMARY KEY (external_profile_link_id);


--
-- Name: help_items help_items_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY help_items
    ADD CONSTRAINT help_items_pkey PRIMARY KEY (help_item_id);


--
-- Name: i18ntext i18ntext_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_pkey PRIMARY KEY (id);


--
-- Name: issuing_boards issuing_boards_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY issuing_boards
    ADD CONSTRAINT issuing_boards_description_key UNIQUE (description);


--
-- Name: issuing_boards issuing_boards_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY issuing_boards
    ADD CONSTRAINT issuing_boards_pkey PRIMARY KEY (code);


--
-- Name: legacy_mapping legacy_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY legacy_mapping
    ADD CONSTRAINT legacy_mapping_pkey PRIMARY KEY (legacy_mapping_id);


--
-- Name: license_statuses license_statuses_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY license_statuses
    ADD CONSTRAINT license_statuses_description_key UNIQUE (description);


--
-- Name: license_statuses license_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY license_statuses
    ADD CONSTRAINT license_statuses_pkey PRIMARY KEY (code);


--
-- Name: license_types license_types_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY license_types
    ADD CONSTRAINT license_types_description_key UNIQUE (description);


--
-- Name: license_types license_types_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY license_types
    ADD CONSTRAINT license_types_pkey PRIMARY KEY (code);


--
-- Name: licenses licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY licenses
    ADD CONSTRAINT licenses_pkey PRIMARY KEY (license_id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (note_id);


--
-- Name: notification_bas notification_bas_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY notification_bas
    ADD CONSTRAINT notification_bas_pkey PRIMARY KEY (task_id, entity_id);


--
-- Name: notification_email_header notification_email_header_emailheaders_id_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY notification_email_header
    ADD CONSTRAINT notification_email_header_emailheaders_id_key UNIQUE (emailheaders_id);


--
-- Name: notification_email_header notification_email_header_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY notification_email_header
    ADD CONSTRAINT notification_email_header_pkey PRIMARY KEY (emailnotification_id, mapkey);


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: notification_recipients notification_recipients_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY notification_recipients
    ADD CONSTRAINT notification_recipients_pkey PRIMARY KEY (task_id, entity_id);


--
-- Name: organizationalentity organizationalentity_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY organizationalentity
    ADD CONSTRAINT organizationalentity_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (entity_id);


--
-- Name: owner_assets owner_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY owner_assets
    ADD CONSTRAINT owner_assets_pkey PRIMARY KEY (owner_asset_id);


--
-- Name: ownership_info ownership_info_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY ownership_info
    ADD CONSTRAINT ownership_info_pkey PRIMARY KEY (ownership_info_id);


--
-- Name: ownership_types ownership_types_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY ownership_types
    ADD CONSTRAINT ownership_types_description_key UNIQUE (description);


--
-- Name: ownership_types ownership_types_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY ownership_types
    ADD CONSTRAINT ownership_types_pkey PRIMARY KEY (code);


--
-- Name: pay_to_provider_types pay_to_provider_types_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY pay_to_provider_types
    ADD CONSTRAINT pay_to_provider_types_description_key UNIQUE (description);


--
-- Name: pay_to_provider_types pay_to_provider_types_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY pay_to_provider_types
    ADD CONSTRAINT pay_to_provider_types_pkey PRIMARY KEY (code);


--
-- Name: pay_to_providers pay_to_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY pay_to_providers
    ADD CONSTRAINT pay_to_providers_pkey PRIMARY KEY (pay_to_providers_id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (entity_id);


--
-- Name: peopleassignments_bas peopleassignments_bas_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_bas
    ADD CONSTRAINT peopleassignments_bas_pkey PRIMARY KEY (task_id, entity_id);


--
-- Name: peopleassignments_exclowners peopleassignments_exclowners_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_exclowners
    ADD CONSTRAINT peopleassignments_exclowners_pkey PRIMARY KEY (task_id, entity_id);


--
-- Name: peopleassignments_potowners peopleassignments_potowners_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_potowners
    ADD CONSTRAINT peopleassignments_potowners_pkey PRIMARY KEY (task_id, entity_id);


--
-- Name: peopleassignments_recipients peopleassignments_recipients_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_recipients
    ADD CONSTRAINT peopleassignments_recipients_pkey PRIMARY KEY (task_id, entity_id);


--
-- Name: peopleassignments_stakeholders peopleassignments_stakeholders_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_stakeholders
    ADD CONSTRAINT peopleassignments_stakeholders_pkey PRIMARY KEY (task_id, entity_id);


--
-- Name: persistent_logins persistent_logins_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY persistent_logins
    ADD CONSTRAINT persistent_logins_pkey PRIMARY KEY (series);


--
-- Name: processinstanceinfo processinstanceinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY processinstanceinfo
    ADD CONSTRAINT processinstanceinfo_pkey PRIMARY KEY (instanceid);


--
-- Name: profile_assured_svc_xref profile_assured_svc_xref_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY profile_assured_svc_xref
    ADD CONSTRAINT profile_assured_svc_xref_pkey PRIMARY KEY (profile_assured_svc_id);


--
-- Name: profile_statuses profile_statuses_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY profile_statuses
    ADD CONSTRAINT profile_statuses_description_key UNIQUE (description);


--
-- Name: profile_statuses profile_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY profile_statuses
    ADD CONSTRAINT profile_statuses_pkey PRIMARY KEY (code);


--
-- Name: provider_category_of_service_approvals provider_category_of_service_approvals_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_category_of_service_approvals
    ADD CONSTRAINT provider_category_of_service_approvals_pkey PRIMARY KEY (provider_category_of_service_approval_id);


--
-- Name: provider_cos_xref provider_cos_xref_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_cos_xref
    ADD CONSTRAINT provider_cos_xref_pkey PRIMARY KEY (provider_cos_id);


--
-- Name: provider_profiles provider_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_profiles
    ADD CONSTRAINT provider_profiles_pkey PRIMARY KEY (control_no);


--
-- Name: provider_services provider_services_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_services
    ADD CONSTRAINT provider_services_pkey PRIMARY KEY (provider_service_id);


--
-- Name: provider_statements provider_statements_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_statements
    ADD CONSTRAINT provider_statements_pkey PRIMARY KEY (provider_statement_id);


--
-- Name: provider_svcs provider_svcs_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_svcs
    ADD CONSTRAINT provider_svcs_pkey PRIMARY KEY (provider_svcs_id);


--
-- Name: provider_type_agreement_documents provider_type_agreement_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_type_agreement_documents
    ADD CONSTRAINT provider_type_agreement_documents_pkey PRIMARY KEY (provider_type_code, agreement_document_id);


--
-- Name: provider_type_license_types provider_type_license_types_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_type_license_types
    ADD CONSTRAINT provider_type_license_types_pkey PRIMARY KEY (provider_type_code, license_type_code);


--
-- Name: provider_type_settings provider_type_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_type_settings
    ADD CONSTRAINT provider_type_settings_pkey PRIMARY KEY (provider_type_setting_id);


--
-- Name: provider_types provider_types_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_types
    ADD CONSTRAINT provider_types_description_key UNIQUE (description);


--
-- Name: provider_types provider_types_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_types
    ADD CONSTRAINT provider_types_pkey PRIMARY KEY (code);


--
-- Name: qualified_professional_types qualified_professional_types_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY qualified_professional_types
    ADD CONSTRAINT qualified_professional_types_description_key UNIQUE (description);


--
-- Name: qualified_professional_types qualified_professional_types_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY qualified_professional_types
    ADD CONSTRAINT qualified_professional_types_pkey PRIMARY KEY (code);


--
-- Name: reassignment reassignment_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY reassignment
    ADD CONSTRAINT reassignment_pkey PRIMARY KEY (id);


--
-- Name: relationship_types relationship_types_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY relationship_types
    ADD CONSTRAINT relationship_types_description_key UNIQUE (description);


--
-- Name: relationship_types relationship_types_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY relationship_types
    ADD CONSTRAINT relationship_types_pkey PRIMARY KEY (code);


--
-- Name: request_types request_types_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY request_types
    ADD CONSTRAINT request_types_description_key UNIQUE (description);


--
-- Name: request_types request_types_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY request_types
    ADD CONSTRAINT request_types_pkey PRIMARY KEY (code);


--
-- Name: required_field_types required_field_types_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY required_field_types
    ADD CONSTRAINT required_field_types_description_key UNIQUE (description);


--
-- Name: required_field_types required_field_types_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY required_field_types
    ADD CONSTRAINT required_field_types_pkey PRIMARY KEY (code);


--
-- Name: required_fld required_fld_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY required_fld
    ADD CONSTRAINT required_fld_pkey PRIMARY KEY (code);


--
-- Name: risk_levels risk_levels_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY risk_levels
    ADD CONSTRAINT risk_levels_description_key UNIQUE (description);


--
-- Name: risk_levels risk_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY risk_levels
    ADD CONSTRAINT risk_levels_pkey PRIMARY KEY (code);


--
-- Name: risk_levels risk_levels_sort_index_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY risk_levels
    ADD CONSTRAINT risk_levels_sort_index_key UNIQUE (sort_index);


--
-- Name: roles roles_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_description_key UNIQUE (description);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (code);


--
-- Name: screening_schedules screening_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY screening_schedules
    ADD CONSTRAINT screening_schedules_pkey PRIMARY KEY (screening_schedule_id);


--
-- Name: service_assurance_ext_types service_assurance_ext_types_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY service_assurance_ext_types
    ADD CONSTRAINT service_assurance_ext_types_description_key UNIQUE (description);


--
-- Name: service_assurance_ext_types service_assurance_ext_types_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY service_assurance_ext_types
    ADD CONSTRAINT service_assurance_ext_types_pkey PRIMARY KEY (code);


--
-- Name: service_assurance_types service_assurance_types_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY service_assurance_types
    ADD CONSTRAINT service_assurance_types_description_key UNIQUE (description);


--
-- Name: service_assurance_types service_assurance_types_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY service_assurance_types
    ADD CONSTRAINT service_assurance_types_pkey PRIMARY KEY (code);


--
-- Name: service_categories service_categories_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY service_categories
    ADD CONSTRAINT service_categories_description_key UNIQUE (description);


--
-- Name: service_categories service_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY service_categories
    ADD CONSTRAINT service_categories_pkey PRIMARY KEY (code);


--
-- Name: sessioninfo sessioninfo_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY sessioninfo
    ADD CONSTRAINT sessioninfo_pkey PRIMARY KEY (id);


--
-- Name: specialty_types specialty_types_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY specialty_types
    ADD CONSTRAINT specialty_types_description_key UNIQUE (description);


--
-- Name: specialty_types specialty_types_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY specialty_types
    ADD CONSTRAINT specialty_types_pkey PRIMARY KEY (code);


--
-- Name: states states_description_key; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY states
    ADD CONSTRAINT states_description_key UNIQUE (description);


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY states
    ADD CONSTRAINT states_pkey PRIMARY KEY (code);


--
-- Name: subtasksstrategy subtasksstrategy_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY subtasksstrategy
    ADD CONSTRAINT subtasksstrategy_pkey PRIMARY KEY (id);


--
-- Name: task_comment task_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY task_comment
    ADD CONSTRAINT task_comment_pkey PRIMARY KEY (id);


--
-- Name: task task_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id);


--
-- Name: workiteminfo workiteminfo_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY workiteminfo
    ADD CONSTRAINT workiteminfo_pkey PRIMARY KEY (workitemid);


--
-- Name: accepted_agreements accepted_agreements_agreement_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY accepted_agreements
    ADD CONSTRAINT accepted_agreements_agreement_document_id_fkey FOREIGN KEY (agreement_document_id) REFERENCES agreement_documents(agreement_document_id);


--
-- Name: affiliations affiliations_qualified_professional_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY affiliations
    ADD CONSTRAINT affiliations_qualified_professional_type_code_fkey FOREIGN KEY (qualified_professional_type_code) REFERENCES qualified_professional_types(code);


--
-- Name: attachment attachment_attachedby_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY attachment
    ADD CONSTRAINT attachment_attachedby_id_fkey FOREIGN KEY (attachedby_id) REFERENCES organizationalentity(id);


--
-- Name: attachment attachment_taskdata_attachments_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY attachment
    ADD CONSTRAINT attachment_taskdata_attachments_id_fkey FOREIGN KEY (taskdata_attachments_id) REFERENCES task(id);


--
-- Name: audit_details audit_details_audit_record_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY audit_details
    ADD CONSTRAINT audit_details_audit_record_id_fkey FOREIGN KEY (audit_record_id) REFERENCES audit_records(audit_record_id);


--
-- Name: beneficial_owner beneficial_owner_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY beneficial_owner
    ADD CONSTRAINT beneficial_owner_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(address_id);


--
-- Name: beneficial_owner beneficial_owner_ben_type_cd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY beneficial_owner
    ADD CONSTRAINT beneficial_owner_ben_type_cd_fkey FOREIGN KEY (ben_type_cd) REFERENCES beneficial_owner_types(code);


--
-- Name: beneficial_owner beneficial_owner_oth_provider_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY beneficial_owner
    ADD CONSTRAINT beneficial_owner_oth_provider_address_id_fkey FOREIGN KEY (oth_provider_address_id) REFERENCES addresses(address_id);


--
-- Name: beneficial_owner beneficial_owner_ownership_info_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY beneficial_owner
    ADD CONSTRAINT beneficial_owner_ownership_info_id_fkey FOREIGN KEY (ownership_info_id) REFERENCES ownership_info(ownership_info_id);


--
-- Name: beneficial_owner beneficial_owner_relationship_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY beneficial_owner
    ADD CONSTRAINT beneficial_owner_relationship_type_code_fkey FOREIGN KEY (relationship_type_code) REFERENCES relationship_types(code);


--
-- Name: booleanexpression booleanexpression_escalation_constraints_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY booleanexpression
    ADD CONSTRAINT booleanexpression_escalation_constraints_id_fkey FOREIGN KEY (escalation_constraints_id) REFERENCES escalation(id);


--
-- Name: cms_user cms_user_role_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY cms_user
    ADD CONSTRAINT cms_user_role_code_fkey FOREIGN KEY (role_code) REFERENCES roles(code);


--
-- Name: contacts contacts_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(address_id);


--
-- Name: deadline deadline_deadlines_enddeadline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY deadline
    ADD CONSTRAINT deadline_deadlines_enddeadline_id_fkey FOREIGN KEY (deadlines_enddeadline_id) REFERENCES task(id);


--
-- Name: deadline deadline_deadlines_startdeadline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY deadline
    ADD CONSTRAINT deadline_deadlines_startdeadline_id_fkey FOREIGN KEY (deadlines_startdeadline_id) REFERENCES task(id);


--
-- Name: delegation_delegates delegation_delegates_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY delegation_delegates
    ADD CONSTRAINT delegation_delegates_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);


--
-- Name: delegation_delegates delegation_delegates_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY delegation_delegates
    ADD CONSTRAINT delegation_delegates_task_id_fkey FOREIGN KEY (task_id) REFERENCES task(id);


--
-- Name: designated_contacts designated_contacts_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY designated_contacts
    ADD CONSTRAINT designated_contacts_person_id_fkey FOREIGN KEY (person_id) REFERENCES people(entity_id);


--
-- Name: enrollments enrollments_enrollment_status_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY enrollments
    ADD CONSTRAINT enrollments_enrollment_status_code_fkey FOREIGN KEY (enrollment_status_code) REFERENCES enrollment_statuses(code);


--
-- Name: enrollments enrollments_request_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY enrollments
    ADD CONSTRAINT enrollments_request_type_code_fkey FOREIGN KEY (request_type_code) REFERENCES request_types(code);


--
-- Name: entities entities_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY entities
    ADD CONSTRAINT entities_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES contacts(contact_id);


--
-- Name: entities entities_provider_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY entities
    ADD CONSTRAINT entities_provider_type_code_fkey FOREIGN KEY (provider_type_code) REFERENCES provider_types(code);


--
-- Name: escalation escalation_deadline_escalation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY escalation
    ADD CONSTRAINT escalation_deadline_escalation_id_fkey FOREIGN KEY (deadline_escalation_id) REFERENCES deadline(id);


--
-- Name: eventtypes eventtypes_instanceid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY eventtypes
    ADD CONSTRAINT eventtypes_instanceid_fkey FOREIGN KEY (instanceid) REFERENCES processinstanceinfo(instanceid);


--
-- Name: provider_cos fk2ciqibe0u9h2cmyeut8q5alir; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_cos
    ADD CONSTRAINT fk2ciqibe0u9h2cmyeut8q5alir FOREIGN KEY (provider_cos_id) REFERENCES provider_cos_xref(provider_cos_id);


--
-- Name: required_fld fk3pj5itnxvpohvq0q8skilyal0; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY required_fld
    ADD CONSTRAINT fk3pj5itnxvpohvq0q8skilyal0 FOREIGN KEY (required_fld_type_id) REFERENCES required_fld(code);


--
-- Name: profile_assured_ext_svcs fknpq45dvbn0v9qxjrp3ccs81uy; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY profile_assured_ext_svcs
    ADD CONSTRAINT fknpq45dvbn0v9qxjrp3ccs81uy FOREIGN KEY (profile_assured_svc_id) REFERENCES profile_assured_svc_xref(profile_assured_svc_id);


--
-- Name: i18ntext i18ntext_deadline_documentation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_deadline_documentation_id_fkey FOREIGN KEY (deadline_documentation_id) REFERENCES deadline(id);


--
-- Name: i18ntext i18ntext_notification_descriptions_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_notification_descriptions_id_fkey FOREIGN KEY (notification_descriptions_id) REFERENCES notification(id);


--
-- Name: i18ntext i18ntext_notification_documentation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_notification_documentation_id_fkey FOREIGN KEY (notification_documentation_id) REFERENCES notification(id);


--
-- Name: i18ntext i18ntext_notification_names_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_notification_names_id_fkey FOREIGN KEY (notification_names_id) REFERENCES notification(id);


--
-- Name: i18ntext i18ntext_notification_subjects_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_notification_subjects_id_fkey FOREIGN KEY (notification_subjects_id) REFERENCES notification(id);


--
-- Name: i18ntext i18ntext_reassignment_documentation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_reassignment_documentation_id_fkey FOREIGN KEY (reassignment_documentation_id) REFERENCES reassignment(id);


--
-- Name: i18ntext i18ntext_task_descriptions_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_task_descriptions_id_fkey FOREIGN KEY (task_descriptions_id) REFERENCES task(id);


--
-- Name: i18ntext i18ntext_task_names_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_task_names_id_fkey FOREIGN KEY (task_names_id) REFERENCES task(id);


--
-- Name: i18ntext i18ntext_task_subjects_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_task_subjects_id_fkey FOREIGN KEY (task_subjects_id) REFERENCES task(id);


--
-- Name: licenses licenses_issuing_board_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY licenses
    ADD CONSTRAINT licenses_issuing_board_code_fkey FOREIGN KEY (issuing_board_code) REFERENCES issuing_boards(code);


--
-- Name: licenses licenses_license_status_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY licenses
    ADD CONSTRAINT licenses_license_status_code_fkey FOREIGN KEY (license_status_code) REFERENCES license_statuses(code);


--
-- Name: licenses licenses_license_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY licenses
    ADD CONSTRAINT licenses_license_type_code_fkey FOREIGN KEY (license_type_code) REFERENCES license_types(code);


--
-- Name: licenses licenses_specialty_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY licenses
    ADD CONSTRAINT licenses_specialty_type_code_fkey FOREIGN KEY (specialty_type_code) REFERENCES specialty_types(code);


--
-- Name: notification_bas notification_bas_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY notification_bas
    ADD CONSTRAINT notification_bas_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);


--
-- Name: notification_bas notification_bas_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY notification_bas
    ADD CONSTRAINT notification_bas_task_id_fkey FOREIGN KEY (task_id) REFERENCES notification(id);


--
-- Name: notification_email_header notification_email_header_emailheaders_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY notification_email_header
    ADD CONSTRAINT notification_email_header_emailheaders_id_fkey FOREIGN KEY (emailheaders_id) REFERENCES email_header(id);


--
-- Name: notification_email_header notification_email_header_emailnotification_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY notification_email_header
    ADD CONSTRAINT notification_email_header_emailnotification_id_fkey FOREIGN KEY (emailnotification_id) REFERENCES notification(id);


--
-- Name: notification notification_escalation_notifications_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_escalation_notifications_id_fkey FOREIGN KEY (escalation_notifications_id) REFERENCES escalation(id);


--
-- Name: notification_recipients notification_recipients_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY notification_recipients
    ADD CONSTRAINT notification_recipients_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);


--
-- Name: notification_recipients notification_recipients_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY notification_recipients
    ADD CONSTRAINT notification_recipients_task_id_fkey FOREIGN KEY (task_id) REFERENCES notification(id);


--
-- Name: organizations organizations_billing_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_billing_address_id_fkey FOREIGN KEY (billing_address_id) REFERENCES addresses(address_id);


--
-- Name: organizations organizations_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES entities(entity_id);


--
-- Name: organizations organizations_reimbursement_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_reimbursement_address_id_fkey FOREIGN KEY (reimbursement_address_id) REFERENCES addresses(address_id);


--
-- Name: organizations organizations_ten99_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_ten99_address_id_fkey FOREIGN KEY (ten99_address_id) REFERENCES addresses(address_id);


--
-- Name: owner_assets owner_assets_ownership_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY owner_assets
    ADD CONSTRAINT owner_assets_ownership_type_code_fkey FOREIGN KEY (ownership_type_code) REFERENCES ownership_types(code);


--
-- Name: ownership_info ownership_info_entity_structure_subtype_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY ownership_info
    ADD CONSTRAINT ownership_info_entity_structure_subtype_code_fkey FOREIGN KEY (entity_structure_subtype_code) REFERENCES entity_structure_types(code);


--
-- Name: ownership_info ownership_info_entity_structure_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY ownership_info
    ADD CONSTRAINT ownership_info_entity_structure_type_code_fkey FOREIGN KEY (entity_structure_type_code) REFERENCES entity_structure_types(code);


--
-- Name: pay_to_providers pay_to_providers_pay_to_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY pay_to_providers
    ADD CONSTRAINT pay_to_providers_pay_to_type_code_fkey FOREIGN KEY (pay_to_type_code) REFERENCES pay_to_provider_types(code);


--
-- Name: people people_degree_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_degree_code_fkey FOREIGN KEY (degree_code) REFERENCES degrees(code);


--
-- Name: people people_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES entities(entity_id);


--
-- Name: peopleassignments_bas peopleassignments_bas_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_bas
    ADD CONSTRAINT peopleassignments_bas_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);


--
-- Name: peopleassignments_bas peopleassignments_bas_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_bas
    ADD CONSTRAINT peopleassignments_bas_task_id_fkey FOREIGN KEY (task_id) REFERENCES task(id);


--
-- Name: peopleassignments_exclowners peopleassignments_exclowners_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_exclowners
    ADD CONSTRAINT peopleassignments_exclowners_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);


--
-- Name: peopleassignments_exclowners peopleassignments_exclowners_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_exclowners
    ADD CONSTRAINT peopleassignments_exclowners_task_id_fkey FOREIGN KEY (task_id) REFERENCES task(id);


--
-- Name: peopleassignments_potowners peopleassignments_potowners_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_potowners
    ADD CONSTRAINT peopleassignments_potowners_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);


--
-- Name: peopleassignments_potowners peopleassignments_potowners_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_potowners
    ADD CONSTRAINT peopleassignments_potowners_task_id_fkey FOREIGN KEY (task_id) REFERENCES task(id);


--
-- Name: peopleassignments_recipients peopleassignments_recipients_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_recipients
    ADD CONSTRAINT peopleassignments_recipients_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);


--
-- Name: peopleassignments_recipients peopleassignments_recipients_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_recipients
    ADD CONSTRAINT peopleassignments_recipients_task_id_fkey FOREIGN KEY (task_id) REFERENCES task(id);


--
-- Name: peopleassignments_stakeholders peopleassignments_stakeholders_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_stakeholders
    ADD CONSTRAINT peopleassignments_stakeholders_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);


--
-- Name: peopleassignments_stakeholders peopleassignments_stakeholders_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY peopleassignments_stakeholders
    ADD CONSTRAINT peopleassignments_stakeholders_task_id_fkey FOREIGN KEY (task_id) REFERENCES task(id);


--
-- Name: provider_approved_categories_of_service provider_approved_categories__provider_category_of_service_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_approved_categories_of_service
    ADD CONSTRAINT provider_approved_categories__provider_category_of_service_fkey FOREIGN KEY (provider_category_of_service_approval_id) REFERENCES provider_category_of_service_approvals(provider_category_of_service_approval_id);


--
-- Name: provider_approved_categories_of_service provider_approved_categories_of_s_category_of_service_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_approved_categories_of_service
    ADD CONSTRAINT provider_approved_categories_of_s_category_of_service_code_fkey FOREIGN KEY (category_of_service_code) REFERENCES categories_of_service(code);


--
-- Name: provider_profiles provider_profiles_profile_status_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_profiles
    ADD CONSTRAINT provider_profiles_profile_status_code_fkey FOREIGN KEY (profile_status_code) REFERENCES profile_statuses(code);


--
-- Name: provider_profiles provider_profiles_risk_level_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_profiles
    ADD CONSTRAINT provider_profiles_risk_level_code_fkey FOREIGN KEY (risk_level_code) REFERENCES risk_levels(code);


--
-- Name: provider_services provider_services_service_category_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_services
    ADD CONSTRAINT provider_services_service_category_code_fkey FOREIGN KEY (service_category_code) REFERENCES service_categories(code);


--
-- Name: provider_type_agreement_documents provider_type_agreement_documents_agreement_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_type_agreement_documents
    ADD CONSTRAINT provider_type_agreement_documents_agreement_document_id_fkey FOREIGN KEY (agreement_document_id) REFERENCES agreement_documents(agreement_document_id);


--
-- Name: provider_type_agreement_documents provider_type_agreement_documents_provider_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_type_agreement_documents
    ADD CONSTRAINT provider_type_agreement_documents_provider_type_code_fkey FOREIGN KEY (provider_type_code) REFERENCES provider_types(code);


--
-- Name: provider_type_license_types provider_type_license_types_license_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_type_license_types
    ADD CONSTRAINT provider_type_license_types_license_type_code_fkey FOREIGN KEY (license_type_code) REFERENCES license_types(code);


--
-- Name: provider_type_license_types provider_type_license_types_provider_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_type_license_types
    ADD CONSTRAINT provider_type_license_types_provider_type_code_fkey FOREIGN KEY (provider_type_code) REFERENCES provider_types(code);


--
-- Name: provider_type_settings provider_type_settings_provider_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY provider_type_settings
    ADD CONSTRAINT provider_type_settings_provider_type_code_fkey FOREIGN KEY (provider_type_code) REFERENCES provider_types(code);


--
-- Name: reassignment reassignment_escalation_reassignments_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY reassignment
    ADD CONSTRAINT reassignment_escalation_reassignments_id_fkey FOREIGN KEY (escalation_reassignments_id) REFERENCES escalation(id);


--
-- Name: reassignment_potentialowners reassignment_potentialowners_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY reassignment_potentialowners
    ADD CONSTRAINT reassignment_potentialowners_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);


--
-- Name: reassignment_potentialowners reassignment_potentialowners_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY reassignment_potentialowners
    ADD CONSTRAINT reassignment_potentialowners_task_id_fkey FOREIGN KEY (task_id) REFERENCES reassignment(id);


--
-- Name: subtasksstrategy subtasksstrategy_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY subtasksstrategy
    ADD CONSTRAINT subtasksstrategy_task_id_fkey FOREIGN KEY (task_id) REFERENCES task(id);


--
-- Name: task task_actualowner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_actualowner_id_fkey FOREIGN KEY (actualowner_id) REFERENCES organizationalentity(id);


--
-- Name: task_comment task_comment_addedby_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY task_comment
    ADD CONSTRAINT task_comment_addedby_id_fkey FOREIGN KEY (addedby_id) REFERENCES organizationalentity(id);


--
-- Name: task_comment task_comment_taskdata_comments_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY task_comment
    ADD CONSTRAINT task_comment_taskdata_comments_id_fkey FOREIGN KEY (taskdata_comments_id) REFERENCES task(id);


--
-- Name: task task_createdby_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_createdby_id_fkey FOREIGN KEY (createdby_id) REFERENCES organizationalentity(id);


--
-- Name: task task_taskinitiator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_taskinitiator_id_fkey FOREIGN KEY (taskinitiator_id) REFERENCES organizationalentity(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

