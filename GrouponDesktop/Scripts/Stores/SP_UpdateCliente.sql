USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[UpdateCliente]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[UpdateCliente]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [GRUPO_N].[UpdateCliente]
	@ID int,
	@DNI numeric(18,0),
	@Nombre nvarchar(255),
	@Apellido nvarchar(255),
	@FechaNacimiento datetime
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE GRUPO_N.Cliente SET
	DNI = @DNI, Nombre = @Nombre, Apellido = @Apellido, FechaNacimiento = @FechaNacimiento
	WHERE ID = @ID
	
END


GO


