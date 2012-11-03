USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertCliente]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertCliente]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertCliente]
	@DNI numeric(18,0),
	@Nombre nvarchar(255),
	@Apellido nvarchar(255),
	@FechaNacimiento datetime,
	@ID_Detalle int
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO GRUPO_N.Cliente(DNI, Nombre, Apellido, FechaNacimiento, ID_Detalle) VALUES 
	(@DNI, @Nombre, @Apellido, @FechaNacimiento, @ID_Detalle)
	
	SELECT @@Identity AS ID
END

GO


