
----- Pivot & Unpivot

create table master.sales (id serial, year int, quater int, amount int);

insert into
  master.sales (year, quater, amount)
values
  (2022, 1, 340),
  (2023, 2, 420),
  (2022, 3, 380),
  (2023, 3, 450),
  (2022, 2, 500);

select
  *
from
  master.sales;

select
  *
from
  crosstab (
    'select year, quater, amount from master.sales order by 1,2',
    'select distinct quater from master.sales order by 1'
  ) as ct (year int, quater1 int, quater2 int, quater3 int)
order by
  1;

select
  "year",
  sum(
    case
      when quater = 1 then amount
    end
  ) as quater1,
  sum(
    case
      when quater = 2 then amount
    end
  ) as quater2,
  sum(
    case
      when quater = 3 then amount
    end
  ) as quater3 into master.pivoted_table
from
  master.sales
group by
  1;

select
  *
from
  master.pivoted_table;

select
  year,
  1 as quater,
  quater1 as amount
from
  master.pivoted_table
where
  quater1 is not null
union all
select
  year,
  2 as quater,
  quater2 as amount
from
  master.pivoted_table
where
  quater2 is not null
union all
select
  year,
  3 as quater,
  quater3 as amount
from
  master.pivoted_table
where
  quater3 is not null;

create type dp as (
  dept_name varchar,
  manager_id int,
  description text
);

-------Custom Data Type

create table master.department (id serial, dept_info dp, location_id int);

select
  *
from
  master.department;

insert into
  master.department (dept_info, location_id)
values
  (
    (
      'Data Engineer',
      150,
      'Big data enables predictive insights'
    ),
    10001
  ),
  (
    (
      'Data Analyst',
      160,
      'Visualization makes data easily understandable'
    ),
    10002
  ),
  (
    (
      'Business Intelligence',
      170,
      'Business intelligence transforms raw data'
    ),
    10003
  ),
  (
    (
      'Data Scientist',
      180,
      'Machine learning improves data prediction'
    ),
    10004
  );

select
  (dept_info).dept_name,
  (dept_info).manager_id,
  (dept_info).description,
  location_id
from
  master.department;

create type emts as enum('happy', 'sad', 'funny');

create table master.emotion (id serial, emotion emts, human_name varchar);

select
  *
from
  master.emotion;

insert into
  master.emotion (emotion, human_name)
values
  ('happy', 'Monir'),
  ('sad', 'Jerin'),
  ('funny', 'Ariful'),
  ('sad', 'Jahid'),
  ('happy', 'Rasel');

create type call_type as range (subtype = time);

create table master.callhistory (
  id serial,
  callduration call_type,
  _user int,
  created_at timestamp default current_timestamp
);

insert into
  master.callhistory (callduration, _user)
values
  ('[9:20, 9:25)', 3454),
  ('[9:30, 9:35)', 3243),
  ('[9:15, 9:18)', 4355),
  ('[10:08, 10:10)', 2134),
  ('[10:15, 10:20)', 3473);

select
  *
from
  master.callhistory;

select
  *
from
  master.callhistory
where
  callduration @> '9:22'::time;

select
  *
from
  master.callhistory
where
  callduration && '[9:30, 9:35)'::call_type;

create type qua as (q varchar, a varchar);

create table master.auto_genarated_qa (
  id serial,
  question qua,
  is_added_by int,
  is_created timestamp default current_timestamp,
  is_updated timestamp default now(),
  is_deleted BOOLEAN default false
);

insert into
  master.auto_genarated_qa (question, is_added_by)
values
  (('what''s you name cat?', 'pushi'), 74909),
  (('how old is your dog', '10 Years'), 43763);

select
  (question).q
from
  master.auto_genarated_qa;

select
  (question).a
from
  master.auto_genarated_qa;

select
  (question).a
from
  master.auto_genarated_qa
where
  (question).q = 'what''s you name cat?';

select
  (question).a
from
  master.auto_genarated_qa
where
  (question).q = 'how old is your dog';

select
  *
from
  master.auto_genarated_qa;