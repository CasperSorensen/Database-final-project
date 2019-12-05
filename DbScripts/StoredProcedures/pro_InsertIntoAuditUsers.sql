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

CREATE OR ALTER PROCEDURE pro_InsertIntoAuditUsers

    -- SET 
    @before_nUserId INT,
    @before_cName VARCHAR(30),
    @before_cSurname VARCHAR(40),
    @before_cAddress VARCHAR(60),
    @before_cPhoneNo VARCHAR(8),
    @before_cZipcode VARCHAR(8),
    @before_cCity VARCHAR(8),
    @before_cEmail VARCHAR(8),
    @before_nTotalAmount DECIMAL(2),

    -- SET
    @after_nCPR INT,
    @after_cName VARCHAR(30),
    @after_cSurname VARCHAR(40),
    @after_cAddress VARCHAR(60),
    @after_VPhoneNo VARCHAR(8),
    @after_cCity VARCHAR(8),
    @after_cEmail VARCHAR (8),
    @after_nTotalAmount DECIMAL(2),

    -- Data
    @vStatementType VARCHAR(10),
    @dtExecutedAt DATETIME,
    @nDBMSId INT,
    @nDBMSName NVARCHAR(128),
    @nHostId CHAR(8),
    @nHostName NVARCHAR(128)
AS
BEGIN

    INSERT INTO TAuditUsers
        (before_nUserId ,
        before_cName,
        before_cSurname,
        before_cAddress,
        before_cPhoneNo,
        before_cZipcode,
        before_cCity,
        before_cEmail,
        before_nTotalAmount,
        after_nUserId,
        after_cName,
        after_cSurname,
        after_cAddress,
        after_cPhoneNo,
        after_cZipcode,
        after_cCity,
        after_cEmail,
        after_nTotalAmount,
        vStatementType,
        dtExecutedAt,
        nDBMSName,
        nDBMSId,
        nHostId,
        nHostName
        )
    VALUES
        (@beforeICPR,
            @before_cName,
            @before_cSurname,
            @before_cAddress,
            @before_cPhoneNo,
            @before_DBirthDate,
            @before_DNewMemberDate,
            @after_nUserId,
            @after_cName,
            @after_cSurname,
            @after_cAddress,
            @after_cPhoneNo,
            @after_dBirthDate,
            @after_dNewMemberDate,
            @cStatementType,
            @dtExecutedAt,
            @nDBMSId,
            @nDBMSName,
            @nHostId,
            @nHostName
    );
    RETURN 1
END