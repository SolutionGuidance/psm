DROP TABLE IF EXISTS
  accepted_agreements,
  affiliations,
  beneficial_owner,
  binary_contents,
  designated_contacts,
  documents,
  events,
  external_account_links,
  external_profile_links,
  licenses,
  notes,
  ownership_info,
  pay_to_providers,
  provider_statements,
  provider_services,
  provider_type_settings,
  screening_schedules
CASCADE;

CREATE TABLE binary_contents(
  binary_content_id TEXT PRIMARY KEY,
  content OID
);

CREATE TABLE documents(
  document_id BIGINT PRIMARY KEY,
  profile_id BIGINT,
  ticket_id BIGINT,
  "type" TEXT,
  filename TEXT,
  description TEXT,
  binary_content_id TEXT,
  created_by TEXT,
  created_at TIMESTAMP WITH TIME ZONE
);
INSERT INTO documents(
  document_id,
  profile_id,
  ticket_id
  /*"type",*/
  /*filename,*/
  /*description,*/
  /*binary_content_id,*/
  /*created_by,*/
  /*created_at*/
) VALUES
  (1001, 0, 1006),
  (1002, 0, 1008),
  (1003, 0, 1009),
  (1004, 0, 1010),
  (1005, 0, 1010),
  (1006, 0, 1010);

CREATE TABLE designated_contacts(
  designated_contact_id BIGINT PRIMARY KEY,
  profile_id BIGINT,
  ticket_id BIGINT,
  designated_contact_type TEXT,
  same_as_provider CHARACTER VARYING(1),
  hired_at DATE,
  person_id BIGINT
    REFERENCES people(entity_id)
);

CREATE TABLE accepted_agreements(
  accepted_agreement_id BIGINT PRIMARY KEY,
  profile_id BIGINT,
  ticket_id BIGINT,
  accepted_date DATE,
  agreement_document_id BIGINT
    REFERENCES  agreement_documents(agreement_document_id)
 ) ;

CREATE TABLE screening_schedules(
  screening_schedule_id BIGINT PRIMARY KEY,
  upcoming_screening_date DATE,
  interval_type TEXT,
  interval_value BIGINT NOT NULL
);

INSERT INTO screening_schedules(
  screening_schedule_id,
  upcoming_screening_date,
  interval_type,
  interval_value
) VALUES
  (1, null, null, 0);

CREATE TABLE licenses(
  license_id BIGINT PRIMARY KEY,
  profile_id BIGINT,
  ticket_id BIGINT,
  affiliate_id BIGINT,
  object_type TEXT,
  license_number TEXT,
  issued_at DATE,
  expires_at DATE,
  issuing_us_state TEXT,
  issuing_board_code CHARACTER VARYING(2)
    REFERENCES issuing_boards(code),
  license_status_code CHARACTER VARYING(2)
    REFERENCES license_statuses(code),
  license_type_code CHARACTER VARYING(2)
    REFERENCES license_types(code),
  specialty_type_code CHARACTER VARYING(2)
    REFERENCES specialty_types(code),
  attachment_id BIGINT
);

CREATE TABLE affiliations(
  affiliation_id BIGINT PRIMARY KEY,
  is_primary CHARACTER VARYING(1),
  profile_id BIGINT,
  object_type TEXT,
  ticket_id BIGINT,
  effective_at DATE,
  target_profile_id BIGINT,
  target_entity_id BIGINT,
  qualified_professional_type_code CHARACTER VARYING(2)
    REFERENCES qualified_professional_types(code),
  mental_health_professional_type TEXT,
  acknowledgement_attachment_id TEXT,
  is_terminated CHARACTER VARYING(1),
  terminated_at DATE,
  bgs_study_id TEXT,
  bgs_clearance_date DATE
);

CREATE TABLE ownership_info (
  ownership_info_id BIGINT PRIMARY KEY,
  profile_id BIGINT,
  ticket_id BIGINT,
  entity_structure_type_code CHARACTER VARYING(2)
    REFERENCES entity_structure_types(code),
  entity_structure_subtype_code CHARACTER VARYING(2)
    REFERENCES entity_structure_types(code),
  other_entity_type_desc TEXT
);

CREATE TABLE beneficial_owner (
  beneficial_owner_id       BIGINT PRIMARY KEY,
  person_ind                CHARACTER VARYING(1),
  ben_type_cd               CHARACTER VARYING(2)
    REFERENCES beneficial_owner_types (code),
  oth_type_desc             TEXT,
  own_interest_pct          FLOAT,
  address_id                BIGINT
    REFERENCES addresses (address_id),
  oth_provider_interest_ind TEXT,
  oth_provider_name         TEXT,
  oth_provider_own_pct      FLOAT,
  oth_provider_address_id   BIGINT
    REFERENCES addresses(address_id),
  middle_name               TEXT,
  first_name                TEXT,
  last_name                 TEXT,
  ssn                       TEXT,
  birth_dt                  DATE,
  hired_at                  DATE,
  relationship_type_code    CHARACTER VARYING(2)
    REFERENCES relationship_types (code),
  ownership_info_id         BIGINT
    REFERENCES ownership_info(ownership_info_id),
  fein                      CHARACTER VARYING(20),
  legal_name                TEXT
);

CREATE TABLE provider_statements(
  provider_statement_id BIGINT PRIMARY KEY,
  profile_id BIGINT,
  ticket_id BIGINT,
  name TEXT,
  title TEXT,
  "date" DATE
);

CREATE TABLE notes(
  note_id BIGINT PRIMARY KEY,
  profile_id BIGINT,
  ticket_id BIGINT,
  note_text TEXT,
  created_by TEXT,
  created_at TIMESTAMP WITH TIME ZONE
);

CREATE TABLE events(
  event_id BIGINT PRIMARY KEY,
  ticket_id BIGINT,
  npi TEXT,
  status TEXT,
  created_by TEXT,
  created_at TIMESTAMP WITH TIME ZONE
);

CREATE TABLE pay_to_providers(
  pay_to_providers_id  BIGINT PRIMARY KEY,
  effective_date DATE,
  pay_to_type_code CHARACTER VARYING(2)
    REFERENCES pay_to_provider_types(code),
  profile_id BIGINT,
  ticket_id BIGINT,
  target_profile_id BIGINT,
  name TEXT,
  contact_name TEXT,
  npi TEXT,
  phone TEXT
);

CREATE TABLE provider_type_settings (
  provider_type_setting_id INTEGER PRIMARY KEY,
  provider_type_code CHARACTER VARYING(2) NOT NULL
    REFERENCES provider_types(code),
  related_entity_type TEXT NOT NULL,
  related_entity_code TEXT NOT NULL,
  relationship_type TEXT NOT NULL
);
INSERT INTO provider_type_settings (
  provider_type_setting_id,
  provider_type_code,
  related_entity_type,
  related_entity_code,
  relationship_type
) VALUES
  (103, '01', 'StateType', 'MN', 'LS'),
  (202, '02', 'StateType', 'MN', 'LS'),
  (302, '03', 'StateType', 'MN', 'LS'),
  (303, '03', 'SpecialtyType', 'S1', 'SO'),
  (304, '03', 'IssuingBoard', 'B1', 'SB'),
  (402, '04', 'StateType', 'MN', 'LS'),
  (502, '05', 'StateType', 'MN', 'LS'),
  (503, '05', 'SpecialtyType', 'S2', 'SO'),
  (504, '05', 'IssuingBoard', 'B2', 'SB'),
  (602, '06', 'StateType', 'MN', 'LS'),
  (702, '07', 'StateType', 'MN', 'LS'),
  (703, '07', 'SpecialtyType', 'S3', 'SO'),
  (704, '07', 'IssuingBoard', 'B3', 'SB'),
  (705, '07', 'SpecialtyType', 'C1', 'SO'),
  (706, '07', 'SpecialtyType', 'C2', 'SO'),
  (707, '07', 'SpecialtyType', 'C3', 'SO'),
  (708, '07', 'SpecialtyType', 'C4', 'SO'),
  (709, '07', 'SpecialtyType', 'C5', 'SO'),
  (802, '08', 'StateType', 'MN', 'LS'),
  (902, '09', 'StateType', 'MN', 'LS'),
  (1002, '10', 'StateType', 'MN', 'LS'),
  (1102, '11', 'StateType', 'MN', 'LS'),
  (1202, '12', 'StateType', 'MN', 'LS'),
  (1203, '12', 'SpecialtyType', 'S3', 'SO'),
  (1204, '12', 'IssuingBoard', 'B3', 'SB'),
  (1302, '13', 'StateType', 'MN', 'LS'),
  (1303, '13', 'SpecialtyType', 'S3', 'SO'),
  (1304, '13', 'SpecialtyType', 'S4', 'SO'),
  (1305, '13', 'SpecialtyType', 'S5', 'SO'),
  (1306, '13', 'SpecialtyType', 'S6', 'SO'),
  (1307, '13', 'IssuingBoard', 'B4', 'SB'),
  (1402, '14', 'StateType', 'MN', 'LS'),
  (1502, '15', 'StateType', 'MN', 'LS'),
  (1602, '16', 'StateType', 'MN', 'LS'),
  (1702, '17', 'StateType', 'MN', 'LS'),
  (1802, '18', 'StateType', 'MN', 'LS'),
  (1902, '19', 'StateType', 'MN', 'LS'),
  (2002, '20', 'StateType', 'MN', 'LS'),
  (2102, '21', 'StateType', 'MN', 'LS'),
  (2103, '21', 'SpecialtyType', 'D1', 'SO'),
  (2104, '21', 'SpecialtyType', 'D2', 'SO'),
  (2105, '21', 'SpecialtyType', 'D3', 'SO'),
  (2106, '21', 'SpecialtyType', 'D4', 'SO'),
  (2107, '21', 'SpecialtyType', 'D5', 'SO'),
  (2108, '21', 'SpecialtyType', 'D6', 'SO'),
  (2109, '21', 'IssuingBoard', 'B5', 'SB'),
  (2110, '21', 'IssuingBoard', 'C1', 'SB'),
  (2202, '22', 'StateType', 'MN', 'LS'),
  (2302, '23', 'StateType', 'MN', 'LS'),
  (2402, '24', 'StateType', 'MN', 'LS'),
  (2403, '24', 'SpecialtyType', 'S3', 'SO'),
  (2404, '24', 'IssuingBoard', 'B3', 'SB'),
  (2502, '25', 'StateType', 'MN', 'LS'),
  (2503, '25', 'SpecialtyType', 'S9', 'SO'),
  (2504, '25', 'IssuingBoard', 'B8', 'SB'),
  (2602, '26', 'StateType', 'MN', 'LS'),
  (2702, '27', 'StateType', 'MN', 'LS'),
  (2703, '27', 'SpecialtyType', 'P1', 'SO'),
  (2802, '28', 'StateType', 'MN', 'LS'),
  (2803, '28', 'IssuingBoard', 'B6', 'SB'),
  (2804, '28', 'IssuingBoard', 'B7', 'SB'),
  (2805, '28', 'SpecialtyType', '01', 'SO'),
  (2806, '28', 'SpecialtyType', '02', 'SO'),
  (2807, '28', 'SpecialtyType', '03', 'SO'),
  (2808, '28', 'SpecialtyType', '04', 'SO'),
  (2809, '28', 'SpecialtyType', '05', 'SO'),
  (2810, '28', 'SpecialtyType', '06', 'SO'),
  (2811, '28', 'SpecialtyType', '07', 'SO'),
  (2812, '28', 'SpecialtyType', '08', 'SO'),
  (2813, '28', 'SpecialtyType', '09', 'SO'),
  (2814, '28', 'SpecialtyType', '10', 'SO'),
  (2815, '28', 'SpecialtyType', '11', 'SO'),
  (2816, '28', 'SpecialtyType', '12', 'SO'),
  (2817, '28', 'SpecialtyType', '13', 'SO'),
  (2818, '28', 'SpecialtyType', '14', 'SO'),
  (2819, '28', 'SpecialtyType', '15', 'SO'),
  (2820, '28', 'SpecialtyType', '16', 'SO'),
  (2821, '28', 'SpecialtyType', '17', 'SO'),
  (2822, '28', 'SpecialtyType', '18', 'SO'),
  (2823, '28', 'SpecialtyType', '19', 'SO'),
  (2824, '28', 'SpecialtyType', '20', 'SO'),
  (2825, '28', 'SpecialtyType', '21', 'SO'),
  (2826, '28', 'SpecialtyType', '22', 'SO'),
  (2827, '28', 'SpecialtyType', '23', 'SO'),
  (2828, '28', 'SpecialtyType', '24', 'SO'),
  (2829, '28', 'SpecialtyType', '25', 'SO'),
  (2830, '28', 'SpecialtyType', '26', 'SO'),
  (2831, '28', 'SpecialtyType', '27', 'SO'),
  (2832, '28', 'SpecialtyType', '28', 'SO'),
  (2833, '28', 'SpecialtyType', '29', 'SO'),
  (2834, '28', 'SpecialtyType', '30', 'SO'),
  (2835, '28', 'SpecialtyType', '31', 'SO'),
  (2836, '28', 'SpecialtyType', '32', 'SO'),
  (2837, '28', 'SpecialtyType', '33', 'SO'),
  (2838, '28', 'SpecialtyType', '34', 'SO'),
  (2839, '28', 'SpecialtyType', '35', 'SO'),
  (2840, '28', 'SpecialtyType', '36', 'SO'),
  (2841, '28', 'SpecialtyType', '37', 'SO'),
  (2842, '28', 'SpecialtyType', '38', 'SO'),
  (2843, '28', 'SpecialtyType', '39', 'SO'),
  (2844, '28', 'SpecialtyType', '49', 'SO'),
  (2845, '28', 'SpecialtyType', '50', 'SO'),
  (9901, '04', 'BeneficialOwnerType', '04', 'BT'),
  (9902, '04', 'BeneficialOwnerType', '02', 'BT'),
  (9903, '04', 'BeneficialOwnerType', '01', 'BT'),
  (9904, '01', 'BeneficialOwnerType', '03', 'BT'),
  (9905, '01', 'BeneficialOwnerType', '02', 'BT'),
  (9906, '01', 'BeneficialOwnerType', '01', 'BT'),
  (9907, '05', 'BeneficialOwnerType', '04', 'BT'),
  (9908, '05', 'BeneficialOwnerType', '03', 'BT'),
  (9909, '05', 'BeneficialOwnerType', '02', 'BT'),
  (9910, '05', 'BeneficialOwnerType', '01', 'BT'),
  (9911, '03', 'BeneficialOwnerType', '03', 'BT'),
  (9912, '03', 'BeneficialOwnerType', '02', 'BT'),
  (9913, '03', 'BeneficialOwnerType', '01', 'BT'),
  (9914, '02', 'BeneficialOwnerType', '03', 'BT'),
  (9915, '02', 'BeneficialOwnerType', '02', 'BT'),
  (9916, '02', 'BeneficialOwnerType', '01', 'BT'),
  (9917, '06', 'BeneficialOwnerType', '02', 'BT'),
  (9918, '06', 'BeneficialOwnerType', '01', 'BT'),
  (9919, '07', 'BeneficialOwnerType', '01', 'BT'),
  (9920, '07', 'BeneficialOwnerType', '05', 'BT'),
  (9921, '07', 'BeneficialOwnerType', '06', 'BT'),
  (14001, '12', 'SpecialtyType', '41', 'SO'),
  (14002, '12', 'SpecialtyType', '42', 'SO'),
  (14003, '12', 'SpecialtyType', '43', 'SO'),
  (14004, '12', 'SpecialtyType', '44', 'SO'),
  (14005, '12', 'SpecialtyType', '45', 'SO'),
  (14006, '12', 'SpecialtyType', '46', 'SO'),
  (14007, '12', 'SpecialtyType', '47', 'SO'),
  (14008, '12', 'SpecialtyType', '48', 'SO'),
  (100001, '41', 'LicenseType', 'L4', 'QL'),
  (100002, '41', 'LicenseType', 'N2', 'QL'),
  (100003, '41', 'LicenseType', 'M2', 'QL'),
  (100004, '41', 'LicenseType', 'M4', 'QL'),
  (100006, '41', 'LicenseType', 'H1', 'QL'),
  (100007, '41', 'LicenseType', 'H2', 'QL');

CREATE TABLE provider_services(
  provider_service_id BIGINT PRIMARY KEY,
  profile_id BIGINT DEFAULT 0 NOT NULL,
  ticket_id BIGINT DEFAULT 0 NOT NULL,
  service_category_code CHARACTER VARYING(2)
    REFERENCES service_categories(code)
);

CREATE TABLE external_account_links(
  external_account_link_id BIGINT PRIMARY KEY,
  user_id TEXT,
  system_id TEXT,
  external_user_id TEXT
);

CREATE TABLE external_profile_links(
  external_profile_link_id BIGINT PRIMARY KEY,
  profile_id BIGINT,
  system_id TEXT,
  external_profile_id TEXT
);
