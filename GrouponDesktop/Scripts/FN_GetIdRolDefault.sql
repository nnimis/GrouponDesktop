USE [GD1C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetIdRolDefault]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [GRUPO_N].[GetIdRolDefault]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [GRUPO_N].[GetIdRolDefault] ()
RETURNS int
AS
BEGIN
	DECLARE @Rol_ID int

	SELECT @Rol_ID = ID FROM GRUPO_N.Rol
	WHERE Descripcion = 'Rol por Defecto'

	RETURN @Rol_ID
END

GO


