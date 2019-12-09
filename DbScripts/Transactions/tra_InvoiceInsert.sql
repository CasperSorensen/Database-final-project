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
BEGIN
    DECLARE @nTransID INT;
    DECLARE @cText VARCHAR(20);
    DECLARE curTrans CURSOR FOR
	SELECT TOP 200
        nTransID, cText
    FROM Trans
    ORDER BY nTransID;

    OPEN curTrans;
    FETCH NEXT FROM curTrans INTO @nTransID, @cText;

    BEGIN TRANSACTION;

    BEGIN TRY
		WHILE @@FETCH_STATUS = 0
		BEGIN
        IF @nTransID = 127
				SELECT 1/0;


        UPDATE Trans SET cText = 'After' WHERE nTransID = @nTransID;

        FETCH NEXT FROM curTrans INTO @nTransID, @cText;
    END;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SELECT 'You have divided by zero';
	END CATCH;

    CLOSE curTrans;
    DEALLOCATE curTrans;
END;

-- BEGIN TRANSACTION [tra_InvoiceInsert]

-- BEGIN TRY

--       INSERT INTO [Test].[dbo].[T1]
--     ([Title], [AVG])
-- VALUES
--     ('Tidd130', 130),
--     ('Tidd230', 230)

--       UPDATE [Test].[dbo].[T1]
--       SET [Title] = N'az2' ,[AVG] = 1
--       WHERE [dbo].[T1].[Title] = N'az'

--       COMMIT TRANSACTION [tra_InvoiceInsert]

--   END TRY

--   BEGIN CATCH

--       ROLLBACK TRANSACTION [tra_InvoiceInsert]

--   END CATCH 