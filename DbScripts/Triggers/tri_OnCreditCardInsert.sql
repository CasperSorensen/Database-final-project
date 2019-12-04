-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         tri_OnCreditCardInsert.sql
-- 
-- Purpose:      Creates a ON DELETE trigger on the TCreditCard table
--               It adds the Tsuers old and the new values from the row
--               it then calls the sp_InsertIntoAuditCreditCards 
--               that inserts them into to the TAuditCreditCard table.
--
-- At:           AFTER INSERT
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


CREATE OR ALTER TRIGGER trg_OnCreditCardInsert
ON TCreditCard
AFTER INSERT
AS
BEGIN

    -- DECLARE ALL VARIABLES
    DECLARE @before_ICPR VARCHAR(10)
    DECLARE @before_cName VARCHAR(30)
    DECLARE @before_cSurname VARCHAR(40)
    DECLARE @before_cAddress VARCHAR(60)
    DECLARE @before_cPhoneNo VARCHAR(8)
    DECLARE @before_DBirthDate DATE
    DECLARE @before_DNewMemberDate DATE
    DECLARE @after_ICPR VARCHAR(10)
    DECLARE @after_cName VARCHAR(30)
    DECLARE @after_cSurname VARCHAR(40)
    DECLARE @after_cAddress VARCHAR(60)
    DECLARE @after_cPhoneNo VARCHAR(8)
    DECLARE @after_DBirthDate DATE
    DECLARE @after_DNewMemberDate DATE
    DECLARE @vStatementType VARCHAR(10)
    DECLARE @dtExecutedAt DATETIME
    DECLARE @nDBMSId NVARCHAR(128)
    DECLARE @nDBMSName NVARCHAR(128)
    DECLARE @nHostId CHAR(8)
    DECLARE @nHostName NVARCHAR(128)

    -- SET BEFORE VARIABLES
    SELECT @before_InCPR = NULL
    SELECT @before_cName = NULL
    SELECT @before_cSurname = NULL
    SELECT @before_cAddress = NULL
    SELECT @before_cPhoneNo = NULL
    SELECT @before_DBirthDate = NULL
    SELECT @before_DNewMemberDate = NULL

    -- SET AFTER VARIABLES
    SELECT @after_ICPR = cCPR
    from inserted
    SELECT @after_cName = cName
    from inserted
    SELECT @after_cSurname = cSurname
    from inserted
    SELECT @after_cAddress = cAddress
    from inserted
    SELECT @after_cPhoneNo = cPhoneNo
    from inserted
    SELECT @after_DBirthDate = dBirth
    from inserted
    SELECT @after_DNewMemberDate = dNewMember
    from inserted
    SELECT @vStatementType = 'INSERT'

    -- SET THE SYSTEM VARIABLES
    SET @dtExecutedAt = GETDATE()
    SET @nDBMSId = USER_ID()
    SET @nDBMSName = USER_NAME()
    SET @nHostId = HOST_ID()
    SET @nHostName = HOST_NAME()

    -- CALL THE INSERT INTO TAUDITUSERS STORED PROCEDURE
    EXEC pro_InsertIntoAuditCreditCardsTable 
        @before_nCPR,
        @before_cName,
        @before_cSurname,
        @before_cAddress,
        @before_cPhoneNo,
        @before_dBirthDate,
        @before_dNewMemberDate,
        @after_nCPR,
        @after_cName,
        @after_cSurname,
        @after_cAddress,
        @after_cPhoneNo,
        @after_dBirthDate,
        @after_dNewMemberDate,
        @vStatementType,
        @dtExecutedAt,
        @nDBMSName,
        @nDBMSId,
        @nHostId,
        @nHostName
END;