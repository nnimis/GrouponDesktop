USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetCiudadesCupon]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetCiudadesCupon]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[GetCiudadesCupon]
@ID_Cupon int
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT c.ID, c.Descripcion
	FROM GRUPO_N.CuponCiudad cc
	INNER JOIN GRUPO_N.Ciudad c ON cc.ID_Ciudad = c.ID
	WHERE ID_Cupon = @ID_Cupon
END

GO