USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[DeleteRoleFunctionalities]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[DeleteRoleFunctionalities]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[DeleteRoleFunctionalities]
	@Rol_ID int
AS
BEGIN
	DELETE FROM GRUPO_N.RolesFuncionalidades
	WHERE ID_Rol = @Rol_ID
END

GO


