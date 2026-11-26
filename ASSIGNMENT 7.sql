CREATE DATABASE HOSPITAL;
USE HOSPITAL;
CREATE TABLE patients (
Patient_ID INT PRIMARY KEY,
Patient_Name VARCHAR(50),
Age INT,
Gender VARCHAR(10),
Department VARCHAR(30),
Diagnosis VARCHAR(50),
Doctor_Name VARCHAR(50),
Admission_Date DATE,
Treatment_Cost DECIMAL(10,2),
Email VARCHAR(60),
Phone VARCHAR(15),
Insurance_Provider VARCHAR(40)
);

INSERT INTO patients VALUES
(1, 'Anita Menon', 34, 'Female', 'Cardiology', 'Hypertension', 'Dr. Nair', '2025-01-10', 45000, 'anita@mail.com', '9876500001', 'Star Health'),
(2, 'Arun Kumar', 52, 'Male', 'Cardiology', 'Heart Failure', 'Dr. Nair', '2025-01-15', 120000, NULL, '9876500002', NULL),
(3, 'Rahul Das', 28, 'Male', 'Orthopedics', 'Fracture', 'Dr. Thomas', '2025-02-02', 60000, 'rahul@mail.com', NULL, 'HDFC Ergo'),
(4, 'Sneha Pillai', 41, 'Female', 'Neurology', 'Migraine', 'Dr. Iyer', '2025-02-10', 25000, NULL, NULL, NULL),
(5, 'Vijay Anand', 67, 'Male', 'Neurology', 'Stroke', 'Dr. Iyer', '2025-02-18', 150000, 'vijay@mail.com', '9876500005', 'Star Health'),
(6, 'Meera Joseph', 23, 'Female', 'Pediatrics', 'Viral Fever', 'Dr. George', '2025-03-01', 8000, 'meera@mail.com', '9876500006', NULL),
(7, 'Alan Varghese', 8, 'Male', 'Pediatrics', 'Asthma', 'Dr. George', '2025-03-05', NULL, NULL, '9876500007', 'New India Assurance'),
(8, 'Nisha Raj', 45, 'Female', 'Orthopedics', 'Knee Replacement', 'Dr. Thomas', '2025-03-12', 180000, 'nisha@mail.com', '9876500008', 'HDFC Ergo'),
(9, 'Ajay Krishnan', 59, 'Male', 'Cardiology', 'Angioplasty', 'Dr. Nair', '2025-03-20', NULL, 'ajay@mail.com', NULL, 'Star Health'),
(10, 'Fathima Beevi', 36, 'Female', 'Gynecology', 'Pregnancy Care', 'Dr. Susan', '2025-04-02', 35000, NULL, '9876500010', 'New India Assurance'),
(11, 'Kiran Nair', 31, 'Male', 'Dermatology', 'Eczema', 'Dr. Paul', '2025-04-08', 6000, 'kiran@mail.com', '9876500011', NULL),
(12, 'Anjali Suresh', 26, 'Female', 'Dermatology', 'Acne', 'Dr. Paul', '2025-04-15', 4500, 'anjali@mail.com', NULL, NULL),
(13, 'Naveen Mathew', 49, 'Male', 'Oncology', 'Lung Cancer', 'Dr. Rao', '2025-05-01', 300000, 'naveen@mail.com', '9876500013', 'HDFC Ergo'),
(14, 'Divya Menon', 38, 'Female', 'Oncology', 'Breast Cancer', 'Dr. Rao', '2025-05-10', 250000, NULL, '9876500014', 'Star Health'),
(15, 'Sam Eapen', 72, 'Male', 'Neurology', 'Parkinsons', 'Dr. Iyer', '2025-05-18', NULL, NULL, NULL, NULL);

#Q1
SELECT * FROM PATIENTS;
#Q2
SELECT DISTINCT(DEPARTMENT) FROM PATIENTS;
#Q3
WITH NAMESTARTWITH_A AS(
	SELECT PATIENT_NAME FROM PATIENTS WHERE PATIENT_NAME LIKE 'A%')
SELECT * FROM NAMESTARTWITH_A;
#Q4
WITH NAME_ENDWITH_N AS(
	SELECT PATIENT_NAME FROM PATIENTS WHERE PATIENT_NAME LIKE '%N')
SELECT * FROM NAME_ENDWITH_N;
#CTE
#Q5
WITH AVERAGE_TREATMENT_COST AS (
	SELECT DEPARTMENT,AVG(TREATMENT_COST) AS AVERAGE_COST FROM PATIENTS GROUP BY DEPARTMENT)
SELECT * FROM AVERAGE_TREATMENT_COST WHERE AVERAGE_COST>50000;
#Q6
WITH NUMBER_OF_PATIENTS AS(
	SELECT PATIENT_ID,DOCTOR_NAME FROM PATIENTS GROUP BY PATIENT_ID)
SELECT * FROM NUMBER_OF_PATIENTS WHERE PATIENT_ID >2;
#Q7
-- 1. Common Table Expression (CTE) Approach
-- A CTE isolates aggregate logic into a named temporary result set before filtering in a main query block:
-- Without a CTE, group filtering is handled directly within a single query using the HAVING clause:

#CASE
#Q8
SELECT PATIENT_NAME,DEPARTMENT,TREATMENT_COST,
	CASE
		WHEN TREATMENT_COST >=150000 THEN 'CRITICAL CARE'
        WHEN TREATMENT_COST >=50000 THEN 'MODERATE'
        ELSE 'BASIC'
	END  AS COST_CATEGORY
FROM PATIENTS;
#Q9
SELECT AGE,
	CASE
		WHEN AGE<18 THEN 'CHILD'
        WHEN AGE BETWEEN 18 AND 59 THEN 'ADULT'
        WHEN AGE>60 THEN 'SENIOR'
	END AS AGE_GROUP
FROM PATIENTS;
#Q10
SELECT INSURANCE_PROVIDER,
	CASE
		WHEN INSURANCE_PROVIDER IS NOT NULL THEN 'INSURED'
        ELSE 'SELF-PAY'
		END AS INSURANCE_STATUS
FROM PATIENTS;
#Q11
SELECT PATIENT_NAME FROM PATIENTS WHERE ISNULL(TREATMENT_COST);
#Q12
SELECT PATIENT_NAME,IFNULL(TREATMENT_COST,0) AS TREATMENT_COST FROM PATIENTS;
#Q13
SELECT PHONE,COALESCE (EMAIL,PHONE,'NO CONTACT AVAILABLE') AS CONTACT_INFO FROM PATIENTS;
#Q14
-- IFNULL() replaces a NULL value with another value.
-- ISNULL() checks whether a value is NULL.
-- COALESCE() returns the first non-NULL value.
#Q15
WITH AVERAGE_COST AS(
	SELECT DEPARTMENT,avg(ifnull(TREATMENT_COST,0)) AS AVERAGE_TREATMENT FROM PATIENTS GROUP BY DEPARTMENT)
SELECT DEPARTMENT,
	CASE
		WHEN AVERAGE_TREATMENT>100000 THEN 'HIGH REVENUE'
        WHEN AVERAGE_TREATMENT BETWEEN 30000 AND 100000 THEN 'MEDIUM REVENUE'
        ELSE 'LOW REVENUE'
        END AS DEPARTMENT_LABEL
        FROM AVERAGE_COST;
#Q16
WITH NO_CONTACTDETAILS AS(
	SELECT DEPARTMENT,COUNT(PATIENT_ID) AS PATIENT_COUNT FROM PATIENTS WHERE EMAIL IS NULL AND PHONE IS NULL GROUP BY DEPARTMENT)
SELECT DEPARTMENT,PATIENT_COUNT FROM NO_CONTACTDETAILS;
#Q17
WITH Insurance_Costs AS (
    SELECT
        CASE
            WHEN Insurance_Provider IS NULL THEN 'Self-Pay'
            ELSE Insurance_Provider
        END AS Insurance_Provider,
        IFNULL(Treatment_Cost, 0) AS Clean_Cost
    FROM patients
)
SELECT
    Insurance_Provider,
    SUM(Clean_Cost) AS Total_Treatment_Cost
FROM Insurance_Costs
GROUP BY Insurance_Provider
ORDER BY Total_Treatment_Cost DESC;
#Q18
SELECT * FROM PATIENTS WHERE ADMISSION_DATE>'2025-03-31';
SELECT DEPARTMENT,MAX(TREATMENT_COST) AS HIGHEST_COST FROM PATIENTS GROUP BY DEPARTMENT;
SELECT * FROM PATIENTS WHERE AGE>60 AND DEPARTMENT ='NEUROLOGY';
#Q19
-- Yes. Running it on your 15 rows returns the 6 patients admitted in April and May 2025
-- Yes—none of the rows have a NULL Admission_Date, so no valid records are missed.
-- None needed (using Admission_Date > '2025-03-31' is cleaner and safer than MONTH()/YEAR() functions when filtering past a specific date).
#Q20
WITH DEPARTMENT_SUMMARY AS(
	SELECT DEPARTMENT,COUNT(*) AS TOTAL_PATIENTS,SUM(IFNULL(TREATMENT_COST,0)) AS TOTAL_TREATMENT_COST,SUM(CASE WHEN TREATMENT_COST IS NULL THEN 1 ELSE 0 END) AS MISSING_PATIENTS
    FROM PATIENTS GROUP BY DEPARTMENT)
SELECT DEPARTMENT,TOTAL_PATIENTS,TOTAL_TREATMENT_COST,MISSING_PATIENTS,
	CASE
		WHEN TOTAL_TREATMENT_COST>200000 THEN 'HIGH REVENUE'
        WHEN TOTAL_TREATMENT_COST BETWEEN 50000 AND 200000 THEN 'MEDIUM REVENUE'
        ELSE 'LOW REVENUE'
        END AS REVENUE_LEVEL
FROM DEPARTMENT_SUMMARY;



        
    
    
    
    
    





