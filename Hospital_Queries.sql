-- SQL Queries containing Joins, Aggregate functions, and nested queries
-- Get the name of a patients with diabetes 
SELECT patient_name, diseases
FROM patient 
LEFT JOIN HealthRecord  ON patient.id = HealthRecord.patientID
WHERE  CAST(diseases as varchar(max)) = 'diabetes';

-- get the names of patients and their corresponding physicians
SELECT patient_name, physician_name
FROM patient 
Inner JOIN Monitor ON Monitor.patientID= Patient.ID
Inner JOIN Physician  ON Physician.ID = Monitor.PhysicianID;

-- get the name of the patient, assigned physician and assigned nurse
SELECT patient_name, physician_name, nurse_name
FROM patient
LEFT JOIN Monitor ON Patient.ID = Monitor.patientID
LEFT JOIN physician  ON Monitor.physicianID = physician.id
LEFT JOIN provide_medication  ON Patient.ID= provide_medication.patientID
LEFT JOIN Nurse  ON Provide_medication.nurseID = Nurse.ID;

-- Retrieve the total amount of medications given to each patient.
SELECT patientID, SUM(amount) AS total_medication_amount
FROM provide_medication
GROUP BY patientID;

-- Name of Nurse that administered the most medication
SELECT nurse_name, address
FROM nurse
WHERE nurse.ID = (
  SELECT nurseID
  FROM (
    SELECT nurseID, SUM(amount) AS total_medication_administered
    FROM provide_medication
    GROUP BY nurseID
  ) AS temp
  ORDER BY total_medication_administered DESC
  OFFSET 0 rows
  Fetch Next 1 rows only
);


-- Name of patient, address and amount,  with most amount of medication
SELECT patient_name, patient.P_Address
FROM patient
WHERE id = (
  SELECT patientID
  FROM (
    SELECT patientID, SUM(amount) AS total_medication_received
    FROM provide_medication
    GROUP BY patientID
  ) AS temp
  ORDER BY total_medication_received DESC OFFSET 0 rows
  Fetch Next 1 rows only
);

---- Retrieve the name, address and phone number of a patient that was prescibed Ibuprofen. 
SELECT patient_name, P_Address, phone_number
FROM patient 
WHERE patient.id IN (
  SELECT patientID
  FROM provide_medication
  WHERE cast(medicine_name as varchar(max)) = 'Ibuprofen'
);




------ Select all patients who have had a diagnosis of 'Asthma', 
------ and show their names and the total amount paid by them:
SELECT CAST(patient_name as varchar(max)) as patient_name, SUM(amount) as price
FROM patient
JOIN Payment ON patient.id = Payment.patientID
WHERE patient.id IN (
  SELECT patientID
  FROM HealthRecord
  WHERE CAST(diseases as varchar(max)) = 'Asthma'
)
GROUP BY  CAST(patient_name as varchar(max));

------ Query to find the total number of patients who have been treated by a physician with a certification number that is between 20 and 40.
SELECT COUNT(DISTINCT patientid) AS total_patients_treated
FROM Monitor
WHERE physicianID IN (
  SELECT ID
  FROM physician
  WHERE certification_number Between 20 AND 40
);

------ Retrieve the name, address, and total amount of medication administered to a patient
SELECT CAST(patient_name as varchar(max)) as patient_name, CAST(P_Address as varchar(max)) as patient_address, SUM(provide_medication.amount) AS total_medication
FROM patient
INNER JOIN provide_medication ON patient.id = provide_medication.patientID
WHERE patient.id IN (
  SELECT DISTINCT provide_medication.patientID
  FROM provide_medication
)
GROUP BY CAST(patient_name as varchar(max)), CAST(P_Address as varchar(max))
ORDER BY total_medication DESC;

------ Retrieve the name and total amount paid by each patient 
------ who has made a payment to the hospital. 
------ If a patient has not made any payment, display 0 as the amount paid.
SELECT CAST(patient_name as varchar(max)) as patient_name, COALESCE(SUM(payment.amount), 0) AS total_amount_paid
FROM patient
LEFT JOIN payment ON patient.id = payment.patientid
GROUP BY  CAST(patient_name as varchar(max))
ORDER BY total_amount_paid DESC;


------ Retrieve the patient with the most medication received who also 
------ has a health record that includes a diagnosis of Anxiety.
SELECT CAST(patient_name as varchar(max)) as patient_name, CAST(P_Address as varchar(max)) as patient_address, MAX(total_medication_received) as total_medication
FROM patient
INNER JOIN (
  SELECT patientID, SUM(amount) AS total_medication_received
  FROM provide_medication
  GROUP BY patientID
) AS medication_totals ON patient.id = medication_totals.patientID
WHERE EXISTS (
  SELECT *
  FROM HealthRecord
  WHERE patient.id = HealthRecord.patientID
  AND CAST(diseases as varchar(max)) = 'Anxiety'
)
GROUP BY CAST(patient_name as varchar(max)), CAST(P_Address as varchar(max))
ORDER BY MAX(total_medication_received) DESC
OFFSET 0 rows
  Fetch Next 1 rows only;