USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertProveedor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertProveedor]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[InsertProveedor]
	@CUIT nvarchar(20),
	@RazonSocial nvarchar(255),
	@ID_Rubro int,
	@ID int
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO GRUPO_N.Proveedor(RazonSocial, ID_Rubro, CUIT, ID) VALUES 
	(@RazonSocial, @ID_Rubro, @CUIT, @ID)
	
	SELECT @@Identity AS ID
END



GO


