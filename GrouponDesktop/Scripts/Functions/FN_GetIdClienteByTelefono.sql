USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetIdClienteByTelefono]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [GRUPO_N].[GetIdClienteByTelefono]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [GRUPO_N].[GetIdClienteByTelefono]
(
	@Telefono NUMERIC(18,0)
)
RETURNS int
AS
BEGIN
	DECLARE @Cliente_ID int

	SELECT @Cliente_ID = c.ID FROM GRUPO_N.Cliente c, GRUPO_N.DetalleEntidad d
	WHERE c.ID_Detalle = d.ID AND d.Telefono = @Telefono

	RETURN @Cliente_ID
END
GO