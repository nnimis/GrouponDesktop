USE [GD1C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetIdRolByName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [GRUPO_N].[GetIdRolByName]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [GRUPO_N].[GetIdRolByName]
(
	@RoleName NVARCHAR(100)
)
RETURNS int
AS
BEGIN
	DECLARE @Rol_ID int

	SELECT @Rol_ID = ID FROM GRUPO_N.Rol
	WHERE Descripcion = @RoleName

	RETURN @Rol_ID
END
GO