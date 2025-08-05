ALTER TABLE md_water_services.water_quality
ADD CONSTRAINT fk_water_quality_visits
FOREIGN KEY (record_id)
REFERENCES md_water_services.visits(record_id)
ON DELETE CASCADE;

SELECT record_id, COUNT(*) 
FROM md_water_services.water_quality
GROUP BY record_id 
HAVING COUNT(*) > 1;

SELECT record_id, COUNT(*) 
FROM md_water_services.visits 
GROUP BY record_id 
HAVING COUNT(*) > 1;

/* Integrating the Auditor's report */

DROP TABLE IF EXISTS `auditor_report`;
CREATE TABLE `auditor_report` (
`location_id` VARCHAR(32),
`type_of_water_source` VARCHAR(64),
`true_water_source_score` int DEFAULT NULL,
`statements` VARCHAR(255)
);

SELECT * FROM md_water_services.auditor_report;
SELECT 
	location_id,
	type_of_water_source
FROM md_water_services.auditor_report;
SELECT * FROM  md_water_services.visits;

-- Joins auditor_report with visits using location_id
-- Shows both versions of location_id
SELECT
	AR.location_id AS audit_locationId,
	AR.true_water_source_score AS true_water_source_score,
	V.location_id AS visit_location,
	V.record_id AS record_id
FROM md_water_services.auditor_report AR
JOIN 
	md_water_services.visits V
ON AR.location_id = V.location_id;

-- JOIN the visits table and the water_quality table, using the record_id as the connecting key.
SELECT
	V.location_id AS locationId,
	V.record_id AS record_id,
    WQ.subjective_quality_score AS survey_score,
    AR.true_water_source_score AS true_water_source_score
FROM md_water_services.visits V
JOIN md_water_services.water_quality WQ ON V.record_id = WQ.record_id
JOIN md_water_services.auditor_report AR ON V.location_id = AR.location_id;

SELECT
	V.location_id AS locationId,
	V.record_id AS record_id,
    WQ.subjective_quality_score AS survey_score,
    AR.true_water_source_score AS true_water_source_score
FROM md_water_services.visits V
JOIN md_water_services.water_quality WQ ON V.record_id = WQ.record_id
JOIN md_water_services.auditor_report AR ON V.location_id = AR.location_id
WHERE WQ.subjective_quality_score = AR.true_water_source_score;

/* Query without filtering on visit_count returns 2505 rows with matching scores —
 this counts all matching visits, including duplicates for the same location.*/
SELECT COUNT(*) AS exact_matches
FROM md_water_services.visits V
JOIN md_water_services.water_quality WQ 
  ON V.record_id = WQ.record_id
JOIN md_water_services.auditor_report AR 
  ON V.location_id = AR.location_id
WHERE AR.true_water_source_score = WQ.subjective_quality_score;

WITH joined_score AS (
  SELECT
    WQ.subjective_quality_score AS survey_score,
    AR.true_water_source_score AS true_water_source_score
  FROM md_water_services.visits V
  JOIN md_water_services.water_quality WQ ON V.record_id = WQ.record_id
  JOIN md_water_services.auditor_report AR ON V.location_id = AR.location_id
)

SELECT
  (SELECT COUNT(*) FROM joined_score WHERE survey_score = true_water_source_score) * 100.0 /
  (SELECT COUNT(*) FROM joined_score) AS match_percentage;

SELECT
  AR.location_id AS audit_location_id,
  AR.true_water_source_score AS auditor_score,
  V.location_id AS visit_location_id,
  V.record_id,
  V.visit_count,
  WQ.subjective_quality_score AS surveyor_score
FROM md_water_services.visits V
JOIN md_water_services.water_quality WQ 
  ON V.record_id = WQ.record_id
JOIN md_water_services.auditor_report AR 
  ON V.location_id = AR.location_id
WHERE V.visit_count = 1;
-- The auditor visited 1620 unique locations 
-- To avoid counting duplicates and analyze unique location visits only,
SELECT COUNT(*) AS total_rows
FROM md_water_services.visits V
JOIN md_water_services.water_quality WQ 
  ON V.record_id = WQ.record_id
JOIN md_water_services.auditor_report AR 
  ON V.location_id = AR.location_id
WHERE V.visit_count = 1;

-- mismatched records
SELECT 
V.location_id AS visit_location_id,
AR.location_id AS audit_location_id,
 WQ.subjective_quality_score AS surveyor_score,
 AR.true_water_source_score AS auditor_score
FROM md_water_services.visits V
JOIN md_water_services.water_quality WQ 
  ON V.record_id = WQ.record_id
JOIN md_water_services.auditor_report AR 
  ON V.location_id = AR.location_id
WHERE V.visit_count = 1
  AND AR.true_water_source_score != WQ.subjective_quality_score;

