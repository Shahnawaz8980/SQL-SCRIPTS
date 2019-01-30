
BEGIN
	DECLARE @AccountNumber BIGINT ,@Amount NUMERIC(8),
			@[Type] BIT = 1, @Mode varchar(20)='Online', @Remark varchar(30),
			@Info varchar(200), @CreatedBy varchar(20)
	SET @AccountNumber = 007066100000001
	SET @Amount = 3000

	IF @Type=1
END

create table T1 (Col1 int,Col2 varchar(20))
create table T2 (data1 int UNIQUE,data2 varchar(20))
drop table t2;
BEGIN TRAN
BEGIN TRY
	insert into T1 values(1,'DATA')
	
	BEGIN TRY
	insert into T1 values(1,'DATA')
	INSERT INTo T2 values(1,'DATUM')
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK TRAN
END CATCH



select * from T1;
select * from T2;

---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- Ecercise 8

BEGIN
DECLARE @LoginName VARCHAR(5)
DECLARE @Password VARCHAR(300)
DECLARE @RetValue INT
	SET @LoginName = 'T1011'
	SET @Password = 'Indy!123'
    IF EXISTS (SELECT * FROM Teller WHERE LoginName = @LoginName)
		SET @RetValue = -1
	ELSE
		SET @RetValue = 1
	IF (@RetValue!=-1)
		INSERT INTO Teller (LoginName, [Password]) VALUES(@LoginName ,CONVERT(VARBINARY(300),@Password))
	IF(@RetValue=-1) 
		PRINT 'Login name already exists'
	ELSE
		PRINT 'Teller details added successfully'
END;

select * from Teller;
---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- Exercise 9
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('nyashkin0@fastcompany.com' , 'Melanie Vanyashkin' , '1993/09/01' , 1 , NULL, NULL)
SELECT @@IDENTITY AS CustomerId;
SELECT @@servername
---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--Execise-7

CREATE TABLE PRODUCT_DATA (ProdId int identity(2000,2), Name varchar(20));
drop table PRODUCT_DATA
drop 
---
BEGIN
DECLARE @Count int=0
while(@count<30)
BEGIN
	INSERT INTO PRODUCT_DATA values('Hello')
	SET @Count=@Count+1
END
END

select * from Product_data;

---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--Execise-11

