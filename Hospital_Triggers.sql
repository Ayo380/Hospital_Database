use Hospital;
Go
---- Triggers
CREATE TRIGGER default_room_capacity
ON Room 
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS(SELECT * FROM inserted WHERE capacity IS NOT NULL)
    BEGIN
        INSERT INTO Room (capacity)
        SELECT 1 FROM inserted;
    END
    ELSE
    BEGIN
        INSERT INTO Room (capacity)
        SELECT capacity FROM inserted WHERE capacity IS NOT NULL;
    END
END

Go 

CREATE TRIGGER default_execute_status
ON Executed_Order 
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Executed_Order (eo_status)
    SELECT 
        CASE WHEN i.eo_status IS NULL THEN 'incomplete' ELSE i.eo_status END
    FROM inserted AS i;
END

Go

CREATE TRIGGER update_payment_amount
ON Room
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @org_amt DECIMAL(10,2);
    
    SELECT @org_amt = amount
    FROM Payment
    WHERE patientID IN (SELECT ID FROM Patient WHERE room_number IN 
	(SELECT roomNum FROM inserted));

    UPDATE Payment
    SET amount = @org_amt + i.fee
    FROM Payment p
    INNER JOIN Patient pa ON p.patientID = pa.ID
    INNER JOIN inserted i ON pa.room_number = i.roomNum;
END

