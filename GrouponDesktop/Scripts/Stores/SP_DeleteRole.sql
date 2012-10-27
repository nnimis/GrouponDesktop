USE [GD1C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[DeleteRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetRoleFunctionalities]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE GRUPO_N.DeleteRole
	@Rol_ID int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE GRUPO_N.Rol SET Activo = 0 WHERE ID = @Rol_ID
	UPDATE GRUPO_N.Usuario SET ID_Rol = [GRUPO_N].[GetIdRolDefault]() WHERE ID_Rol = @Rol_ID
END
GO
