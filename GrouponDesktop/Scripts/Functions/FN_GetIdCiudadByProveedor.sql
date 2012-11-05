USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetIdCiudadByProveedor]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [GRUPO_N].[GetIdCiudadByProveedor]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [GRUPO_N].[GetIdCiudadByProveedor]
(
	@ProveedorName NVARCHAR(100)
)
RETURNS int
AS
BEGIN
	DECLARE @Ciudad_ID int

	SELECT @Ciudad_ID = ID_Ciudad FROM GRUPO_N.Proveedor
	WHERE RazonSocial = @ProveedorName

	RETURN @Ciudad_ID 
END
GO