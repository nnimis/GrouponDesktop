USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetIdProveedorByName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [GRUPO_N].[GetIdProveedorByName]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [GRUPO_N].[GetIdProveedorByName]
(
	@ProveedorName NVARCHAR(100)
)
RETURNS int
AS
BEGIN
	DECLARE @Proveedor_ID int

	SELECT @Proveedor_ID = ID FROM GRUPO_N.Proveedor
	WHERE RazonSocial = @ProveedorName

	RETURN @Proveedor_ID
END
GO