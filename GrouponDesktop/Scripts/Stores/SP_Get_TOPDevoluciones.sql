USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[Get_TOPDevoluciones]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[Get_TOPDevoluciones]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[Get_TOPDevoluciones]
@fecha_inicio AS NVARCHAR(50),
@fecha_fin AS NVARCHAR(50)
AS
BEGIN
SELECT TOP 5 cmp.RazonSocial, cmp.compras, dev.devoluciones, 100*CONVERT(FLOAT,dev.devoluciones)/CONVERT(FLOAT,cmp.compras) AS porcentaje
FROM 
(
	SELECT p1.RazonSocial, COUNT(*) AS compras
	FROM GRUPO_N.Proveedor p1
	INNER JOIN GRUPO_N.Cupon cu1 ON cu1.ID_Proveedor=p1.ID
	INNER JOIN GRUPO_N.CompraCupon cc1 ON cc1.ID_Cupon=cu1.ID
	WHERE (cc1.Fecha BETWEEN @fecha_inicio AND @fecha_fin)
	GROUP BY p1.RazonSocial
) cmp
INNER JOIN
(
	SELECT p2.RazonSocial, COUNT(*) AS devoluciones
	FROM GRUPO_N.Proveedor p2
	INNER JOIN GRUPO_N.Cupon cu2 ON cu2.ID_Proveedor=p2.ID
	INNER JOIN GRUPO_N.CompraCupon cc2 ON cc2.ID_Cupon=cu2.ID
	INNER JOIN GRUPO_N.Devolucion dv2 ON dv2.ID_CompraCupon=cc2.ID
	WHERE (cc2.Fecha BETWEEN @fecha_inicio AND @fecha_fin) AND (dv2.Fecha BETWEEN @fecha_inicio AND @fecha_fin)
	GROUP BY p2.RazonSocial
)dev ON dev.RazonSocial=cmp.RazonSocial
ORDER BY 4 DESC
END
GO
