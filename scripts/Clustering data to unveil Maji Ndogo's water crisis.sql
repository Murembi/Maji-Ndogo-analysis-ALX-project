SELECT 
	CONCAT(
    (REPLACE(employee_name, ' ','.')), '@ndogowater.gov') AS new_email
#replace the blank space with a full stop and convert everything to lower casge
FROM md_water_services.employee;

UPDATE md_water_services.employee
SET email = CONCAT(LOWER(REPLACE(employee_name, ' ', '.')),
'@ndogowater.gov');

SELECT * FROM md_water_services.employee;
SELECT * FROM md_water_services.visits;
SELECT * FROM md_water_services.location;
SELECT 
	town_name,
	COUNT(town_name) records_per_town
FROM md_water_services.location
GROUP BY town_name;

SELECT 
	province_name,
	COUNT(province_name) records_per_town
FROM md_water_services.location
GROUP BY province_name;

SELECT
	town_name,
	province_name,
    COUNT(town_name) records_per_town
FROM md_water_services.location
GROUP BY 
	province_name, town_name
ORDER BY 
	province_name ASC, records_per_town DESC;

SELECT 
	location_type,
	COUNT(location_id) AS num_source
FROM md_water_services.location
GROUP BY location_type;

SELECT * FROM md_water_services.water_source;

SELECT DISTINCT type_of_water_source FROM md_water_services.water_source;
SELECT 
	COUNT(number_of_people_served) AS total_people
FROM md_water_services.water_source;

SELECT
	type_of_water_source,
	COUNT(type_of_water_source) AS source_number
 FROM md_water_services.water_source
 GROUP BY type_of_water_source;
 
 SELECT
    type_of_water_source,
    COUNT(source_id) AS total_sources
FROM md_water_services.water_source
GROUP BY 
    type_of_water_source
ORDER BY 
    total_sources DESC;
SELECT  * FROM md_water_services.water_source;

SELECT 
	type_of_water_source,
	SUM(number_of_people_served) AS population_served
FROM  md_water_services.water_source
GROUP BY 
	type_of_water_source;

SELECT
    type_of_water_source,
    ROUND(
        SUM(number_of_people_served) * 100.0 / 
        (SELECT SUM(number_of_people_served) FROM md_water_services.water_source),
        2
    ) AS percent_people_served
FROM 
    md_water_services.water_source
GROUP BY 
    type_of_water_source
ORDER BY 
    percent_people_served DESC;
 
SELECT 
	CONCAT(
    (REPLACE(employee_name, ' ','.')), '@ndogowater.gov') AS new_email
#replace the blank space with a full stop and convert everything to lower casge
FROM md_water_services.employee;

UPDATE md_water_services.employee
SET email = CONCAT(LOWER(REPLACE(employee_name, ' ', '.')),
'@ndogowater.gov');

SELECT
    LENGTH(phone_number)
FROM md_water_services.employee;

SELECT 
    RTRIM(phone_number)
FROM md_water_services.employee;

SELECT 
    RTRIM(phone_number) AS Trimmed_number
FROM md_water_services.employee
LIMIT 6;

UPDATE md_water_services.employee
SET phone_number = RTRIM(phone_number);

SELECT
    LENGTH(phone_number)
FROM
md_water_services.employee;

SELECT
    employee_name,
    province_name,
    town_name,
    COUNT(town_name) OVER(PARTITION BY town_name)
FROM
    employee
LIMIT 5;

SELECT
    DISTINCT town_name,
    COUNT(town_name) OVER(PARTITION BY town_name)
FROM
    employee
LIMIT 5;

SELECT
    e employee_name, 
    e email,
    e phone_numbers
    COUNT(visit_count) AS visit_counts
FROM employee e
JOIN visits v 
    v.assigned_employee_id = e.assigned_employee_id
SORT BY ASC;
SELECT
    e.employee_name, 
    e.email,
    e.phone_numbers,
    COUNT(v.visit_id) AS visit_counts
FROM employee e
JOIN visits v 
    ON v.assigned_employee_id = e.assigned_employee_id
GROUP BY 
    e.employee_name, e.email, e.phone_numbers
ORDER BY 
    visit_counts ASC;
    
 SELECT
    e.employee_name, 
    e.email,
    e.phone_number,
    COUNT(v.visit_count) AS visit_counts
FROM employee e
JOIN visits v 
    ON v.assigned_employee_id = e.assigned_employee_id
WHERE e.position = 'Field Surveyor'
GROUP BY 
    e.employee_name, e.email, e.phone_number
ORDER BY 
    visit_counts DESC
LIMIT 3;   
SELECT
    e.employee_name, 
    e.email,
    e.phone_number,
    COUNT(v.visit_count) AS visit_counts
FROM employee e
JOIN visits v 
    ON v.assigned_employee_id = e.assigned_employee_id
WHERE e.position = 'Field Surveyor'
GROUP BY 
    e.employee_name, e.email, e.phone_number
ORDER BY 
    visit_counts ASC
LIMIT 3;

SELECT
    e.employee_name, 
    e.email,
    e.phone_number,
    COUNT(v.visit_count) AS visit_counts
FROM employee e
JOIN visits v 
    ON v.assigned_employee_id = e.assigned_employee_id
GROUP BY 
    e.employee_name, e.email, e.phone_number
LIMIT 3;

SELECT
	town_name,
	province_name,
    COUNT(town_name) records_per_town
FROM md_water_services.location
GROUP BY 
	province_name, town_name
ORDER BY 
	province_name ASC, records_per_town DESC
LIMIT 5;

SELECT 
	location_type,
	COUNT(location_id) AS num_source
FROM md_water_services.location
GROUP BY 
    location_type;

SELECT 
	location_type,
	(COUNT(location_id) / (15910 + 23740) * 100) AS num_source
FROM md_water_services.location
GROUP BY 
    location_type;

SELECT 
	COUNT(number_of_people_served) AS total_people
FROM md_water_services.water_source;

SELECT
	type_of_water_source,
	COUNT(type_of_water_source) AS source_number
 FROM md_water_services.water_source
 GROUP BY type_of_water_source;
 
 SELECT
	type_of_water_source,
	COUNT(number_of_people_served) AS no_people
FROM md_water_services.water_source
GROUP BY 
	type_of_water_source;
    
SELECT
	type_of_water_source,
	AVG(number_of_people_served) AS AVG_people
FROM md_water_services.water_source
GROUP BY 
	type_of_water_source;

SELECT
	type_of_water_source,
	ROUND(AVG(number_of_people_served), 0) AS avg_people
FROM md_water_services.water_source
GROUP BY 
	type_of_water_source;
 
SELECT 
	type_of_water_source,
	SUM(number_of_people_served) AS population_served
FROM  md_water_services.water_source
GROUP BY 
	type_of_water_source;

SELECT
    SUM(number_of_people_served) total_people_served
FROM 
md_water_services.water_source;

SELECT
    SUM((number_of_people_served)/ (27628140) * 100) total_people_served
FROM 
md_water_services.water_source;

SELECT
    type_of_water_source,
    ROUND(
        SUM(number_of_people_served) * 100.0 / 
        (SELECT SUM(number_of_people_served) FROM md_water_services.water_source),
        2
    ) AS percent_people_served
FROM 
    md_water_services.water_source
GROUP BY 
    type_of_water_source
ORDER BY 
    percent_people_served DESC;
 
 SELECT 
    type_of_water_source,
    total_people_served,
    RANK() OVER (ORDER BY total_people_served DESC) AS rank_by_population
FROM (
    SELECT 
        type_of_water_source,
        SUM(number_of_people_served) AS total_people_served
    FROM md_water_services.water_source
    GROUP BY type_of_water_source
) AS summary;

SELECT 
    type_of_water_source,
    total_people_served,
    RANK() OVER (ORDER BY total_people_served DESC) AS rank_by_population
FROM (
    SELECT 
        type_of_water_source,
        SUM(number_of_people_served) AS total_people_served
    FROM md_water_services.water_source
    WHERE type_of_water_source != 'tap_in_home'
    GROUP BY type_of_water_source
) AS summary;

SELECT 
    source_id,
    type_of_water_source,
    number_of_people_served,
    RANK() OVER (
        PARTITION BY type_of_water_source 
        ORDER BY number_of_people_served DESC
    ) AS rank_within_type
FROM md_water_services.water_source
WHERE type_of_water_source != 'tap_in_home'
ORDER BY number_of_people_served DESC;

SELECT 
    source_id,
    type_of_water_source,
    number_of_people_served,
    DENSE_RANK() OVER (
        PARTITION BY type_of_water_source
        ORDER BY number_of_people_served DESC
    ) AS rank_within_type
FROM md_water_services.water_source
WHERE type_of_water_source != 'tap_in_home'
ORDER BY number_of_people_served DESC;

SELECT 
    source_id,
    type_of_water_source,
    number_of_people_served,
    ROW_NUMBER() OVER (
        PARTITION BY type_of_water_source
        ORDER BY number_of_people_served DESC
    ) AS row_num_within_type
FROM md_water_services.water_source
WHERE type_of_water_source != 'tap_in_home'
ORDER BY number_of_people_served DESC;

SELECT * FROM md_water_services.visits;
SELECT
	AVG(time_in_queue)
FROM md_water_services.visits;

SELECT
MIN(time_of_record)
FROM md_water_services.visits;

SELECT
MAX(time_of_record)
FROM md_water_services.visits;

SELECT 
DATEDIFF('2023-07-14', '2021-01-01') AS days_difference
FROM md_water_services.visits;

SELECT * FROM md_water_services.visits;
SELECT
	DAYNAME(time_of_record) AS Days,
    AVG(time_in_queue)
FROM md_water_services.visits
GROUP BY Days;

SELECT
	TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
    AVG(time_in_queue)
FROM md_water_services.visits
GROUP BY hour_of_day;

SELECT
	TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
	DAYNAME(time_of_record),
CASE
	WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
ELSE NULL
END AS Sunday
FROM
	md_water_services.visits
WHERE
time_in_queue != 0;

SELECT
	TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
-- Sunday
ROUND(AVG(
	CASE
	WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
	ELSE NULL
END
),0) AS Sunday,
-- Monday
ROUND(AVG(
	CASE
	WHEN DAYNAME(time_of_record) = 'Monday' THEN time_in_queue
	ELSE NULL
END
),0) AS Monday,
-- Tuesday
ROUND(AVG(
	CASE
	WHEN DAYNAME(time_of_record) = 'Tuesday' THEN time_in_queue
	ELSE NULL
END
),0) AS Tuesday,
-- Wednesday
ROUND(AVG(
	CASE
	WHEN DAYNAME(time_of_record) = 'Wednesday' THEN time_in_queue
	ELSE NULL
END
),0) AS Wednesday,
-- Thursday
ROUND(AVG(
	CASE
	WHEN DAYNAME(time_of_record) = 'Thursday' THEN time_in_queue
	ELSE NULL
END
),0) AS Thursday,
-- Friday
ROUND(AVG(
	CASE
	WHEN DAYNAME(time_of_record) = 'Friday' THEN time_in_queue
	ELSE NULL
END
),0) AS Friday
FROM
	md_water_services.visits
WHERE
	time_in_queue != 0 -- this excludes other sources with 0 queue times
GROUP BY
	hour_of_day
ORDER BY
	hour_of_day;






