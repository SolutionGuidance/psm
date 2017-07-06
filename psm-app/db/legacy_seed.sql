DROP TABLE IF EXISTS
  external_account_link,
  external_profile_link,
  profile_assured_ext_svcs,
  profile_assured_svc_xref,
  required_fld
CASCADE ;

create table external_account_link
(
	external_account_link_id bigint not null
		constraint external_account_link_pkey
			primary key,
	user_id varchar(255),
	system_id varchar(255),
	external_user_id varchar(255)
)
;

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

create table profile_assured_ext_svcs
(
	profile_assured_svc_id bigint not null,
	elt varchar(255) not null
)
;

create table profile_assured_svc_xref
(
	profile_assured_svc_id bigint not null
		constraint profile_assured_svc_xref_pkey
			primary key,
	eff_dt date,
	svc_assurance_cd varchar(255),
	profile_id bigint,
	ticket_id bigint,
	status integer
)
;

alter table profile_assured_ext_svcs
	add constraint fknpq45dvbn0v9qxjrp3ccs81uy
		foreign key (profile_assured_svc_id) references profile_assured_svc_xref
;

create table required_fld
(
	code varchar(2) not null
		constraint required_fld_pkey
			primary key,
	description varchar(255),
	required_fld_type_id varchar(2)
		constraint fk3pj5itnxvpohvq0q8skilyal0
			references required_fld
)
;
