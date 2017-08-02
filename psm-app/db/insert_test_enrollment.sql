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
ALTER TABLE ONLY public.task DROP CONSTRAINT task_actualowner_id_fkey;
ALTER TABLE ONLY public.people DROP CONSTRAINT people_entity_id_fkey;
ALTER TABLE ONLY public.people DROP CONSTRAINT people_degree_code_fkey;
ALTER TABLE ONLY public.organizations DROP CONSTRAINT organizations_ten99_address_id_fkey;
ALTER TABLE ONLY public.organizations DROP CONSTRAINT organizations_reimbursement_address_id_fkey;
ALTER TABLE ONLY public.organizations DROP CONSTRAINT organizations_entity_id_fkey;
ALTER TABLE ONLY public.organizations DROP CONSTRAINT organizations_billing_address_id_fkey;
ALTER TABLE ONLY public.eventtypes DROP CONSTRAINT eventtypes_instanceid_fkey;
ALTER TABLE ONLY public.entities DROP CONSTRAINT entities_provider_type_code_fkey;
ALTER TABLE ONLY public.entities DROP CONSTRAINT entities_contact_id_fkey;
ALTER TABLE ONLY public.enrollments DROP CONSTRAINT enrollments_request_type_code_fkey;
ALTER TABLE ONLY public.enrollments DROP CONSTRAINT enrollments_enrollment_status_code_fkey;
ALTER TABLE ONLY public.contacts DROP CONSTRAINT contacts_address_id_fkey;
ALTER TABLE ONLY public.affiliations DROP CONSTRAINT affiliations_qualified_professional_type_code_fkey;
ALTER TABLE ONLY public.workiteminfo DROP CONSTRAINT workiteminfo_pkey;
ALTER TABLE ONLY public.task DROP CONSTRAINT task_pkey;
ALTER TABLE ONLY public.sessioninfo DROP CONSTRAINT sessioninfo_pkey;
ALTER TABLE ONLY public.processinstanceinfo DROP CONSTRAINT processinstanceinfo_pkey;
ALTER TABLE ONLY public.people DROP CONSTRAINT people_pkey;
ALTER TABLE ONLY public.organizations DROP CONSTRAINT organizations_pkey;
ALTER TABLE ONLY public.entities DROP CONSTRAINT entities_pkey;
ALTER TABLE ONLY public.enrollments DROP CONSTRAINT enrollments_pkey;
ALTER TABLE ONLY public.content DROP CONSTRAINT content_pkey;
ALTER TABLE ONLY public.contacts DROP CONSTRAINT contacts_pkey;
ALTER TABLE ONLY public.affiliations DROP CONSTRAINT affiliations_pkey;
ALTER TABLE ONLY public.addresses DROP CONSTRAINT addresses_pkey;
DROP TABLE public.workiteminfo;
DROP TABLE public.task;
DROP TABLE public.sessioninfo;
DROP TABLE public.processinstanceinfo;
DROP TABLE public.people;
DROP TABLE public.organizations;
DROP TABLE public.eventtypes;
DROP TABLE public.entities;
DROP TABLE public.enrollments;
DROP TABLE public.content;
DROP TABLE public.contacts;
DROP TABLE public.affiliations;
DROP TABLE public.addresses;
SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

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
-- Name: eventtypes; Type: TABLE; Schema: public; Owner: psm
--

CREATE TABLE eventtypes (
    instanceid bigint NOT NULL,
    eventtypes text
);


ALTER TABLE eventtypes OWNER TO psm;

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
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO contacts (contact_id, phone_number, fax_number, email, address_id) VALUES (21, '217 777-7777', NULL, NULL, 20);
INSERT INTO contacts (contact_id, phone_number, fax_number, email, address_id) VALUES (25, '121 121-1211', NULL, '', NULL);


--
-- Data for Name: content; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO content (id, content) VALUES (1, 62440);


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
-- Data for Name: eventtypes; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO eventtypes (instanceid, eventtypes) VALUES (18, 'RuleFlowStateEvent-gov.medicaid.process.enrollment');


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO organizations (entity_id, fein, agency_id, billing_same_as_primary, reimbursement_same_as_primary, ten99_same_as_primary, billing_address_id, reimbursement_address_id, ten99_address_id, state_tax_id, fiscal_year_end, remittance_sequence_order, eft_vendor_number) VALUES (24, '12-1212111', NULL, 'Y', NULL, 'Y', 22, NULL, 23, '', NULL, 'PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER', NULL);


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO people (entity_id, prefix, first_name, middle_name, last_name, suffix, ssn, ssn_verified, birth_date, degree_code, degree_award_date) VALUES (26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO people (entity_id, prefix, first_name, middle_name, last_name, suffix, ssn, ssn_verified, birth_date, degree_code, degree_award_date) VALUES (28, NULL, NULL, NULL, NULL, NULL, '121212121', NULL, '1970-01-01', NULL, NULL);


--
-- Data for Name: processinstanceinfo; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO processinstanceinfo (instanceid, id, lastmodificationdate, lastreaddate, processid, processinstancebytearray, startdate, state, optlock) VALUES (18, 18, '2017-08-02 14:21:49.798-05', '2017-08-02 14:21:45.987-05', 'gov.medicaid.process.enrollment', 62441, '2017-08-02 14:21:45.981-05', 1, 1);


--
-- Data for Name: sessioninfo; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO sessioninfo (id, lastmodificationdate, rulesbytearray, startdate, optlock) VALUES (1, '2017-08-02 14:21:49.452-05', 62437, '2017-08-02 14:21:45.559-05', 1);


--
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO task (id, archived, allowedtodelegate, priority, activationtime, completedon, createdon, documentaccesstype, documentcontentid, documenttype, expirationtime, faultaccesstype, faultcontentid, faultname, faulttype, outputaccesstype, outputcontentid, outputtype, parentid, previousstatus, processid, processinstanceid, processsessionid, skipable, status, workitemid, optlock, taskinitiator_id, actualowner_id, createdby_id) VALUES (35, 0, NULL, 0, '2017-08-02 14:21:49.306-05', NULL, '2017-08-02 14:21:49.306-05', 0, 1, 'java.util.map', NULL, NULL, -1, NULL, NULL, NULL, -1, NULL, -1, 0, 'gov.medicaid.process.enrollment', 18, 1, false, 'Ready', 11, 1, NULL, NULL, 'Administrator');


--
-- Data for Name: workiteminfo; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO workiteminfo (workitemid, creationdate, name, processinstanceid, state, optlock, workitembytearray) VALUES (11, '2017-08-02 14:21:49.013-05', 'Human Task', 18, 0, 1, 62442);
INSERT INTO workiteminfo (workitemid, creationdate, name, processinstanceid, state, optlock, workitembytearray) VALUES (12, '2017-08-02 14:21:49.315-05', 'Auto Disqualification', 18, 0, 1, 62443);


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
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (entity_id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (entity_id);


--
-- Name: processinstanceinfo processinstanceinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY processinstanceinfo
    ADD CONSTRAINT processinstanceinfo_pkey PRIMARY KEY (instanceid);


--
-- Name: sessioninfo sessioninfo_pkey; Type: CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY sessioninfo
    ADD CONSTRAINT sessioninfo_pkey PRIMARY KEY (id);


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
-- Name: affiliations affiliations_qualified_professional_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY affiliations
    ADD CONSTRAINT affiliations_qualified_professional_type_code_fkey FOREIGN KEY (qualified_professional_type_code) REFERENCES qualified_professional_types(code);


--
-- Name: contacts contacts_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(address_id);


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
-- Name: eventtypes eventtypes_instanceid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY eventtypes
    ADD CONSTRAINT eventtypes_instanceid_fkey FOREIGN KEY (instanceid) REFERENCES processinstanceinfo(instanceid);


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
-- Name: task task_actualowner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: psm
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_actualowner_id_fkey FOREIGN KEY (actualowner_id) REFERENCES organizationalentity(id);


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
-- PostgreSQL database dump complete
--

