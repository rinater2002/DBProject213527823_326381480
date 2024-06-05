
[General]
Version=1

[Preferences]
Username=
Password=2160
Database=
DateFormat=dd/mm/yyyy
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=ZEHAVI
Name=PAYMENTS
Count=400

[Record]
Name=PAYMENTDATE
Type=DATE
Size=
Data=Random(1/1/2004, 1/1/2024)
Master=

[Record]
Name=NUMBEROFTRANSACTION
Type=NUMBER
Size=
Data=Random(1, 10)
Master=

[Record]
Name=STATUS
Type=VARCHAR2
Size=50
Data=List('Paid', 'not paid')
Master=

[Record]
Name=PAYMENTTYPE
Type=VARCHAR2
Size=50
Data=List('CreditCard', 'cash','bank transfer')
Master=

[Record]
Name=PAYMENTID
Type=NUMBER
Size=
Data=Sequence(1000)
Master=

[Record]
Name=IDCO
Type=NUMBER
Size=
Data=List(select  IdCo from Customers)
Master=

