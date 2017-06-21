DROP SEQUENCE IF EXISTS 
 attachment_id_seq,
 booleanexpr_id_seq,
 comment_id_seq,
 content_id_seq,
 deadline_id_seq,
 emailnotifhead_id_seq,
 escalation_id_seq,
 i18ntext_id_seq,
 notification_id_seq,
 reassignment_id_seq,
 sessioninfo_id_seq,
 workiteminfo_id_seq
CASCADE ;

  
DROP TABLE  IF EXISTS 
  attachment,
  booleanexpression,
  content,
  deadline,
  delegation_delegates,
  email_header,
  escalation,
  event,
  eventtypes,
  external_account_link,
  external_profile_link,
  i18ntext,
  legacy_mapping,
  notification,
  notification_bas,
  notification_email_header,
  notification_recipients,
  organizationalentity,
  peopleassignments_bas,
  peopleassignments_exclowners,
  peopleassignments_potowners,
  peopleassignments_recipients,
  peopleassignments_stakeholders,
  processinstanceinfo,
  profile_assured_ext_svcs,
  profile_assured_svc_xref,
  profile_notes,
  profile_payto_xref,
  provider_cos,
  provider_cos_xref,
  provider_setting,
  provider_svcs,
  reassignment,
  reassignment_potentialowners,
  required_fld,
  sessioninfo,
  subtasksstrategy,
  task,
  task_comment,
  workiteminfo
CASCADE ;


create sequence attachment_id_seq;
create sequence booleanexpr_id_seq;
create sequence comment_id_seq;
create sequence content_id_seq;
create sequence deadline_id_seq;
create sequence emailnotifhead_id_seq;
create sequence escalation_id_seq;
create sequence i18ntext_id_seq;
create sequence notification_id_seq;
create sequence reassignment_id_seq;
create sequence sessioninfo_id_seq;
create sequence workiteminfo_id_seq;

create table attachment
(
	id bigint not null
		constraint attachment_pkey
			primary key,
	accesstype integer,
	attachedat timestamp,
	attachmentcontentid bigint not null,
	contenttype varchar(255),
	name varchar(255),
	attachment_size integer,
	attachedby_id varchar(255),
	taskdata_attachments_id bigint
)
;

create table booleanexpression
(
	id bigint not null
		constraint booleanexpression_pkey
			primary key,
	expression text,
	type varchar(255),
	escalation_constraints_id bigint
)
;

create table content
(
	id bigint not null
		constraint content_pkey
			primary key,
	content oid
)
;

create table deadline
(
	id bigint not null
		constraint deadline_pkey
			primary key,
	deadline_date timestamp,
	escalated smallint,
	deadlines_startdeadline_id bigint,
	deadlines_enddeadline_id bigint
)
;

create table delegation_delegates
(
	task_id bigint not null,
	entity_id varchar(255) not null
)
;

create table email_header
(
	id bigint not null
		constraint email_header_pkey
			primary key,
	body text,
	fromaddress varchar(255),
	language varchar(255),
	replytoaddress varchar(255),
	subject varchar(255)
)
;

create table escalation
(
	id bigint not null
		constraint escalation_pkey
			primary key,
	name varchar(255),
	deadline_escalation_id bigint
		constraint fk37v8ova8ti6jiblda7n6j298e
			references deadline
)
;

alter table booleanexpression
	add constraint fkqth56a8k6d8pv6ngsu2vjp4kj
		foreign key (escalation_constraints_id) references escalation
;

create table event
(
	event_id bigint not null
		constraint event_pkey
			primary key,
	npi varchar(10),
	ticket_id bigint,
	status_cd varchar(2),
	created_by varchar(50),
	create_ts timestamp
)
;

create table eventtypes
(
	instanceid bigint not null,
	eventtypes varchar(255)
)
;

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

create table i18ntext
(
	id bigint not null
		constraint i18ntext_pkey
			primary key,
	language varchar(255),
	text text,
	task_subjects_id bigint,
	task_names_id bigint,
	task_descriptions_id bigint,
	reassignment_documentation_id bigint,
	notification_subjects_id bigint,
	notification_names_id bigint,
	notification_documentation_id bigint,
	notification_descriptions_id bigint,
	deadline_documentation_id bigint
		constraint fk8wn7sw34q6bifsi1pvl2b1yyb
			references deadline
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

create table notification
(
	dtype varchar(31) not null,
	id bigint not null
		constraint notification_pkey
			primary key,
	priority integer not null,
	escalation_notifications_id bigint
		constraint fkoxq5uqfg4ylwyijsg2ubyflna
			references escalation
)
;

alter table i18ntext
	add constraint fkthf8ix3t3opf9hya1s04hwsx8
		foreign key (notification_subjects_id) references notification
;

alter table i18ntext
	add constraint fkg2jsybeuc8pbj8ek8xwxutuyo
		foreign key (notification_names_id) references notification
;

alter table i18ntext
	add constraint fkp0m7uhipskrljktvfeubdgfid
		foreign key (notification_documentation_id) references notification
;

alter table i18ntext
	add constraint fk6k8hmfvhko069970eghiy2ifp
		foreign key (notification_descriptions_id) references notification
;

create table notification_bas
(
	task_id bigint not null
		constraint fkb123fgeomc741s9yc014421yy
			references notification,
	entity_id varchar(255) not null
)
;

create table notification_email_header
(
	emailnotification_id bigint not null
		constraint fk1nrqk2dtn3c9ytwxy70t0i73b
			references notification,
	emailheaders_id bigint not null
		constraint uk_ptaka5kost68h7l3wflv7w6y8
			unique
		constraint fkd74pdu41avy2f7a8qyp7wn2n
			references email_header,
	mapkey varchar(255) not null,
	constraint notification_email_header_pkey
		primary key (emailnotification_id, mapkey)
)
;

create table notification_recipients
(
	task_id bigint not null
		constraint fkn7v944d0hw37bh0auv4gr3hsf
			references notification,
	entity_id varchar(255) not null
)
;

create table organizationalentity
(
	dtype varchar(31) not null,
	id varchar(255) not null
		constraint organizationalentity_pkey
			primary key
)
;

alter table attachment
	add constraint fkd5xpm81gxg8n40167lbu5rbfb
		foreign key (attachedby_id) references organizationalentity
;

alter table delegation_delegates
	add constraint fkewkdyi0wrgy9byp6abyglpcxq
		foreign key (entity_id) references organizationalentity
;

alter table notification_bas
	add constraint fk378pb1cvjv54w4ljqpw99s3wr
		foreign key (entity_id) references organizationalentity
;

alter table notification_recipients
	add constraint fkot769nimyq1jvw0m61pgsq5g3
		foreign key (entity_id) references organizationalentity
;

create table peopleassignments_bas
(
	task_id bigint not null,
	entity_id varchar(255) not null
		constraint fka90cdfgc4km384n1ataqigq67
			references organizationalentity
)
;

create table peopleassignments_exclowners
(
	task_id bigint not null,
	entity_id varchar(255) not null
		constraint fk5ituvd6t8uvp63hsx6282xo6h
			references organizationalentity
)
;

create table peopleassignments_potowners
(
	task_id bigint not null,
	entity_id varchar(255) not null
		constraint fksa3rrrjsm1qw98ajbbu2s7cjr
			references organizationalentity
)
;

create table peopleassignments_recipients
(
	task_id bigint not null,
	entity_id varchar(255) not null
		constraint fkrd0h9ud1bhs9waf2mdmiv6j2r
			references organizationalentity
)
;

create table peopleassignments_stakeholders
(
	task_id bigint not null,
	entity_id varchar(255) not null
		constraint fk9uy76cu650rg1nnkrtjwj1e9t
			references organizationalentity
)
;

create table processinstanceinfo
(
	instanceid bigint not null
		constraint processinstanceinfo_pkey
			primary key,
	id bigint,
	lastmodificationdate date,
	lastreaddate date,
	processid varchar(255),
	processinstancebytearray oid,
	startdate date,
	state integer not null,
	optlock integer
)
;

alter table eventtypes
	add constraint fkj0o3uve2nqo5yrjwrkc9jfttq
		foreign key (instanceid) references processinstanceinfo
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

create table profile_notes
(
	provider_note_id bigint not null
		constraint profile_notes_pkey
			primary key,
	profile_id bigint,
	ticket_id bigint,
	note_txt varchar(255),
	created_by varchar(255),
	create_ts date
)
;

create table profile_payto_xref
(
	profile_payto_xref_id bigint not null
		constraint profile_payto_xref_pkey
			primary key,
	eff_dt date,
	payto_typ_cd varchar(255),
	profile_id bigint,
	ticket_id bigint,
	target_profile_id bigint,
	name varchar(255),
	contact_name varchar(255),
	npi varchar(255),
	phone_number varchar(255)
)
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

create table provider_setting
(
	provider_setting_id bigint not null
		constraint provider_setting_pkey
			primary key,
	provider_typ_cd varchar(255),
	rel_typ varchar(2),
	related_entity_typ varchar(255),
	related_entity_cd varchar(255)
)
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

create table reassignment
(
	id bigint not null
		constraint reassignment_pkey
			primary key,
	escalation_reassignments_id bigint
		constraint fkessy30safh44b30f1cfoujv2k
			references escalation
)
;

alter table i18ntext
	add constraint fkqxgws3fnukyqlaet11tivqg5u
		foreign key (reassignment_documentation_id) references reassignment
;

create table reassignment_potentialowners
(
	task_id bigint not null
		constraint fkftegfexshix752bh2jfxf6bnh
			references reassignment,
	entity_id varchar(255) not null
		constraint fksqrmpvehlc4qe9i0km22nmkjl
			references organizationalentity
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

create table sessioninfo
(
	id integer not null
		constraint sessioninfo_pkey
			primary key,
	lastmodificationdate timestamp,
	rulesbytearray oid,
	startdate timestamp,
	optlock integer
)
;

create table subtasksstrategy
(
	dtype varchar(100) not null,
	id bigint not null
		constraint subtasksstrategy_pkey
			primary key,
	name varchar(255),
	task_id bigint
)
;

create table task
(
	id bigint not null
		constraint task_pkey
			primary key,
	archived smallint,
	allowedtodelegate varchar(255),
	priority integer not null,
	activationtime timestamp,
	createdon timestamp,
	documentaccesstype integer,
	documentcontentid bigint not null,
	documenttype varchar(255),
	expirationtime timestamp,
	faultaccesstype integer,
	faultcontentid bigint not null,
	faultname varchar(255),
	faulttype varchar(255),
	outputaccesstype integer,
	outputcontentid bigint not null,
	outputtype varchar(255),
	parentid bigint not null,
	previousstatus integer,
	processid varchar(255),
	processinstanceid bigint not null,
	processsessionid integer not null,
	skipable boolean not null,
	status varchar(255),
	workitemid bigint not null,
	optlock integer,
	taskinitiator_id varchar(255)
		constraint fk48d1bfgwf0jqow1yk8ku4xcpi
			references organizationalentity,
	actualowner_id varchar(255)
		constraint fkpmkxvqq63aed2y2boruu53a0s
			references organizationalentity,
	createdby_id varchar(255)
		constraint fkexuboqnbla7jfyyesyo61ucmb
			references organizationalentity
)
;

alter table attachment
	add constraint fkjj9psk52ifamilliyo16epwpc
		foreign key (taskdata_attachments_id) references task
;

alter table deadline
	add constraint fk361ggw230po88svgfasg36i2w
		foreign key (deadlines_startdeadline_id) references task
;

alter table deadline
	add constraint fkpeiadnoy228t35213t63c3imm
		foreign key (deadlines_enddeadline_id) references task
;

alter table delegation_delegates
	add constraint fk85x3trafk3wfbrv719cafr591
		foreign key (task_id) references task
;

alter table i18ntext
	add constraint fkcd6eb4q62d9ab8p0di8pb99ch
		foreign key (task_subjects_id) references task
;

alter table i18ntext
	add constraint fkiogka67sji8fk4cp7a369895i
		foreign key (task_names_id) references task
;

alter table i18ntext
	add constraint fkrisdlmalotmk64mdeqpo4s5m0
		foreign key (task_descriptions_id) references task
;

alter table peopleassignments_bas
	add constraint fkt4xs0glwhbsa0xwg69r6xduv9
		foreign key (task_id) references task
;

alter table peopleassignments_exclowners
	add constraint fkqxbjm1b3dl7w8w2f2y6sk0fv8
		foreign key (task_id) references task
;

alter table peopleassignments_potowners
	add constraint fkh8oqmk4iuh2pmpgby6g8r3jd1
		foreign key (task_id) references task
;

alter table peopleassignments_recipients
	add constraint fk9gnbv6bplxkxoedj35vg8n7ir
		foreign key (task_id) references task
;

alter table peopleassignments_stakeholders
	add constraint fkaeyk4nwslvx0jywjomjq7083i
		foreign key (task_id) references task
;

alter table subtasksstrategy
	add constraint fk4e4k7ew5y1u0uvnjdj4wxp4il
		foreign key (task_id) references task
;

create table task_comment
(
	id bigint not null
		constraint task_comment_pkey
			primary key,
	addedat timestamp,
	text text,
	addedby_id varchar(255)
		constraint fkqb4mkarf209y9546w7n75lb7a
			references organizationalentity,
	taskdata_comments_id bigint
		constraint fkm2mwc1ukcpdsiqwgkoroy6ise
			references task
)
;

create table workiteminfo
(
	workitemid bigint not null
		constraint workiteminfo_pkey
			primary key,
	creationdate timestamp,
	name varchar(255),
	processinstanceid bigint not null,
	state bigint not null,
	optlock integer,
	workitembytearray oid
)
;


insert into OrganizationalEntity (DTYPE, id) values ('Group', 'Service Agent'),
('Group', 'Service Administrator'),
('Group', 'System Administrator'),
('User', 'Administrator');
