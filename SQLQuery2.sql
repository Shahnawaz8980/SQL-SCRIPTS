CREATE TABLE Teller 
(
    TellerId TINYINT CONSTRAINT pk_Teller_TellerId PRIMARY KEY,
    LoginName VARCHAR(5) CONSTRAINT uq__Teller_LoginName UNIQUE NOT NULL CONSTRAINT ck_Teller_LoginName CHECK(LoginName like 'T____'),
    [Password] VARBINARY(300) NOT NULL
)

CREATE TABLE Customer 
(
    CustomerId BIGINT CONSTRAINT pk_Customer_CustomerId PRIMARY KEY NOT NULL,
    EmailId VARCHAR(255) NOT NULL CONSTRAINT uq__Customer_EmailId UNIQUE,
    Name VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL CONSTRAINT chk_Customer_DateOfBirth CHECK (DATEDIFF(day,DateOfBirth,GETDATE())/(365.25)>=(18)),
    CreatedTimestamp DATETIME2(7) CONSTRAINT df_Customer_CreatedTimeStamp DEFAULT GETDATE() NOT NULL,
    CreatedBy TINYINT NOT NULL CONSTRAINT fk_Customer_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Teller(TellerId),
    ModifiedTimestamp DATETIME2(7),
    ModifiedBy TINYINT CONSTRAINT fk_Customer_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES Teller(TellerId)
)

Create Table a1(col1 int, col3 varchar(10))

insert into a1 values(1,'shahnawaz')

insert into a1 values(2,'shah')

CREATE SEQUENCE AccountNumber_Sequence
    AS INT
	start with 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999999999

drop sequence AccountNumber_Sequence

select NEXT VALUE For AccountNumber_Sequence

select * from a1
set identity_insert a1 ON

insert into a1 values( NEXT VALUE For AccountNumber_Sequence,'shah')

drop table a1;
CREATE SEQUENCE Purchase_Sequence

SELECT * FROM sys.sequences WHERE name = 'Purchase_Sequence'
DROP SEQUENCE Purchase_Sequence

create sequence customized_seq
as int 
start with 10
increment by 1

select next value for Number_Sequence

drop SEQUENCE Number_Sequence

select minimum_value from sys.sequences where name='Number_Sequence'
CREATE SEQUENCE Number_Sequence AS INTEGER
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1 
    MAXVALUE 5
    CYCLE

SELECT NEXT VALUE FOR Number_Sequence
SELECT NEXT VALUE FOR Number_Sequence
SELECT NEXT VALUE FOR Number_Sequence
SELECT NEXT VALUE FOR Number_Sequence
SELECT NEXT VALUE FOR Number_Sequence
SELECT NEXT VALUE FOR Number_Sequence
ALTER SEQUENCE Number_Sequence
    INCREMENT BY -3


Create Sequence CardFirst_Sequence 
AS INTEGER
	INCREMENT BY 1
	MAXVALUE 99


CREATE SEQUENCE CardLast_SEquence
AS INTEGER
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 999
	CYCLE
