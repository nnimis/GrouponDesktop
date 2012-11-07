USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetCiudadesCliente]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetCiudadesCliente]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[GetCiudadesCliente]
@ID_Cliente int
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT *
	FROM GRUPO_N.ClienteCiudad
	WHERE ID_Cliente = @ID_Cliente
END


GO


