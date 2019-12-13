-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         tri_OnCreditCardDelete.sql
-- 
-- Purpose:      Creates a AFTER DELETE trigger on the TCreditCard table
--               It adds the TCreditCard old and the new values FROM the row
--               it then calls the pro_InsertIntoAuditCreditCards 
--               that inserts them into to the TAuditCreditCard table.
--
-- At:           AFTER DELETE
--               
-- Type:         Trigger
-- 
-- Artifacts:    None
--                 
-- Authors:      Casper Sørensen, 
--               Martin Belák, 
--               Norbert Krausz, 
--               Bastian Normann Garding
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

CREATE OR ALTER TRIGGER trg_OnCreditCardDelete
ON TCreditCard
AFTER DELETE
AS
BEGIN

    -- DECLARE ALL VARIABLES
    DECLARE @before_nCreditCardId INT
    DECLARE @before_nUserId INT
    DECLARE @before_cIBANCode VARCHAR(34)
    DECLARE @before_dExpDate VARCHAR(4)
    DECLARE @before_nCcv INT
    DECLARE @before_cCardholderName VARCHAR(40)
    DECLARE @before_nAmountSpent DECIMAL(2)
    -- SET NEW VALUES
    DECLARE @after_nCreditCardId INT
    DECLARE @after_nUserId INT
    DECLARE @after_cIBANCode VARCHAR(34)
    DECLARE @after_dExpDate VARCHAR(4)
    DECLARE @after_nCcv INT
    DECLARE @after_cCardholderName VARCHAR(40)
    DECLARE @after_nAmountSpent DECIMAL(2)
    
    -- SET SYSTEM DATE
    DECLARE @cStatementType VARCHAR(10)
    DECLARE @dtExecutedAt DATETIME
    DECLARE @nDBMSId INT
    DECLARE @cDBMSName NVARCHAR(128)
    DECLARE @cHostId CHAR(8)
    DECLARE @cHostName NVARCHAR(128)

    -- SET BEFORE VARIABLES
    SELECT @before_nCreditCardId = nCreditCardId,
    @before_nUserId = nUserId, 
    @before_cIBANCode = cIBANCode, 
    @before_dExpDate = dExpDate,
    @before_nCcv = nCcv, 
    @before_cCardholderName = cCardholderName,
    @before_nAmountSpent = nAmountSpent
    from deleted 

    SELECT @cStatementType = 'DELETE'

    -- SET THE SYSTEM VARIABLES
    SET @dtExecutedAt = GETDATE()
    SET @nDBMSId = USER_ID()
    SET @cDBMSName = USER_NAME()
    SET @cHostId = HOST_ID()
    SET @cHostName = HOST_NAME()

    -- CALL THE INSERT INTO TAUDITUSERS STORED PROCEDURE
    EXEC pro_InsertIntoAuditCreditCard
        @before_nCreditCardId,
    @before_nUserId,
        @before_cIBANCode,
        @before_dExpDate,
        @before_nCcv,
        @before_cCardholderName,
        @before_nAmountSpent,
        @after_nCreditCardId,
        @after_nUserId,
        @after_cIBANCode,
        @after_dExpDate,
        @after_nCcv,
        @after_cCardholderName,
        @after_nAmountSpent,
        @cStatementType,
        @dtExecutedAt,
        @nDBMSId,
        @cDBMSName,
        @cHostId,
        @cHostName
END;