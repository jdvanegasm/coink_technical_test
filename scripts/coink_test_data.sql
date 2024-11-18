--- insert data into divisions_types
insert into divisions_types (type) values
('Federal'),
('State'),
('Provincial'),
('Departmental');

--- insert data into global_regions
insert into global_regions (global_region_id, region_code, region_name) values
(1, 'LATAM', 'Latin America'),
(2, 'NA', 'North America'),
(3, 'EU', 'Europe'),
(4, 'ASIA', 'Asia');

--- insert data into countries (ensuring global_region_id exists)
insert into countries (country_name, country_code, global_region_id, division_id) values
('Colombia', 'CO', 1, 4),  -- latin america, departmental
('Argentina', 'AR', 1, 4), -- latin america, departmental
('United States', 'US', 2, 1); -- north america, federal

--- insert data into regions
insert into regions (region_name, country_id) values
('Cundinamarca', 1), -- colombia
('Bogotá DC', 1),    -- colombia
('Buenos Aires', 2), -- argentina
('California', 3);   -- united states

--- insert data into municipalities
insert into municipalities (municipality_name, region_id) values
('Soacha', 1),       -- cundinamarca
('Usaquén', 2),      -- bogotá dc
('Palermo', 3),      -- buenos aires
('Los Angeles', 4);  -- california