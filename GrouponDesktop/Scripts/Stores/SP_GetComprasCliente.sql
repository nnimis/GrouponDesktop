USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetComprasCliente]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetComprasCliente]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[GetComprasCliente]
	@ID_Cliente int,
	@FechaDesde datetime,
	@FechaHasta datetime
AS
BEGIN
	SET NOCOUNT ON;

	SELECT cc.*, c.Descripcion, c.Precio, c.FechaVencimiento AS FechaVencimiento, 
		d.ID AS ID_Devolucion, ca.ID AS ID_Canje
	FROM GRUPO_N.CompraCupon cc
	INNER JOIN GRUPO_N.Cupon c ON cc.ID_Cupon = c.ID
	LEFT JOIN GRUPO_N.Devolucion d ON d.ID_CompraCupon = cc.ID
	LEFT JOIN GRUPO_N.CanjeCupon ca ON ca.ID_CompraCupon = cc.ID
	WHERE cc.ID_Cliente = @ID_Cliente
	AND cc.Fecha <= @FechaHasta
	AND cc.Fecha >= @FechaDesde
	ORDER BY cc.Fecha DESC
END

GO