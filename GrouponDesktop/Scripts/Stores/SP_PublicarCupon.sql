USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[PublicarCupon]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[PublicarCupon]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[PublicarCupon]
@ID datetime
AS
BEGIN
	SET NOCOUNT ON;
    
	UPDATE GRUPO_N.Cupon
	SET Publicado = 1
	WHERE ID = @ID
END

GO