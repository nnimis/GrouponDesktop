USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetCuponesProveedor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetCuponesProveedor]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[GetCuponesProveedor]
@ID_Proveedor int
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT * FROM GRUPO_N.Cupon c
	WHERE c.ID_Proveedor = @ID_Proveedor
END

GO