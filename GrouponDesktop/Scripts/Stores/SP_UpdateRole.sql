USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[UpdateRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[UpdateRole]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[UpdateRole]
	@Description nvarchar(100),
	@ID int
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE GRUPO_N.Rol SET Descripcion = @Description
	WHERE ID = @ID
END

GO


