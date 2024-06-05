
[General]
Version=1

[Preferences]
Username=
Password=2842
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=ZEHAVI
Name=INVENTORY
Count=400

[Record]
Name=SHELF
Type=NUMBER
Size=
Data=Random(1,10)
Master=

[Record]
Name=UNITSINSTOCK
Type=NUMBER
Size=
Data=Random(0, 50)
Master=

[Record]
Name=INVENTORYID
Type=NUMBER
Size=
Data=Sequence(2000)
Master=

[Record]
Name=CATALOGNUMBER
Type=NUMBER
Size=
Data=List(select NewCatalogNumber from NewCatalog)
Master=

