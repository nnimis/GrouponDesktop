USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertDevolucionCompra]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertDevolucionCompra]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertDevolucionCompra]
	@ID_Cliente int,
	@ID_CompraCupon int,
	@Fecha datetime,
	@Motivo varchar(max)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO GRUPO_N.Devolucion (ID_Cliente, Fecha, Motivo, ID_CompraCupon)
	VALUES (@ID_Cliente, @Fecha, @Motivo, @ID_CompraCupon)
END

GO