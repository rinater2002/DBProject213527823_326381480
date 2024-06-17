SELECT WorkersName, WorkersMail, WorkersPhone, Wage
FROM Workers
WHERE Shift = 'Evening' AND Wage > 12000
ORDER BY Wage desc;


SELECT c.CustomersName, COUNT(o.OrderID) AS TotalOrders, MIN(o.DateOfSupply) AS FirstSupplyDate
FROM Orders o
JOIN Customers c ON o.IdCo = c.IdCo
WHERE o.OrderDate > TO_DATE('01/01/2023', 'DD/MM/YYYY')
GROUP BY c.CustomersName
ORDER BY TotalOrders DESC;

SELECT o.OrderID, o.Amount, c.CustomersName, w.WorkersName
FROM Orders o
JOIN Customers c ON o.IdCo = c.IdCo
JOIN Workers w ON o.IdWo = w.IdWo
WHERE o.Amount > 50
ORDER BY o.Amount DESC, o.OrderID ASC;

SELECT p.PaymentID, p.PaymentDate, p.PaymentType, c.CustomersName
FROM Payments p
JOIN Customers c ON p.IdCo = c.IdCo
WHERE c.IdCo IN (
    SELECT IdCo
    FROM Customers
    WHERE CustomersType = 'office'
)
GROUP BY p.PaymentID, p.PaymentDate, p.PaymentType, c.CustomersName;


DELETE FROM Orders
WHERE IdCo IN (
    SELECT IdCo
    FROM Customers
    WHERE CustomersType = 'office'
);


DELETE FROM Payments
WHERE IdCo IN (
    SELECT IdCo
    FROM Customers
    WHERE CustomersType = 'private'
);


UPDATE Workers
SET Wage = Wage * 1.1
WHERE Shift = 'Morning';

UPDATE Payments
SET Status = 'Completed'
WHERE IdCo IN (
    SELECT IdCo
    FROM Customers
    WHERE CustomersType = 'office'
);
