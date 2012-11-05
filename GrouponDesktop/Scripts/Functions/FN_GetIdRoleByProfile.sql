USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetIdRoleByProfile]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [GRUPO_N].[GetIdRoleByProfile]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [GRUPO_N].[GetIdRoleByProfile]
(
	@ProfileName NVARCHAR(100)
)
RETURNS int
AS
BEGIN
	DECLARE @ID_Rol int

	SELECT @ID_Rol = ID_Rol FROM GRUPO_N.Perfil
	WHERE Descripcion = @ProfileName

	RETURN @ID_Rol
END

