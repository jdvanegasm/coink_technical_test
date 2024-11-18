--- insert data into divisions_types
insert into divisions_types (type) values
('Federal'),
('State'),
('Provincial'),
('Municipal'),
('Metropolitan'),
('Departmental');

--- insert data into global_regions
insert into global_regions (global_region_id, region_code, region_name) values
(1, 'LATAM', 'Latin America'),
(2, 'NA', 'North America'),
(3, 'EU', 'Europe'),
(4, 'ASIA', 'Asia'),
(5, 'AFRICA', 'Africa'),
(6, 'OC', 'Oceania');

--- insert data into countries (ensuring global_region_id exists)
insert into countries (country_name, country_code, global_region_id, division_id) values
('Colombia', 'CO', 1, 4), --- latin america, departmental
('Argentina', 'AR', 1, 4), --- latin america, departmental
('United States', 'US', 2, 1), --- north america, federal
('Mexico', 'MX', 2, 1), --- North America, federal
('Germany', 'DE', 3, 3), --- Europe, provincial
('South Africa', 'ZA', 5, 4), --- Africa, departmental
('Australia', 'AU', 6, 2); --- Oceania, state

--- insert data into regions
insert into regions (region_name, country_id) values
('Cundinamarca', 1), --- colombia
('Bogotá DC', 1), --- colombia
('Buenos Aires', 2), --- argentina
('California', 3), --- united states
('Nuevo León', 4), --- mexico
('Bavaria', 5), --- germany
('Western Cape', 6), --- south africa
('New South Wales', 7); --- australia

--- insert data into municipalities
insert into municipalities (municipality_name, region_id) values
('Soacha', 1), --- cundinamarca
('Usaquén', 2), --- bogotá dc
('Palermo', 3), --- buenos aires
('Los Angeles', 4), --- california
('Monterrey', 5), --- nuevo león
('Munich', 6), --- bavaria
('Cape Town', 7), --- western cape
('Sydney', 8); --- new south wales