USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetIdCuponByAllKeys]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [GRUPO_N].[GetIdCuponByAllKeys]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [GRUPO_N].[GetIdCuponByAllKeys]
(
	@Provee_RS nvarchar(100),
	@Groupon_Precio numeric(18,2),
	@Groupon_Precio_Ficticio numeric(18,2),		
	@Groupon_Fecha datetime ,
	@Groupon_Fecha_Venc datetime ,
	@Groupon_Cantidad numeric(18,0),
	@Groupon_Descripcion nvarchar(255)
)
RETURNS int
AS
BEGIN
	DECLARE @Cupon_ID int

	SELECT @Cupon_ID = c.ID FROM GRUPO_N.Proveedor p, GRUPO_N.Cupon c
	WHERE p.ID = c.ID_Proveedor AND p.RazonSocial = @Provee_RS AND c.Precio = @Groupon_Precio_Ficticio
	AND c.PrecioOriginal = @Groupon_Precio AND c.FechaPublicacion = @Groupon_Fecha
	AND c.FechaVigencia = @Groupon_Fecha_Venc AND c.Stock = @Groupon_Cantidad
	AND c.Descripcion = @Groupon_Descripcion;

	RETURN @Cupon_ID
END
GO