USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetComprasProveedor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetComprasProveedor]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[GetComprasProveedor]
	@ID_Proveedor int,
	@FechaVencimiento datetime
AS
BEGIN
	SET NOCOUNT ON;

	SELECT cc.*, c.Descripcion, c.Precio, cl.Nombre AS Cliente
	FROM GRUPO_N.CompraCupon cc
		INNER JOIN GRUPO_N.Cupon c ON cc.ID_Cupon = c.ID
		INNER JOIN GRUPO_N.Usuario cl ON cc.ID_Cliente = cl.ID
		LEFT JOIN GRUPO_N.Devolucion d ON d.ID_CompraCupon = cc.ID
		LEFT JOIN GRUPO_N.CanjeCupon ca ON ca.ID_CompraCupon = cc.ID
	WHERE c.ID_Proveedor = @ID_Proveedor
		AND c.FechaVencimiento > @FechaVencimiento
		AND d.ID_CompraCupon IS NULL
		AND ca.ID_CompraCupon IS NULL
	ORDER BY cc.Fecha DESC
END

GO