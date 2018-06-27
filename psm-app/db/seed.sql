DROP TABLE IF EXISTS
  external_account_links,
  external_profile_links
CASCADE;

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
