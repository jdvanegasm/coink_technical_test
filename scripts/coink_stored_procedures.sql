--- owner Juan Daniel Vanegas Mayorquin

/*
stored procedure for register a new user
*/
create or replace function sp_register_user (
	p_name varchar,
	p_phone varchar,
	p_address varchar,
	p_country_id int,
	p_region_id int,
	p_municipality_id int
) returns void as $$
begin
	if not exists(
	select 1
	from municipalities m
	join regions r on m.region_id = r.region_id
	join countries c on r.country_id = c.country_id
	where m.municipality_id = p_municipality_id
		and r.region_id = p_region_id
		and c.country_id = p_country_id
	) then
		raise exception 'The hierarchy Country -> Region -> Municipality is not valid';
end if;
insert into users (user_id, name, phone, address, user_country_id, user_region_id, user_municipality_id)
values (gen_random_uuid(), p_name, p_phone, p_address, p_country_id, p_region_id, p_municipality_id);
end;
$$ language plpgsql;

/*
stored procedure to check if a phone number is already registered
*/
create or replace function sp_check_phone_exists (p_phone varchar)
returns boolean as $$
begin
	return exists(
		select 1
		from users
		where phone = p_phone
	);
end;
$$ language plpgsql;

/*
stored procedure to get users by location
*/
create or replace function sp_get_users_by_location (
	p_country_id int,
	p_region_id int,
	p_municipality_id int
) returns table (
	user_id uuid,
	name varchar,
	phone varchar,
	address varchar,
	country_name varchar,
	region_name varchar,
	municipality_name varchar
) as $$
begin
	return query
	select u.user_id, u.name, u.phone, u.address, c.country_name, r.region_name, m.municipality_name
	from users u
	join countries c on u.user_country_id = c.country_id
	join regions r on u.user_region_id = r.region_id
	join municipalities m on u.user_municipality_id = m.municipality_id
	where u.user_country_id = p_country_id
		and u.user_region_id = p_region_id
		and u.user_municipality_id = p_municipality_id;
end;
$$ language plpgsql;

/*
stored procedure to get all countries
*/
create or replace function sp_get_countries()
returns table (
	country_id int,
	country_name varchar,
	country_code varchar,
	global_region_name varchar,
	division_type varchar
) as $$
begin
	return query
	select
		c.country_id,
		c.country_name,
		c.country_code,
		gr.region_name as global_region_name,
		dt.type as division_type
	from
		countries c
	join
		global_regions gr on c.global_region_id = gr.global_region_id
	join
		divisions_types dt on c.division_id = dt.division_id;
end;
$$ language plpgsql;

/*
stored procedure to get municipalities of a region
*/
create or replace function sp_get_municipalities_by_region(p_region_id int)
returns table (
	municipality_id int,
	municipality_name varchar
) as $$
begin
	return query
	select municipalities.municipality_id, municipalities.municipality_name
	from municipalities
	where municipalities.region_id = p_region_id;
end;
$$ language plpgsql;

/*
stored procedure to get regions from a country
*/
create or replace function sp_get_regions_by_country(p_country_id int)
returns table (
	region_id int,
	region_name varchar
) as $$
begin
	return query
	select regions.region_id, regions.region_name
	from regions
	where country_id = p_country_id;
end;
$$ language plpgsql;

/*
stored procedure to get de ubication hierarchy (not implemented in the API)
*/
create or replace function sp_validate_location(
	p_country_id int,
	p_region_id int,
	p_municipality_id int
) returns boolean as $$
begin
	return exists (
		select 1
		from municipalities m
		join regions r on m.region_id = r.region_id
		join countries c on r.country_id = c.country_id
		where m.municipality_id = p_municipality_id
			and r.region_id = p_region_id
			and c.country_id = p_country_id
	);
end;
$$ language plpgsql;

/*
stored procedure to update an user
*/
create or replace function sp_update_user (
    p_user_id uuid,
    p_name varchar,
    p_phone varchar,
    p_address varchar,
    p_country_id int,
    p_region_id int,
    p_municipality_id int
) returns void as $$
begin
    if not exists (
        select 1
        from municipalities m
        join regions r on m.region_id = r.region_id
        join countries c on r.country_id = c.country_id
        where m.municipality_id = p_municipality_id
          and r.region_id = p_region_id
          and c.country_id = p_country_id
    ) then
        raise exception 'The hierarchy Country -> Region -> Municipality is not valid';
    end if;

    update users
    set name = p_name,
        phone = p_phone,
        address = p_address,
        user_country_id = p_country_id,
        user_region_id = p_region_id,
        user_municipality_id = p_municipality_id
    where user_id = p_user_id;

    if not found then
        raise exception 'User with ID % does not exist', p_user_id;
    end if;
end;
$$ language plpgsql;

/*
stored procedure to delete an user
*/
create or replace function sp_delete_user(p_user_id uuid)
returns void as $$
begin
    delete from users where user_id = p_user_id;

    if not found then
        raise exception 'User with ID % does not exist', p_user_id;
    end if;
end;
$$ language plpgsql;