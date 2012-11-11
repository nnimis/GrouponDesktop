USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertFactura]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertFactura]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertFactura]
	@ID_Proveedor int,
	@Fecha datetime
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @NroFactura numeric(18,0)
	SELECT @NroFactura = MAX(Numero) + 1 FROM GRUPO_N.Factura

	IF @NroFactura IS NULL
		SET @NroFactura = 1

	INSERT INTO GRUPO_N.Factura(Numero, Fecha, ID_Proveedor)
	VALUES (@NroFactura, @Fecha, @ID_Proveedor)
	
	SELECT @@IDENTITY AS ID_Factura, @NroFactura AS NroFactura
END

GO