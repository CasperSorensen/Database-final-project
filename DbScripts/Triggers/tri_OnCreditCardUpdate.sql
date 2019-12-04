-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         tri_OnCreditCardDUpdate.sql
-- 
-- Purpose:      Creates a ON DELETE trigger on the TCreditCard table
--               It adds the Tsuers old and the new values from the row
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

CREATE OR ALTER TRIGGER trg_OnCreditCardUpdate
ON TCreditCard
AFTER UPDATE
AS
BEGIN

    -- DECLARE VARIABLES --
    DECLARE @beforeICPR VARCHAR(10)
    DECLARE @beforeVName VARCHAR(30)
    DECLARE @beforeVSurname VARCHAR(40)
    DECLARE @beforeVAddress VARCHAR(60)
    DECLARE @beforeVPhoneNo VARCHAR(8)
    DECLARE @beforeDBirthDate DATE
    DECLARE @beforeDNewMemberDate DATE
    DECLARE @afterICPR VARCHAR(10)
    DECLARE @afterVName VARCHAR(30)
    DECLARE @afterVSurname VARCHAR(40)
    DECLARE @afterVAddress VARCHAR(60)
    DECLARE @afterVPhoneNo VARCHAR(8)
    DECLARE @afterDBirthDate DATE
    DECLARE @afterDNewMemberDate DATE
    DECLARE @vStatementType VARCHAR(10)

    -- SET BEFORE VARIABLES
    SELECT @beforeICPR = cCPR
    from deleted
    SELECT @beforeVName = cName
    from deleted
    SELECT @beforeVSurname = cSurname
    from deleted
    SELECT @beforeVAddress = cAddress
    from deleted
    SELECT @beforeVPhoneNo = cPhoneNo
    from deleted
    SELECT @beforeDBirthDate = dBirth
    from deleted
    SELECT @beforeDNewMemberDate = dNewMember
    from deleted

    -- SET AFTER VARIABLES
    SELECT @afterICPR = cCPR
    from inserted
    SELECT @afterVName = cName
    from inserted
    SELECT @afterVSurname = cSurname
    from inserted
    SELECT @afterVAddress = cAddress
    from inserted
    SELECT @afterVPhoneNo = cPhoneNo
    from inserted
    SELECT @afterDBirthDate = dBirth
    from inserted
    SELECT @afterDNewMemberDate = dNewMember
    from inserted

    -- SET SYSTEM VARIABLES
    SELECT @vStatementType = 'UPDATE'
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