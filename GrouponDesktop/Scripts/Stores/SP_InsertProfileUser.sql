USE [GD2C2012]
GO

/****** Object:  StoredProcedure [GRUPO_N].[InsertUser]    Script Date: 11/03/2012 16:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertProfileUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertProfileUser]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertProfileUser]
	@UserName nvarchar(255),
	@Password nvarchar(255),
	@ProfileName nvarchar(100)
AS
BEGIN
	INSERT INTO GRUPO_N.Usuario (Nombre, Password, ID_Rol, Activo, Intentos) VALUES
	(@UserName, @Password, GRUPO_N.GetIdRoleByProfile(@ProfileName), 1, 0)
	SELECT @@Identity AS ID
END

GO


