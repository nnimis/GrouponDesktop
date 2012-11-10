USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetCuponesCliente]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetCuponesCliente]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[GetCuponesCliente]
@Fecha_Publicacion datetime,
@ID_Cliente int
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT c.* FROM GRUPO_N.Cupon c
	INNER JOIN GRUPO_N.CuponCiudad cc ON cc.ID_Cupon = c.ID
	INNER JOIN GRUPO_N.ClienteCiudad cu ON cu.ID_Ciudad = cc.ID_Ciudad
	WHERE c.Publicado = 1
	AND cu.ID_Cliente = @ID_Cliente
	AND c.FechaPublicacion <= @Fecha_Publicacion
	AND c.FechaVigencia >= @Fecha_Publicacion
END

GO