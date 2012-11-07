USE [GD2C2012]
GO

/****** Object:  StoredProcedure [GRUPO_N].[GetProveedores]    Script Date: 11/07/2012 17:40:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetProveedores]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetProveedores]
GO

USE [GD2C2012]
GO

/****** Object:  StoredProcedure [GRUPO_N].[GetProveedores]    Script Date: 11/07/2012 17:40:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [GRUPO_N].[GetProveedores]
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT p.ID, p.RazonSocial, p.CUIT, p.ID_Rubro, p.Contacto,
		d.Email, d.Telefono, di.Descripcion AS Direccion, di.ID_Ciudad,
		di.CP, u.Nombre AS UserName, u.ID_Rol
	FROM GRUPO_N.Proveedor p
	INNER JOIN GRUPO_N.DetalleEntidad d ON d.ID_Usuario = p.ID
	INNER JOIN GRUPO_N.Direccion di ON d.ID = di.ID_Detalle
	INNER JOIN GRUPO_N.Usuario u ON p.ID = u.ID
	WHERE u.Activo = 1
END




GO


