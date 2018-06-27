DROP TABLE IF EXISTS
  external_account_links,
  external_profile_links,
  provider_services
CASCADE;

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
