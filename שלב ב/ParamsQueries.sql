SELECT 
  Payments.PaymentID,
  Payments.PaymentDate,
  Payments.PaymentType,
  Payments.Status,
  Customers.CustomersName,
  Customers.CustomersMail
FROM 
  Payments
JOIN 
  Customers ON Payments.IdCo = Customers.IdCo
WHERE 
  Payments.Status = 'not paid' and payments.paymentdate=&<name="newDate" type="date">;
  
  
  
SELECT 
  Orders.OrderID,
  Orders.OrderDate,
  Orders.Amount,
  Customers.CustomersName,
  Customers.CustomersPhone,
  Customers.CustomersType,
  NewCatalog.NewCatalogName,
  NewCatalog.PricePerUnit,
  Workers.WorkersName,
  Workers.WorkersRole
FROM 
  Orders
JOIN 
  Customers ON Orders.IdCo = Customers.IdCo
JOIN 
  NewCatalog ON Orders.CatalogNumber = NewCatalog.NewCatalogNumber
JOIN 
  Workers ON Orders.IdWo = Workers.IdWo
WHERE 
  Customers.CustomersType =&<name="customrType" list="private,office,school" type="string" restricted="yes">
  AND Orders.Amount > 1500
ORDER BY 
  Orders.OrderDate DESC;
  
  
SELECT 
  Inventory.InventoryID,
  Inventory.Shelf,
  Inventory.UnitsInStock,
  NewCatalog.NewCatalogName,
  NewCatalog.PricePerUnit
FROM 
  Inventory
JOIN 
  NewCatalog ON Inventory.CatalogNumber = NewCatalog.NewCatalogNumber
WHERE 
  Inventory.UnitsInStock < &<name="units" hint="select a number between 10-30" type="integer" required="true">
ORDER BY 
  Inventory.Shelf;


SELECT * FROM  Workers
&<name="sorted" list="workersRole,workersMail,shift" prefix="order by " suffix=" desc">;

