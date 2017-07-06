--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO addresses (address_id, attention_line, address_line_1, address_line_2, city, state, zip_code, county) VALUES (19, NULL, NULL, '1300 S State St', 'Minneapolis', 'MN', '55404', '27');


--
-- Data for Name: affiliations; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO affiliations (affiliation_id, is_primary, profile_id, object_type, ticket_id, effective_at, target_profile_id, target_entity_id, qualified_professional_type_code, mental_health_professional_type, acknowledgement_attachment_id, is_terminated, terminated_at, bgs_study_id, bgs_clearance_date) VALUES (22, 'Y', 0, 'L', 2, '2017-01-01', 0, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: binary_contents; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO binary_contents (binary_content_id, content) VALUES ('ab75aa88-710c-480e-ba2b-b9b0037cff0a', 389757);


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO contacts (contact_id, phone_number, fax_number, email, address_id) VALUES (15, NULL, NULL, 'p1@example.com', NULL);
INSERT INTO contacts (contact_id, phone_number, fax_number, email, address_id) VALUES (20, '555 555-5555', NULL, NULL, 19);


--
-- Data for Name: content; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO content (id, content) VALUES (1, 389762);


--
-- Name: content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: psm
--

SELECT pg_catalog.setval('content_id_seq', 1, true);


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO documents (document_id, profile_id, ticket_id, type, filename, description, binary_content_id, created_by, created_at) VALUES (1, 0, 0, 'image/png', 'womens-dinner-screenshot.png', NULL, 'ab75aa88-710c-480e-ba2b-b9b0037cff0a', 'p1', '2017-07-06 10:12:11.364-05');
INSERT INTO documents (document_id, profile_id, ticket_id, type, filename, description, binary_content_id, created_by, created_at) VALUES (17, 0, 2, 'image/png', 'womens-dinner-screenshot.png', NULL, 'ab75aa88-710c-480e-ba2b-b9b0037cff0a', 'p1', '2017-07-06 10:12:11.364-05');


--
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO enrollments (enrollment_id, enrollment_status_code, request_type_code, process_instance_id, profile_reference_id, reference_timestamp, progress_page, created_by, created_at, submitted_by, submitted_at, changed_by, changed_at, change_note) VALUES (2, '02', '02', 13, 0, NULL, 'Provider Statement', 'p1', '2017-07-06 10:13:02.299-05', 'p1', '2017-07-06 10:13:04.499-05', 'p1', '2017-07-06 10:13:04.499-05', NULL);


--
-- Data for Name: entities; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO entities (entity_id, enrolled, profile_id, ticket_id, name, legal_name, legacy_indicator, legacy_id, npi, npi_verified, npi_lookup_verified, nonexclusion_verified, provider_type_code, provider_sub_type, contact_id, background_study_id, background_clearance_date) VALUES (16, NULL, 0, 2, 'p1 p1', NULL, NULL, NULL, '0000000006', NULL, NULL, NULL, '01', NULL, 15, NULL, NULL);
INSERT INTO entities (entity_id, enrolled, profile_id, ticket_id, name, legal_name, legacy_indicator, legacy_id, npi, npi_verified, npi_lookup_verified, nonexclusion_verified, provider_type_code, provider_sub_type, contact_id, background_study_id, background_clearance_date) VALUES (21, NULL, 0, 0, 'Test Audiologist', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 20, NULL, NULL);


--
-- Data for Name: licenses; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO licenses (license_id, profile_id, ticket_id, affiliate_id, object_type, license_number, issued_at, expires_at, issuing_us_state, issuing_board_code, license_status_code, license_type_code, specialty_type_code, attachment_id) VALUES (18, 0, 2, NULL, 'L', '51', '2015-01-01', '2018-12-31', 'MN', NULL, NULL, 'L1', NULL, 17);


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO organizations (entity_id, fein, agency_id, billing_same_as_primary, reimbursement_same_as_primary, ten99_same_as_primary, billing_address_id, reimbursement_address_id, ten99_address_id, state_tax_id, fiscal_year_end, remittance_sequence_order, eft_vendor_number) VALUES (21, '', NULL, 'Y', NULL, NULL, NULL, NULL, NULL, '', '06/30', 'PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER', '');


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO people (entity_id, prefix, first_name, middle_name, last_name, suffix, ssn, ssn_verified, birth_date, degree_code, degree_award_date) VALUES (16, NULL, 'p1', '', 'p1', NULL, '000110000', NULL, '1980-10-08', NULL, NULL);


--
-- Data for Name: provider_profiles; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO provider_profiles (control_no, profile_id, ticket_id, effective_date, profile_status_code, works_on_reservation, maintains_own_private_practice, employed_or_contracted_by_group, criminal_conviction, civil_penalty, previous_exclusion, employee_criminal_conviction, employee_civil_penalty, employee_previous_exclusion, adult, county, employed_since_clearance, risk_level_code, bed_count, bed_count_title_18, bed_count_title_19, bed_count_dual_certified, bed_count_icf, bed_count_effective_date, physical_and_occupational_therapy, reference_ticket_id, owner_id, form_completed_by, health_board, created_by, created_at, last_modified_by, last_modified_at) VALUES (14, 0, 2, NULL, NULL, 'N', 'Y', 'N', 'N', 'N', 'N', NULL, NULL, NULL, NULL, NULL, NULL, '01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: provider_statements; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO provider_statements (provider_statement_id, profile_id, ticket_id, name, title, date) VALUES (23, 0, 2, 'Test Provider', 'Audiologist', '2017-07-06');


--
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO task (id, archived, allowedtodelegate, priority, activationtime, completedon, createdon, documentaccesstype, documentcontentid, documenttype, expirationtime, faultaccesstype, faultcontentid, faultname, faulttype, outputaccesstype, outputcontentid, outputtype, parentid, previousstatus, processid, processinstanceid, processsessionid, skipable, status, workitemid, optlock, taskinitiator_id, actualowner_id, createdby_id) VALUES (24, 0, NULL, 0, '2017-07-06 10:13:07.623-05', NULL, '2017-07-06 10:13:07.623-05', 0, 1, 'java.util.map', NULL, NULL, -1, NULL, NULL, NULL, -1, NULL, -1, 0, 'gov.medicaid.process.enrollment', 13, 1, false, 'Ready', 11, 1, NULL, NULL, 'Administrator');


--
-- Data for Name: workiteminfo; Type: TABLE DATA; Schema: public; Owner: psm
--

INSERT INTO workiteminfo (workitemid, creationdate, name, processinstanceid, state, optlock, workitembytearray) VALUES (11, '2017-07-06 10:13:07.377-05', 'Human Task', 13, 0, 1, 389764);
INSERT INTO workiteminfo (workitemid, creationdate, name, processinstanceid, state, optlock, workitembytearray) VALUES (12, '2017-07-06 10:13:07.63-05', 'Auto Disqualification', 13, 0, 1, 389765);


--
-- PostgreSQL database dump complete
--

