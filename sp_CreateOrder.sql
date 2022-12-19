/*  STORED PROCEDURE sp_CreateOrder

	Description: SP to store the master list of Attributes. This will be used by the Admin only.
	Tables Used: [Ankur].[dbo].[Product]
*/

CREATE PROCEDURE dbo.sp_CreateOrder
    @ProductName Varchar(50),
	@Qty	INT,
	@Attribute1 Varchar(50),
	@Attribute2 Varchar(50),
	@Attribute3 Varchar(50),
	@Attribute4 Varchar(50),
	@CustomerName as Varchar(50),	--will be captured when customer enters the name or login to existing account
	@DeliveryStatus as Varchar(50)  --by default it will be 'Pending', once the customer order and will change as per the order transit details
	
AS
BEGIN    
	DECLARE @ProductId BIGINT
			,@Price Numeric(10,2)
			,@Attribute Varchar(300)

	SET @CustomerName='TestUser'
	SET @DeliveryStatus ='Pending'
	SELECT @ProductId = ProductId FROM Product  (NOLOCK) WHERE ProductName=@ProductName
	SELECT @Price = Price  FROM Product  (NOLOCK) WHERE ProductName=@ProductName

	SELECT @Attribute = REPLACE(CONCAT(@Attribute1,',',@Attribute2,',',@Attribute3,',',@Attribute4),',NULL','')


	INSERT INTO [Ankur].[dbo].[Order] (CustomerId, ProductId, ProductAttributes, OrderedQuantity, ShippingAddress, EmailId, Mobile, DeliveryStatus, ExpectedDeliveryDateTime, Amount)
	SELECT CustomerId, @ProductId, @Attribute, @Qty, ShippingAddress, EmailId, Mobile, @DeliveryStatus, '', @Price
	FROM CUSTOMER  (NOLOCK) 
	WHERE CustomerName=@CustomerName
END

--EXEC sp_CreateOrder 'apple','1','Size','color','NULL','NULL','TestUser',null


