USE church;

INSERT INTO unit_type
(unit_type_name)
VALUES
  ('Stake')
, ('Ward');

INSERT INTO unit
( unit_name
, unit_type_id
, parent_unit_id)
VALUES
( '6th'
, 1
, NULL)
, ('13th'
,  2
,  1);