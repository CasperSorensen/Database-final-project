-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         tri_OnUserInsert.sql
-- 
-- Purpose:      * Creates a trigger on the TUser table
--               * Adds empty values to the @before fields
--               * Adds the new users values to the @after fields 
--               * Inserts into the TAuditUser table.
--               
-- Type:         Trigger
--
-- At:           AFTER INSERT
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

CREATE OR ALTER TRIGGER trg_OnUserInsert
ON TUser
AFTER INSERT
AS
BEGIN

    -- DECLARE ALL VARIABLES
    -- DECARE BEFORE VALUES
    DECLARE @before_nUserId INT
    DECLARE @before_cFirstName VARCHAR(20)
    DECLARE @before_cSurname VARCHAR(20)
    DECLARE @before_cAddress VARCHAR(60)
    DECLARE @before_cPhoneNo VARCHAR(8)
    DECLARE @before_cZipcode VARCHAR(4)
    DECLARE @before_nCity INT
    DECLARE @before_cEmail VARCHAR(60)
    DECLARE @before_nTotalAmount DECIMAL(2)
    -- DECLARE NEW VALUES
    DECLARE @after_nUserId INT
    DECLARE @after_cFirstName VARCHAR(20)
    DECLARE @after_cSurname VARCHAR(20)
    DECLARE @after_cAddress VARCHAR(60)
    DECLARE @after_cPhoneNo VARCHAR(8)
    DECLARE @after_cZipcode VARCHAR(4)
    DECLARE @after_nCity INT
    DECLARE @after_cEmail VARCHAR (60)
    DECLARE @after_nTotalAmount DECIMAL(2)
    -- DECLARE SYSTEM DATE
    DECLARE @cStatementType VARCHAR(10)
    DECLARE @dtExecutedAt DATETIME
    DECLARE @nDBMSId INT
    DECLARE @cDBMSName NVARCHAR(128)
    DECLARE @cHostId CHAR(8)
    DECLARE @cHostName NVARCHAR(128)

    -- SET BEFORE VARIABLES
    SELECT @before_nUserId = NULL
    SELECT @before_cFirstName = NULL 
    SELECT @before_cSurname = NULL
    SELECT @before_cAddress = NULL
    SELECT @before_cPhoneNo = NULL
    SELECT @before_cZipcode = NULL
    SELECT @before_nCity = NULL
    SELECT @before_cEmail = NULL
    SELECT @before_nTotalAmount = NULL

    -- SET AFTER VARIABLES
    SELECT @after_nUserId = nUserId from inserted
    SELECT @after_cFirstName = cFirstName from inserted
    SELECT @after_cSurname = cSurname from inserted
    SELECT @after_cAddress = cAddress from inserted
    SELECT @after_cPhoneNo = cPhoneNo from inserted
    SELECT @after_cZipcode = cZipCode from inserted
    SELECT @after_nCity = cCity from inserted
    SELECT @after_cEmail = cEmail from inserted
    SELECT @after_nTotalAmount = nTotalAmount from inserted
    SELECT @cStatementType = 'INSERT'

    -- SET THE SYSTEM VARIABLES
    SET @dtExecutedAt = GETDATE()
    SET @nDBMSId = USER_ID()
    SET @cDBMSName = USER_NAME()
    SET @cHostId = HOST_ID()
    SET @cHostName = HOST_NAME()

    -- CALL THE INSERT INTO TAUDITUSERS STORED PROCEDURE
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