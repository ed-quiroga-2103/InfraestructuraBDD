
GO
CREATE PROCEDURE [dbo].[Auxiliar_Multifunction]  @NameCountry nvarchar(30), @IdJob integer

AS

BEGIN

SET XACT_ABORT ON

    BEGIN TRY

    BEGIN TRANSACTION

      DECLARE @IdCountry integer
	  SELECT @IdCountry = (SELECT MAX(IdCountry) AS LastID FROM [sk8-4-tec].Country) + 1

		INSERT INTO [sk8-4-tec].Country
			(
			IdCountry,
			Name
			)
		VALUES (
			@IdCountry,
			@NameCountry
			)

		UPDATE [sk8-4-tec].Job
		SET Salary = (SELECT Salary FROM [sk8-4-tec].Job WHERE IdJob = @IdJob) + 1000000
		Where IdJob = @IdJob 

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
CREATE PROCEDURE [dbo].[Multifunction]  @Job nvarchar(30), @Brand nvarchar(30), @Salary integer, @Country nvarchar(30), @Id integer

AS

BEGIN

SET XACT_ABORT ON

    BEGIN TRY

    BEGIN TRANSACTION

      DECLARE @IdJob integer
	  SELECT @IdJob = (SELECT MAX(IdJob) AS LastID FROM [sk8-4-tec].Job) + 1

	  DECLARE @IdBrand integer
	  SELECT @IdBrand = (SELECT MAX(IdBrand) AS LastID FROM [sk8-4-tec].Brand) + 1

		INSERT INTO [sk8-4-tec].Job
			(
			IdJob,
			Job,
			Salary
			)
		VALUES (
			@IdJob,
			@Job,
			@Salary
			)

		INSERT INTO [sk8-4-tec].Brand
			(
			IdBrand,
			Name
			)
		VALUES (
			@IdBrand,
			@Brand
			) 

		EXEC [dbo].Auxiliar_Multifunction @Country , @Id

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
CREATE PROCEDURE [dbo].Point3  @FirstName nvarchar(30), @MiddleName nvarchar(30), @LastName nvarchar(30), @IdentityDoc nvarchar(30), @IdAddress integer, @Status integer, @Points integer, @Job nvarchar(30), @Brand nvarchar(30), @Salary integer, @Country nvarchar(30), @Id integer
AS

BEGIN

 BEGIN TRANSACTION

    BEGIN TRY

      DECLARE @IdPerson integer
	  SELECT @IdPerson = (SELECT MAX(IdPerson) AS LastID FROM [sk8-4-tec].Person) + 1

		INSERT INTO [sk8-4-tec].Person
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

		INSERT INTO [sk8-4-tec].Customer
            (
            IdPerson,
			Status,
			Points
            )

        VALUES (
             @IdPerson,
			 @Status,
			 @Points
            )

		EXEC [dbo].Multifunction @Job, @Brand, @Salary, @Country, @Id

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
