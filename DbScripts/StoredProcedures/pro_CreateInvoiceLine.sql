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


CREATE OR ALTER PROCEDURE pro_CreateInvoiceLine

    @nInvoiceId INT,
    @nProductId INT,
    @nQuantity INT,
	@nUnitPrice DECIMAL(4,2)
    
AS
BEGIN

    INSERT INTO TInvoiceLine
        ([nInvoiceId]
        ,[nProductId]
        ,[nQuantity]
		,[nUnitPrice])
    VALUES
        (@nInvoiceId, @nProductId,@nQuantity,@nUnitPrice)
 
END