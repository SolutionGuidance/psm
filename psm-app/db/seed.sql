DROP SEQUENCE IF EXISTS
  hibernate_sequence
CASCADE;
DROP TABLE IF EXISTS
  addresses,
  agreement_documents,
  audit_details,
  audit_records,
  cms_authentication,
  cms_user,
  enrollment_statuses,
  enrollments,
  help_items,
  license_types,
  persistent_logins,
  profile_statuses,
  provider_profiles,
  provider_types,
  request_types,
  risk_levels,
  roles,
  service_assurance_types,
  service_assurance_ext_types,
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

CREATE TABLE service_assurance_ext_types (
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
  ('L3', 'Optometrist License'),
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
