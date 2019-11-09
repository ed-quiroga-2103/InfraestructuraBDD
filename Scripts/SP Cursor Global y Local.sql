
GO
CREATE Procedure Dec_Cursor_Customer AS
BEGIN
DECLARE Customer_Cursor CURSOR
GLOBAL
FOR
SELECT 
	IdPerson,
	Status,
	Points
FROM [sk8-4-tec].Customer
OPEN Customer_Cursor
END


GO
CREATE PROCEDURE Fetch_Cursor_Customer
AS
BEGIN
FETCH NEXT FROM Customer_Cursor
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	FETCH NEXT FROM Customer_Cursor
	END
END