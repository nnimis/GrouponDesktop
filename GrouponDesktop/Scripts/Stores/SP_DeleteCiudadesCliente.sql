USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[DeleteCiudadesCliente]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[DeleteCiudadesCliente]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[DeleteCiudadesCliente]
@ID_Cliente int
AS
BEGIN
	DELETE FROM GRUPO_N.ClienteCiudad
	WHERE ID_Cliente = @ID_Cliente
END



GO


