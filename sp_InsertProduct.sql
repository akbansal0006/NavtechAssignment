/*  STORED PROCEDURE sp_InsertProduct

	Description: SP to store the master list of Attributes. This will be used by the Admin only.
	Tables Used: [Ankur].[dbo].[Product]
*/


CREATE PROCEDURE sp_InsertProduct
	@ProductName Varchar(50), 
	@Description Varchar(200) NULL,
	@Price		NUMERIC(10,2),
	@ProductQuantity INT

AS

	BEGIN
			IF EXISTS( SELECT 1 FROM [Ankur].[dbo].[Product] WHERE  ProductName=@ProductName)
				BEGIN
					UPDATE [Ankur].[dbo].[Product]
						SET [Description]= @Description
							,Price=@Price
							,ProductQuantity= @ProductQuantity
						WHERE ProductName = @ProductName
				END
			ELSE
				BEGIN
				INSERT INTO [Ankur].[dbo].[Product] (ProductName, Description, Price, ProductQuantity) 
				SELECT @ProductName, @Description, @Price, @ProductQuantity
				END

	END


/*
EXEC sp_InsertProduct 'apple', 'fruit', '10', '20'
EXEC sp_InsertProduct 'Mango', 'fruit', '30', '4'
EXEC sp_InsertProduct 'Guava', '', '100', '20'
EXEC sp_InsertProduct 'Garpes', 'fruit', '180', '12'
EXEC sp_InsertProduct 'dragonFruit', 'fruit', '280', '5'

*/

