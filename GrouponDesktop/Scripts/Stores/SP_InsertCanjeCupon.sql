USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertCanjeCupon]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertCanjeCupon]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertCanjeCupon]
	@ID_CompraCupon int,
	@Fecha datetime
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO GRUPO_N.CanjeCupon (ID_CompraCupon, Fecha) 
	VALUES (@ID_CompraCupon, @Fecha)
END

GO