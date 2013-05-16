INSERT INTO lu_specialty_type (code, description) values ('S7', 'Certified Nurse Midwife');
INSERT INTO lu_issuing_board(code, description) VALUES ('C7', 'AMCB');
UPDATE provider_setting SET related_entity_cd = 'S7' WHERE related_entity_cd = 'S2' AND provider_typ_cd = '25';
UPDATE provider_setting SET related_entity_cd = 'C7' WHERE related_entity_cd = 'B2' AND provider_typ_cd = '25';