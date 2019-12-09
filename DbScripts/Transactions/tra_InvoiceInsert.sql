-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         tra_InvoiceInsert.sql
-- 
-- Purpose:      Creates a ON DELETE trigger on the TUser table
--               It adds the Tsuers old and the new values from the row
--               it then calls the sp_InsertIntoAuditUsers 
--               that inserts them into to the TAuditUser table.
--               
-- Type:         Transaction
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

-- With transaction and error (all is rollbacked)
BEGIN TRANSACTION InsertIvoice;

    BEGIN TRY

			-- call insertinvoice proc.
			-- 
			EXEC @RESULT = pro_CreateInvoice @nUserId =2, @nCardId = 2, @dTax = 20,@nTotalAmount = 20.20,@dDate ='2000-03-03';



		
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SELECT 'Something went wrong';
	END CATCH;

COMMIT TRANSACTION InsertInvoice;