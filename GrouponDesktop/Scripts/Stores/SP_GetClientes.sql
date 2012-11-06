USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetClientes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetClientes]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [GRUPO_N].[GetClientes]
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT c.ID, c.Nombre, c.Apellido, c.DNI, d.Email FROM GRUPO_N.Cliente c
	INNER JOIN GRUPO_N.DetalleEntidad d ON c.ID_Detalle = d.ID
END

GO


