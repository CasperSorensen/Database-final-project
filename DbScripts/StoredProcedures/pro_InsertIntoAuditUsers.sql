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

    -- SET BEFORE VALUES
    @before_nUserId INT,
    @before_cFirstName VARCHAR(20),
    @before_cSurname VARCHAR(20),
    @before_cAddress VARCHAR(60),
    @before_cPhoneNo VARCHAR(8),
    @before_cZipcode VARCHAR(4),
    @before_nCity INT,
    @before_cEmail VARCHAR(60),
    @before_nTotalAmount DECIMAL(2),

    -- SET NEW VALUES
    @after_nUserId INT,
    @after_cFirstName VARCHAR(20),
    @after_cSurname VARCHAR(20),
    @after_cAddress VARCHAR(60),
    @after_cPhoneNo VARCHAR(8),
    @after_cZipcode VARCHAR(4),
    @after_nCity INT,
    @after_cEmail VARCHAR (60),
    @after_nTotalAmount DECIMAL(2),

    -- SET SYSTEM DATE
    @cStatementType VARCHAR(10),
    @dtExecutedAt DATETIME,
    @nDBMSId INT,
    @cDBMSName NVARCHAR(128),
    @cHostId CHAR(8),
    @cHostName NVARCHAR(128)
AS
BEGIN
    INSERT INTO TAuditUser
        (before_nUserId,
        before_cFirstName,
        before_cSurname,
        before_cAddress,
        before_cPhoneNo,
        before_cZipcode,
        before_nCity,
        before_cEmail,
        before_nTotalAmount,
        after_nUserId,
        after_cFirstName,
        after_cSurname,
        after_cAddress,
        after_cPhoneNo,
        after_cZipcode,
        after_nCity,
        after_cEmail,
        after_nTotalAmount,
        cStatementType,
        dtExecutedAt,
        nDBMSId,
        cDBMSName,
        cHostId,
        cHostName
        )
    VALUES
        (@before_nUserId,
            @before_cFirstName,
            @before_cSurname,
            @before_cAddress,
            @before_cPhoneNo,
            @before_cZipcode,
            @before_nCity,
            @before_cEmail,
            @before_nTotalAmount,
            -- New Values
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
    );
    RETURN 1
END

