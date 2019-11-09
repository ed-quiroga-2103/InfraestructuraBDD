GO
CREATE Procedure Dec_Cursor_Brand AS
BEGIN
DECLARE Brand_Cursor CURSOR
LOCAL
FOR
SELECT 
	IdBrand,
	Name
FROM [sk8-4-tec].Brand
OPEN Brand_Cursor

FETCH NEXT FROM Brand_Cursor
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	FETCH NEXT FROM Brand_Cursor
	END


END