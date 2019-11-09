
GO
CREATE TYPE BrandTableType AS TABLE
(
	IdBrand INTEGER PRIMARY KEY,
	Name nvarchar(20) NOT NULL
)
GO

CREATE PROCEDURE InsertBrand @BrandType BrandTableType READONLY
AS
BEGIN
	INSERT INTO [sk8-4-tec].Brand
	SELECT * FROM @BrandType
END
	

GO
CREATE PROCEDURE InsertBrandType @Brand nvarchar(20)
AS

DECLARE @BrandTableType BrandTableType

BEGIN
	INSERT INTO @BrandTableType VALUES ((SELECT MAX(IdBrand) AS LastID FROM [sk8-4-tec].Brand) + 1, @Brand)

	EXECUTE [dbo].InsertBrand @BrandTableType
END
GO