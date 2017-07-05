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
CASCADE;

DROP TABLE IF EXISTS
  attachment,
  booleanexpression,
  content,
  deadline,
  delegation_delegates,
  email_header,
  escalation,
  eventtypes,
  i18ntext,
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
  reassignment,
  reassignment_potentialowners,
  sessioninfo,
  subtasksstrategy,
  task,
  task_comment,
  workiteminfo
CASCADE;

CREATE TABLE organizationalentity (
  id TEXT PRIMARY KEY,
  dtype TEXT NOT NULL
);
INSERT INTO organizationalentity (id, dtype) VALUES
  ('Administrator', 'User'),
  ('Service Administrator', 'Group'),
  ('Service Agent', 'Group'),
  ('System Administrator', 'Group');

CREATE TABLE task (
  id BIGINT PRIMARY KEY,
  archived SMALLINT,
  allowedtodelegate TEXT,
  priority INTEGER NOT NULL,
  activationtime TIMESTAMP WITH TIME ZONE,
  completedon TIMESTAMP WITH TIME ZONE,
  createdon TIMESTAMP WITH TIME ZONE,
  documentaccesstype INTEGER,
  documentcontentid BIGINT NOT NULL,
  documenttype TEXT,
  expirationtime TIMESTAMP WITH TIME ZONE,
  faultaccesstype INTEGER,
  faultcontentid BIGINT NOT NULL,
  faultname TEXT,
  faulttype TEXT,
  outputaccesstype INTEGER,
  outputcontentid BIGINT NOT NULL,
  outputtype TEXT,
  parentid BIGINT NOT NULL,
  previousstatus INTEGER,
  processid TEXT,
  processinstanceid BIGINT NOT NULL,
  processsessionid INTEGER NOT NULL,
  skipable BOOLEAN NOT NULL,
  status TEXT,
  workitemid BIGINT NOT NULL,
  optlock INTEGER,
  taskinitiator_id TEXT
    REFERENCES organizationalentity(id),
  actualowner_id TEXT
    REFERENCES organizationalentity(id),
  createdby_id TEXT
    REFERENCES organizationalentity(id)
);

CREATE SEQUENCE attachment_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
CREATE TABLE attachment (
  id BIGINT PRIMARY KEY,
  accesstype INTEGER,
  attachedat TIMESTAMP WITH TIME ZONE,
  attachmentcontentid BIGINT NOT NULL,
  contenttype TEXT,
  name TEXT,
  attachment_size INTEGER,
  attachedby_id TEXT
    REFERENCES organizationalentity(id),
  taskdata_attachments_id BIGINT
    REFERENCES task(id)
);

CREATE SEQUENCE content_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
CREATE TABLE content (
  id BIGINT PRIMARY KEY,
  content OID
);

CREATE SEQUENCE deadline_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
CREATE TABLE deadline (
  id BIGINT PRIMARY KEY,
  deadline_date TIMESTAMP WITH TIME ZONE,
  escalated SMALLINT,
  deadlines_startdeadline_id BIGINT
    REFERENCES task(id),
  deadlines_enddeadline_id BIGINT
    REFERENCES task(id)
);

CREATE TABLE delegation_delegates (
  task_id BIGINT NOT NULL
    REFERENCES task(id),
  entity_id TEXT NOT NULL
    REFERENCES organizationalentity(id),
  PRIMARY KEY (task_id, entity_id)
);

CREATE SEQUENCE emailnotifhead_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
CREATE TABLE email_header (
  id BIGINT PRIMARY KEY,
  body TEXT,
  fromaddress TEXT,
  language TEXT,
  replytoaddress TEXT,
  subject TEXT
);

CREATE SEQUENCE escalation_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
CREATE TABLE escalation (
  id BIGINT PRIMARY KEY,
  name TEXT,
  deadline_escalation_id BIGINT
    REFERENCES deadline(id)
);

CREATE SEQUENCE booleanexpr_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
CREATE TABLE booleanexpression (
  id BIGINT PRIMARY KEY,
  expression TEXT,
  type TEXT,
  escalation_constraints_id BIGINT
    REFERENCES escalation(id)
);

CREATE SEQUENCE notification_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
CREATE TABLE notification (
  id BIGINT PRIMARY KEY,
  dtype TEXT NOT NULL,
  priority INTEGER NOT NULL,
  escalation_notifications_id BIGINT
    REFERENCES escalation(id)
);

CREATE SEQUENCE reassignment_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
CREATE TABLE reassignment (
  id BIGINT PRIMARY KEY,
  escalation_reassignments_id BIGINT
    REFERENCES escalation(id)
);

CREATE SEQUENCE i18ntext_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
CREATE TABLE i18ntext (
  id BIGINT PRIMARY KEY,
  language TEXT,
  shorttext TEXT,
  text TEXT,
  task_subjects_id BIGINT
    REFERENCES task(id),
  task_names_id BIGINT
    REFERENCES task(id),
  task_descriptions_id BIGINT
    REFERENCES task(id),
  reassignment_documentation_id BIGINT
    REFERENCES reassignment(id),
  notification_subjects_id BIGINT
    REFERENCES notification(id),
  notification_names_id BIGINT
    REFERENCES notification(id),
  notification_documentation_id BIGINT
    REFERENCES notification(id),
  notification_descriptions_id BIGINT
    REFERENCES notification(id),
  deadline_documentation_id BIGINT
    REFERENCES deadline(id)
);

CREATE TABLE notification_bas (
  task_id bigint NOT NULL
    REFERENCES notification(id),
  entity_id TEXT NOT NULL
    REFERENCES organizationalentity(id),
  PRIMARY KEY (task_id, entity_id)
);

CREATE TABLE notification_email_header (
  emailnotification_id bigint NOT NULL
    REFERENCES notification(id),
  emailheaders_id BIGINT UNIQUE NOT NULL
    REFERENCES email_header(id),
  mapkey TEXT NOT NULL,
  PRIMARY KEY (emailnotification_id, mapkey)
);

CREATE TABLE notification_recipients (
  task_id BIGINT NOT NULL
    REFERENCES notification(id),
  entity_id TEXT NOT NULL
    REFERENCES organizationalentity(id),
  PRIMARY KEY (task_id, entity_id)
);

CREATE TABLE peopleassignments_bas (
  task_id BIGINT NOT NULL
    REFERENCES task(id),
  entity_id TEXT NOT NULL
    REFERENCES organizationalentity(id),
  PRIMARY KEY (task_id, entity_id)
);

CREATE TABLE peopleassignments_exclowners (
  task_id BIGINT NOT NULL
    REFERENCES task(id),
  entity_id TEXT NOT NULL
    REFERENCES organizationalentity(id),
  PRIMARY KEY (task_id, entity_id)
);

CREATE TABLE peopleassignments_potowners (
  task_id BIGINT NOT NULL
    REFERENCES task(id),
  entity_id TEXT NOT NULL
    REFERENCES organizationalentity(id),
  PRIMARY KEY (task_id, entity_id)
);

CREATE TABLE peopleassignments_recipients (
  task_id BIGINT NOT NULL
    REFERENCES task(id),
  entity_id TEXT NOT NULL
    REFERENCES organizationalentity(id),
  PRIMARY KEY (task_id, entity_id)
);

CREATE TABLE peopleassignments_stakeholders (
  task_id BIGINT NOT NULL
    REFERENCES task(id),
  entity_id TEXT NOT NULL
    REFERENCES organizationalentity(id),
  PRIMARY KEY (task_id, entity_id)
);

CREATE TABLE processinstanceinfo (
  instanceid BIGINT PRIMARY KEY,
  id BIGINT,
  lastmodificationdate TIMESTAMP WITH TIME ZONE,
  lastreaddate TIMESTAMP WITH TIME ZONE,
  processid TEXT,
  processinstancebytearray OID,
  startdate TIMESTAMP WITH TIME ZONE,
  state INTEGER NOT NULL,
  optlock INTEGER
);

CREATE TABLE eventtypes (
  instanceid BIGINT NOT NULL
    REFERENCES processinstanceinfo(instanceid),
  eventtypes TEXT
);

CREATE TABLE reassignment_potentialowners (
  task_id bigint NOT NULL
    REFERENCES reassignment(id),
  entity_id TEXT NOT NULL
    REFERENCES organizationalentity(id)
);

CREATE SEQUENCE sessioninfo_id_seq
  START WITH 1
  INCREMENT BY 50
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
CREATE TABLE sessioninfo (
  id INTEGER PRIMARY KEY,
  lastmodificationdate TIMESTAMP WITH TIME ZONE,
  rulesbytearray OID,
  startdate TIMESTAMP WITH TIME ZONE,
  optlock INTEGER
);

CREATE TABLE subtasksstrategy (
  id bigint PRIMARY KEY,
  dtype TEXT NOT NULL,
  name TEXT,
  task_id bigint
    REFERENCES task(id)
);

CREATE SEQUENCE comment_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
CREATE TABLE task_comment (
  id BIGINT PRIMARY KEY,
  addedat TIMESTAMP WITH TIME ZONE,
  text TEXT,
  addedby_id TEXT
    REFERENCES organizationalentity(id),
  taskdata_comments_id BIGINT
    REFERENCES task(id)
);

CREATE SEQUENCE workiteminfo_id_seq
  START WITH 1
  INCREMENT BY 50
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
CREATE TABLE workiteminfo (
  workitemid BIGINT PRIMARY KEY,
  creationdate TIMESTAMP WITH TIME ZONE,
  name TEXT,
  processinstanceid BIGINT NOT NULL,
  state BIGINT NOT NULL,
  optlock INTEGER,
  workitembytearray OID
);
