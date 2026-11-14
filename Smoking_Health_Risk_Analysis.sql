CREATE DATABASE smoking_health_analysis;
USE smoking_health_analysis;

CREATE TABLE patients(
patient_id INT PRIMARY KEY,
age INT,
gender VARCHAR(10),
smoking_status VARCHAR(50),
cigarettes_per_day INT,
years_smoking INT,
pack_years DECIMAL(10,2),
bmi DECIMAL(5,2),
total_cholesterol_mg_dl INT,
systolic_bp_mmhg INT,
diastolic_bp_mmhg INT,
fasting_glucose_mg_dl INT,
physical_activity VARCHAR(50),
diet_quality VARCHAR(50),
alcohol_use VARCHAR(50),
family_history_cardiovascular BOOLEAN
);

CREATE TABLE conditions(
patient_id INT,
condition_name VARCHAR(100),
condition_status VARCHAR(50),
PRIMARY KEY (patient_id, condition_name),
FOREIGN KEY (patient_id) REFERENCES patients(patient_id));

CREATE TABLE organ_assessments (
patient_id INT,
organ VARCHAR(50),
simulated_organ_status VARCHAR(50),
simlated_severity_status INT,
large_simulated_score_component VARCHAR(100),
PRIMARY KEY (patient_id, organ),
FOREIGN KEY (patient_id) REFERENCES patients(patient_id));


SELECT * FROM patients;
SELECT * FROM conditions;
SELECT * FROM organ_assessments;

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Smoking_patients_table.csv'
INTO TABLE patients
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\smoking_conditions_table.csv'
INTO TABLE conditions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\smoking_organ_assessment_table.csv'
INTO TABLE organ_assessments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM patients;
SELECT * FROM conditions;
SELECT * FROM organ_assessments;

-- A. Basic SQL analysis
-- 1) What is the total number of patients?
SELECT COUNT(*) FROM patients;

-- 2) What is the distribution of patients by smoking status?
SELECT smoking_status, COUNT(patient_id) as patient_count
FROM patients
GROUP BY smoking_status;

-- 3) What is the average age of current, former and never smokers?
SELECT smoking_status, AVG(age) as avg_age
FROM patients
GROUP BY smoking_status;

-- 4) What are the top five conditions by number of flagged records?
SELECT condition_name, COUNT(condition_status) as number_of_flagged_records
FROM conditions
GROUP BY condition_name
ORDER BY COUNT(condition_status) DESC
LIMIT 5;

-- 5) Which organ has the highest number of damaged assessments?
SELECT organ, simulated_organ_status, COUNT(simlated_severity_status) 
FROM organ_assessments
GROUP BY organ, simulated_organ_status
HAVING simulated_organ_status = 'Damaged'
ORDER BY COUNT(simlated_severity_status) DESC
LIMIT 1;

-- B. Smoking exposure analysis
-- 6) How does average pack-years vary across smoking statuses?
SELECT smoking_status, AVG(pack_years) as avg_pack_years
FROM patients
GROUP BY smoking_status;

-- 7) Which age group has the highest proportion of current smokers?
WITH age_group_cte AS(
SELECT patient_id, 
smoking_status,
CASE 
	WHEN age BETWEEN 10 AND 29 THEN '18-29' 
    WHEN age BETWEEN 30 AND 39 THEN '30-39'
    WHEN age BETWEEN 40 AND 49 THEN '40-49'
    WHEN age BETWEEN 50 AND 59 THEN '50-59'
    WHEN age BETWEEN 60 AND 69 THEN '60-69'
    ELSE '70-85'
    END as age_group 
FROM patients)
SELECT age_group, COUNT(CASE WHEN smoking_status = 'current' THEN 1 END) AS count_of_current_smokers,
COUNT(*) as total_patients, 
CONCAT(ROUND(COUNT(CASE WHEN smoking_status = 'current' THEN 1 END) * 100 / COUNT(*),2),'%') as current_smoker_percentage
FROM age_group_cte
GROUP BY age_group
ORDER BY current_smoker_percentage DESC;

-- 8) How many current smokers smoke more than 20 cigarettes per day?
SELECT smoking_status, COUNT(CASE WHEN cigarettes_per_day > 20 THEN 1 END) as count_of_current_smokers
FROM patients
WHERE smoking_status = 'current'
GROUP BY smoking_status;

-- 9) Does the average simulated severity score differ across smoking statuses?
SELECT p.smoking_status, ROUND(AVG(o.simlated_severity_status),2) as avg_severity_status
FROM patients p 
JOIN organ_assessments o 
ON p.patient_id = o.patient_id 
GROUP BY p.smoking_status;

-- 10) Which smoking exposure group has the highest number of damaged organ assessments?
SELECT p.smoking_status, COUNT(CASE WHEN o.simulated_organ_status = 'damaged' THEN 1 END) as count_of_damaged_organ
FROM patients p 
JOIN organ_assessments o 
ON p.patient_id = o.patient_id 
GROUP BY p.smoking_status
ORDER BY count_of_damaged_organ DESC;

-- C. Organ health analysis

-- 11) What is the distribution of simulated organ status for each organ?
SELECT organ, simulated_organ_status, COUNT(simulated_organ_status) as count_of_simulated_organ_status
FROM organ_assessments
GROUP BY organ, simulated_organ_status
ORDER BY COUNT(simulated_organ_status) DESC;

-- 12) Which organ has the highest average severity score?
SELECT organ, ROUND(AVG(simlated_severity_status),2) as avg_simlated_severity_status
FROM organ_assessments
GROUP BY organ
ORDER BY avg_simlated_severity_status DESC
LIMIT 1;

-- 13) Which organs have the highest percentage of damaged assessments?
SELECT organ,
COUNT(CASE WHEN simulated_organ_status = 'damaged' THEN 1 END) as damaged_assessments,
COUNT(*) as total_assessments,
(COUNT(CASE WHEN simulated_organ_status = 'damaged' THEN 1 END) * 100.0 / COUNT(*)) as damaged_percentage
FROM organ_assessments
GROUP BY organ
ORDER BY damaged_percentage DESC;

-- 14) Which organ has the highest number of healthy assessments?
SELECT organ,
COUNT(CASE WHEN simulated_organ_status = 'healthy' THEN 1 END) as healthy_assessments,
COUNT(*) as total_assessments,
(COUNT(CASE WHEN simulated_organ_status = 'healthy' THEN 1 END) * 100.0 / COUNT(*)) as healthy_percentage
FROM organ_assessments
GROUP BY organ
ORDER BY healthy_percentage DESC;

-- 15) Which patients have three or more organs classified as damaged?
SELECT patient_id, simulated_organ_status, COUNT(organ)
FROM organ_assessments
WHERE simulated_organ_status = 'damaged'
GROUP BY patient_id
HAVING COUNT(organ) >= 3;

 -- D. Patient risk profile
-- 16) How many patients have multiple flagged conditions?
SELECT COUNT(*) AS patients_with_multiple_conditions
FROM (
SELECT patient_id
FROM conditions
WHERE condition_status = "Flagged"
GROUP BY patient_id
HAVING COUNT(DISTINCT condition_name) > 1 
) AS multiple_conditions;

-- 17) What is the average BMI among patients with and without a family history of cardiovascular disease?
SELECT family_history_cardiovascular, ROUND(AVG(bmi),2) AS average_bmi
FROM patients
GROUP BY family_history_cardiovascular;

-- 18) How do cholesterol and blood pressure levels vary across smoking statuses?
SELECT smoking_status, ROUND(Avg(total_cholesterol_mg_dl),2) AS avg_cholesterol, 
ROUND(AVG(systolic_bp_mmhg),2) AS avg_systolic_bp, 
ROUND(AVG(diastolic_bp_mmhg),2) AS avg_diastolic_bp
FROM patients
GROUP BY smoking_status;

-- 19) Which patients have both high blood pressure and high cholesterol flags?
SELECT patient_id, systolic_bp_mmhg, diastolic_bp_mmhg, total_cholesterol_mg_dl
FROM patients
WHERE (systolic_bp_mmhg >= 130 OR diastolic_bp_mmhg >= 80) AND total_cholesterol_mg_dl >=200;

-- 20) What percentage of current smokers have at least one damaged organ assessment?
SELECT 
ROUND(100.0 * COUNT(DISTINCT oa.patient_id) / (SELECT COUNT(*) 
												FROM patients
                                                WHERE smoking_status = "Current"),2) AS percent_damaged
FROM organ_assessments oa 
JOIN patients p 
ON oa.patient_id = p.patient_id
WHERE p.smoking_status = "Current" AND oa.simulated_organ_status = "Damaged";

-- E. Advanced SQL
-- 21) Rank organs by average severity score.
SELECT organ, ROUND(AVG(simlated_severity_status),2) AS avg_severity,
RANK() OVER(ORDER BY AVG(simlated_severity_status) DESC) AS organ_rank
FROM organ_assessments
GROUP BY organ;

-- 22) Rank patients by total simulated severity score across all five organs.
SELECT patient_id, SUM(simlated_severity_status) AS total_severity_score,
RANK() OVER(ORDER BY SUM(simlated_severity_status) DESC) AS patient_rank
FROM organ_assessments
GROUP BY patient_id 
HAVING COUNT(DISTINCT organ) = 5;

-- 23) Find the top 10% of patients by pack-years.
WITH patient_ranking AS(
SELECT patient_id, pack_years, 
NTILE(10) OVER(ORDER BY pack_years DESC) AS percentile_group 
FROM patients)
SELECT patient_id, pack_years
FROM patient_ranking 
WHERE percentile_group = 1
ORDER BY pack_years DESC;

-- 24) Compare organ damage percentages between smoking groups.
SELECT p.smoking_status, oa.organ,
COUNT(*) AS total_assessments,
SUM(
	CASE 
    WHEN oa.simulated_organ_status = "Damaged"
    THEN 1 
    ELSE 0
END) AS damaged_assessments,
CONCAT(ROUND(
100.0 * SUM(
	CASE
    WHEN 
    oa.simulated_organ_status = "Damaged"
    THEN 1 
    ELSE 0
END) / COUNT(*), 2),"%") AS damage_percentage
FROM patients p 
JOIN organ_assessments oa
ON p.patient_id = oa.patient_id 
GROUP BY p.smoking_status, oa.organ
ORDER BY oa.organ, damage_percentage DESC;

-- 25) Identify patients whose simulated organ severity is higher than the average for their respective organ.
WITH organ_avg AS (
SELECT organ, AVG(simlated_severity_status) as avg_severity
FROM organ_assessments
GROUP BY organ
)
SELECT oa.patient_id, oa.organ, oa.simlated_severity_status, 
ROUND(og.avg_severity, 2) AS organ_avg_severity 
FROM organ_assessments oa 
JOIN organ_avg og 
ON oa.organ = og.organ
WHERE oa.simlated_severity_status > og.avg_severity 
ORDER BY oa.organ, oa.simlated_severity_status DESC;