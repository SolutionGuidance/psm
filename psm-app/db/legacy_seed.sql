DROP TABLE IF EXISTS
  external_account_link,
  external_profile_link,
  legacy_mapping,
  profile_assured_ext_svcs,
  profile_assured_svc_xref,
  provider_cos,
  provider_cos_xref,
  provider_svcs,
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

create table legacy_mapping
(
	legacy_mapping_id bigint not null
		constraint legacy_mapping_pkey
			primary key,
	system_nm varchar(255),
	code_type varchar(255),
	internal_code varchar(255),
	external_code varchar(255)
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

create table provider_cos
(
	provider_cos_id bigint not null,
	provider_cos_cd varchar(255) not null
)
;

create table provider_cos_xref
(
	provider_cos_id bigint not null
		constraint provider_cos_xref_pkey
			primary key,
	profile_id bigint default 0,
	ticket_id bigint default 0,
	start_dt timestamp not null,
	end_dt timestamp
)
;

alter table provider_cos
	add constraint fk2ciqibe0u9h2cmyeut8q5alir
		foreign key (provider_cos_id) references provider_cos_xref
;

create table provider_svcs
(
	provider_svcs_id bigint not null
		constraint provider_svcs_pkey
			primary key,
	profile_id bigint default 0 not null,
	ticket_id bigint default 0 not null,
	svc_cat_cd varchar(255)
)
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
