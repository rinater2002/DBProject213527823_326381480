CREATE TABLE Workers
(
  WorkersRole VARCHAR(50),
  Wage NUMERIC,
  WorkersMail VARCHAR(50),
  WorkersPhone NUMERIC,
  Shift VARCHAR(50),
  IdWo NUMERIC NOT NULL,
  WorkersName VARCHAR(50),
  PRIMARY KEY (IdWo)
);

CREATE TABLE Customers
(
  CustomersName VARCHAR(50),
  IdCo NUMERIC NOT NULL,
  CustomersPhone NUMERIC,
  CustomersType VARCHAR(50),
  CustomersMail VARCHAR(50),
  PRIMARY KEY (IdCo)
);

CREATE TABLE NewCatalog
(
  NewCatalogNumber NUMERIC NOT NULL,
  NewCatalogName VARCHAR(50),
  PricePerUnit NUMERIC,
  PRIMARY KEY (NewCatalogNumber)
);


CREATE TABLE Payments
(
  PaymentDate DATE,
  NumberOfTransaction NUMERIC,
  Status VARCHAR(50),
  PaymentType VARCHAR(50),
  PaymentID NUMERIC NOT NULL,
  IdCo NUMERIC,
  PRIMARY KEY (PaymentID),
  FOREIGN KEY (IdCo) REFERENCES Customers(IdCo)
);

CREATE TABLE Inventory
(
  Shelf NUMERIC,
  UnitsInStock NUMERIC,
  InventoryID NUMERIC NOT NULL,
  CatalogNumber NUMERIC NOT NULL,
  PRIMARY KEY (InventoryID),
  FOREIGN KEY (CatalogNumber) REFERENCES NewCatalog(NewCatalogNumber)
);

CREATE TABLE Orders
(
  Amount NUMERIC,
  DateOfSupply DATE,
  OrderDate DATE,
  OrderID NUMERIC NOT NULL,
  IdWo NUMERIC NOT NULL,
  CatalogNumber NUMERIC NOT NULL,
  InventoryID NUMERIC NOT NULL,
  IdCo NUMERIC NOT NULL,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (IdWo) REFERENCES Workers(IdWo),
  FOREIGN KEY (CatalogNumber) REFERENCES NewCatalog(NewCatalogNumber),
  FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID),
  FOREIGN KEY (IdCo) REFERENCES Customers(IdCo)
);

