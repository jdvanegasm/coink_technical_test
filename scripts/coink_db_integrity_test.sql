--- owner Juan Daniel Vanegas Mayorquin

begin;

--- insert data into divisions_types
insert into divisions_types (type) values 
('Federal'),
('Unitary');

select * from divisions_types;

--- insert data into global_regions
insert into global_regions (region_code, region_name) values 
('NA', 'North America'),
('EU', 'Europe');

select * from global_regions;

--- insert data into countries
insert into countries (country_name, country_code, global_region_id, division_id) values 
('United States', 'US', 1, 1),
('France', 'FR', 2, 2);

select * from countries;

--- insert data into regions
insert into regions (region_name, country_id) values 
('California', 1),
('Île-de-France', 2);

select * from regions;

--- insert data into municipalities
insert into municipalities (municipality_name, region_id) values 
('Los Angeles', 1),
('Paris', 2);

select * from municipalities;

--- insert data into users
insert into users (user_id, name, phone, address, user_country_id, user_region_id, user_municipality_id) values 
(gen_random_uuid(), 'John Doe', '+1 123-456-7890', '123 Main St', 1, 1, 1),
(gen_random_uuid(), 'Marie Curie', '+33 987-654-3210', '456 Rue de Paris', 2, 2, 2);

select * from users;

--- test update with cascade
update global_regions set region_name = 'North America Updated' where global_region_id = 1;

select * from global_regions;

--- test delete with cascade
delete from countries where country_id = 1;

select * from countries;

--- integrity check
select * from municipalities; --- verify related records are deleted
select * from users;          --- verify related records are deleted

--- validate integrity
select * 
from pg_constraint 
where conname like 'fk_%';

rollback;