USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertPago]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertPago]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertPago]
	@ID_Cliente int,
	@Credito numeric(18,2),
	@Fecha datetime,
	@ID_TipoPago int,
	@Tarjeta nvarchar(255),
	@Banco nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ID_Pago int
	DECLARE @ID_Tarjeta int

	INSERT INTO GRUPO_N.Pago (Credito, Fecha, ID_Cliente, ID_TipoPago)
	VALUES (@Credito, @Fecha, @ID_Cliente, @ID_TipoPago)
	
    SET @ID_Pago = @@IDENTITY
    
    IF @ID_TipoPago = 2
    BEGIN
		INSERT INTO GRUPO_N.Tarjeta (Banco, Numero, ID_Cliente)
		VALUES (@Banco, @Tarjeta, @ID_Cliente)
		
		SET @ID_Tarjeta = @@IDENTITY
		INSERT INTO GRUPO_N.PagosTarjetas (ID_Pago, ID_Tarjeta)
		VALUES (@ID_Pago, @ID_Tarjeta)
    END
END

GO