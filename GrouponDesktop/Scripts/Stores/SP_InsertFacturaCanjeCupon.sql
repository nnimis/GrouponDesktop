USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertFacturaCanjeCupon]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertFacturaCanjeCupon]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertFacturaCanjeCupon]
	@ID_Factura int,
	@ID_CanjeCupon int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO GRUPO_N.FacturasCanjesCupones(ID_CanjeCupon, ID_Factura)
	VALUES (@ID_CanjeCupon, @ID_Factura)
END

GO