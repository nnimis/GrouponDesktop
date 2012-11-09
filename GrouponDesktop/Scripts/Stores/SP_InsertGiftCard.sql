USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertGiftCard]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertGiftCard]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertGiftCard]
	@ID_ClienteOrigen int,
	@ID_ClienteDestino int,
	@Fecha datetime,
	@Credito numeric(18,2)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @CreditoActual numeric(18,2)
	SELECT @CreditoActual = Saldo FROM GRUPO_N.Cliente
	WHERE ID = @ID_ClienteOrigen
	
	IF @CreditoActual - @Credito < 0
		SELECT 0
	ELSE
	BEGIN
		INSERT INTO GRUPO_N.GiftCard (Credito, Fecha, ID_Cliente_Origen, ID_Cliente_Destino)
		VALUES (@Credito, @Fecha, @ID_ClienteOrigen, @ID_ClienteDestino)
		
		SELECT @@IDENTITY
	END
END

GO