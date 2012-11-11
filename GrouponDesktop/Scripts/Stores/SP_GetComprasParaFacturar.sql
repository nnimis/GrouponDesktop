USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetComprasParaFacturar]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetComprasParaFacturar]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[GetComprasParaFacturar]
	@ID_Proveedor int,
	@FechaDesde datetime,
	@FechaHasta datetime
AS
BEGIN
	SET NOCOUNT ON;

	SELECT cc.*, c.Descripcion, c.Precio, cl.Nombre AS Cliente, ca.ID AS ID_Canje
	FROM GRUPO_N.CompraCupon cc
		INNER JOIN GRUPO_N.Cupon c ON cc.ID_Cupon = c.ID
		INNER JOIN GRUPO_N.Usuario cl ON cc.ID_Cliente = cl.ID
		INNER JOIN GRUPO_N.CanjeCupon ca ON ca.ID_CompraCupon = cc.ID
		LEFT JOIN GRUPO_N.FacturasCanjesCupones fc ON ca.ID = fc.ID_CanjeCupon
	WHERE c.ID_Proveedor = @ID_Proveedor
		AND ca.Fecha >= @FechaDesde
		AND ca.Fecha <= @FechaHasta
		AND fc.ID_CanjeCupon IS NULL
	ORDER BY ca.Fecha DESC
END

GO