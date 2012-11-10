USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertCupon]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertCupon]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertCupon]
	@Precio numeric(18,2),
	@PrecioOriginal numeric(18,2),
	@FechaPublicacion datetime,
	@FechaVigencia datetime,
	@FechaVencimiento datetime,
	@Stock numeric(18,0),
	@Descripcion nvarchar(255),
	@ID_Proveedor int,
	@CantidadPorUsuario int,
	@Publicado bit,
	@Codigo nvarchar(50)
AS
BEGIN
	INSERT INTO [GRUPO_N].[Cupon]
	   ([Precio]
	   ,[PrecioOriginal]
	   ,[FechaPublicacion]
	   ,[FechaVigencia]
	   ,[FechaVencimiento]
	   ,[Stock]
	   ,[Descripcion]
	   ,[ID_Proveedor]
	   ,[CantidadPorUsuario]
	   ,[Publicado]
	   ,[Codigo])
	 VALUES
	   (@Precio,
		@PrecioOriginal,
		@FechaPublicacion,
		@FechaVigencia,
		@FechaVencimiento,
		@Stock,
		@Descripcion,
		@ID_Proveedor,
		@CantidadPorUsuario,
		@Publicado,
		@Codigo)
	
	SELECT @@IDENTITY
END

GO