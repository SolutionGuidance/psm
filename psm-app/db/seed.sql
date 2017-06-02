DROP SEQUENCE IF EXISTS
  hibernate_sequence
CASCADE;
DROP TABLE IF EXISTS
  audit_details,
  audit_records,
  cms_authentication,
  cms_user,
  help_items,
  persistent_logins,
  profile_statuses,
  provider_types,
  risk_levels,
  roles,
  service_assurance_types,
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

CREATE TABLE service_assurance_types (
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT UNIQUE,
  patient_indicator TEXT
);

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
  ('ADMIN', 'admin', 'admin', 'admin', 'admin@example.com', 'ACTIVE', 'R3'),
  ('SYSTEM', 'system', 'system', 'system', 'system@example.com', 'ACTIVE', 'R4');

CREATE TABLE cms_authentication(
  username TEXT PRIMARY KEY,
  password TEXT NOT NULL
);
INSERT INTO cms_authentication (username, password) VALUES
  ('admin', '{SHA}0DPiKuNIrrVmD8IUCuw1hQxNqZc='), -- password: admin
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

CREATE TABLE risk_levels(
  code CHARACTER VARYING(2) PRIMARY KEY,
  sort_index INTEGER UNIQUE NOT NULL,
  description TEXT UNIQUE
);
INSERT INTO risk_levels (code, sort_index, description) VALUES
  ('01', 1, 'Limited'),
  ('02', 2, 'Moderate'),
  ('03', 3, 'High');

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
