USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertDetalleEntidad]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertDetalleEntidad]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertDetalleEntidad]
	@Telefono numeric(18,0),
	@Email nvarchar(255),
	@ID_Usuario int,
	@Direccion nvarchar(255),
	@ID_Ciudad int,
	@CP nvarchar(50)
AS
BEGIN
	DECLARE @DetalleEntidad int
	SET NOCOUNT ON;
	INSERT INTO GRUPO_N.DetalleEntidad (Telefono, Email, ID_Usuario) VALUES (@Telefono, @Email, @ID_Usuario)
	
	SET @DetalleEntidad = @@Identity
	INSERT INTO GRUPO_N.Direccion (Descripcion, ID_Ciudad, ID_Detalle, CP) VALUES (@Direccion, @ID_Ciudad, @DetalleEntidad, @CP)
	
	SELECT @DetalleEntidad AS ID
END


GO


