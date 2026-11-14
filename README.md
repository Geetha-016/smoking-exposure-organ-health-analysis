# Smoking Exposure & Simulated Organ Health Analysis

## Project Overview

This project explores the relationship between smoking patterns, cumulative smoking exposure, patient demographics and simulated organ health outcomes using a synthetic healthcare dataset.

The project follows an end-to-end data analytics workflow using Python, SQL and Power BI to perform data exploration, data analysis and interactive dashboard development.


## Objectives

- Analyze patient demographics and smoking status distribution.
- Explore smoking exposure through cigarettes per day, years of smoking and pack-years.
- Examine the distribution of flagged health conditions.
- Analyze simulated organ health status across different organs.
- Compare simulated organ severity scores across smoking groups.
- Identify patients with multiple simulated organ damage flags.
- Develop interactive dashboards to present analytical findings.

## Tools & Technologies

- **Python:** Data exploration and analysis
- **Pandas:** Data cleaning and manipulation
- **MySQL:** Data storage and SQL analysis
- **Power BI:** Interactive dashboard development
- **DAX:** Measures, calculated metrics and dynamic visualizations
- **GitHub:** Project version control and documentation

## Dataset Description

The project uses four CSV files containing synthetic patient and organ assessment information.

| Dataset | Records | Description |
|---|---:|---|
| `patients.csv` | 10,000 | Patient demographics, smoking history, and health measurements |
| `organ_assessments.csv` | 50,000 | Simulated health assessments across five organs |
| `conditions.csv` | 13,331 | Flagged health conditions associated with patients |
| `organ_image_lookup.csv` | 15 | Organ images mapped to simulated health status |

### Key Dataset Attributes

**Patient Information**
- Patient ID
- Age
- Gender
- Smoking status
- Cigarettes per day
- Years of smoking
- Pack-years
- BMI
- Cholesterol
- Systolic and diastolic blood pressure

**Organ Assessment Information**
- Organ
- Simulated organ health status
- Simulated severity score
- Largest simulated score component

**Organs Covered**
- Brain
- Heart
- Kidneys
- Liver
- Lungs

**Simulated Organ Health Categories**
- Healthy
- At Risk
- Damaged

The simulated severity score ranges from 0 to 100 and is categorized as follows:

| Simulated Health Status | Severity Score |
|---|---:|
| Healthy | 0–34 |
| At Risk | 35–64 |
| Damaged | 65–100 |

These thresholds are part of the synthetic dataset's scoring design and are not medical reference ranges.

## Project Workflow

### 1. Data Exploration and Analysis – Python

- Analyzed the distribution of Never, Former, and Current smokers.
- Calculated average patient age, BMI, cholesterol, blood pressure, and glucose levels.
- Examined unique patient counts across all datasets.
- Validated organ assessment completeness by checking whether each patient had exactly five organ assessments.
- Identified duplicate patient-organ combinations.
- Verified the consistency of pack-year calculations against smoking exposure.
- Explored smoking status distribution across gender and age groups.
- Analyzed the percentage distribution of Healthy, At Risk, and Damaged organ assessments across the five organs.

**Python Libraries Used**
- Pandas
- Matplotlib
  
### 2. Data Analysis – SQL

- Imported datasets into MySQL.
- Created relational tables with primary and foreign key constraints.
- Used SQL queries to analyze patient demographics and smoking patterns.
- Calculated average smoking exposure and pack-years.
- Compared simulated organ severity across smoking groups.
- Identified damaged organ assessments and patients with multiple damaged organ flags.
- Examined cholesterol and blood pressure measurements.

**SQL Concepts Used**
- SELECT, WHERE, ORDER BY
- GROUP BY and HAVING
- Aggregate functions
- CASE statements
- JOIN operations
- Subqueries
- Common Table Expressions (CTEs)
- Window functions

### 3. Interactive Dashboard Development – Power BI

Developed a three-page interactive Power BI report.

#### Dashboard 1: Patient & Smoking Overview
<img width="1456" height="815" alt="image" src="https://github.com/user-attachments/assets/11512d68-1b9f-4537-a9a6-f61a086c9a45" />

Focuses on patient demographics, smoking patterns and exposure history.

Key analyses:
- Patient distribution by smoking status.
- Average pack-years across smoking groups.
- Smoking status distribution across age groups.
- Most frequently flagged conditions.

#### Dashboard 2: Organ Health Assessment
<img width="1453" height="814" alt="image" src="https://github.com/user-attachments/assets/d8769fb9-9801-4aeb-9157-56be6b21a2c0" />

Explores the distribution of simulated organ health outcomes.

Key analyses:
- Healthy, At Risk, and Damaged assessment distributions.
- Average simulated severity by organ.
- Damaged assessments across organs.
- Organ health status distribution.
- Dynamic organ images based on selected organ and health status.

#### Dashboard 3: Smoking Exposure & Risk Analysis
<img width="1449" height="811" alt="image" src="https://github.com/user-attachments/assets/09896def-10e6-4f2e-adaa-4ac155e4c592" />

Explores smoking exposure in relation to simulated organ health outcomes.

Key analyses:
- Damaged organ assessments by smoking status.
- Average simulated severity by smoking status.
- Organ health status distribution across smoking groups.
- Flagged conditions across smoking groups.
- Average smoking exposure by age group.

### Dashboard Features

- Interactive slicers for patient demographics, smoking status, organ and simulated health status.
- DAX measures for dynamic KPI calculations.
- Dynamic chart colouring based on selected health status.
- Organ-specific images using image URL mapping and DAX.
- Synchronized slicers across report pages.

## Key Findings

- Analyzed 10,000 synthetic patient records and 50,000 organ assessment records.
- Smoking exposure was the most frequently recorded largest simulated score component.
- The heart had the highest average simulated severity score among the five organs.
- The heart also recorded the highest number of simulated damaged assessments.
- The liver had the lowest average simulated severity score and the highest number of healthy assessments.

These findings describe patterns within the synthetic dataset only.

## Repository Contents

The repository includes:
- CSV datasets
- Python analysis notebook
- SQL scripts
- Power BI report
- Organ images and image lookup data
- Dashboard screenshots

## Conclusion

This project demonstrates an end-to-end data analytics workflow combining Python-based data exploration, SQL querying, and interactive Power BI dashboard development.

It provided practical experience in data cleaning, exploratory data analysis, relational database management, analytical SQL, DAX calculations and interactive data visualization.
