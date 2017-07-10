DROP TABLE IF EXISTS
  external_profile_link
CASCADE ;

create table external_profile_link
(
	external_profile_link_id bigint not null
		constraint external_profile_link_pkey
			primary key,
	profile_id bigint,
	system_id varchar(255),
	external_profile_id varchar(255)
)
;
