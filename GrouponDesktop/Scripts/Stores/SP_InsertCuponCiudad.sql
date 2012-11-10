USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertCuponCiudad]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertCuponCiudad]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertCuponCiudad]
	@ID_Cupon int,
	@ID_Ciudad int
AS
BEGIN
	INSERT INTO [GRUPO_N].[CuponCiudad]
	   (ID_Ciudad, ID_Cupon)
	 VALUES
	   (@ID_Ciudad, @ID_Cupon)
END

GO