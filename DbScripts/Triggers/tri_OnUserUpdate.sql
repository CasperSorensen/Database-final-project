-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         tri_OnUserUpdate.sql
-- 
-- Purpose:      Creates a ON DELETE trigger on the TCreditCard table
--               It adds the Tsuers old and the new values FROM the row
--               it then calls the sp_InsertIntoAuditCreditCards 
--               that inserts them into to the TAuditCreditCard table.
--
-- At:           AFTER UPDATE
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
CREATE
OR ALTER TRIGGER trg_OnUserUpdate
ON TUser
AFTER UPDATE
    AS BEGIN
    -- DECLARE ALL VARIABLES
    DECLARE @before_nUserId INT
    DECLARE @before_cFirstName VARCHAR(20)
    DECLARE @before_cSurname VARCHAR(20)
    DECLARE @before_cAddress VARCHAR(60) 
    DECLARE @before_cPhoneNo VARCHAR(8) 
    DECLARE @before_cZipcode VARCHAR(4) 
    DECLARE @before_nCity INT 
    DECLARE @before_cEmail VARCHAR(60)    
    DECLARE @before_nTotalAmount DECIMAL(2) 
    DECLARE @after_nUserId INT      
    DECLARE @after_cFirstName VARCHAR(20) 
    DECLARE @after_cSurname VARCHAR(20) 
    DECLARE @after_cAddress VARCHAR(60) 
    DECLARE @after_cPhoneNo VARCHAR(8) 
    DECLARE @after_cZipcode VARCHAR(4) 
    DECLARE @after_nCity INT 
    DECLARE @after_cEmail VARCHAR (60)
    DECLARE @after_nTotalAmount DECIMAL(2)      
    DECLARE @cStatementType VARCHAR(10) 
    DECLARE @dtExecutedAt DATETIME 
    DECLARE @nDBMSId INT
    DECLARE @cDBMSName NVARCHAR(128) 
    DECLARE @cHostId CHAR(8) 
    DECLARE @cHostName NVARCHAR(128)
    
    SELECT @before_nUserId = nUserId from deleted
    SELECT @before_cFirstName = cFirstName from deleted 
    SELECT @before_cSurname = cSurname from deleted 
    SELECT @before_cAddress = cAddress from deleted 
    SELECT @before_cPhoneNo = cPhoneNo from deleted 
    SELECT @before_cZipcode = cZipCode from deleted 
    SELECT @before_nCity = cCity from deleted 
    SELECT @before_cEmail = cEmail from deleted 
    SELECT @before_nTotalAmount = nTotalAmount from deleted

    SELECT @after_nUserId = nUserId from inserted
    SELECT @after_cFirstName = cFirstName from inserted 
    SELECT @after_cSurname = cSurname from inserted 
    SELECT @after_cAddress = cAddress from inserted 
    SELECT @after_cPhoneNo = cPhoneNo from inserted 
    SELECT @after_cZipcode = cZipCode from inserted 
    SELECT @after_nCity = cCity from inserted 
    SELECT @after_cEmail = cEmail from inserted 
    SELECT @after_nTotalAmount = nTotalAmount from inserted 
    SELECT @cStatementType = 'UPDATE' 
    
    SET @dtExecutedAt = GETDATE() 
    SET @nDBMSId = USER_ID() 
    SET @cDBMSName = USER_NAME() 
    SET @cHostId = HOST_ID() 
    SET @cHostName = HOST_NAME() 

EXEC pro_InsertIntoAuditUsers 
    @before_nUserId,
    @before_cFirstName,
    @before_cSurname,
    @before_cAddress, 
    @before_cPhoneNo, 
    @before_cZipcode, 
    @before_nCity, 
    @before_cEmail,     
    @before_nTotalAmount, 
    @after_nUserId,     
    @after_cFirstName, 
    @after_cSurname, 
    @after_cAddress, 
    @after_cPhoneNo, 
    @after_cZipcode, 
    @after_nCity, 
    @after_cEmail,
    @after_nTotalAmount,      
    @cStatementType, 
    @dtExecutedAt, 
    @nDBMSId,
    @cDBMSName, 
    @cHostId, 
    @cHostName

END;