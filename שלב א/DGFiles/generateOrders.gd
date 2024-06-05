
[General]
Version=1

[Preferences]
Username=
Password=2163
Database=
DateFormat=dd/mm/yyyy
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=ZEHAVI
Name=ORDERS
Count=10..20

[Record]
Name=AMOUNT
Type=NUMBER
Size=
Data=Random(1000, 2000)
Master=

[Record]
Name=DATEOFSUPPLY
Type=DATE
Size=
Data=Random(1/1/2020, 1/1/2024)
Master=

[Record]
Name=ORDERDATE
Type=DATE
Size=
Data=Random(1/1/2020, 1/1/2024)
Master=

[Record]
Name=ORDERID
Type=NUMBER
Size=
Data=Sequence(2000)
Master=

[Record]
Name=IDWO
Type=NUMBER
Size=
Data=List(select IdWo from Workers)
Master=

[Record]
Name=CATALOGNUMBER
Type=NUMBER
Size=
Data=List(select NewCatalogNumber from NewCatalog)
Master=

[Record]
Name=INVENTORYID
Type=NUMBER
Size=
Data=List(select InventoryID from Inventory)
Master=

[Record]
Name=IDCO
Type=NUMBER
Size=
Data=List(select IdCo from Customers)
Master=

