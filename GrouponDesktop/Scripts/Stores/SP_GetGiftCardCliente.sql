USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetGiftCardCliente]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetGiftCardCliente]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[GetGiftCardCliente]
	@ID_Cliente int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT g.*, uo.Nombre AS ClienteOrigen, ud.Nombre AS ClienteDestino
    FROM GRUPO_N.GiftCard g
    INNER JOIN GRUPO_N.Usuario uo ON g.ID_Cliente_Origen = uo.ID
    INNER JOIN GRUPO_N.Usuario ud ON g.ID_Cliente_Destino = ud.ID
    WHERE uo.ID = @ID_Cliente
END

GO