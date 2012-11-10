USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetCuponesParaPublicar]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetCuponesParaPublicar]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[GetCuponesParaPublicar]
@Fecha_Publicacion datetime
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT c.*, p.RazonSocial FROM GRUPO_N.Cupon c
	INNER JOIN GRUPO_N.Proveedor p ON c.ID_Proveedor = p.ID
	WHERE c.FechaPublicacion >= @Fecha_Publicacion
	AND c.FechaPublicacion < DATEADD(d,1,@Fecha_Publicacion)
END

GO