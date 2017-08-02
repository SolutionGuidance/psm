

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;



COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;


CREATE TABLE accepted_agreements (
    accepted_agreement_id bigint NOT NULL,
    profile_id bigint,
    ticket_id bigint,
    accepted_date date,
    agreement_document_id bigint
);


ALTER TABLE accepted_agreements OWNER TO psm;


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


CREATE SEQUENCE attachment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE attachment_id_seq OWNER TO psm;


CREATE TABLE audit_details (
    audit_detail_id bigint NOT NULL,
    audit_record_id bigint NOT NULL,
    table_name text,
    column_name text,
    old_value text,
    new_value text
);


ALTER TABLE audit_details OWNER TO psm;


CREATE TABLE audit_records (
    audit_record_id bigint NOT NULL,
    action text,
    date timestamp with time zone,
    system_id text,
    username text
);


ALTER TABLE audit_records OWNER TO psm;


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


CREATE TABLE beneficial_owner_types (
    code character varying(2) NOT NULL,
    description text,
    owner_type character varying(1)
);


ALTER TABLE beneficial_owner_types OWNER TO psm;


CREATE TABLE binary_contents (
    binary_content_id text NOT NULL,
    content oid
);


ALTER TABLE binary_contents OWNER TO psm;


CREATE SEQUENCE booleanexpr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE booleanexpr_id_seq OWNER TO psm;


CREATE TABLE booleanexpression (
    id bigint NOT NULL,
    expression text,
    type text,
    escalation_constraints_id bigint
);


ALTER TABLE booleanexpression OWNER TO psm;


CREATE TABLE categories_of_service (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE categories_of_service OWNER TO psm;


CREATE TABLE cms_authentication (
    username text NOT NULL,
    password text NOT NULL
);


ALTER TABLE cms_authentication OWNER TO psm;


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


CREATE SEQUENCE comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comment_id_seq OWNER TO psm;


CREATE TABLE contacts (
    contact_id bigint NOT NULL,
    phone_number text,
    fax_number text,
    email text,
    address_id bigint
);


ALTER TABLE contacts OWNER TO psm;


CREATE TABLE content (
    id bigint NOT NULL,
    content oid
);


ALTER TABLE content OWNER TO psm;


CREATE SEQUENCE content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE content_id_seq OWNER TO psm;


CREATE TABLE counties (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE counties OWNER TO psm;


CREATE TABLE deadline (
    id bigint NOT NULL,
    deadline_date timestamp with time zone,
    escalated smallint,
    deadlines_startdeadline_id bigint,
    deadlines_enddeadline_id bigint
);


ALTER TABLE deadline OWNER TO psm;


CREATE SEQUENCE deadline_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE deadline_id_seq OWNER TO psm;


CREATE TABLE degrees (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE degrees OWNER TO psm;


CREATE TABLE delegation_delegates (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE delegation_delegates OWNER TO psm;


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


CREATE TABLE email_header (
    id bigint NOT NULL,
    body text,
    fromaddress text,
    language text,
    replytoaddress text,
    subject text
);


ALTER TABLE email_header OWNER TO psm;


CREATE SEQUENCE emailnotifhead_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE emailnotifhead_id_seq OWNER TO psm;


CREATE TABLE enrollment_statuses (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE enrollment_statuses OWNER TO psm;


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


CREATE TABLE entity_structure_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE entity_structure_types OWNER TO psm;


CREATE TABLE escalation (
    id bigint NOT NULL,
    name text,
    deadline_escalation_id bigint
);


ALTER TABLE escalation OWNER TO psm;


CREATE SEQUENCE escalation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE escalation_id_seq OWNER TO psm;


CREATE TABLE events (
    event_id bigint NOT NULL,
    ticket_id bigint,
    npi text,
    status text,
    created_by text,
    created_at timestamp with time zone
);


ALTER TABLE events OWNER TO psm;


CREATE TABLE eventtypes (
    instanceid bigint NOT NULL,
    eventtypes text
);


ALTER TABLE eventtypes OWNER TO psm;


CREATE TABLE external_account_link (
    external_account_link_id bigint NOT NULL,
    user_id character varying(255),
    system_id character varying(255),
    external_user_id character varying(255)
);


ALTER TABLE external_account_link OWNER TO psm;


CREATE TABLE external_account_links (
    external_account_link_id bigint NOT NULL,
    user_id text,
    system_id text,
    external_user_id text
);


ALTER TABLE external_account_links OWNER TO psm;


CREATE TABLE external_profile_link (
    external_profile_link_id bigint NOT NULL,
    profile_id bigint,
    system_id character varying(255),
    external_profile_id character varying(255)
);


ALTER TABLE external_profile_link OWNER TO psm;


CREATE TABLE external_profile_links (
    external_profile_link_id bigint NOT NULL,
    profile_id bigint,
    system_id text,
    external_profile_id text
);


ALTER TABLE external_profile_links OWNER TO psm;


CREATE TABLE help_items (
    help_item_id bigint NOT NULL,
    title text,
    description text
);


ALTER TABLE help_items OWNER TO psm;


CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO psm;


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


CREATE SEQUENCE i18ntext_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE i18ntext_id_seq OWNER TO psm;


CREATE TABLE issuing_boards (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE issuing_boards OWNER TO psm;


CREATE TABLE legacy_mapping (
    legacy_mapping_id bigint NOT NULL,
    system_nm character varying(255),
    code_type character varying(255),
    internal_code character varying(255),
    external_code character varying(255)
);


ALTER TABLE legacy_mapping OWNER TO psm;


CREATE TABLE license_statuses (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE license_statuses OWNER TO psm;


CREATE TABLE license_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE license_types OWNER TO psm;


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


CREATE TABLE notes (
    note_id bigint NOT NULL,
    profile_id bigint,
    ticket_id bigint,
    note_text text,
    created_by text,
    created_at timestamp with time zone
);


ALTER TABLE notes OWNER TO psm;


CREATE TABLE notification (
    id bigint NOT NULL,
    dtype text NOT NULL,
    priority integer NOT NULL,
    escalation_notifications_id bigint
);


ALTER TABLE notification OWNER TO psm;


CREATE TABLE notification_bas (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE notification_bas OWNER TO psm;


CREATE TABLE notification_email_header (
    emailnotification_id bigint NOT NULL,
    emailheaders_id bigint NOT NULL,
    mapkey text NOT NULL
);


ALTER TABLE notification_email_header OWNER TO psm;


CREATE SEQUENCE notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notification_id_seq OWNER TO psm;


CREATE TABLE notification_recipients (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE notification_recipients OWNER TO psm;


CREATE TABLE organizationalentity (
    id text NOT NULL,
    dtype text NOT NULL
);


ALTER TABLE organizationalentity OWNER TO psm;


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


CREATE TABLE owner_assets (
    owner_asset_id bigint NOT NULL,
    name text,
    ownership_type_code character varying(2),
    address_id bigint,
    ownership_info_id bigint
);


ALTER TABLE owner_assets OWNER TO psm;


CREATE TABLE ownership_info (
    ownership_info_id bigint NOT NULL,
    profile_id bigint,
    ticket_id bigint,
    entity_structure_type_code character varying(2),
    entity_structure_subtype_code character varying(2),
    other_entity_type_desc text
);


ALTER TABLE ownership_info OWNER TO psm;


CREATE TABLE ownership_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE ownership_types OWNER TO psm;


CREATE TABLE pay_to_provider_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE pay_to_provider_types OWNER TO psm;


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


CREATE TABLE peopleassignments_bas (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE peopleassignments_bas OWNER TO psm;


CREATE TABLE peopleassignments_exclowners (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE peopleassignments_exclowners OWNER TO psm;


CREATE TABLE peopleassignments_potowners (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE peopleassignments_potowners OWNER TO psm;


CREATE TABLE peopleassignments_recipients (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE peopleassignments_recipients OWNER TO psm;


CREATE TABLE peopleassignments_stakeholders (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE peopleassignments_stakeholders OWNER TO psm;


CREATE TABLE persistent_logins (
    series character varying(64) NOT NULL,
    username character varying(64) NOT NULL,
    token character varying(64) NOT NULL,
    last_used timestamp with time zone NOT NULL
);


ALTER TABLE persistent_logins OWNER TO psm;


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


CREATE TABLE profile_assured_ext_svcs (
    profile_assured_svc_id bigint NOT NULL,
    elt character varying(255) NOT NULL
);


ALTER TABLE profile_assured_ext_svcs OWNER TO psm;


CREATE TABLE profile_assured_svc_xref (
    profile_assured_svc_id bigint NOT NULL,
    eff_dt date,
    svc_assurance_cd character varying(255),
    profile_id bigint,
    ticket_id bigint,
    status integer
);


ALTER TABLE profile_assured_svc_xref OWNER TO psm;


CREATE TABLE profile_statuses (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE profile_statuses OWNER TO psm;


CREATE TABLE provider_approved_categories_of_service (
    provider_category_of_service_approval_id bigint,
    category_of_service_code character varying(2)
);


ALTER TABLE provider_approved_categories_of_service OWNER TO psm;


CREATE TABLE provider_category_of_service_approvals (
    provider_category_of_service_approval_id bigint NOT NULL,
    profile_id bigint,
    ticket_id bigint,
    start_date date,
    end_date date
);


ALTER TABLE provider_category_of_service_approvals OWNER TO psm;


CREATE TABLE provider_cos (
    provider_cos_id bigint NOT NULL,
    provider_cos_cd character varying(255) NOT NULL
);


ALTER TABLE provider_cos OWNER TO psm;


CREATE TABLE provider_cos_xref (
    provider_cos_id bigint NOT NULL,
    profile_id bigint DEFAULT 0,
    ticket_id bigint DEFAULT 0,
    start_dt timestamp without time zone NOT NULL,
    end_dt timestamp without time zone
);


ALTER TABLE provider_cos_xref OWNER TO psm;


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


CREATE TABLE provider_services (
    provider_service_id bigint NOT NULL,
    profile_id bigint DEFAULT 0 NOT NULL,
    ticket_id bigint DEFAULT 0 NOT NULL,
    service_category_code character varying(2)
);


ALTER TABLE provider_services OWNER TO psm;


CREATE TABLE provider_statements (
    provider_statement_id bigint NOT NULL,
    profile_id bigint,
    ticket_id bigint,
    name text,
    title text,
    date date
);


ALTER TABLE provider_statements OWNER TO psm;


CREATE TABLE provider_svcs (
    provider_svcs_id bigint NOT NULL,
    profile_id bigint DEFAULT 0 NOT NULL,
    ticket_id bigint DEFAULT 0 NOT NULL,
    svc_cat_cd character varying(255)
);


ALTER TABLE provider_svcs OWNER TO psm;


CREATE TABLE provider_type_agreement_documents (
    provider_type_code character varying(2) NOT NULL,
    agreement_document_id bigint NOT NULL
);


ALTER TABLE provider_type_agreement_documents OWNER TO psm;


CREATE TABLE provider_type_license_types (
    provider_type_code character varying(2) NOT NULL,
    license_type_code character varying(2) NOT NULL
);


ALTER TABLE provider_type_license_types OWNER TO psm;


CREATE TABLE provider_type_settings (
    provider_type_setting_id integer NOT NULL,
    provider_type_code character varying(2) NOT NULL,
    related_entity_type text NOT NULL,
    related_entity_code text NOT NULL,
    relationship_type text NOT NULL
);


ALTER TABLE provider_type_settings OWNER TO psm;


CREATE TABLE provider_types (
    code character varying(2) NOT NULL,
    description text,
    applicant_type text DEFAULT 'INDIVIDUAL'::text NOT NULL
);


ALTER TABLE provider_types OWNER TO psm;


CREATE TABLE qualified_professional_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE qualified_professional_types OWNER TO psm;


CREATE TABLE reassignment (
    id bigint NOT NULL,
    escalation_reassignments_id bigint
);


ALTER TABLE reassignment OWNER TO psm;


CREATE SEQUENCE reassignment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reassignment_id_seq OWNER TO psm;


CREATE TABLE reassignment_potentialowners (
    task_id bigint NOT NULL,
    entity_id text NOT NULL
);


ALTER TABLE reassignment_potentialowners OWNER TO psm;


CREATE TABLE relationship_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE relationship_types OWNER TO psm;


CREATE TABLE request_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE request_types OWNER TO psm;


CREATE TABLE required_field_types (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE required_field_types OWNER TO psm;


CREATE TABLE required_fld (
    code character varying(2) NOT NULL,
    description character varying(255),
    required_fld_type_id character varying(2)
);


ALTER TABLE required_fld OWNER TO psm;


CREATE TABLE risk_levels (
    code character varying(2) NOT NULL,
    sort_index integer NOT NULL,
    description text
);


ALTER TABLE risk_levels OWNER TO psm;


CREATE TABLE roles (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE roles OWNER TO psm;


CREATE TABLE screening_schedules (
    screening_schedule_id bigint NOT NULL,
    upcoming_screening_date date,
    interval_type text,
    interval_value bigint NOT NULL
);


ALTER TABLE screening_schedules OWNER TO psm;


CREATE TABLE service_assurance_ext_types (
    code character varying(2) NOT NULL,
    description text,
    service_assurance_code text
);


ALTER TABLE service_assurance_ext_types OWNER TO psm;


CREATE TABLE service_assurance_types (
    code character varying(2) NOT NULL,
    description text,
    patient_indicator text
);


ALTER TABLE service_assurance_types OWNER TO psm;


CREATE TABLE service_categories (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE service_categories OWNER TO psm;


CREATE TABLE sessioninfo (
    id integer NOT NULL,
    lastmodificationdate timestamp with time zone,
    rulesbytearray oid,
    startdate timestamp with time zone,
    optlock integer
);


ALTER TABLE sessioninfo OWNER TO psm;


CREATE SEQUENCE sessioninfo_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sessioninfo_id_seq OWNER TO psm;


CREATE TABLE specialty_types (
    code character varying(2) NOT NULL,
    description text,
    sub_category character varying(2)
);


ALTER TABLE specialty_types OWNER TO psm;


CREATE TABLE states (
    code character varying(2) NOT NULL,
    description text
);


ALTER TABLE states OWNER TO psm;


CREATE TABLE subtasksstrategy (
    id bigint NOT NULL,
    dtype text NOT NULL,
    name text,
    task_id bigint
);


ALTER TABLE subtasksstrategy OWNER TO psm;


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


CREATE TABLE task_comment (
    id bigint NOT NULL,
    addedat timestamp with time zone,
    text text,
    addedby_id text,
    taskdata_comments_id bigint
);


ALTER TABLE task_comment OWNER TO psm;


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


CREATE SEQUENCE workiteminfo_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE workiteminfo_id_seq OWNER TO psm;


SELECT pg_catalog.lo_create('44753');


ALTER LARGE OBJECT 44753 OWNER TO psm;


SELECT pg_catalog.lo_create('44754');


ALTER LARGE OBJECT 44754 OWNER TO psm;


SELECT pg_catalog.lo_create('44755');


ALTER LARGE OBJECT 44755 OWNER TO psm;


SELECT pg_catalog.lo_create('44756');


ALTER LARGE OBJECT 44756 OWNER TO psm;


SELECT pg_catalog.lo_create('44757');


ALTER LARGE OBJECT 44757 OWNER TO psm;


SELECT pg_catalog.lo_create('44758');


ALTER LARGE OBJECT 44758 OWNER TO psm;


SELECT pg_catalog.lo_create('44759');


ALTER LARGE OBJECT 44759 OWNER TO psm;


SELECT pg_catalog.lo_create('44760');


ALTER LARGE OBJECT 44760 OWNER TO psm;


SELECT pg_catalog.lo_create('52440');


ALTER LARGE OBJECT 52440 OWNER TO psm;


SELECT pg_catalog.lo_create('52441');


ALTER LARGE OBJECT 52441 OWNER TO psm;


SELECT pg_catalog.lo_create('52442');


ALTER LARGE OBJECT 52442 OWNER TO psm;


SELECT pg_catalog.lo_create('52443');


ALTER LARGE OBJECT 52443 OWNER TO psm;


SELECT pg_catalog.lo_create('52444');


ALTER LARGE OBJECT 52444 OWNER TO psm;


SELECT pg_catalog.lo_create('52445');


ALTER LARGE OBJECT 52445 OWNER TO psm;


SELECT pg_catalog.lo_create('52446');


ALTER LARGE OBJECT 52446 OWNER TO psm;


SELECT pg_catalog.lo_create('52447');


ALTER LARGE OBJECT 52447 OWNER TO psm;











INSERT INTO agreement_documents (agreement_document_id, type, title, version, body, created_by, created_at) VALUES (1, '01', 'Agreement (1)', 0, 'This is the content of the agreement.', 'system', '2017-08-02 11:20:25.461288-05');
INSERT INTO agreement_documents (agreement_document_id, type, title, version, body, created_by, created_at) VALUES (2, '02', 'Addendum (2)', 0, 'This is the content of the addendum.', 'system', '2017-08-02 11:20:25.461288-05');






SELECT pg_catalog.setval('attachment_id_seq', 1, false);












INSERT INTO beneficial_owner_types (code, description, owner_type) VALUES ('01', 'Subcontractor', 'A');
INSERT INTO beneficial_owner_types (code, description, owner_type) VALUES ('02', 'Managing Employee', 'P');
INSERT INTO beneficial_owner_types (code, description, owner_type) VALUES ('03', 'Owner - 5% or more of Ownership Interest', 'A');
INSERT INTO beneficial_owner_types (code, description, owner_type) VALUES ('04', 'Board Member or Officer', 'P');
INSERT INTO beneficial_owner_types (code, description, owner_type) VALUES ('05', 'Program Manager', 'P');
INSERT INTO beneficial_owner_types (code, description, owner_type) VALUES ('06', 'Managing Director', 'P');
INSERT INTO beneficial_owner_types (code, description, owner_type) VALUES ('99', 'Other', 'A');






SELECT pg_catalog.setval('booleanexpr_id_seq', 1, false);






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



INSERT INTO cms_authentication (username, password) VALUES ('admin', '{SHA}0DPiKuNIrrVmD8IUCuw1hQxNqZc=');
INSERT INTO cms_authentication (username, password) VALUES ('p1', '{SHA}t49XZhHsBvlq88plTCIXKl10bEA=');
INSERT INTO cms_authentication (username, password) VALUES ('system', '{SHA}MX8edh8vqo2ngaR2K53MLFytIJo=');



INSERT INTO cms_user (user_id, username, first_name, middle_name, last_name, phone_number, email, status, role_code) VALUES ('p1', 'p1', 'p1', NULL, 'p1', NULL, 'p1@example.com', 'ACTIVE', 'R1');
INSERT INTO cms_user (user_id, username, first_name, middle_name, last_name, phone_number, email, status, role_code) VALUES ('ADMIN', 'admin', 'admin', NULL, 'admin', NULL, 'admin@example.com', 'ACTIVE', 'R3');
INSERT INTO cms_user (user_id, username, first_name, middle_name, last_name, phone_number, email, status, role_code) VALUES ('SYSTEM', 'system', 'system', NULL, 'system', NULL, 'system@example.com', 'ACTIVE', 'R4');



SELECT pg_catalog.setval('comment_id_seq', 1, false);









SELECT pg_catalog.setval('content_id_seq', 1, false);



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






SELECT pg_catalog.setval('deadline_id_seq', 1, false);



INSERT INTO degrees (code, description) VALUES ('D1', 'MASTERS');
INSERT INTO degrees (code, description) VALUES ('D2', 'DOCTORATE');















SELECT pg_catalog.setval('emailnotifhead_id_seq', 1, false);



INSERT INTO enrollment_statuses (code, description) VALUES ('01', 'Draft');
INSERT INTO enrollment_statuses (code, description) VALUES ('02', 'Pending');
INSERT INTO enrollment_statuses (code, description) VALUES ('03', 'Rejected');
INSERT INTO enrollment_statuses (code, description) VALUES ('04', 'Approved');









INSERT INTO entity_structure_types (code, description) VALUES ('01', 'Sole Proprietorship');
INSERT INTO entity_structure_types (code, description) VALUES ('02', 'Partnership');
INSERT INTO entity_structure_types (code, description) VALUES ('03', 'Corporation');
INSERT INTO entity_structure_types (code, description) VALUES ('04', 'Non-Profit');
INSERT INTO entity_structure_types (code, description) VALUES ('05', 'Hospital Based');
INSERT INTO entity_structure_types (code, description) VALUES ('06', 'State');
INSERT INTO entity_structure_types (code, description) VALUES ('07', 'Public');
INSERT INTO entity_structure_types (code, description) VALUES ('08', 'Professional Association');
INSERT INTO entity_structure_types (code, description) VALUES ('99', 'Other');






SELECT pg_catalog.setval('escalation_id_seq', 1, false);
























SELECT pg_catalog.setval('hibernate_sequence', 1, false);






SELECT pg_catalog.setval('i18ntext_id_seq', 1, false);



INSERT INTO issuing_boards (code, description) VALUES ('B1', 'AANA');
INSERT INTO issuing_boards (code, description) VALUES ('B2', 'NARM');
INSERT INTO issuing_boards (code, description) VALUES ('B3', 'ANCC');
INSERT INTO issuing_boards (code, description) VALUES ('B4', 'AOTA');
INSERT INTO issuing_boards (code, description) VALUES ('B5', 'ADA');
INSERT INTO issuing_boards (code, description) VALUES ('B6', 'ABMS');
INSERT INTO issuing_boards (code, description) VALUES ('B7', 'ABPS');






INSERT INTO license_statuses (code, description) VALUES ('01', 'Active');
INSERT INTO license_statuses (code, description) VALUES ('02', 'Suspended');
INSERT INTO license_statuses (code, description) VALUES ('03', 'Expired');



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


















SELECT pg_catalog.setval('notification_id_seq', 1, false);






INSERT INTO organizationalentity (id, dtype) VALUES ('Administrator', 'User');
INSERT INTO organizationalentity (id, dtype) VALUES ('Service Administrator', 'Group');
INSERT INTO organizationalentity (id, dtype) VALUES ('Service Agent', 'Group');
INSERT INTO organizationalentity (id, dtype) VALUES ('System Administrator', 'Group');















INSERT INTO pay_to_provider_types (code, description) VALUES ('01', 'Claim');
INSERT INTO pay_to_provider_types (code, description) VALUES ('02', 'ERA');
INSERT INTO pay_to_provider_types (code, description) VALUES ('03', 'Both');




































INSERT INTO profile_statuses (code, description) VALUES ('01', 'Active');
INSERT INTO profile_statuses (code, description) VALUES ('02', 'Suspended');
INSERT INTO profile_statuses (code, description) VALUES ('03', 'Expired');



























INSERT INTO provider_type_agreement_documents (provider_type_code, agreement_document_id) VALUES ('18', 1);



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



INSERT INTO qualified_professional_types (code, description) VALUES ('01', 'Registered Nurse');
INSERT INTO qualified_professional_types (code, description) VALUES ('02', 'Licensed Social Worker');
INSERT INTO qualified_professional_types (code, description) VALUES ('03', 'Mental Health Professional');
INSERT INTO qualified_professional_types (code, description) VALUES ('04', 'Qualified Developmental Disability Specialist');






SELECT pg_catalog.setval('reassignment_id_seq', 1, false);






INSERT INTO relationship_types (code, description) VALUES ('01', 'Spouse');
INSERT INTO relationship_types (code, description) VALUES ('02', 'Child');
INSERT INTO relationship_types (code, description) VALUES ('03', 'Parent');
INSERT INTO relationship_types (code, description) VALUES ('04', 'Sibling');



INSERT INTO request_types (code, description) VALUES ('01', 'Import Profile');
INSERT INTO request_types (code, description) VALUES ('02', 'Enrollment');
INSERT INTO request_types (code, description) VALUES ('03', 'Renewal');
INSERT INTO request_types (code, description) VALUES ('04', 'Suspend');
INSERT INTO request_types (code, description) VALUES ('05', 'Update');



INSERT INTO required_field_types (code, description) VALUES ('01', 'Required');
INSERT INTO required_field_types (code, description) VALUES ('02', 'Optional');






INSERT INTO risk_levels (code, sort_index, description) VALUES ('01', 1, 'Limited');
INSERT INTO risk_levels (code, sort_index, description) VALUES ('02', 2, 'Moderate');
INSERT INTO risk_levels (code, sort_index, description) VALUES ('03', 3, 'High');



INSERT INTO roles (code, description) VALUES ('R1', 'Provider');
INSERT INTO roles (code, description) VALUES ('R2', 'Service Agent');
INSERT INTO roles (code, description) VALUES ('R3', 'Service Administrator');
INSERT INTO roles (code, description) VALUES ('R4', 'System Administrator');



INSERT INTO screening_schedules (screening_schedule_id, upcoming_screening_date, interval_type, interval_value) VALUES (1, NULL, NULL, 0);









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






SELECT pg_catalog.setval('sessioninfo_id_seq', 1, false);



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















SELECT pg_catalog.setval('workiteminfo_id_seq', 1, false);



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

COMMIT;

SET search_path = public, pg_catalog;


ALTER TABLE ONLY accepted_agreements
    ADD CONSTRAINT accepted_agreements_pkey PRIMARY KEY (accepted_agreement_id);



ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (address_id);



ALTER TABLE ONLY affiliations
    ADD CONSTRAINT affiliations_pkey PRIMARY KEY (affiliation_id);



ALTER TABLE ONLY agreement_documents
    ADD CONSTRAINT agreement_documents_pkey PRIMARY KEY (agreement_document_id);



ALTER TABLE ONLY attachment
    ADD CONSTRAINT attachment_pkey PRIMARY KEY (id);



ALTER TABLE ONLY audit_details
    ADD CONSTRAINT audit_details_pkey PRIMARY KEY (audit_detail_id);



ALTER TABLE ONLY audit_records
    ADD CONSTRAINT audit_records_pkey PRIMARY KEY (audit_record_id);



ALTER TABLE ONLY beneficial_owner
    ADD CONSTRAINT beneficial_owner_pkey PRIMARY KEY (beneficial_owner_id);



ALTER TABLE ONLY beneficial_owner_types
    ADD CONSTRAINT beneficial_owner_types_description_key UNIQUE (description);



ALTER TABLE ONLY beneficial_owner_types
    ADD CONSTRAINT beneficial_owner_types_pkey PRIMARY KEY (code);



ALTER TABLE ONLY binary_contents
    ADD CONSTRAINT binary_contents_pkey PRIMARY KEY (binary_content_id);



ALTER TABLE ONLY booleanexpression
    ADD CONSTRAINT booleanexpression_pkey PRIMARY KEY (id);



ALTER TABLE ONLY categories_of_service
    ADD CONSTRAINT categories_of_service_description_key UNIQUE (description);



ALTER TABLE ONLY categories_of_service
    ADD CONSTRAINT categories_of_service_pkey PRIMARY KEY (code);



ALTER TABLE ONLY cms_authentication
    ADD CONSTRAINT cms_authentication_pkey PRIMARY KEY (username);



ALTER TABLE ONLY cms_user
    ADD CONSTRAINT cms_user_pkey PRIMARY KEY (user_id);



ALTER TABLE ONLY cms_user
    ADD CONSTRAINT cms_user_username_key UNIQUE (username);



ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (contact_id);



ALTER TABLE ONLY content
    ADD CONSTRAINT content_pkey PRIMARY KEY (id);



ALTER TABLE ONLY counties
    ADD CONSTRAINT counties_description_key UNIQUE (description);



ALTER TABLE ONLY counties
    ADD CONSTRAINT counties_pkey PRIMARY KEY (code);



ALTER TABLE ONLY deadline
    ADD CONSTRAINT deadline_pkey PRIMARY KEY (id);



ALTER TABLE ONLY degrees
    ADD CONSTRAINT degrees_description_key UNIQUE (description);



ALTER TABLE ONLY degrees
    ADD CONSTRAINT degrees_pkey PRIMARY KEY (code);



ALTER TABLE ONLY delegation_delegates
    ADD CONSTRAINT delegation_delegates_pkey PRIMARY KEY (task_id, entity_id);



ALTER TABLE ONLY designated_contacts
    ADD CONSTRAINT designated_contacts_pkey PRIMARY KEY (designated_contact_id);



ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (document_id);



ALTER TABLE ONLY email_header
    ADD CONSTRAINT email_header_pkey PRIMARY KEY (id);



ALTER TABLE ONLY enrollment_statuses
    ADD CONSTRAINT enrollment_statuses_description_key UNIQUE (description);



ALTER TABLE ONLY enrollment_statuses
    ADD CONSTRAINT enrollment_statuses_pkey PRIMARY KEY (code);



ALTER TABLE ONLY enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (enrollment_id);



ALTER TABLE ONLY entities
    ADD CONSTRAINT entities_pkey PRIMARY KEY (entity_id);



ALTER TABLE ONLY entity_structure_types
    ADD CONSTRAINT entity_structure_types_description_key UNIQUE (description);



ALTER TABLE ONLY entity_structure_types
    ADD CONSTRAINT entity_structure_types_pkey PRIMARY KEY (code);



ALTER TABLE ONLY escalation
    ADD CONSTRAINT escalation_pkey PRIMARY KEY (id);



ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);



ALTER TABLE ONLY external_account_link
    ADD CONSTRAINT external_account_link_pkey PRIMARY KEY (external_account_link_id);



ALTER TABLE ONLY external_account_links
    ADD CONSTRAINT external_account_links_pkey PRIMARY KEY (external_account_link_id);



ALTER TABLE ONLY external_profile_link
    ADD CONSTRAINT external_profile_link_pkey PRIMARY KEY (external_profile_link_id);



ALTER TABLE ONLY external_profile_links
    ADD CONSTRAINT external_profile_links_pkey PRIMARY KEY (external_profile_link_id);



ALTER TABLE ONLY help_items
    ADD CONSTRAINT help_items_pkey PRIMARY KEY (help_item_id);



ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_pkey PRIMARY KEY (id);



ALTER TABLE ONLY issuing_boards
    ADD CONSTRAINT issuing_boards_description_key UNIQUE (description);



ALTER TABLE ONLY issuing_boards
    ADD CONSTRAINT issuing_boards_pkey PRIMARY KEY (code);



ALTER TABLE ONLY legacy_mapping
    ADD CONSTRAINT legacy_mapping_pkey PRIMARY KEY (legacy_mapping_id);



ALTER TABLE ONLY license_statuses
    ADD CONSTRAINT license_statuses_description_key UNIQUE (description);



ALTER TABLE ONLY license_statuses
    ADD CONSTRAINT license_statuses_pkey PRIMARY KEY (code);



ALTER TABLE ONLY license_types
    ADD CONSTRAINT license_types_description_key UNIQUE (description);



ALTER TABLE ONLY license_types
    ADD CONSTRAINT license_types_pkey PRIMARY KEY (code);



ALTER TABLE ONLY licenses
    ADD CONSTRAINT licenses_pkey PRIMARY KEY (license_id);



ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (note_id);



ALTER TABLE ONLY notification_bas
    ADD CONSTRAINT notification_bas_pkey PRIMARY KEY (task_id, entity_id);



ALTER TABLE ONLY notification_email_header
    ADD CONSTRAINT notification_email_header_emailheaders_id_key UNIQUE (emailheaders_id);



ALTER TABLE ONLY notification_email_header
    ADD CONSTRAINT notification_email_header_pkey PRIMARY KEY (emailnotification_id, mapkey);



ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);



ALTER TABLE ONLY notification_recipients
    ADD CONSTRAINT notification_recipients_pkey PRIMARY KEY (task_id, entity_id);



ALTER TABLE ONLY organizationalentity
    ADD CONSTRAINT organizationalentity_pkey PRIMARY KEY (id);



ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (entity_id);



ALTER TABLE ONLY owner_assets
    ADD CONSTRAINT owner_assets_pkey PRIMARY KEY (owner_asset_id);



ALTER TABLE ONLY ownership_info
    ADD CONSTRAINT ownership_info_pkey PRIMARY KEY (ownership_info_id);



ALTER TABLE ONLY ownership_types
    ADD CONSTRAINT ownership_types_description_key UNIQUE (description);



ALTER TABLE ONLY ownership_types
    ADD CONSTRAINT ownership_types_pkey PRIMARY KEY (code);



ALTER TABLE ONLY pay_to_provider_types
    ADD CONSTRAINT pay_to_provider_types_description_key UNIQUE (description);



ALTER TABLE ONLY pay_to_provider_types
    ADD CONSTRAINT pay_to_provider_types_pkey PRIMARY KEY (code);



ALTER TABLE ONLY pay_to_providers
    ADD CONSTRAINT pay_to_providers_pkey PRIMARY KEY (pay_to_providers_id);



ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (entity_id);



ALTER TABLE ONLY peopleassignments_bas
    ADD CONSTRAINT peopleassignments_bas_pkey PRIMARY KEY (task_id, entity_id);



ALTER TABLE ONLY peopleassignments_exclowners
    ADD CONSTRAINT peopleassignments_exclowners_pkey PRIMARY KEY (task_id, entity_id);



ALTER TABLE ONLY peopleassignments_potowners
    ADD CONSTRAINT peopleassignments_potowners_pkey PRIMARY KEY (task_id, entity_id);



ALTER TABLE ONLY peopleassignments_recipients
    ADD CONSTRAINT peopleassignments_recipients_pkey PRIMARY KEY (task_id, entity_id);



ALTER TABLE ONLY peopleassignments_stakeholders
    ADD CONSTRAINT peopleassignments_stakeholders_pkey PRIMARY KEY (task_id, entity_id);



ALTER TABLE ONLY persistent_logins
    ADD CONSTRAINT persistent_logins_pkey PRIMARY KEY (series);



ALTER TABLE ONLY processinstanceinfo
    ADD CONSTRAINT processinstanceinfo_pkey PRIMARY KEY (instanceid);



ALTER TABLE ONLY profile_assured_svc_xref
    ADD CONSTRAINT profile_assured_svc_xref_pkey PRIMARY KEY (profile_assured_svc_id);



ALTER TABLE ONLY profile_statuses
    ADD CONSTRAINT profile_statuses_description_key UNIQUE (description);



ALTER TABLE ONLY profile_statuses
    ADD CONSTRAINT profile_statuses_pkey PRIMARY KEY (code);



ALTER TABLE ONLY provider_category_of_service_approvals
    ADD CONSTRAINT provider_category_of_service_approvals_pkey PRIMARY KEY (provider_category_of_service_approval_id);



ALTER TABLE ONLY provider_cos_xref
    ADD CONSTRAINT provider_cos_xref_pkey PRIMARY KEY (provider_cos_id);



ALTER TABLE ONLY provider_profiles
    ADD CONSTRAINT provider_profiles_pkey PRIMARY KEY (control_no);



ALTER TABLE ONLY provider_services
    ADD CONSTRAINT provider_services_pkey PRIMARY KEY (provider_service_id);



ALTER TABLE ONLY provider_statements
    ADD CONSTRAINT provider_statements_pkey PRIMARY KEY (provider_statement_id);



ALTER TABLE ONLY provider_svcs
    ADD CONSTRAINT provider_svcs_pkey PRIMARY KEY (provider_svcs_id);



ALTER TABLE ONLY provider_type_agreement_documents
    ADD CONSTRAINT provider_type_agreement_documents_pkey PRIMARY KEY (provider_type_code, agreement_document_id);



ALTER TABLE ONLY provider_type_license_types
    ADD CONSTRAINT provider_type_license_types_pkey PRIMARY KEY (provider_type_code, license_type_code);



ALTER TABLE ONLY provider_type_settings
    ADD CONSTRAINT provider_type_settings_pkey PRIMARY KEY (provider_type_setting_id);



ALTER TABLE ONLY provider_types
    ADD CONSTRAINT provider_types_description_key UNIQUE (description);



ALTER TABLE ONLY provider_types
    ADD CONSTRAINT provider_types_pkey PRIMARY KEY (code);



ALTER TABLE ONLY qualified_professional_types
    ADD CONSTRAINT qualified_professional_types_description_key UNIQUE (description);



ALTER TABLE ONLY qualified_professional_types
    ADD CONSTRAINT qualified_professional_types_pkey PRIMARY KEY (code);



ALTER TABLE ONLY reassignment
    ADD CONSTRAINT reassignment_pkey PRIMARY KEY (id);



ALTER TABLE ONLY relationship_types
    ADD CONSTRAINT relationship_types_description_key UNIQUE (description);



ALTER TABLE ONLY relationship_types
    ADD CONSTRAINT relationship_types_pkey PRIMARY KEY (code);



ALTER TABLE ONLY request_types
    ADD CONSTRAINT request_types_description_key UNIQUE (description);



ALTER TABLE ONLY request_types
    ADD CONSTRAINT request_types_pkey PRIMARY KEY (code);



ALTER TABLE ONLY required_field_types
    ADD CONSTRAINT required_field_types_description_key UNIQUE (description);



ALTER TABLE ONLY required_field_types
    ADD CONSTRAINT required_field_types_pkey PRIMARY KEY (code);



ALTER TABLE ONLY required_fld
    ADD CONSTRAINT required_fld_pkey PRIMARY KEY (code);



ALTER TABLE ONLY risk_levels
    ADD CONSTRAINT risk_levels_description_key UNIQUE (description);



ALTER TABLE ONLY risk_levels
    ADD CONSTRAINT risk_levels_pkey PRIMARY KEY (code);



ALTER TABLE ONLY risk_levels
    ADD CONSTRAINT risk_levels_sort_index_key UNIQUE (sort_index);



ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_description_key UNIQUE (description);



ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (code);



ALTER TABLE ONLY screening_schedules
    ADD CONSTRAINT screening_schedules_pkey PRIMARY KEY (screening_schedule_id);



ALTER TABLE ONLY service_assurance_ext_types
    ADD CONSTRAINT service_assurance_ext_types_description_key UNIQUE (description);



ALTER TABLE ONLY service_assurance_ext_types
    ADD CONSTRAINT service_assurance_ext_types_pkey PRIMARY KEY (code);



ALTER TABLE ONLY service_assurance_types
    ADD CONSTRAINT service_assurance_types_description_key UNIQUE (description);



ALTER TABLE ONLY service_assurance_types
    ADD CONSTRAINT service_assurance_types_pkey PRIMARY KEY (code);



ALTER TABLE ONLY service_categories
    ADD CONSTRAINT service_categories_description_key UNIQUE (description);



ALTER TABLE ONLY service_categories
    ADD CONSTRAINT service_categories_pkey PRIMARY KEY (code);



ALTER TABLE ONLY sessioninfo
    ADD CONSTRAINT sessioninfo_pkey PRIMARY KEY (id);



ALTER TABLE ONLY specialty_types
    ADD CONSTRAINT specialty_types_description_key UNIQUE (description);



ALTER TABLE ONLY specialty_types
    ADD CONSTRAINT specialty_types_pkey PRIMARY KEY (code);



ALTER TABLE ONLY states
    ADD CONSTRAINT states_description_key UNIQUE (description);



ALTER TABLE ONLY states
    ADD CONSTRAINT states_pkey PRIMARY KEY (code);



ALTER TABLE ONLY subtasksstrategy
    ADD CONSTRAINT subtasksstrategy_pkey PRIMARY KEY (id);



ALTER TABLE ONLY task_comment
    ADD CONSTRAINT task_comment_pkey PRIMARY KEY (id);



ALTER TABLE ONLY task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id);



ALTER TABLE ONLY workiteminfo
    ADD CONSTRAINT workiteminfo_pkey PRIMARY KEY (workitemid);



ALTER TABLE ONLY accepted_agreements
    ADD CONSTRAINT accepted_agreements_agreement_document_id_fkey FOREIGN KEY (agreement_document_id) REFERENCES agreement_documents(agreement_document_id);



ALTER TABLE ONLY affiliations
    ADD CONSTRAINT affiliations_qualified_professional_type_code_fkey FOREIGN KEY (qualified_professional_type_code) REFERENCES qualified_professional_types(code);



ALTER TABLE ONLY attachment
    ADD CONSTRAINT attachment_attachedby_id_fkey FOREIGN KEY (attachedby_id) REFERENCES organizationalentity(id);



ALTER TABLE ONLY attachment
    ADD CONSTRAINT attachment_taskdata_attachments_id_fkey FOREIGN KEY (taskdata_attachments_id) REFERENCES task(id);



ALTER TABLE ONLY audit_details
    ADD CONSTRAINT audit_details_audit_record_id_fkey FOREIGN KEY (audit_record_id) REFERENCES audit_records(audit_record_id);



ALTER TABLE ONLY beneficial_owner
    ADD CONSTRAINT beneficial_owner_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(address_id);



ALTER TABLE ONLY beneficial_owner
    ADD CONSTRAINT beneficial_owner_ben_type_cd_fkey FOREIGN KEY (ben_type_cd) REFERENCES beneficial_owner_types(code);



ALTER TABLE ONLY beneficial_owner
    ADD CONSTRAINT beneficial_owner_oth_provider_address_id_fkey FOREIGN KEY (oth_provider_address_id) REFERENCES addresses(address_id);



ALTER TABLE ONLY beneficial_owner
    ADD CONSTRAINT beneficial_owner_ownership_info_id_fkey FOREIGN KEY (ownership_info_id) REFERENCES ownership_info(ownership_info_id);



ALTER TABLE ONLY beneficial_owner
    ADD CONSTRAINT beneficial_owner_relationship_type_code_fkey FOREIGN KEY (relationship_type_code) REFERENCES relationship_types(code);



ALTER TABLE ONLY booleanexpression
    ADD CONSTRAINT booleanexpression_escalation_constraints_id_fkey FOREIGN KEY (escalation_constraints_id) REFERENCES escalation(id);



ALTER TABLE ONLY cms_user
    ADD CONSTRAINT cms_user_role_code_fkey FOREIGN KEY (role_code) REFERENCES roles(code);



ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(address_id);



ALTER TABLE ONLY deadline
    ADD CONSTRAINT deadline_deadlines_enddeadline_id_fkey FOREIGN KEY (deadlines_enddeadline_id) REFERENCES task(id);



ALTER TABLE ONLY deadline
    ADD CONSTRAINT deadline_deadlines_startdeadline_id_fkey FOREIGN KEY (deadlines_startdeadline_id) REFERENCES task(id);



ALTER TABLE ONLY delegation_delegates
    ADD CONSTRAINT delegation_delegates_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);



ALTER TABLE ONLY delegation_delegates
    ADD CONSTRAINT delegation_delegates_task_id_fkey FOREIGN KEY (task_id) REFERENCES task(id);



ALTER TABLE ONLY designated_contacts
    ADD CONSTRAINT designated_contacts_person_id_fkey FOREIGN KEY (person_id) REFERENCES people(entity_id);



ALTER TABLE ONLY enrollments
    ADD CONSTRAINT enrollments_enrollment_status_code_fkey FOREIGN KEY (enrollment_status_code) REFERENCES enrollment_statuses(code);



ALTER TABLE ONLY enrollments
    ADD CONSTRAINT enrollments_request_type_code_fkey FOREIGN KEY (request_type_code) REFERENCES request_types(code);



ALTER TABLE ONLY entities
    ADD CONSTRAINT entities_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES contacts(contact_id);



ALTER TABLE ONLY entities
    ADD CONSTRAINT entities_provider_type_code_fkey FOREIGN KEY (provider_type_code) REFERENCES provider_types(code);



ALTER TABLE ONLY escalation
    ADD CONSTRAINT escalation_deadline_escalation_id_fkey FOREIGN KEY (deadline_escalation_id) REFERENCES deadline(id);



ALTER TABLE ONLY eventtypes
    ADD CONSTRAINT eventtypes_instanceid_fkey FOREIGN KEY (instanceid) REFERENCES processinstanceinfo(instanceid);



ALTER TABLE ONLY provider_cos
    ADD CONSTRAINT fk2ciqibe0u9h2cmyeut8q5alir FOREIGN KEY (provider_cos_id) REFERENCES provider_cos_xref(provider_cos_id);



ALTER TABLE ONLY required_fld
    ADD CONSTRAINT fk3pj5itnxvpohvq0q8skilyal0 FOREIGN KEY (required_fld_type_id) REFERENCES required_fld(code);



ALTER TABLE ONLY profile_assured_ext_svcs
    ADD CONSTRAINT fknpq45dvbn0v9qxjrp3ccs81uy FOREIGN KEY (profile_assured_svc_id) REFERENCES profile_assured_svc_xref(profile_assured_svc_id);



ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_deadline_documentation_id_fkey FOREIGN KEY (deadline_documentation_id) REFERENCES deadline(id);



ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_notification_descriptions_id_fkey FOREIGN KEY (notification_descriptions_id) REFERENCES notification(id);



ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_notification_documentation_id_fkey FOREIGN KEY (notification_documentation_id) REFERENCES notification(id);



ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_notification_names_id_fkey FOREIGN KEY (notification_names_id) REFERENCES notification(id);



ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_notification_subjects_id_fkey FOREIGN KEY (notification_subjects_id) REFERENCES notification(id);



ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_reassignment_documentation_id_fkey FOREIGN KEY (reassignment_documentation_id) REFERENCES reassignment(id);



ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_task_descriptions_id_fkey FOREIGN KEY (task_descriptions_id) REFERENCES task(id);



ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_task_names_id_fkey FOREIGN KEY (task_names_id) REFERENCES task(id);



ALTER TABLE ONLY i18ntext
    ADD CONSTRAINT i18ntext_task_subjects_id_fkey FOREIGN KEY (task_subjects_id) REFERENCES task(id);



ALTER TABLE ONLY licenses
    ADD CONSTRAINT licenses_issuing_board_code_fkey FOREIGN KEY (issuing_board_code) REFERENCES issuing_boards(code);



ALTER TABLE ONLY licenses
    ADD CONSTRAINT licenses_license_status_code_fkey FOREIGN KEY (license_status_code) REFERENCES license_statuses(code);



ALTER TABLE ONLY licenses
    ADD CONSTRAINT licenses_license_type_code_fkey FOREIGN KEY (license_type_code) REFERENCES license_types(code);



ALTER TABLE ONLY licenses
    ADD CONSTRAINT licenses_specialty_type_code_fkey FOREIGN KEY (specialty_type_code) REFERENCES specialty_types(code);



ALTER TABLE ONLY notification_bas
    ADD CONSTRAINT notification_bas_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);



ALTER TABLE ONLY notification_bas
    ADD CONSTRAINT notification_bas_task_id_fkey FOREIGN KEY (task_id) REFERENCES notification(id);



ALTER TABLE ONLY notification_email_header
    ADD CONSTRAINT notification_email_header_emailheaders_id_fkey FOREIGN KEY (emailheaders_id) REFERENCES email_header(id);



ALTER TABLE ONLY notification_email_header
    ADD CONSTRAINT notification_email_header_emailnotification_id_fkey FOREIGN KEY (emailnotification_id) REFERENCES notification(id);



ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_escalation_notifications_id_fkey FOREIGN KEY (escalation_notifications_id) REFERENCES escalation(id);



ALTER TABLE ONLY notification_recipients
    ADD CONSTRAINT notification_recipients_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);



ALTER TABLE ONLY notification_recipients
    ADD CONSTRAINT notification_recipients_task_id_fkey FOREIGN KEY (task_id) REFERENCES notification(id);



ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_billing_address_id_fkey FOREIGN KEY (billing_address_id) REFERENCES addresses(address_id);



ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES entities(entity_id);



ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_reimbursement_address_id_fkey FOREIGN KEY (reimbursement_address_id) REFERENCES addresses(address_id);



ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_ten99_address_id_fkey FOREIGN KEY (ten99_address_id) REFERENCES addresses(address_id);



ALTER TABLE ONLY owner_assets
    ADD CONSTRAINT owner_assets_ownership_type_code_fkey FOREIGN KEY (ownership_type_code) REFERENCES ownership_types(code);



ALTER TABLE ONLY ownership_info
    ADD CONSTRAINT ownership_info_entity_structure_subtype_code_fkey FOREIGN KEY (entity_structure_subtype_code) REFERENCES entity_structure_types(code);



ALTER TABLE ONLY ownership_info
    ADD CONSTRAINT ownership_info_entity_structure_type_code_fkey FOREIGN KEY (entity_structure_type_code) REFERENCES entity_structure_types(code);



ALTER TABLE ONLY pay_to_providers
    ADD CONSTRAINT pay_to_providers_pay_to_type_code_fkey FOREIGN KEY (pay_to_type_code) REFERENCES pay_to_provider_types(code);



ALTER TABLE ONLY people
    ADD CONSTRAINT people_degree_code_fkey FOREIGN KEY (degree_code) REFERENCES degrees(code);



ALTER TABLE ONLY people
    ADD CONSTRAINT people_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES entities(entity_id);



ALTER TABLE ONLY peopleassignments_bas
    ADD CONSTRAINT peopleassignments_bas_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);



ALTER TABLE ONLY peopleassignments_bas
    ADD CONSTRAINT peopleassignments_bas_task_id_fkey FOREIGN KEY (task_id) REFERENCES task(id);



ALTER TABLE ONLY peopleassignments_exclowners
    ADD CONSTRAINT peopleassignments_exclowners_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);



ALTER TABLE ONLY peopleassignments_exclowners
    ADD CONSTRAINT peopleassignments_exclowners_task_id_fkey FOREIGN KEY (task_id) REFERENCES task(id);



ALTER TABLE ONLY peopleassignments_potowners
    ADD CONSTRAINT peopleassignments_potowners_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);



ALTER TABLE ONLY peopleassignments_potowners
    ADD CONSTRAINT peopleassignments_potowners_task_id_fkey FOREIGN KEY (task_id) REFERENCES task(id);



ALTER TABLE ONLY peopleassignments_recipients
    ADD CONSTRAINT peopleassignments_recipients_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);



ALTER TABLE ONLY peopleassignments_recipients
    ADD CONSTRAINT peopleassignments_recipients_task_id_fkey FOREIGN KEY (task_id) REFERENCES task(id);



ALTER TABLE ONLY peopleassignments_stakeholders
    ADD CONSTRAINT peopleassignments_stakeholders_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);



ALTER TABLE ONLY peopleassignments_stakeholders
    ADD CONSTRAINT peopleassignments_stakeholders_task_id_fkey FOREIGN KEY (task_id) REFERENCES task(id);



ALTER TABLE ONLY provider_approved_categories_of_service
    ADD CONSTRAINT provider_approved_categories__provider_category_of_service_fkey FOREIGN KEY (provider_category_of_service_approval_id) REFERENCES provider_category_of_service_approvals(provider_category_of_service_approval_id);



ALTER TABLE ONLY provider_approved_categories_of_service
    ADD CONSTRAINT provider_approved_categories_of_s_category_of_service_code_fkey FOREIGN KEY (category_of_service_code) REFERENCES categories_of_service(code);



ALTER TABLE ONLY provider_profiles
    ADD CONSTRAINT provider_profiles_profile_status_code_fkey FOREIGN KEY (profile_status_code) REFERENCES profile_statuses(code);



ALTER TABLE ONLY provider_profiles
    ADD CONSTRAINT provider_profiles_risk_level_code_fkey FOREIGN KEY (risk_level_code) REFERENCES risk_levels(code);



ALTER TABLE ONLY provider_services
    ADD CONSTRAINT provider_services_service_category_code_fkey FOREIGN KEY (service_category_code) REFERENCES service_categories(code);



ALTER TABLE ONLY provider_type_agreement_documents
    ADD CONSTRAINT provider_type_agreement_documents_agreement_document_id_fkey FOREIGN KEY (agreement_document_id) REFERENCES agreement_documents(agreement_document_id);



ALTER TABLE ONLY provider_type_agreement_documents
    ADD CONSTRAINT provider_type_agreement_documents_provider_type_code_fkey FOREIGN KEY (provider_type_code) REFERENCES provider_types(code);



ALTER TABLE ONLY provider_type_license_types
    ADD CONSTRAINT provider_type_license_types_license_type_code_fkey FOREIGN KEY (license_type_code) REFERENCES license_types(code);



ALTER TABLE ONLY provider_type_license_types
    ADD CONSTRAINT provider_type_license_types_provider_type_code_fkey FOREIGN KEY (provider_type_code) REFERENCES provider_types(code);



ALTER TABLE ONLY provider_type_settings
    ADD CONSTRAINT provider_type_settings_provider_type_code_fkey FOREIGN KEY (provider_type_code) REFERENCES provider_types(code);



ALTER TABLE ONLY reassignment
    ADD CONSTRAINT reassignment_escalation_reassignments_id_fkey FOREIGN KEY (escalation_reassignments_id) REFERENCES escalation(id);



ALTER TABLE ONLY reassignment_potentialowners
    ADD CONSTRAINT reassignment_potentialowners_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES organizationalentity(id);



ALTER TABLE ONLY reassignment_potentialowners
    ADD CONSTRAINT reassignment_potentialowners_task_id_fkey FOREIGN KEY (task_id) REFERENCES reassignment(id);



ALTER TABLE ONLY subtasksstrategy
    ADD CONSTRAINT subtasksstrategy_task_id_fkey FOREIGN KEY (task_id) REFERENCES task(id);



ALTER TABLE ONLY task
    ADD CONSTRAINT task_actualowner_id_fkey FOREIGN KEY (actualowner_id) REFERENCES organizationalentity(id);



ALTER TABLE ONLY task_comment
    ADD CONSTRAINT task_comment_addedby_id_fkey FOREIGN KEY (addedby_id) REFERENCES organizationalentity(id);



ALTER TABLE ONLY task_comment
    ADD CONSTRAINT task_comment_taskdata_comments_id_fkey FOREIGN KEY (taskdata_comments_id) REFERENCES task(id);



ALTER TABLE ONLY task
    ADD CONSTRAINT task_createdby_id_fkey FOREIGN KEY (createdby_id) REFERENCES organizationalentity(id);



ALTER TABLE ONLY task
    ADD CONSTRAINT task_taskinitiator_id_fkey FOREIGN KEY (taskinitiator_id) REFERENCES organizationalentity(id);



