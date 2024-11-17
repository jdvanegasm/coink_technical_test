drop database if exists coink_db;
create database coink_db;

\c coink_db;

drop schema if exists public cascade;
create schema public;

create table divisions_types(
	division_id serial primary key,
	type varchar (40) unique not null
);

create table global_regions(
	global_region_id serial primary key,
	region_code varchar (10) unique not null,
	region_name varchar (40) unique not null
);

create table countries(
	country_id serial primary key,
	country_name varchar (35) unique not null,
	country_code varchar (10) unique not null,
	global_region_id int not null,
	division_id int not null,
	--- foreign keys definition
	constraint fk_global_region_id foreign key (global_region_id)
		references global_regions (global_region_id)
		on delete cascade
		on update cascade,
	constraint fk_division_id foreign key (division_id)
		references divisions_types (division_id)
		on delete cascade
		on update cascade
);

create table regions(
	region_id serial primary key,
	region_name varchar(50) not null,
	country_id int not null,
	--- foreign key definition
	constraint fk_country_id foreign key (country_id)
		references countries (country_id)
		on delete cascade
		on update cascade
);

create table municipalities(
	municipality_id serial primary key,
	municipality_name varchar (50) not null,
	region_id int not null,
	--- foreign key definition
	constraint fk_region_id foreign key (region_id)
	references regions (region_id)
	on delete cascade
	on update cascade
);

create table users(
	user_id uuid primary key,
	name varchar (50) not null,
	phone varchar (20) not null,
	address varchar (50) not null,
	user_country_id int not null,
	user_region_id int not null,
	user_municipality_id int not null,
	--- foreign keys definition
	constraint fk_country_id foreign key (user_country_id)
		references countries (country_id)
		on delete cascade
		on update cascade,
	constraint fk_region_id foreign key (user_region_id)
		references regions (region_id)
		on delete cascade
		on update cascade,
	constraint fk_municipality_id foreign key (user_municipality_id)
		references municipalities (municipality_id)
		on delete cascade
		on update cascade
);