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
    
	SELECT c.ID, c.Nombre, c.Apellido, c.DNI, c.FechaNacimiento,
		d.Email, d.Telefono, di.Descripcion AS Direccion, di.ID_Ciudad,
		di.CP, u.Nombre AS UserName, u.ID_Rol
	FROM GRUPO_N.Cliente c
	INNER JOIN GRUPO_N.DetalleEntidad d ON d.ID_Usuario = c.ID
	INNER JOIN GRUPO_N.Direccion di ON d.ID = di.ID_Detalle
	INNER JOIN GRUPO_N.Usuario u ON c.ID = u.ID
	WHERE u.Activo = 1
END


GO


