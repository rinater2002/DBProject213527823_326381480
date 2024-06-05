
[General]
Version=1

[Preferences]
Username=
Password=2281
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=ZEHAVI
Name=CUSTOMERS
Count=400

[Record]
Name=CUSTOMERSNAME
Type=VARCHAR2
Size=50
Data=FirstName '-' LastName
Master=

[Record]
Name=IDCO
Type=NUMBER
Size=
Data=Sequence(401)
Master=

[Record]
Name=CUSTOMERSPHONE
Type=NUMBER
Size=
Data=Random(500000000,599999999)
Master=

[Record]
Name=CUSTOMERSTYPE
Type=VARCHAR2
Size=50
Data=List('private','school','office')
Master=

[Record]
Name=CUSTOMERSMAIL
Type=VARCHAR2
Size=50
Data=Email
Master=

