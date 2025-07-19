/* checks if the results is Clean but the biological column is > 0.01 */
SELECT
*
FROM 
  well_pollution
WHERE 
  results = 'clean'
AND biological > 0.01;

/*Case 1a: Update descriptions that mistakenly mention
`Clean Bacteria: E. coli` to `Bacteria: E. coli` */
SELECT
  *
FROM well_pollution
WHERE description 
LIKE 
	'%Bacteria: E. coli';
UPDATE md_water_services.well_pollution
SET description = 'Bacteria: E. coli'
WHERE 
description = '%Bacteria: E. coli';

/*Case 1b: Update the descriptions that mistakenly mention
`Clean Bacteria: Giardia Lamblia` to `Bacteria: Giardia Lamblia */
SELECT
  *
FROM 
  well_pollution
WHERE 
  description 
LIKE 
	'%Bacteria: Giardia Lamblia';
UPDATE 
  md_water_services.well_pollution
SET 
  description = '%Bacteria: Giardia Lamblia'
WHERE 
description = '%Bacteria: Giardia Lamblia';

SELECT * FROM well_pollution;

/* Case 2: Update the `result` to `Contaminated: Biological` where
`biological` is greater than 0.01 plus current results is `Clean` */

UPDATE 
  md_water_services.well_pollution 
SET 
  results = 'Contaminated: Biological' 
WHERE 
	biological > 0.01  
AND 
	results = 'clean';
CREATE TABLE
  md_water_services.well_pollution_copy
AS (
SELECT
*
FROM
md_water_services.well_pollution
);

SELECT * FROM md_water_services.well_pollution_copy;

SELECT DISTINCT description 
FROM well_pollution;
/*check if our errors are fixed */

SELECT
*
FROM
  well_pollution_copy
WHERE
  description LIKE "Clean_%"
OR (results = "Clean" AND biological > 0.01);
DROP TABLE
md_water_services.well_pollution_copy;

/* check for fraud */
SELECT *
FROM employee
WHERE position = 'Field Surveyor'
  AND (phone_number LIKE '%86%' OR phone_number LIKE '%11%')
  AND (
    SUBSTRING_INDEX(employee_name, ' ', -1) LIKE 'A%' OR
    SUBSTRING_INDEX(employee_name, ' ', -1) LIKE 'M%'
  );
  
  SELECT
	ws.source_id,
	wp.results, 
	ws.type_of_water_source
FROM well_pollution wp
JOIN 
	water_source ws
ON 
	wp.source_id = ws.source_id;

/* count the number of rows */
SELECT COUNT(*) AS row_count
FROM well_pollution
WHERE description IN ('Parasite: Cryptosporidium', 'biologically contaminated')
   OR (results = 'Clean' AND biological > 0.01);
