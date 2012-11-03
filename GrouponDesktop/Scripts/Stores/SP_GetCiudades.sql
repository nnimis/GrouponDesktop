USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetCiudades]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetCiudades]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[GetCiudades]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT ID, Descripcion FROM GRUPO_N.Ciudad
END

GO


