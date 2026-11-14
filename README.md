<img width="1449" height="811" alt="image" src="https://github.com/user-attachments/assets/2c74bf62-0800-4d1f-8fd2-ff6b50f89819" /># smoking-exposure-organ-health-analysis
# Smoking & Organ Health Analysis — Synthetic Dataset

## Files
- `patients.csv`: one row per synthetic patient (10,000 rows).
- `organ_assessments.csv`: one row per patient-organ pair (50,000 rows; 5 organs per patient).
- `conditions.csv`: one row per flagged condition per patient (long format).
- `organ_image_lookup.csv`: organ/status lookup table for dynamic-image design. `image_url` is intentionally blank; add image URLs you have permission to use.

## Suggested Power BI relationships
- `patients[patient_id]` (1) -> `organ_assessments[patient_id]` (*)
- `patients[patient_id]` (1) -> `conditions[patient_id]` (*)
- `organ_image_lookup[organ]` and status fields are lookup attributes for the visual logic. Depending on your model design, create a combined key in both tables (`organ & "|" & status`) to relate it to `organ_assessments`.

## Important interpretation note
Every record is synthetic and generated for portfolio practice. No real patient records are included.
`simulated_organ_status` and `simulated_severity_score` are artificial demonstration fields generated using predefined rules and random variation based on age, smoking exposure, BMI, cholesterol, blood pressure, activity, and selected family-history inputs. These labels are NOT clinical diagnoses, validated medical risk scores, or evidence that smoking caused a particular organ condition.

The dataset intentionally contains relationships between some inputs and simulated organ labels because it is designed for practising data modelling, DAX, filtering, and exploratory dashboard design. Do not describe those relationships as discoveries about real patients or use them to make medical recommendations.

## Column guide

### patients.csv
- `patient_id`: synthetic unique identifier.
- `age`: age in years (18–85).
- `gender`: Female, Male, Other.
- `smoking_status`: Never, Former, Current.
- `cigarettes_per_day`: generated daily amount; 0 for Never.
- `years_smoking`: generated exposure duration; 0 for Never.
- `pack_years`: cigarettes-per-day × years-smoked / 20.
- `bmi`: generated BMI (kg/m²).
- `total_cholesterol_mg_dl`: generated total cholesterol (mg/dL).
- `systolic_bp_mmhg`, `diastolic_bp_mmhg`: generated blood pressure values (mmHg).
- `fasting_glucose_mg_dl`: generated fasting glucose (mg/dL).
- `physical_activity`: Low, Moderate, High.
- `diet_quality`: Needs improvement, Average, Balanced.
- `alcohol_use`: Never, Occasional, Frequent.
- `family_history_cardiovascular`: Yes, No.

### organ_assessments.csv
- `patient_id`: joins to patients.
- `organ`: Heart, Lungs, Kidneys, Liver, Brain.
- `simulated_organ_status`: Healthy, At Risk, Damaged.
- `simulated_severity_score`: artificial score from 0 to 100; not clinically validated.
- `largest_simulated_score_component`: largest input component in the artificial scoring formula; not a clinical explanation.

### conditions.csv
- `patient_id`: joins to patients.
- `condition_name`: generated flag based on a simple threshold/rule.
- `condition_status`: Flagged. These are analytical flags, not confirmed diagnoses.

### organ_image_lookup.csv
- `organ`, `simulated_organ_status`: lookup combination.
- `image_key`: unique text key for each organ/status combination.
- `image_url`: blank field for your chosen licensed image URL.
- `image_note`: reminder about image rights.

## Suggested project title
**Smoking Exposure & Simulated Organ Health: An Interactive Power BI Exploration**

## Suggested disclosure for GitHub/LinkedIn
"This project uses a fully synthetic dataset created for portfolio practice. Organ-status labels and severity scores are simulated using predefined rules and random variation; they are not clinical diagnoses or real-world medical findings. The dashboard demonstrates data modelling, DAX, filtering, and visual storytelling."
