USE [GD1C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetRoleFunctionalities]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetRoleFunctionalities]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[GetRoleFunctionalities]
	@Rol_ID int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT F.Descripcion AS Descripcion FROM GRUPO_N.Funcionalidad F
	INNER JOIN GRUPO_N.RolesFuncionalidades RF ON F.ID = RF.ID_Funcionalidad
	WHERE RF.ID_Rol = @Rol_ID
END
GO
