
drop procedure usp_OpenAccount
CREATE PROCEDURE usp_OpenAccount
(
    @CustomerId INT,
    @BranchId INT,
    @TellerId INT,
    @AccountNumber VARCHAR(15) OUTPUT 
)
AS
BEGIN
    DECLARE @SequenceValue VARCHAR(9), @BranchCode VARCHAR(6)
    BEGIN TRY
        IF NOT EXISTS (SELECT CustomerId FROM Customer WHERE CustomerId = @CustomerId)
        BEGIN
            RETURN -1
        END
        IF NOT EXISTS (SELECT BranchId FROM Branch WHERE BranchId = @BranchId)
        BEGIN
            RETURN -2
        END
        IF NOT EXISTS (SELECT TellerId FROM Teller WHERE TellerId = @TellerId)
        BEGIN
            RETURN -3
        END
        SELECT @SequenceValue = NEXT VALUE FOR AccountNumber_Sequence
        SELECT @BranchCode=BranchCode FROM Branch WHERE BranchId = @BranchId
        SELECT @AccountNumber = @BranchCode + @SequenceValue
            BEGIN TRAN
                INSERT INTO Account(AccountNumber, BranchId, CreatedBy)
                VALUES(@AccountNumber, @BranchId, @TellerId)
                INSERT INTO AccountCustomerMapping(AccountNumber, CustomerId)
                VALUES(@AccountNumber, @CustomerId)
            COMMIT
            RETURN 1
    END TRY
    BEGIN CATCH
        ROLLBACK
        RETURN -99
    END CATCH
END

CREATE SEQUENCE AccountNumber_Sequence
    AS INT
    INCREMENT BY 1
    START WITH 100000104
    MINVALUE 100000101
    MAXVALUE 999999999

DROP SEQUENCE AccountNumber_Sequence

BEGIN
	DECLARE @AccountNumber VARCHAR(15), @ReturnValue INT
	EXEC @ReturnValue = usp_OpenAccount '1000000060', 1, 5, @AccountNumber OUT
	SELECT @AccountNumber AS AccountNumber
	SELECT @ReturnValue AS ReturnValue
END

