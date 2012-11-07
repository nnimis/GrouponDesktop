USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[UpdateDetalleEntidad]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[UpdateDetalleEntidad]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[UpdateDetalleEntidad]
	@Telefono numeric(18,0),
	@Email nvarchar(255),
	@ID_Usuario int,
	@Direccion nvarchar(255),
	@ID_Ciudad int,
	@CP nvarchar(50)
AS
BEGIN
	DECLARE @DetalleEntidad int
	
	UPDATE GRUPO_N.DetalleEntidad SET 
	Telefono = @Telefono, Email = @Email
	WHERE ID_Usuario = @ID_Usuario
	
	SET @DetalleEntidad = (SELECT ID FROM GRUPO_N.DetalleEntidad WHERE ID_Usuario = @ID_Usuario)
	
	UPDATE GRUPO_N.Direccion SET 
	Descripcion = @Direccion, 
	ID_Ciudad = @ID_Ciudad,
	CP = @CP
	WHERE ID_Detalle = @DetalleEntidad
END


GO


