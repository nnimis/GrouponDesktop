USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[Get_TOPGiftCard]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[Get_TOPGiftCard]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[Get_TOPGiftCard]
	@fecha_inicio AS NVARCHAR(50),
	@fecha_fin AS NVARCHAR(50)
AS
BEGIN

	SELECT TOP 5 c.Nombre, c.Apellido, crg.credito AS [Crédito], gst.Consumo AS Consumo
	FROM
	(
		SELECT SUM(gf.Credito) AS credito, gf.ID_Cliente_Destino
		FROM GRUPO_N.GiftCard gf
		WHERE gf.Fecha BETWEEN @fecha_inicio AND @fecha_fin
		GROUP BY gf.ID_Cliente_Destino
	) crg 
	INNER JOIN
	(
		SELECT SUM(c.Precio) AS Consumo, ccp.ID_Cliente
		FROM GRUPO_N.CanjeCupon cac
			INNER JOIN GRUPO_N.CompraCupon ccp ON ccp.ID = cac.ID_CompraCupon
			INNER JOIN GRUPO_N.Cupon c ON c.ID = ccp.ID_Cupon
		WHERE ccp.Fecha BETWEEN @fecha_inicio AND @fecha_fin
		GROUP BY ccp.ID_Cliente
	) gst ON gst.ID_Cliente = crg.ID_Cliente_Destino
	INNER JOIN GRUPO_N.Cliente c ON c.ID = crg.ID_Cliente_Destino
	WHERE crg.credito <= gst.consumo
	ORDER BY crg.credito DESC
END
GO