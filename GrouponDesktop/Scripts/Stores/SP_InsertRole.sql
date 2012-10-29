USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertRole]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertRole]
	@Description nvarchar(100)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO GRUPO_N.Rol (Descripcion) VALUES (@Description)
	SELECT @@Identity AS ID
END

GO


