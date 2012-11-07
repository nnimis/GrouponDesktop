USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[UpdateProveedor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[UpdateProveedor]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[UpdateProveedor]
	@CUIT nvarchar(20),
	@RazonSocial nvarchar(255),
	@ID_Rubro int,
	@ID int,
	@Contacto nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE GRUPO_N.Proveedor SET
	RazonSocial = @RazonSocial, ID_Rubro = @ID_Rubro, CUIT = @CUIT, Contacto = @Contacto
	WHERE ID = @ID
END

GO


