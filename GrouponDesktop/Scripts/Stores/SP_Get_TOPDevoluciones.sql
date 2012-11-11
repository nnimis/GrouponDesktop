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
SELECT TOP 5 *,100*CONVERT(FLOAT,ca.devoluciones)/CONVERT(FLOAT,ca.compras) AS porcentaje FROM
(
SELECT	m.Provee_RS, 
		COUNT(*) AS devoluciones,
		(SELECT COUNT(*)FROM gd_esquema.Maestra c
			WHERE
			c.Groupon_Fecha_Compra IS NOT NULL AND c.Groupon_Fecha_Compra BETWEEN @fecha_inicio AND @fecha_fin
			AND c.Provee_RS=m.Provee_RS 
		) AS compras
FROM gd_esquema.Maestra m
WHERE
m.Groupon_Devolucion_Fecha IS NOT NULL AND m.Groupon_Devolucion_Fecha BETWEEN @fecha_inicio AND @fecha_fin
GROUP BY m.Provee_RS
) ca
ORDER BY porcentaje DESC
END
GO
