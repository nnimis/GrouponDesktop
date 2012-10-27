USE [GD1C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertRoleFunctionality]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertRoleFunctionality]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertRoleFunctionality]
	@Rol_ID int,
	@Funcionalidad nvarchar(255)
AS
BEGIN
	INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
	VALUES (@Rol_ID, [GRUPO_N].[GetFunctionalityByName](@Funcionalidad))
END

GO