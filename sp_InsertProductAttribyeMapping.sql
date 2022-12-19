/*  STORED PROCEDURE sp_InsertProductAttributeMapping

	Description: SP to store the Attributes available for the products. This will be used by the Admin only.
	Tables Used: [Ankur].[dbo].[Attributes]
				[Ankur].[dbo].[Product]
			Truncate table	[Ankur].[dbo].[ProductAttributeMapping]
*/

CREATE PROCEDURE sp_InsertProductAttributeMapping 
	@AttributeName Varchar(50),
	@ProductName VARCHAR(50)
AS

	BEGIN

			DECLARE @ProductId BIGINT
					,@AttributeId BIGINT
			SELECT @ProductId = ProductId FROM [Ankur].[dbo].[Product] WHERE ProductName = @ProductName
			SELECT @AttributeId = AttributesId FROM [Ankur].[dbo].[Attributes] WHERE AttributeName =@AttributeName


			INSERT INTO [Ankur].[dbo].[ProductAttributeMapping] (ProductId, AttributesId) 
			SELECT @ProductId, @AttributeId


	END

/*
EXEC sp_InsertProductAttributeMapping 'Size','apple'
EXEC sp_InsertProductAttributeMapping 'color','apple'
EXEC sp_InsertProductAttributeMapping 'Size','Mango'
EXEC sp_InsertProductAttributeMapping 'color','Mango'
*/
