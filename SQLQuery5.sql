create table roles(ROleId INT PRIMARY KEY IDENTITY(1,1), RoleName VARCHAR(50) UNIQUE);


create table credentials (
	CredentialId INT IDENTITY(1,1) PRIMARY KEY,
	UserName varchar(20) NOT NULL,
	UserPassword varchar(20) NOT NULL,
	RoleId INT FOREIGN KEY REFERENCES roles(ROleId),
	EmailId varchar(50),
	Constraint unique_name UNIQUE(UserName,UserPassword),
	Constraint pw_ch CHECK(UserPassword != UserName)
	)

CREATE TABLE BranchDetails(
	BranchId INT PRIMARY KEY IDENTITY(1000,1),
	BranchName varchar(50) NOT NULL UNIQUE,
	District varchar(50) NOT NULL,
	[State] varchar(50) NOT NULL,
	Counry varchar(50) NOT NULL,
	BranchManagerId INT FOREIGN KEY REFERENCES credentials(CredentialId)
)

CREATE TABLE Customers(
	CustId INT PRIMARY KEY IDENTITY(1000,1),
	Gender CHAR(1) NOT NULL,
	PhoneNumber NUMERIC(10) NOT NULL,
	AddressLine1 VARCHAR(50) NOT NULL,
	City VARCHAR(50) NOT NULL,
	[State] VARCHAR(50) NOT NULL,
	Country VARCHAR(50) NOT NULL,
	PinNumber BIGINT NOT NULL,
	CredentialId INT FOREIGN KEY REFERENCES credentials(CredentialId),
	FirstName VARCHAR(20),
	LastName VARCHAR(20),
	CONSTRAINT chk_phone CHECK (PhoneNumber NOT LIKE '%[^0-9]%(10)')
)



