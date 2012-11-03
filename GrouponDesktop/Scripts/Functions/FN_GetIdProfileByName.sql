USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetIdProfileByName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [GRUPO_N].[GetIdProfileByName]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [GRUPO_N].[GetIdProfileByName]
(
	@ProfileName NVARCHAR(100)
)
RETURNS int
AS
BEGIN
	DECLARE @Profile_ID int

	SELECT @Profile_ID = ID FROM GRUPO_N.Perfil
	WHERE Descripcion = @ProfileName

	RETURN @Profile_ID
END
GO