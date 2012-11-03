USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertUser]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE GRUPO_N.InsertUser
	@UserName nvarchar(255),
	@Password nvarchar(255),
	@ID_Rol int
AS
BEGIN
	INSERT INTO GRUPO_N.Usuario (Nombre, Password, ID_Rol, Activo, Intentos) VALUES
	(@UserName, @Password, @ID_Rol, 1, 0)
	SELECT @@Identity AS ID
END
GO
