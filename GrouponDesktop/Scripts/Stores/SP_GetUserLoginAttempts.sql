USE [GD2C2012]
GO

/****** Object:  StoredProcedure [GRUPO_N].[GetUserLoginAttempts]    Script Date: 11/05/2012 13:06:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetUserLoginAttempts]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetUserLoginAttempts]
GO

USE [GD2C2012]
GO

/****** Object:  StoredProcedure [GRUPO_N].[GetUserLoginAttempts]    Script Date: 11/05/2012 13:06:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [GRUPO_N].[GetUserLoginAttempts]
	@Nombre nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Intentos FROM GRUPO_N.Usuario WHERE Nombre = @Nombre
	IF(@@ROWCOUNT = 0)
		SELECT 0 AS Intentos
END


GO


