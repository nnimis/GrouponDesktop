USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertCiudadCliente]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertCiudadCliente]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertCiudadCliente]
@ID_Cliente int,
@ID_Ciudad int
AS
BEGIN
	INSERT INTO GRUPO_N.ClienteCiudad
	(ID_Cliente, ID_Ciudad) VALUES (@ID_Cliente, @ID_Ciudad)
END



GO


