
use Hospital;
GO
---- View 
CREATE VIEW nurse_who_executed as
SELECT n.nurse_name, e.eo_status from Nurse n
JOIN Executed_Order e
on e.nurseID = n.ID;

GO

CREATE VIEW total_price as
SELECT SUM(p.amount) as price from Payment p
join Patient i on i.ID = p.patientID;

Go

CREATE VIEW list_of_patients as
SELECT p.ID, p.patient_name, p.room_number from Patient p
join Room r on r.roomNum = p.room_number;

Go


