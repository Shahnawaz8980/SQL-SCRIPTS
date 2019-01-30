BEGIN 
	BEGIN TRY
		DECLARE @AccountNumber VARCHAR(15) = '007066100000103', 
		        @BranchId TINYINT = 1
		DECLARE @TellerId TINYINT = 5, @CustomerId BIGINT = 123
		INSERT INTO Account(AccountNumber, BranchId, CreatedBy) 
			   VALUES(@AccountNumber, @BranchId, @TellerId) 
		INSERT INTO AccountCustomerMapping(AccountNumber, CustomerId) 
			   VALUES(@AccountNumber, @CustomerId) 
	END TRY
    BEGIN CATCH
	    PRINT 'Some error occurred.'
    	   SELECT ERROR_LINE() AS LineNumber,        
           ERROR_MESSAGE() AS ErrorMessage,           
           ERROR_NUMBER() AS ErrorNumber,    
           ERROR_SEVERITY() AS Severity,         
           ERROR_STATE() AS ErrorState
   END CATCH
END


--Batches Demo--

BEGIN 
     DECLARE @Price NUMERIC(8) =200, @QuantityPurchased TINYINT=2, @TotalAmount NUMERIC(8)=0 -- DECLARE keyword is used to declare local variables
	 select @Price
END

BEGIN
    DECLARE @Price NUMERIC(8) =200, @QuantityPurchased TINYINT=3, @TotalAmount NUMERIC(8)=0, @Counter INT =0 
    WHILE @Counter < @QuantityPurchased
    BEGIN
        SET @TotalAmount=@TotalAmount + @price -- SET keyword is used to assign value to or update a local variable
        SET @Counter = @Counter + 1
    END
    PRINT @TotalAmount -- PRINT keyword is used to display data
END

BEGIN
	DECLARE @Price NUMERIC(8)=200, @QuantityPurchased int=2, @TotalAmount NUMERIC(8)
	SET @TotalAmount = @Price * @QuantityPurchased
	IF @TotalAmount > 0 AND @TotalAmount < 1000
		SET @TotalAmount=0.05 * @TotalAmount
	ELSE IF @TotalAmount>=1000 AND @TotalAmount<2000 
    SET @TotalAmount=0.9*@TotalAmount 
	ELSE    
    SET @TotalAmount=0.8*@TotalAmount 
 PRINT @TotalAmount 
END


DECLARE @Age INT = 28 
PRINT ' The Age is: '+  CAST(@Age AS NVARCHAR) +'Years'




Select * from [Transaction]




