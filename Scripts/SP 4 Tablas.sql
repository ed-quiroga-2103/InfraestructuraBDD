
GO
CREATE PROCEDURE [sk8-4-tec].InsertEmployee  @FirstName nvarchar(30), @MiddleName nvarchar(30), @LastName nvarchar(30), @IdentityDoc nvarchar(30), @IdAddress integer, @Status integer, @IdJob integer
AS
BEGIN

SET XACT_ABORT ON


    BEGIN TRY

    BEGIN TRANSACTION

      DECLARE @IdPerson integer
	  SELECT @IdPerson = (SELECT MAX(IdPerson) AS LastID FROM Person) + 1

	  DECLARE @HireDate date
	  SELECT @HireDate = (SELECT CONVERT(DATE, GETDATE()))

        INSERT INTO Person
            (
            IdPerson,
			FirstName,
			MiddleName,
			LastName,
			IdentityDoc,
			IdAddress
            )

        VALUES (
             @IdPerson,
			 @FirstName,
			 @MiddleName,
			 @LastName,
			 @IdentityDoc,
			 @IdAddress
            )

		INSERT INTO [sk8-4-tec].Employee
			(
			IdPerson,
			Status
			)
		VALUES (
			@IdPerson,
			@Status
			)

		INSERT INTO [sk8-4-tec].EmployeeJob
			(
			IdStore,
			IdJob,
			IdPerson,
			HireDate
			)
		VALUES (
			1,
			@IdJob,
			@IdPerson,
			@HireDate
			)

		INSERT INTO [sk8-4-tec].Customer
			(
			IdPerson,
			Status,
			Points
			)
		VALUES (
			@IdPerson,
			@Status,
			0
			)

        COMMIT TRANSACTION
    END TRY
   begin catch
  SELECT   
        ERROR_NUMBER() AS ErrorNumber,  
        ERROR_SEVERITY() AS ErrorSeverity, 
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,  
        ERROR_MESSAGE() AS ErrorMessage 

		ROLLBACK TRANSACTION;

end catch
END;
GO
