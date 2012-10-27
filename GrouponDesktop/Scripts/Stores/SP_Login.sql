USE [GD1C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[Login]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[Login]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[Login]
	@Nombre nvarchar(255),
	@Password nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, ID_Rol, Nombre FROM GRUPO_N.Usuario WHERE
	Nombre = @Nombre AND Password = @Password
END

GO