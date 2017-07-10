DROP SEQUENCE IF EXISTS
  hibernate_sequence
CASCADE;
DROP TABLE IF EXISTS
  accepted_agreements,
  addresses,
  affiliations,
  agreement_documents,
  audit_details,
  audit_records,
  beneficial_owner,
  beneficial_owner_types,
  binary_contents,
  categories_of_service,
  cms_authentication,
  cms_user,
  contacts,
  counties,
  degrees,
  designated_contacts,
  documents,
  enrollment_statuses,
  enrollments,
  entities,
  entity_structure_types,
  events,
  help_items,
  issuing_boards,
  license_statuses,
  license_types,
  licenses,
  notes,
  organizations,
  owner_assets,
  ownership_info,
  ownership_types,
  pay_to_provider_types,
  pay_to_providers,
  people,
  persistent_logins,
  profile_statuses,
  provider_approved_categories_of_service,
  provider_category_of_service_approvals,
  provider_profiles,
  provider_statements,
  provider_services,
  provider_type_agreement_documents,
  provider_type_license_types,
  provider_type_settings,
  provider_types,
  qualified_professional_types,
  relationship_types,
  request_types,
  risk_levels,
  roles,
  screening_schedules,
  service_categories,
  specialty_types,
  states
CASCADE;

CREATE SEQUENCE hibernate_sequence;

CREATE TABLE persistent_logins (
  series VARCHAR(64) PRIMARY KEY,
  username VARCHAR(64) NOT NULL,
  token VARCHAR(64) NOT NULL,
  last_used TIMESTAMP WITH TIME ZONE NOT NULL
);

CREATE TABLE roles (
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO roles (code, description) VALUES
  ('R1', 'Provider'),
  ('R2', 'Service Agent'),
  ('R3', 'Service Administrator'),
  ('R4', 'System Administrator');

CREATE TABLE cms_user (
  user_id TEXT PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  first_name TEXT,
  middle_name TEXT,
  last_name TEXT,
  phone_number TEXT,
  email TEXT,
  status TEXT,
  role_code CHARACTER VARYING(2) REFERENCES roles(code)
);
INSERT INTO cms_user (
  user_id,
  username,
  first_name,
  last_name,
  email,
  status,
  role_code
) VALUES
  ('p1', 'p1', 'p1', 'p1', 'p1@example.com', 'ACTIVE', 'R1'),
  ('ADMIN', 'admin', 'admin', 'admin', 'admin@example.com', 'ACTIVE', 'R3'),
  ('SYSTEM', 'system', 'system', 'system', 'system@example.com', 'ACTIVE', 'R4');

CREATE TABLE cms_authentication(
  username TEXT PRIMARY KEY,
  password TEXT NOT NULL
);
INSERT INTO cms_authentication (username, password) VALUES
  ('admin', '{SHA}0DPiKuNIrrVmD8IUCuw1hQxNqZc='), -- password: admin
  ('p1', '{SHA}t49XZhHsBvlq88plTCIXKl10bEA='), -- password: p1
  ('system', '{SHA}MX8edh8vqo2ngaR2K53MLFytIJo='); -- password: system

CREATE TABLE audit_records(
  audit_record_id BIGINT PRIMARY KEY,
  action TEXT,
  date TIMESTAMP WITH TIME ZONE,
  system_id TEXT,
  username TEXT
);
CREATE TABLE audit_details(
  audit_detail_id BIGINT PRIMARY KEY,
  audit_record_id BIGINT NOT NULL REFERENCES audit_records(audit_record_id),
  table_name TEXT,
  column_name TEXT,
  old_value TEXT,
  new_value TEXT
);
CREATE TABLE help_items(
  help_item_id BIGINT PRIMARY KEY,
  title TEXT,
  description TEXT
);

CREATE TABLE qualified_professional_types(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO qualified_professional_types (code, description) VALUES
  ('01', 'Registered Nurse'),
  ('02', 'Licensed Social Worker'),
  ('03', 'Mental Health Professional'),
  ('04', 'Qualified Developmental Disability Specialist');

CREATE TABLE provider_types(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE,
  applicant_type TEXT NOT NULL DEFAULT 'INDIVIDUAL'
);
INSERT INTO provider_types(code, description, applicant_type) VALUES
  ('01', 'Audiologist', 'INDIVIDUAL'),
  ('02', 'Optometrist', 'INDIVIDUAL'),
  ('03', 'Certified Registered Nurse Anesthetist', 'INDIVIDUAL'),
  ('04', 'Personal Care Assistant', 'INDIVIDUAL'),
  ('05', 'Certified Professional Midwife', 'INDIVIDUAL'),
  ('06', 'Community Health Care Worker', 'INDIVIDUAL'),
  ('07', 'Clinical Nurse Specialist', 'INDIVIDUAL'),
  ('08', 'Chiropractor', 'INDIVIDUAL'),
  ('09', 'Podiatrist', 'INDIVIDUAL'),
  ('10', 'Licensed Marriage and Family Therapist', 'INDIVIDUAL'),
  ('11', 'Licensed Professional Clinical Counselor', 'INDIVIDUAL'),
  ('12', 'Nurse Practitioner', 'INDIVIDUAL'),
  ('13', 'Occupational Therapist', 'INDIVIDUAL'),
  ('14', 'Physician Assistant', 'INDIVIDUAL'),
  ('15', 'Private Duty Nurse', 'INDIVIDUAL'),
  ('16', 'Physical Therapist', 'INDIVIDUAL'),
  ('17', 'Speech Language Pathologist', 'INDIVIDUAL'),
  ('18', 'Acupuncturist', 'INDIVIDUAL'),
  ('19', 'Allied Dental Professional', 'INDIVIDUAL'),
  ('20', 'Certified Mental Health Rehab Prof - CPRP', 'INDIVIDUAL'),
  ('21', 'Dentist', 'INDIVIDUAL'),
  ('22', 'Hearing Aid Dispenser', 'INDIVIDUAL'),
  ('23', 'Licensed Dietician or Licensed Nutritionist', 'INDIVIDUAL'),
  ('24', 'Licensed Independent Clinical Social Worker', 'INDIVIDUAL'),
  ('25', 'Nurse Midwife', 'INDIVIDUAL'),
  ('26', 'Pharmacist', 'INDIVIDUAL'),
  ('27', 'Licensed Psychologist', 'INDIVIDUAL'),
  ('28', 'Physician', 'INDIVIDUAL'),
  ('29', 'Billing Entity for Physical Rehabilitative Providers', 'ORGANIZATION'),
  ('30', 'Clearing House', 'ORGANIZATION'),
  ('31', 'Durable Medical Equipment', 'ORGANIZATION'),
  ('32', 'EDI Trading Partner', 'ORGANIZATION'),
  ('33', 'Family Planning Agency', 'ORGANIZATION'),
  ('34', 'Head Start', 'ORGANIZATION'),
  ('35', 'Home Health Agency', 'ORGANIZATION'),
  ('36', 'Independent Diagnostic Testing Facility', 'ORGANIZATION'),
  ('37', 'Independent Laboratory', 'ORGANIZATION'),
  ('38', 'Indian Health Service Facility', 'ORGANIZATION'),
  ('39', 'Intensive Residential Treatment Facility', 'ORGANIZATION'),
  ('40', 'Optical Supplier', 'ORGANIZATION'),
  ('41', 'Personal Care Provider Organization', 'ORGANIZATION'),
  ('42', 'Pharmacy', 'ORGANIZATION'),
  ('43', 'Private Duty Nursing Agency', 'ORGANIZATION'),
  ('44', 'Public Health Clinic', 'ORGANIZATION'),
  ('45', 'Public Health Nursing Organization', 'ORGANIZATION'),
  ('46', 'Regional Treatment Center', 'ORGANIZATION'),
  ('47', 'Rehabilitation Agency', 'ORGANIZATION'),
  ('48', 'Rural Health Clinic', 'ORGANIZATION'),
  ('49', 'Targeted Case Management', 'ORGANIZATION'),
  ('50', 'WIC Program', 'ORGANIZATION'),
  ('51', 'X-Ray Services', 'ORGANIZATION'),
  ('52', 'Ambulatory Surgical Center', 'ORGANIZATION'),
  ('53', 'Certified Registered Nurse Anesthetist Group', 'ORGANIZATION'),
  ('54', 'Child And Teen Checkup Clinic', 'ORGANIZATION'),
  ('55', 'Childrens Mental Health Residential Treatment Facility', 'ORGANIZATION'),
  ('56', 'Community Health Clinic', 'ORGANIZATION'),
  ('57', 'Community Mental Health Center', 'ORGANIZATION'),
  ('58', 'County Contracted Mental Health Rehab', 'ORGANIZATION'),
  ('59', 'Day Training And Habilitation/Day Activity Center', 'ORGANIZATION'),
  ('60', 'Day Treatment', 'ORGANIZATION'),
  ('61', 'Home And Community Based Services (Waivered Services)', 'ORGANIZATION'),
  ('62', 'Billing Intermediary', 'ORGANIZATION'),
  ('63', 'Federally Qualified Health Center', 'ORGANIZATION'),
  ('64', 'Individual Education Plan', 'ORGANIZATION'),
  ('65', 'Nursing Facility', 'ORGANIZATION'),
  ('66', 'Hospice', 'ORGANIZATION'),
  ('67', 'Hospital', 'ORGANIZATION'),
  ('68', 'Renal Dialysis Facility', 'ORGANIZATION'),
  ('69', 'Intermediate Care Facilities For Persons With Developmental Disabilities', 'ORGANIZATION'),
  ('70', 'Physician Clinic', 'ORGANIZATION'),
  ('71', 'Dental Clinic', 'ORGANIZATION'),
  ('72', 'Dental Hygienist Clinic', 'ORGANIZATION'),
  ('73', 'Podiatry Clinic', 'ORGANIZATION'),
  ('74', 'Billing Entity For Mental Health', 'ORGANIZATION'),
  ('75', 'Chiropractic Clinic', 'ORGANIZATION'),
  ('76', 'Birthing Center', 'ORGANIZATION'),
  ('77', 'Medical Transportation', 'ORGANIZATION'),
  ('78', 'Billing Entity for Physician Services', 'ORGANIZATION');

CREATE TABLE profile_statuses(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO profile_statuses (code, description) VALUES
  ('01', 'Active'),
  ('02', 'Suspended'),
  ('03', 'Expired');

CREATE TABLE entity_structure_types(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO entity_structure_types (code, description) VALUES
  ('01', 'Sole Proprietorship'),
  ('02', 'Partnership'),
  ('03', 'Corporation'),
  ('04', 'Non-Profit'),
  ('05', 'Hospital Based'),
  ('06', 'State'),
  ('07', 'Public'),
  ('08', 'Professional Association'),
  ('99', 'Other');

CREATE TABLE issuing_boards(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO issuing_boards (code, description) VALUES
  ('B1', 'AANA'),
  ('B2', 'NARM'),
  ('B3', 'ANCC'),
  ('B4', 'AOTA'),
  ('B5', 'ADA'),
  ('B6', 'ABMS'),
  ('B7', 'ABPS');

CREATE TABLE license_statuses(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO license_statuses (code, description) VALUES
  ('01', 'Active'),
  ('02', 'Suspended'),
  ('03', 'Expired');

CREATE TABLE ownership_types(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);

CREATE TABLE pay_to_provider_types(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO pay_to_provider_types(code, description) VALUES
  ('01', 'Claim'),
  ('02', 'ERA'),
  ('03', 'Both');

CREATE TABLE categories_of_service (
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO categories_of_service (code, description) VALUES
  ('01', 'AC Transportation'),
  ('02', 'Home Delivered Meals'),
  ('03', 'Adult Day Services'),
  ('04', 'Homemaker Services'),
  ('05', 'Behavioral Program Services'),
  ('06', 'In-home Family Support'),
  ('07', 'Caregiver Training'),
  ('08', 'Independent Living Skills'),
  ('09', 'Case Management Waiver/Alternative Care'),
  ('10', 'Modification and Adaptations'),
  ('11', 'Chore'),
  ('12', 'Nutritional Services'),
  ('13', 'Cognitive Therapy'),
  ('14', 'PERS and AC Supplies'),
  ('15', 'Companion Services'),
  ('16', 'Respite Care'),
  ('17', 'Consumer Directed Community Support (CDCS)'),
  ('18', 'Specialized Supplies & Equipment (Waiver)'),
  ('19', 'Spenddown Collection'),
  ('20', 'Customized Living, 24 CL, Residential Care Services, Assisted Living Services'),
  ('21', 'Structured Day Program Services'),
  ('22', 'Supported Employment Services'),
  ('23', 'Family Counseling and Training'),
  ('24', 'Supported Living Services'),
  ('25', 'Foster Care Services'),
  ('26', 'Waiver Transportation');


CREATE TABLE service_categories (
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO service_categories (code, description) VALUES
  ('01', 'AC Transportation'),
  ('02', 'Home Delivered Meals'),
  ('03', 'Adult Day Services'),
  ('04', 'Homemaker Services'),
  ('05', 'Behavioral Program Services'),
  ('06', 'In-home Family Support'),
  ('07', 'Caregiver Training'),
  ('08', 'Independent Living Skills'),
  ('09', 'Case Management Waiver/Alternative Care'),
  ('10', 'Modification and Adaptations'),
  ('11', 'Chore'),
  ('12', 'Nutritional Services'),
  ('13', 'Cognitive Therapy'),
  ('14', 'PERS and AC Supplies'),
  ('15', 'Companion Services'),
  ('16', 'Respite Care'),
  ('17', 'Consumer Directed Community Support (CDCS)'),
  ('18', 'Specialized Supplies & Equipment (Waiver)'),
  ('19', 'Spenddown Collection'),
  ('20', 'Customized Living, 24 CL, Residential Care Services, Assisted Living Services'),
  ('21', 'Structured Day Program Services'),
  ('22', 'Supported Employment Services'),
  ('23', 'Family Counseling and Training'),
  ('24', 'Supported Living Services'),
  ('25', 'Foster Care Services'),
  ('26', 'Waiver Transportation');

CREATE TABLE counties (
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO counties (code, description) VALUES
  ('01', 'Aitkin'),
  ('02', 'Anoka'),
  ('03', 'Becker'),
  ('04', 'Beltrami'),
  ('05', 'Benton'),
  ('06', 'Big Stone'),
  ('07', 'Blue Earth'),
  ('08', 'Brown'),
  ('09', 'Carlton'),
  ('10', 'Carver'),
  ('11', 'Cass'),
  ('12', 'Chippewa'),
  ('13', 'Chisago'),
  ('14', 'Clay'),
  ('15', 'Clearwater'),
  ('16', 'Cook'),
  ('17', 'Cottonwood'),
  ('18', 'Crow Wing'),
  ('19', 'Dakota'),
  ('20', 'Dodge'),
  ('21', 'Douglas'),
  ('22', 'Faribault'),
  ('23', 'Fillmore'),
  ('24', 'Freeborn'),
  ('25', 'Goodhue'),
  ('26', 'Grant'),
  ('27', 'Hennepin'),
  ('28', 'Houston'),
  ('29', 'Hubbard'),
  ('30', 'Isanti'),
  ('31', 'Itasca'),
  ('32', 'Jackson'),
  ('33', 'Kanabec'),
  ('34', 'Kandiyohi'),
  ('35', 'Kittson'),
  ('36', 'Koochiching'),
  ('37', 'Lac qui Parle'),
  ('38', 'Lake'),
  ('39', 'Lake of the Woods'),
  ('40', 'Le Sueur'),
  ('41', 'Lincoln'),
  ('42', 'Lyon'),
  ('43', 'Mahnomen'),
  ('44', 'Marshall'),
  ('45', 'Martin'),
  ('46', 'McLeod'),
  ('47', 'Meeker'),
  ('48', 'Mille Lacs'),
  ('49', 'Morrison'),
  ('50', 'Mower'),
  ('51', 'Murray'),
  ('52', 'Nicollet'),
  ('53', 'Nobles'),
  ('54', 'Norman'),
  ('55', 'Olmsted'),
  ('56', 'Otter Tail'),
  ('57', 'Pennington'),
  ('58', 'Pine'),
  ('59', 'Pipestone'),
  ('60', 'Polk'),
  ('61', 'Pope'),
  ('62', 'Ramsey'),
  ('63', 'Red Lake'),
  ('64', 'Redwood'),
  ('65', 'Renville'),
  ('66', 'Rice'),
  ('67', 'Rock'),
  ('68', 'Roseau'),
  ('69', 'Scott'),
  ('70', 'Sherburne'),
  ('71', 'Sibley'),
  ('72', 'St. Louis'),
  ('73', 'Stearns'),
  ('74', 'Steele'),
  ('75', 'Stevens'),
  ('76', 'Swift'),
  ('77', 'Todd'),
  ('78', 'Traverse'),
  ('79', 'Wabasha'),
  ('80', 'Wadena'),
  ('81', 'Waseca'),
  ('82', 'Washington'),
  ('83', 'Watonwan'),
  ('84', 'Wilkin'),
  ('85', 'Winona'),
  ('86', 'Wright'),
  ('87', 'Yellow');

CREATE TABLE beneficial_owner_types(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE,
  owner_type CHARACTER VARYING(1)
);
INSERT INTO beneficial_owner_types (code, owner_type, description) VALUES
  ('01', 'A', 'Subcontractor'),
  ('02', 'P', 'Managing Employee'),
  ('03', 'A', 'Owner - 5% or more of Ownership Interest'),
  ('04', 'P', 'Board Member or Officer'),
  ('05', 'P', 'Program Manager'),
  ('06', 'P', 'Managing Director'),
  ('99', 'A', 'Other');

CREATE TABLE risk_levels(
  code CHARACTER VARYING(2) PRIMARY KEY,
  sort_index INTEGER UNIQUE NOT NULL,
  description TEXT UNIQUE
);
INSERT INTO risk_levels (code, sort_index, description) VALUES
  ('01', 1, 'Limited'),
  ('02', 2, 'Moderate'),
  ('03', 3, 'High');

CREATE TABLE degrees(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO degrees(CODE, DESCRIPTION) VALUES
  ('D1', 'MASTERS'),
  ('D2', 'DOCTORATE');

CREATE TABLE relationship_types(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO relationship_types (CODE, DESCRIPTION) VALUES
  ('01', 'Spouse'),
  ('02', 'Child'),
  ('03', 'Parent'),
  ('04', 'Sibling');

CREATE TABLE enrollment_statuses(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO enrollment_statuses (code, description) VALUES
  ('01', 'Draft'),
  ('02', 'Pending'),
  ('03', 'Rejected'),
  ('04', 'Approved');

CREATE TABLE license_types(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO license_types (code, description) VALUES
  ('A0', 'Background Study'),
  ('A1', 'Head Start Agency Certification'),
  ('A2', 'Class A Professional Home Care License'),
  ('A3', 'HCFA Medicare Certification'),
  ('A4', 'Housing with Services'),
  ('A5', 'Off-site Approval Letter From Medicare'),
  ('A6', 'Verification of IHS status'),
  ('A7', 'County Contract to Provider IRTS'),
  ('A8', 'Rule 36 Licensed Facility'),
  ('A9', 'Class A License'),
  ('AA', 'Pharmacy License'),
  ('AB', 'Class A License For Private Duty Nursing Services'),
  ('AC', 'Medicare Certification For Home Health Aide And Skilled Nursing Services'),
  ('AD', 'Regional Treatment Center Certification'),
  ('AE', 'Medicare Approval Letter'),
  ('AF', 'Comprehensive Outpatient Rehabilitation Facility Certification'),
  ('AG', 'Independent or Portable X-ray Certification from CMS'),
  ('AH', 'FDA Certification - Mammography services'),
  ('AI', 'PCA 1 or 3 day Steps for Success Training'),
  ('AJ', 'Medicare Certification'),
  ('AK', 'Rule 5 License issued from MN Department of Human Services'),
  ('AL', 'Certificate of Compliance from MN Department of Human Rights'),
  ('AM', 'Rule 29 License'),
  ('AN', 'Day Training & Habilitation License'),
  ('AO', 'License and Transmittal (CMS 1539 Form) from MN Department of Health'),
  ('AP', 'Approval by Kent Dufresne to enroll new facility'),
  ('AQ', 'Hospice license from the MN Dept of Health'),
  ('AR', 'CMS Medicare Certification Letter'),
  ('AS', 'Ambulance Services - Basic Service'),
  ('AT', 'Ambulance Services - Advanced Life Support'),
  ('AU', 'Ambulance Services - Air Transport with FAA Air Worthiness Certificate'),
  ('AV', 'State License to operate as a Hospital'),
  ('AW', 'CMS PECOS Website Verification'),
  ('AX', 'CLIA Certificate if billing Lab Services'),
  ('AZ', 'Renal Dialysis Facility Approval letter from regional CMS office'),
  ('B0', 'Hospital Based Clinic Designation:  approval letter from CMS'),
  ('B1', 'Adult Day Care License'),
  ('B2', '245B License'),
  ('CA', 'Adult Rehabilitative Mental Health Services'),
  ('CB', 'Children''s Therapeutic Services and Supports (CTSS)'),
  ('CC', 'Adult Crisis Response Services - Crisis Assessment & Crisis Intervention'),
  ('CD', 'Adult Crisis Response Services - Crisis Stabilization'),
  ('CE', 'Adult Crisis Response Services - Short-Term Residential'),
  ('H1', 'Rehab Counselor Certification'),
  ('H2', 'Psychosocial Rehab Practitioner Certification'),
  ('H3', 'Licensed Practical Nurse'),
  ('L0', 'Marriage And Family Therapist'),
  ('L1', 'Audiologist License'),
  ('L2', 'Registration with the Department Of Health'),
  ('L3', 'Optometrist'),
  ('L4', 'Registered Nurse'),
  ('L5', 'PCA Training Certificate'),
  ('L6', 'Traditional Midwife'),
  ('L7', 'MnSCU Certification'),
  ('L8', 'Chiropractic Examiner'),
  ('L9', 'License To Practice Podiatric Medicine'),
  ('M0', 'Hearing Aid Dispenser'),
  ('M1', 'Professional Clinical Counselor'),
  ('M2', 'Occupational Therapy'),
  ('M3', 'Physician Assistant'),
  ('M4', 'Physical Therapist'),
  ('M5', 'Speech Language Pathologist'),
  ('M6', 'Acupuncturist'),
  ('M7', 'Dental Hygienist'),
  ('M8', 'Mental Health Rehab Professional'),
  ('M9', 'Dental'),
  ('N1', 'Dietician or Nutritionist'),
  ('N2', 'Clinical Social Worker'),
  ('N3', 'Pharmacist License'),
  ('N4', 'Psychologist'),
  ('N5', 'Physician');

CREATE TABLE specialty_types(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE,
  sub_category CHARACTER VARYING(2)
);
INSERT INTO specialty_types (code, description) VALUES
  ('01', 'Allergy'),
  ('02', 'Anesthesiology'),
  ('03', 'Cardiovascular Disease'),
  ('04', 'Cardiovascular Surgery'),
  ('05', 'Child Psychiatry'),
  ('06', 'Colon and Rectal Surgery'),
  ('07', 'Dermatology'),
  ('08', 'Diabetes'),
  ('09', 'Emergency Services'),
  ('10', 'Endocrinology'),
  ('11', 'Family Practice'),
  ('12', 'Gastroenterology'),
  ('13', 'General Practice'),
  ('14', 'General Surgery'),
  ('15', 'Gynecology'),
  ('16', 'Immunology'),
  ('17', 'Infectious Disease'),
  ('18', 'Internal Medicine'),
  ('19', 'Nephrology'),
  ('20', 'Neurological Surgery'),
  ('21', 'Neurology'),
  ('22', 'Nuclear Medicine'),
  ('23', 'Obstetrics'),
  ('24', 'Obstetrics and Gynecology'),
  ('25', 'Oncology'),
  ('26', 'Ophthalmology'),
  ('27', 'Pathology'),
  ('28', 'Peripheral Vascular Diseases or Surgery'),
  ('29', 'Physical Medicine and Rehabilitation'),
  ('30', 'Plastic Surgery'),
  ('31', 'Preventive Medicine'),
  ('32', 'Psychiatry'),
  ('33', 'Pulmonary Disease'),
  ('34', 'Radiology'),
  ('35', 'Radiology and Radiation Therapy'),
  ('36', 'Rheumatology'),
  ('37', 'Thoracic Surgery'),
  ('38', 'Urology'),
  ('39', 'Other'),
  ('41', 'Gerontological'),
  ('42', 'Pediatric'),
  ('43', 'Family'),
  ('44', 'Adult'),
  ('45', 'OB/GYN'),
  ('46', 'Neonatal'),
  ('47', 'Women''s Health Care'),
  ('48', 'Acute Care'),
  ('49', 'Gerontology'),
  ('50', 'Pediatrics'),
  ('C1', 'Adult CNS'),
  ('C2', 'Diabetes Management CNS'),
  ('C3', 'Gerontological CNS'),
  ('C4', 'Home Health CNS'),
  ('C5', 'Pediatric CNS'),
  ('D1', 'General Dentistry'),
  ('D2', 'Endodontist'),
  ('D3', 'Oral Surgery'),
  ('D4', 'Orthodontics'),
  ('D5', 'Pedodontics'),
  ('D6', 'Periodontics'),
  ('P1', 'Neuropsychology'),
  ('S1', 'CRNA Certification'),
  ('S2', 'Certified Professional Midwife'),
  ('S3', 'Psychiatric/Mental Health'),
  ('S6', 'Physical Rehabilitation'),
  ('S9', 'Certified Nurse Midwife');
INSERT INTO specialty_types (code, description, sub_category) VALUES
  ('FL', 'Fond Du Lac Indian Reservation', 'TC'),
  ('GP', 'Grand Portage Indian Reservation', 'TC'),
  ('LL', 'Leech Lake Indian Reservation', 'TC'),
  ('LS', 'Lower Sioux Indian Reservation', 'TC'),
  ('ML', 'Mille Lacs Indian Reservation', 'TC'),
  ('NL', 'Net Lake Indian Reservation', 'TC'),
  ('PI', 'Prairie Island Indian Reservation', 'TC'),
  ('RL', 'Red Lake Reservation', 'TC'),
  ('US', 'Upper Sioux Indian Reservation', 'TC'),
  ('WE', 'White Earth Indian Reservation', 'TC');

CREATE TABLE request_types(
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE
);
INSERT INTO request_types (code, description) VALUES
  ('01', 'Import Profile'),
  ('02', 'Enrollment'),
  ('03', 'Renewal'),
  ('04', 'Suspend'),
  ('05', 'Update');

CREATE TABLE states (
   code CHARACTER VARYING(2) PRIMARY KEY,
   description TEXT UNIQUE
);
INSERT INTO states (code, description) VALUES
  ('AK', 'Alaska'),
  ('AL', 'Alabama'),
  ('AR', 'Arkansas'),
  ('AZ', 'Arizona'),
  ('CA', 'California'),
  ('CO', 'Colorado'),
  ('CT', 'Connecticut'),
  ('DC', 'District of Columbia'),
  ('DE', 'Delaware'),
  ('FL', 'Florida'),
  ('GA', 'Georgia'),
  ('HI', 'Hawaii'),
  ('IA', 'Iowa'),
  ('ID', 'Idaho'),
  ('IL', 'Illinois'),
  ('IN', 'Indiana'),
  ('KS', 'Kansas'),
  ('KY', 'Kentucky'),
  ('LA', 'Louisiana'),
  ('MA', 'Massachusetts'),
  ('MD', 'Maryland'),
  ('ME', 'Maine'),
  ('MI', 'Michigan'),
  ('MN', 'Minnesota'),
  ('MO', 'Missouri'),
  ('MS', 'Mississippi'),
  ('MT', 'Montana'),
  ('NC', 'North Carolina'),
  ('ND', 'North Dakota'),
  ('NE', 'Nebraska'),
  ('NH', 'New Hampshire'),
  ('NJ', 'New Jersey'),
  ('NM', 'New Mexico'),
  ('NV', 'Nevada'),
  ('NY', 'New York'),
  ('OH', 'Ohio'),
  ('OK', 'Oklahoma'),
  ('OR', 'Oregon'),
  ('PA', 'Pennsylvania'),
  ('RI', 'Rhode Island'),
  ('SC', 'South Carolina'),
  ('SD', 'South Dakota'),
  ('TN', 'Tennessee'),
  ('TX', 'Texas'),
  ('UT', 'Utah'),
  ('VA', 'Virginia'),
  ('VT', 'Vermont'),
  ('WA', 'Washington'),
  ('WI', 'Wisconsin'),
  ('WV', 'West Virginia'),
  ('WY', 'Wyoming');

CREATE TABLE provider_profiles(
  control_no BIGINT PRIMARY KEY,
  profile_id BIGINT NOT NULL DEFAULT 0,
  ticket_id BIGINT NOT NULL DEFAULT 0,
  effective_date DATE,
  profile_status_code CHARACTER VARYING(2)
    REFERENCES profile_statuses(code),
  works_on_reservation CHARACTER VARYING(1),
  maintains_own_private_practice CHARACTER VARYING(1),
  employed_or_contracted_by_group CHARACTER VARYING(1),
  criminal_conviction CHARACTER VARYING(1),
  civil_penalty CHARACTER VARYING(1),
  previous_exclusion CHARACTER VARYING(1),
  employee_criminal_conviction CHARACTER VARYING(1),
  employee_civil_penalty CHARACTER VARYING(1),
  employee_previous_exclusion CHARACTER VARYING(1),
  adult CHARACTER VARYING(1),
  county TEXT,
  employed_since_clearance CHARACTER VARYING(1),
  risk_level_code CHARACTER VARYING(2)
    REFERENCES risk_levels(code),
  bed_count INTEGER,
  bed_count_title_18 INTEGER,
  bed_count_title_19 INTEGER,
  bed_count_dual_certified INTEGER,
  bed_count_icf INTEGER,
  bed_count_effective_date DATE,
  physical_and_occupational_therapy CHARACTER VARYING(1),
  reference_ticket_id BIGINT NOT NULL DEFAULT 0,
  owner_id TEXT,
  form_completed_by TEXT,
  health_board CHARACTER VARYING(1),
  created_by TEXT,
  created_at TIMESTAMP WITH TIME ZONE,
  last_modified_by TEXT,
  last_modified_at TIMESTAMP WITH TIME ZONE
);

CREATE TABLE provider_category_of_service_approvals(
  provider_category_of_service_approval_id BIGINT PRIMARY KEY,
  profile_id BIGINT,
  ticket_id BIGINT,
  start_date DATE,
  end_date DATE
);
CREATE TABLE provider_approved_categories_of_service(
  provider_category_of_service_approval_id BIGINT
    REFERENCES provider_category_of_service_approvals(provider_category_of_service_approval_id),
  category_of_service_code CHARACTER VARYING(2)
    REFERENCES categories_of_service(code)
);

CREATE TABLE addresses(
  address_id BIGINT PRIMARY KEY,
  attention_line TEXT,
  address_line_1 TEXT,
  address_line_2 TEXT,
  city TEXT,
  state TEXT,
  zip_code TEXT,
  county TEXT
);

CREATE TABLE agreement_documents(
  agreement_document_id BIGINT PRIMARY KEY,
  type TEXT,
  title TEXT,
  version INTEGER,
  body TEXT,
  created_by TEXT,
  created_at TIMESTAMP WITH TIME ZONE
);
INSERT INTO agreement_documents (
  agreement_document_id,
  type,
  title,
  version,
  body,
  created_by,
  created_at
) VALUES
  (1, '01', 'Agreement (1)', 0, 'This is the content of the agreement.', 'system', NOW()),
  (2, '02', 'Addendum (2)', 0, 'This is the content of the addendum.', 'system', NOW());

CREATE TABLE contacts(
  contact_id BIGINT PRIMARY KEY,
  phone_number TEXT,
  fax_number TEXT,
  email TEXT,
  address_id BIGINT
    REFERENCES addresses(address_id)
);

CREATE TABLE enrollments(
  enrollment_id BIGINT PRIMARY KEY,
  enrollment_status_code CHARACTER VARYING(2)
    REFERENCES enrollment_statuses(code),
  request_type_code CHARACTER VARYING(2)
    REFERENCES request_types(code),
  process_instance_id BIGINT NOT NULL DEFAULT 0,
  profile_reference_id BIGINT NOT NULL DEFAULT 0,
  reference_timestamp TIMESTAMP WITH TIME ZONE,
  progress_page TEXT,
  created_by TEXT,
  created_at TIMESTAMP WITH TIME ZONE,
  submitted_by TEXT,
  submitted_at TIMESTAMP WITH TIME ZONE,
  changed_by TEXT,
  changed_at TIMESTAMP WITH TIME ZONE,
  change_note TEXT
);

CREATE TABLE provider_type_agreement_documents(
  provider_type_code CHARACTER VARYING(2)
    REFERENCES provider_types(code),
  agreement_document_id BIGINT
    REFERENCES agreement_documents(agreement_document_id),
  PRIMARY KEY (provider_type_code, agreement_document_id)
);
INSERT INTO provider_type_agreement_documents (
  provider_type_code,
  agreement_document_id
) VALUES
  ('18', 1);

CREATE TABLE provider_type_license_types(
  provider_type_code CHARACTER VARYING(2)
    REFERENCES provider_types(code),
  license_type_code CHARACTER VARYING(2)
    REFERENCES license_types(code),
  PRIMARY KEY (provider_type_code, license_type_code)
);
INSERT INTO provider_type_license_types(
  provider_type_code,
  license_type_code
) VALUES
  ('01', 'L1'),
  ('01', 'L2'),
  ('02', 'L3'),
  ('03', 'L4'),
  ('04', 'L5'),
  ('05', 'L6'),
  ('06', 'L7'),
  ('07', 'L4'),
  ('08', 'L8'),
  ('09', 'L9'),
  ('10', 'L0'),
  ('11', 'M1'),
  ('12', 'L4'),
  ('13', 'M2'),
  ('14', 'M3'),
  ('15', 'H3'),
  ('15', 'A9'),
  ('15', 'L4'),
  ('16', 'M4'),
  ('17', 'M5'),
  ('18', 'M6'),
  ('19', 'M7'),
  ('20', 'H1'),
  ('20', 'H2'),
  ('20', 'M8'),
  ('21', 'M9'),
  ('22', 'M0'),
  ('23', 'N1'),
  ('24', 'N2'),
  ('25', 'L4'),
  ('26', 'N3'),
  ('27', 'N4'),
  ('28', 'N5'),
  ('34', 'A1'),
  ('35', 'A2'),
  ('35', 'A3'),
  ('35', 'A4'),
  ('36', 'A5'),
  ('38', 'A6'),
  ('39', 'A7'),
  ('39', 'A8'),
  ('41', 'A0'),
  ('41', 'A9'),
  ('42', 'AA'),
  ('43', 'AB'),
  ('45', 'AB'),
  ('45', 'AC'),
  ('46', 'AD'),
  ('47', 'AE'),
  ('47', 'AF'),
  ('48', 'AE'),
  ('51', 'AG'),
  ('51', 'AH'),
  ('52', 'AJ'),
  ('55', 'AK'),
  ('55', 'AL'),
  ('57', 'AM'),
  ('59', 'AN'),
  ('59', 'B1'),
  ('59', 'B2'),
  ('61', 'A0'),
  ('61', 'A1'),
  ('61', 'A2'),
  ('61', 'A3'),
  ('61', 'A4'),
  ('61', 'A5'),
  ('61', 'A6'),
  ('61', 'A7'),
  ('61', 'A8'),
  ('61', 'A9'),
  ('61', 'AA'),
  ('61', 'AB'),
  ('61', 'AC'),
  ('61', 'AD'),
  ('61', 'AE'),
  ('61', 'AF'),
  ('61', 'AG'),
  ('61', 'AH'),
  ('61', 'AI'),
  ('61', 'AJ'),
  ('61', 'AK'),
  ('61', 'AL'),
  ('61', 'AM'),
  ('65', 'AO'),
  ('65', 'AP'),
  ('66', 'AQ'),
  ('66', 'AR'),
  ('67', 'AR'),
  ('67', 'AV'),
  ('67', 'AW'),
  ('67', 'AX'),
  ('68', 'AO'),
  ('68', 'AZ'),
  ('69', 'AO');

CREATE TABLE entities(
  entity_id BIGINT PRIMARY KEY,
  enrolled CHARACTER VARYING(1),
  profile_id BIGINT NOT NULL,
  ticket_id BIGINT,
  name TEXT,
  legal_name TEXT,
  legacy_indicator CHARACTER VARYING(1),
  legacy_id TEXT,
  npi TEXT,
  npi_verified CHARACTER VARYING(1),
  npi_lookup_verified CHARACTER VARYING(1),
  nonexclusion_verified CHARACTER VARYING(1),
  provider_type_code CHARACTER VARYING(2)
    REFERENCES provider_types(code),
  provider_sub_type TEXT,
  contact_id BIGINT
    REFERENCES contacts(contact_id),
  background_study_id TEXT,
  background_clearance_date TIMESTAMP WITH TIME ZONE
);
CREATE TABLE organizations(
  entity_id BIGINT PRIMARY KEY
    REFERENCES entities(entity_id),
  fein CHARACTER VARYING(10),
  agency_id TEXT,
  billing_same_as_primary CHARACTER VARYING(1),
  reimbursement_same_as_primary CHARACTER VARYING(1),
  ten99_same_as_primary CHARACTER VARYING(1),
  billing_address_id BIGINT
    REFERENCES addresses(address_id),
  reimbursement_address_id BIGINT
    REFERENCES addresses(address_id),
  ten99_address_id BIGINT
    REFERENCES addresses(address_id),
  state_tax_id TEXT,
  fiscal_year_end TEXT,
  remittance_sequence_order TEXT,
  eft_vendor_number TEXT
);
CREATE TABLE people(
  entity_id BIGINT PRIMARY KEY
    REFERENCES entities(entity_id),
  prefix TEXT,
  first_name TEXT,
  middle_name TEXT,
  last_name TEXT,
  suffix TEXT,
  ssn TEXT,
  ssn_verified CHARACTER VARYING(1),
  birth_date DATE,
  degree_code CHARACTER VARYING(2)
    REFERENCES degrees(code),
  degree_award_date DATE
);

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
  subcontractor_name        TEXT,
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

CREATE TABLE owner_assets(
  owner_asset_id BIGINT PRIMARY KEY ,
  name TEXT,
  ownership_type_code CHARACTER VARYING(2)
    REFERENCES  ownership_types(code),
  address_id BIGINT
    REFERENCES addresses(address_id),
  ownership_info_id BIGINT
    REFERENCES ownership_info(ownership_info_id)
) ;

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
