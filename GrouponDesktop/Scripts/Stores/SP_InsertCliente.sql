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
	@ID int,
	@DNI numeric(18,0),
	@Nombre nvarchar(255),
	@Apellido nvarchar(255),
	@FechaNacimiento datetime
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO GRUPO_N.Cliente(ID, DNI, Nombre, Apellido, FechaNacimiento) VALUES 
	(@ID, @DNI, @Nombre, @Apellido, @FechaNacimiento)
	
	SELECT @@Identity AS ID
END

GO


