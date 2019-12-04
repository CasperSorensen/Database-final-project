-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         pro_InsertIntoAuditUsers.sql
-- 
-- Purpose:      Creates a Stored Procedure on the TAuditUser table
--               that can be used to insert into the TAuditUser table
--               
-- Type:         Stored Procedure
-- 
-- Artifacts:    None
--                 
-- Author:       Casper Sørensen
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE pro_InsertIntoAuditUsersTable

    -- Old values
    @before_nCPR INT,
    @before_cName VARCHAR(30),
    @before_cSurname VARCHAR(40),
    @before_cAddress VARCHAR(60),
    @before_cPhoneNo VARCHAR(8),
    @before_dBirthDate DATE,
    @before_dNewMemberDate DATE,
    -- New values
    @after_nCPR INT,
    @after_cName VARCHAR(30),
    @after_cSurname VARCHAR(40),
    @after_cAddress VARCHAR(60),
    @after_VPhoneNo VARCHAR(8),
    @after_dBirthDate DATE,
    @after_dNewMemberDate DATE,
    -- Data
    @vStatementType VARCHAR(10),
    @dtExecutedAt DATETIME,
    @nDBMSId INT,
    @nDBMSName NVARCHAR(128),
    @nHostId CHAR(8),
    @nHostName NVARCHAR(128)
AS
BEGIN

    INSERT INTO 
TAudit
        (beforeICPR ,
        beforeVName,
        beforeVSurname,
        beforeVAddress,
        beforeVPhoneNo,
        beforeDBirthDate,
        beforeDNewMemberDate,
        afterICPR,
        afterVName,
        afterVSurname,
        afterVAddress,
        afterVPhoneNo,
        afterDBirthDate,
        afterDNewMemberDate,
        vStatementType,
        dtExecutedAt,
        nDBMSName,
        nDBMSId,
        nHostId,
        nHostName
        )
    VALUES
        (@beforeICPR,
            @beforeVName,
            @beforeVSurname,
            @beforeVAddress,
            @beforeVPhoneNo,
            @beforeDBirthDate,
            @beforeDNewMemberDate,
            @afterICPR,
            @afterVName,
            @afterVSurname,
            @afterVAddress,
            @afterVPhoneNo,
            @afterDBirthDate,
            @afterDNewMemberDate,
            @vStatementType,
            @dtExecutedAt,
            @nDBMSId,
            @nDBMSName,
            @nHostId,
            @nHostName
    );
    RETURN 1
END