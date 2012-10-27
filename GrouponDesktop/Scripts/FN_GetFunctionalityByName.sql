USE [GD1C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetFunctionalityByName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [GRUPO_N].[GetFunctionalityByName]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [GRUPO_N].[GetFunctionalityByName] 
(
	@Func_Name nvarchar(255)
)
RETURNS int
AS
BEGIN
	DECLARE @Func_ID int

	SELECT @Func_ID = ID FROM GRUPO_N.Funcionalidad
	WHERE Descripcion = @Func_Name

	RETURN @Func_ID
END


GO