DROP SEQUENCE IF EXISTS
  hibernate_sequence
CASCADE;
DROP TABLE IF EXISTS
  audit_details,
  audit_records,
  cms_authentication,
  cms_user,
  lu_role,
  persistent_logins
CASCADE;

CREATE SEQUENCE hibernate_sequence;

CREATE TABLE persistent_logins (
  series VARCHAR(64) PRIMARY KEY,
  username VARCHAR(64) NOT NULL,
  token VARCHAR(64) NOT NULL,
  last_used TIMESTAMP WITH TIME ZONE NOT NULL
);

CREATE TABLE lu_role (
  code CHARACTER VARYING(2) PRIMARY KEY,
  description TEXT
);
INSERT INTO lu_role VALUES ('R1', 'Provider');
INSERT INTO lu_role VALUES ('R2', 'Service Agent');
INSERT INTO lu_role VALUES ('R3', 'Service Administrator');
INSERT INTO lu_role VALUES ('R4', 'System Administrator');

CREATE TABLE cms_user (
  user_id TEXT PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  first_name TEXT,
  middle_name TEXT,
  last_name TEXT,
  phone_number TEXT,
  email TEXT,
  status TEXT,
  role_code CHARACTER VARYING(2) REFERENCES lu_role(code)
);


INSERT INTO cms_user(user_id, username, first_name, last_name, email, status, role_code)
VALUES('SYSTEM', 'system', 'system', 'system', 'system@example.com', 'ACTIVE', 'R4');

CREATE TABLE cms_authentication(
  username TEXT PRIMARY KEY,
  password TEXT NOT NULL
);

INSERT INTO cms_authentication (username, password)
VALUES ('system', '{SHA}MX8edh8vqo2ngaR2K53MLFytIJo='); -- password: system

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
