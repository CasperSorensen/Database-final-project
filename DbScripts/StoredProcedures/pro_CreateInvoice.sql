-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         pro_CreateInvoice.sql
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


CREATE OR ALTER PROCEDURE pro_CreateInvoice

    @nUserId INT,
    @nCardId INT,
    @dTax DECIMAL(4,2),
    @nTotalAmount DECIMAL(6,2),
    @dDate DATETIME

AS
BEGIN

    INSERT INTO TInvoice
        ([nUserId]
        ,[nCreditCardId]
        ,[nTax]
        ,[nTotalAmount]
        ,[nDate])
    VALUES
        (@nUserId, @nCardId, @dTax, @nTotalAmount, @dDate)
    RETURN 1
END