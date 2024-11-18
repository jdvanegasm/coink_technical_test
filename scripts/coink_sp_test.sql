--- owner Juan Daniel Vanegas

/*
test for sp_register_user
*/
begin;
--- call the stored procedure
select sp_register_user(
    'John Doe', 
    '555123456', 
    '123 Main Street', 
    1, -- colombia
    2, -- bogotá dc
    2  -- usaquén
);
--- check tables
select * from divisions_types;
select * from global_regions;
select * from countries;
select * from regions;
select * from municipalities;
select * from users;
rollback;

/*
test for sp_check_phone_exists
*/
begin;
--- insert sample data into the users table
insert into users (user_id, name, phone, address, user_country_id, user_region_id, user_municipality_id) values
(gen_random_uuid(), 'john doe', '555123456', '123 main street', 1, 2, 2),
(gen_random_uuid(), 'jane doe', '555987654', '456 elm street', 1, 1, 1);
--- check if a phone number exists
select sp_check_phone_exists('555123456') as phone_exists; --- expected: true
select sp_check_phone_exists('555987654') as phone_exists; --- expected: true
select sp_check_phone_exists('123456789') as phone_exists; --- expected: false
--- check with NULL value
select sp_check_phone_exists(NULL) as phone_exists; --- expected: false
--- check with an empty string
select sp_check_phone_exists('') as phone_exists; --- expected: false
rollback;

/*
test for sp_get_users_by_location
*/
begin;
--- insert sample data into users
insert into users (user_id, name, phone, address, user_country_id, user_region_id, user_municipality_id) values
(gen_random_uuid(), 'john doe', '555123456', '123 main street', 1, 1, 1),  --- Soacha, Cundinamarca, Colombia
(gen_random_uuid(), 'jane doe', '555987654', '456 elm street', 1, 2, 2),   --- Usaquén, Bogotá DC, Colombia
(gen_random_uuid(), 'juan perez', '555444555', '789 avenida siempre viva', 2, 3, 3); --- Palermo, Buenos Aires, Argentina
--- test: get users by valid location (Soacha, Cundinamarca, Colombia)
select * from sp_get_users_by_location(1, 1, 1);
--- test: get users by valid location (Usaquén, Bogotá DC, Colombia)
select * from sp_get_users_by_location(1, 2, 2);
--- test: get users by valid location (Palermo, Buenos Aires, Argentina)
select * from sp_get_users_by_location(2, 3, 3);
--- test: get users by invalid location (no matching users)
select * from sp_get_users_by_location(1, 1, 3); --- No users expected
rollback;

/*
test for sp_get_municipalities_by_region
*/
begin;
--- insert additional data into municipalities
insert into municipalities (municipality_name, region_id) values
('Zipaquirá', 1),    --- Additional municipality in Cundinamarca
('Chapinero', 2),    --- Additional municipality in Bogotá DC
('Recoleta', 3),     --- Additional municipality in Buenos Aires
('San Francisco', 4); --- Additional municipality in California
select * from sp_get_municipalities_by_region(1); --- expected: Soacha and Zipaquira
select * from sp_get_municipalities_by_region(2); --- expected: Usaquen and Chapinero
select * from sp_get_municipalities_by_region(3); --- expected: Palermo and Recoleta
select * from sp_get_municipalities_by_region(4); --- expected: Los Angeles and San Francisco
select * from sp_get_municipalities_by_region(99); --- expected: no rows
rollback;

/*
test for sp_get_regions_by_country
*/
begin;
select * from sp_get_regions_by_country(1); --- expected: Cundinamarca, Bogota DC
select * from sp_get_regions_by_country(2); --- expected: Buenos Aires
select * from sp_get_regions_by_country(3); --- expected: California
select * from sp_get_regions_by_country(99); --- expected: no rows
rollback;

/*
test for sp_validate_location
*/
begin;
--- Test 1: Validate a correct location (Soacha, Cundinamarca, Colombia)
select sp_validate_location(1, 1, 1) as is_valid; -- Expected: true
--- Test 2: Validate another correct location (Usaquén, Bogotá DC, Colombia)
select sp_validate_location(1, 2, 2) as is_valid; -- Expected: true
--- Test 3: Validate another correct location (Palermo, Buenos Aires, Argentina)
select sp_validate_location(2, 3, 3) as is_valid; -- Expected: true
--- Test 4: Validate another correct location (Los Angeles, California, United States)
select sp_validate_location(3, 4, 4) as is_valid; -- Expected: true
--- Test 5: Validate an incorrect location (Soacha with Bogotá DC, Colombia)
select sp_validate_location(1, 2, 1) as is_valid; -- Expected: false
--- Test 6: Validate an incorrect location (Usaquén with Cundinamarca, Colombia)
select sp_validate_location(1, 1, 2) as is_valid; -- Expected: false
--- Test 7: Validate a non-existent location (non-existent municipality)
select sp_validate_location(1, 1, 99) as is_valid; -- Expected: false
--- Test 8: Validate a non-existent location (non-existent region)
select sp_validate_location(1, 99, 1) as is_valid; -- Expected: false
--- Test 9: Validate a non-existent location (non-existent country)
select sp_validate_location(99, 1, 1) as is_valid; -- Expected: false
rollback;

/*
test to sp_update_user
*/
begin;

--- Insert sample data into users
insert into users (user_id, name, phone, address, user_country_id, user_region_id, user_municipality_id) values
(gen_random_uuid(), 'John Doe', '555123456', '123 Main St', 1, 1, 1), -- Soacha, Cundinamarca, Colombia
(gen_random_uuid(), 'Jane Doe', '555987654', '456 Elm St', 1, 2, 2), -- Usaquén, Bogotá DC, Colombia
(gen_random_uuid(), 'Juan Perez', '555444555', '789 Avenida Siempre Viva', 2, 3, 3); -- Palermo, Buenos Aires, Argentina

--- Fetch the user IDs for testing
select * from users;

--- Test 1: Update user with valid location (John Doe -> Los Angeles, California, United States)
do $$
declare
    v_user_id uuid;
begin
    select u.user_id into v_user_id
    from users u
    where u.name = 'John Doe';

    --- Use PERFORM to call the function
    perform sp_update_user(
        v_user_id,
        'John Updated',
        '555999999',
        '789 Updated St',
        3, --- United States
        4, --- California
        4  --- Los Angeles
    );
end $$;

--- Verify the update
select * from users where name = 'John Updated';

--- Test 2: Update user with invalid location (Jane Doe -> Palermo, Buenos Aires, Colombia)
do $$
declare
    v_user_id uuid;
begin
    select u.user_id into v_user_id
    from users u
    where u.name = 'Jane Doe';

    --- Use PERFORM inside a try-catch block
    begin
        perform sp_update_user(
            v_user_id,
            'Jane Updated',
            '555888888',
            'Updated Address',
            1, --- Colombia
            3, --- Buenos Aires (invalid combination for Colombia)
            3  --- Palermo
        );
    exception when others then
        raise notice 'Expected error: %', sqlerrm;
    end;
end $$;

--- Test 3: Update non-existing user
do $$
begin
    perform sp_update_user(
        '00000000-0000-0000-0000-000000000000',
        'Non-Existent User',
        '555777777',
        'Non-Existent Address',
        1, --- Colombia
        1, --- Cundinamarca
        1  --- Soacha
    );
exception when others then
    raise notice 'Expected error for non-existing user: %', sqlerrm;
end $$;
rollback;

/*
test to sp_delete_user
*/
begin;
--- Insert sample data into users
insert into users (user_id, name, phone, address, user_country_id, user_region_id, user_municipality_id) values
(gen_random_uuid(), 'John Doe', '555123456', '123 Main St', 1, 1, 1), -- Soacha, Cundinamarca, Colombia
(gen_random_uuid(), 'Jane Doe', '555987654', '456 Elm St', 1, 2, 2), -- Usaquén, Bogotá DC, Colombia
(gen_random_uuid(), 'Juan Perez', '555444555', '789 Avenida Siempre Viva', 2, 3, 3); -- Palermo, Buenos Aires, Argentina

--- Fetch the user IDs for testing
select * from users;

--- Test 1: Delete an existing user (John Doe)
do $$
declare
    v_user_id uuid;
begin
    select u.user_id into v_user_id
    from users u
    where u.name = 'John Doe';

    --- Perform deletion
    perform sp_delete_user(v_user_id);

    --- Verify deletion
    if exists (select 1 from users where user_id = v_user_id) then
        raise exception 'User % was not deleted correctly', v_user_id;
    else
        raise notice 'User % was deleted successfully', v_user_id;
    end if;
end $$;

select * from users;

--- Test 2: Attempt to delete a non-existing user
do $$
begin
    --- Attempt to delete a non-existing user ID
    perform sp_delete_user('00000000-0000-0000-0000-000000000000');
exception when others then
    raise notice 'Expected error for non-existing user: %', sqlerrm;
end $$;

--- Test 3: Delete another existing user (Jane Doe)
do $$
declare
    v_user_id uuid;
begin
    select u.user_id into v_user_id
    from users u
    where u.name = 'Jane Doe';

    --- Perform deletion
    perform sp_delete_user(v_user_id);

    --- Verify deletion
    if exists (select 1 from users where user_id = v_user_id) then
        raise exception 'User % was not deleted correctly', v_user_id;
    else
        raise notice 'User % was deleted successfully', v_user_id;
    end if;
end $$;

--- Verify the state of the users table after tests
select * from users;
rollback;