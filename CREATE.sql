--CREATE DATABASE Ankur;
USE [Ankur]
GO

DROP TABLE [Ankur].[dbo].[ProductAttributeMapping]
DROP TABLE [Ankur].[dbo].[Attributes]
DROP TABLE [Ankur].[dbo].Customer
DROP TABLE [Ankur].[dbo].[Order]
DROP TABLE [Ankur].[dbo].[Product]



--====================================================================================================================================

--MASTER TABLE TO CONSOLIDATE ALL ATTRIBUTES
CREATE TABLE [Ankur].[dbo].[Attributes]
(
	AttributesId		BIGINT IDENTITY(1,1) NOT NULL,
	AttributeName		VARCHAR(50) NULL,
	DataType			VARCHAR(50) NULL,
	IsActive			Tinyint,
	CreatedDateTime		DateTime
)

GO
ALTER TABLE [Ankur].[dbo].[Attributes] ADD  CONSTRAINT [PK_Attributes_AttributesId] PRIMARY KEY CLUSTERED 
(
	[AttributesId] ASC
)
GO
ALTER TABLE [Ankur].[dbo].[Attributes] ADD  CONSTRAINT [Df_Attributes_IsActive] 
DEFAULT 1 FOR [IsActive]
GO
ALTER TABLE [Ankur].[dbo].[Attributes] ADD  CONSTRAINT [Df_Attributes_CreatedDateTime] 
DEFAULT GETDATE() FOR [CreatedDateTime]
GO


--====================================================================================================================================

CREATE TABLE [Ankur].[dbo].[Product]
(
		ProductId			BIGINT IDENTITY(1,1) NOT NULL,
		ProductName			VARCHAR(50) NOT NULL,
		Description			VARCHAR(200) NULL,
		Price				NUMERIC(10,2) NOT NULL,
		ProductQuantity		INT NOT NULL,
		IsActive			TinyInt NOT NULL,		--The Product will be marked active by default, when it is added by admin 
		CreatedDateTime			DATETIME	NOT NULL,	--default
		CreatedBy			VARCHAR(50) NOT NULL,
		ModifiedDate		DATETIME	NULL,
		ModifiedBy			VARCHAR(50)		NULL
)
ALTER TABLE [Ankur].[dbo].[Product] ADD  CONSTRAINT [PK_Product_ProductId] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)
GO
ALTER TABLE [Ankur].[dbo].[Product] ADD  CONSTRAINT [Df_Product_CreatedDateTime] 
DEFAULT GETDATE() FOR [CreatedDateTime]
GO
ALTER TABLE [Ankur].[dbo].[Product] ADD  CONSTRAINT [Df_Product_IsActive] 
DEFAULT 1 FOR [IsActive]
ALTER TABLE [Ankur].[dbo].[Product] ADD  CONSTRAINT [Df_Product_CreatedBy] 
DEFAULT SUSER_NAME() FOR [CreatedBy]

--====================================================================================================================================

CREATE TABLE [Ankur].[dbo].[ProductAttributeMapping]
(
	ProductAttributeMappingId		BIGINT IDENTITY(1,1) NOT NULL,
	ProductId						BIGINT NOT NULL,
	AttributesId					BIGINT  NULL,
	AttributeDetail					Varchar(50),
	IsActive						TINYINT,
	CreatedDateTime					DATETIME
)
GO
ALTER TABLE [Ankur].[dbo].[ProductAttributeMapping] ADD  CONSTRAINT [PK_ProductAttributeMapping_ProductAttributeMappingId] PRIMARY KEY CLUSTERED 
(
	[ProductAttributeMappingId] ASC
)
GO
ALTER TABLE [Ankur].[dbo].[ProductAttributeMapping] ADD  CONSTRAINT [Df_ProductAttributeMapping_IsActive] 
DEFAULT 1 FOR [IsActive]
Go
ALTER TABLE [Ankur].[dbo].[ProductAttributeMapping] ADD  CONSTRAINT [Df_ProductAttributeMapping_CreatedDateTime] 
DEFAULT GETDATE() FOR [CreatedDateTime]
GO
ALTER TABLE [Ankur].[dbo].[ProductAttributeMapping]
ADD FOREIGN KEY (AttributesId) REFERENCES [Attributes](AttributesId);
GO
ALTER TABLE [Ankur].[dbo].[ProductAttributeMapping]
ADD FOREIGN KEY (ProductId) REFERENCES Product(ProductId);

--====================================================================================================================================


CREATE TABLE [Ankur].[dbo].[Customer]
(
	CustomerId					BigInt Identity(1,1) NOT NULL,
	CustomerName				VARCHAR(50) NOT NULL,
	ShippingAddress				VARCHAR(MAX) NOT NULL,	--will hold all address details
	EmailId						VARCHAR(20)	NULL,
	Mobile						VARCHAR(20)	NOT NULL,
	IsActive					TINYINT ,
	CustomerCreatedDateTime		DATETIME
);

ALTER TABLE [Ankur].[dbo].[Customer] ADD  CONSTRAINT [PK_Customer_CustomerId] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)
GO
ALTER TABLE [Ankur].[dbo].[Customer] ADD  CONSTRAINT [Df_Customer_CustomerCreatedDateTime] 
DEFAULT GETDATE() FOR [CustomerCreatedDateTime]
GO

--
INSERT into customer values('TestUser','New Delhi','abc@gmail.com','9812341234',1,getdate())


CREATE TABLE [Ankur].[dbo].[Order]
(
	OrderId						BigInt Identity(1,1) NOT NULL,
	CustomerId					BigInt NOT NULL,
	ProductId					BIGINT NOT NULL,
	ProductAttributes			varchar(500) NULL,
	OrderedQuantity				INT NOT NULL,
	DeliveryStatus				VARCHAR(20) NOT NULL,
	OrderCreatedDateTime		DATETIME NOT NULL,	--default
	ExpectedDeliveryDateTime	DATETIME  NULL,
	Amount					NUMERIC(10,2) NOT NULL,
	ShippingAddress				VARCHAR(MAX) NOT NULL,	--will hold all address details
	EmailId						VARCHAR(20)	NULL,
	Mobile						VARCHAR(20)	NOT NULL,
);

ALTER TABLE [Ankur].[dbo].[Order] ADD  CONSTRAINT [PK_Order_OrderId] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)
GO
ALTER TABLE [Ankur].[dbo].[Order] ADD  CONSTRAINT [Df_Order_OrderCreatedDateTime] 
DEFAULT GETDATE() FOR [OrderCreatedDateTime]
GO
ALTER TABLE [Ankur].[dbo].[Order]
ADD FOREIGN KEY (ProductId) REFERENCES Product(ProductId);
GO
ALTER TABLE [Ankur].[dbo].[Order]
ADD FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId);

--====================================================================================================================================


/*
The product will be treated as different on the basis of its attributes.
Since Admin has the permission to manage product attributes, the user can only see those attributes that are available for that particualr product.
Master Table to consolidate all attributed for the table
*/

--====================================================================================================================================

INSERT INTO [Ankur].[dbo].[Order] (CustomerName, ProductId, OrderedQuantity, ShippingAddress, EmailId, Mobile, DeliveryStatus, ExpectedDeliveryTime, TotalAmount)

ProductName, Price, OrderedQuantity, Size, Color, OtherAttributes, OrderedCreatedDatetime


SELECT PD.ProductName
	,pd.Price
	,od.OrderedQuantity
FROM [Ankur].[dbo].[Order] OD  WITH (NOLOCK)
INNER JOIN [Ankur].[dbo].[Product] PD WITH (NOLOCK)
	ON OD.ProductId = PD.ProductId
WHERE PD.IsActive = 1 