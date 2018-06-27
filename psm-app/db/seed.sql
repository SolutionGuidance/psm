DROP TABLE IF EXISTS
  external_profile_links
CASCADE;

CREATE TABLE external_profile_links(
  external_profile_link_id BIGINT PRIMARY KEY,
  profile_id BIGINT,
  system_id TEXT,
  external_profile_id TEXT
);
