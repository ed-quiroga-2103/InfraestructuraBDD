GO
CREATE PROCEDURE InsertarXML @Data XML
AS
BEGIN 
SET NOCOUNT ON;

INSERT INTO [sk8-4-tec].Country(IdCountry,Name)
	SELECT
     country.value('(country_id)[1]', 'int') as IdCountry,
     country.value('(country_name)[1]', 'Varchar(50)') as Name
	FROM
     @Data.nodes('/World/country') as TEMPTABLE(country)
END
GO
