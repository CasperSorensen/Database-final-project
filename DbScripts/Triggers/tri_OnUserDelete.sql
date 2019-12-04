-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         tri_OnUserDelete.sql
-- 
-- Purpose:      Creates a ON DELETE trigger on the TUser table
--               It adds the Tsuers old and the new values from the row
--               it then calls the sp_InsertIntoAuditUsers 
--               that inserts them into to the TAuditUser table.
--
-- Condition:    AFTER DELETE
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

CREATE OR ALTER TRIGGER trg_OnUserDelete
ON TUser
AFTER DELETE
AS
BEGIN

    -- DECLARE VARIABLES --
    DECLARE @before_ICPR VARCHAR(10)
    DECLARE @before_VName VARCHAR(30)
    DECLARE @before_VSurname VARCHAR(40)
    DECLARE @before_VAddress VARCHAR(60)
    DECLARE @before_VPhoneNo VARCHAR(8)
    DECLARE @before_DBirthDate DATE
    DECLARE @before_DNewMemberDate DATE
    DECLARE @after_ICPR VARCHAR(10)
    DECLARE @after_VName VARCHAR(30)
    DECLARE @after_VSurname VARCHAR(40)
    DECLARE @after_VAddress VARCHAR(60)
    DECLARE @after_VPhoneNo VARCHAR(8)
    DECLARE @after_DBirthDate DATE
    DECLARE @after_DNewMemberDate DATE
    DECLARE @vStatementType VARCHAR(10)
    DECLARE @vStatementType VARCHAR(10)
    DECLARE @dtExecutedAt DATETIME
    DECLARE @nDBMSId NVARCHAR(128)
    DECLARE @nDBMSName NVARCHAR(128)
    DECLARE @nHostId CHAR(8)
    DECLARE @nHostName NVARCHAR(128)

    -- SET BEFORE VARIABLES 
    SELECT @before_ICPR = cCPR
    from deleted
    SELECT @before_VName = cName
    from deleted
    SELECT @before_VSurname = cSurname
    from deleted
    SELECT @before_VAddress = cAddress
    from deleted
    SELECT @before_VPhoneNo = cPhoneNo
    from deleted
    SELECT @before_DBirthDate = dBirth
    from deleted
    SELECT @before_DNewMemberDate = dNewMember
    from deleted

    -- SET AFTER VARIABLES
    SELECT @after_ICPR = NULL
    SELECT @after_VName = NULL
    SELECT @after_VSurname = NULL
    SELECT @after_VAddress = NULL
    SELECT @after_VPhoneNo = NULL
    SELECT @after_DBirthDate = NULL
    SELECT @after_DNewMemberDate = NULL

    -- SET SYSTEM VARIABLES
    SELECT @vStatementType = 'DELETE'
    SET @dtExecutedAt = GETDATE()
    SET @nDBMSId = USER_ID()
    SET @nDBMSName = USER_NAME()
    SET @nHostId = HOST_ID()
    SET @nHostName = HOST_NAME()

    -- CALL THE INSERT INTO TAUDITUSERS STORED PROCEDURE
    EXEC pro_InsertIntoAuditUsersTable 
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