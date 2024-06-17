ALTER TABLE Inventory
MODIFY (UnitsInStock DEFAULT 0);

INSERT INTO INVENTORY(SHELF,INVENTORYID,CATALOGNUMBER)VALUES (1,1,802);

SELECT * FROM Inventory WHERE InventoryID = 1;


ALTER TABLE Payments
ADD CONSTRAINT CheckPaymentStatus
CHECK (Status = 'PAID' OR Status = 'NOT PAID');

INSERT INTO Payments (PaymentDate, NumberOfTransaction, Status, PaymentType, PaymentID, IdCo)
VALUES ('2024-06-17', 123456, 'INVALID', 'Credit Card', 1, 1);



ALTER TABLE Workers
ADD CONSTRAINT CheckWorkersRoleNotNull
CHECK (WorkersRole IS NOT NULL);

INSERT INTO Workers (WorkersRole, Wage, WorkersMail, WorkersPhone, Shift, IdWo, WorkersName) 
VALUES (NULL, 2000, 'john@example.com', 123456789, 'Morning', 1, 'John Doe');
