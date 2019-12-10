-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         pro_InsertIntoAuditCreditCard.sql
-- 
-- Purpose:      Creates a Stored Procedure on the TAuditCreditCard table
--               that can be used to insert into the TAuditCreditCard table
--               
-- Type:         Stored Procedure
-- 
-- Artifacts:    None
--                 
-- Author:       Casper Sørensen
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE pro_InsertIntoAuditCreditCard
    -- SET BEFORE VALUES
    @before_nCreditCardId INT,
    @before_nUserId INT,
    @before_cIBANCode VARCHAR(34),
    @before_dExpDate VARCHAR(4),
    @before_nCcv INT,
    @before_cCardholderName VARCHAR(40),
    @before_nAmountSpent DECIMAL(2),
    -- SET NEW VALUES
    @after_nCreditCardId INT,
    @after_nUserId INT,
    @after_cIBANCode VARCHAR(34),
    @after_dExpDate VARCHAR(4),
    @after_nCcv INT,
    @after_cCardholderName VARCHAR(40),
    @after_nAmountSpent DECIMAL(2),
    -- SET SYSTEM VALUES
    @cStatementType VARCHAR(10),
    @dtExecutedAt DATETIME,
    @nDBMSId INT,
    @cDBMSName NVARCHAR(128),
    @cHostId CHAR(8),
    @cHostName NVARCHAR(128)
AS
BEGIN
    INSERT INTO
    TAuditCreditCard
        (
        nTAuditCreditCardId,
        before_nCreditCardId,
        before_nUserId,
        before_cIBANCode,
        before_dExpDate,
        before_nCcv,
        before_cCardholderName,
        before_nAmountSpent,
        after_nCreditCardId,
        after_nUserId,
        after_cIBANCode,
        after_dExpDate,
        after_nCcv,
        after_cCardholderName,
        after_nAmountSpent,
        cStatementType,
        dtExecutedAt,
        nDBMSId,
        cDBMSName,
        cHostId,
        cHostName
        )
    VALUES
        (
            @nTAuditCreditCardId,
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
    );

    RETURN 1
END