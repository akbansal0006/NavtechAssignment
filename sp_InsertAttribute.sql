/*  STORED PROCEDURE sp_InsertAttribute

	Description: SP to store the master list of Attributes. This will be used by the Admin only.
	Tables Used: [Ankur].[dbo].[Attributes]
*/


CREATE PROCEDURE sp_InsertAttribute
	@AttributeName Varchar(50) 
	,@Datatype Varchar(50) 
AS

	BEGIN

	DECLARE @QUERY vARCHAR(200)
	
			--INSERT INTO [Ankur].[dbo].[Attributes] (AttributeName,Datatype) 
			SELECT @AttributeName, @Datatype

			SET @QUERY = 'ALTER TABLE [Order] ADD ' + @AttributeName + ' ' +@Datatype +''
			EXEC(@QUERY)
				

	END


/*
EXEC sp_InsertAttribute 'Size','Varchar(50)'
EXEC sp_InsertAttribute 'Color','Varchar(50)'
EXEC sp_InsertAttribute 'Dimension','Varchar(50)'
EXEC sp_InsertAttribute 'Feature','Varchar(50)'

*/