USE [GD2C2012]
GO

/****** Object:  StoredProcedure [GRUPO_N].[InsertProveedor]    Script Date: 11/07/2012 17:10:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[InsertProveedor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[InsertProveedor]
GO

USE [GD2C2012]
GO

/****** Object:  StoredProcedure [GRUPO_N].[InsertProveedor]    Script Date: 11/07/2012 17:10:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [GRUPO_N].[InsertProveedor]
	@CUIT nvarchar(20),
	@RazonSocial nvarchar(255),
	@ID_Rubro int,
	@ID int,
	@Contacto nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO GRUPO_N.Proveedor(RazonSocial, ID_Rubro, CUIT, ID, Contacto) VALUES 
	(@RazonSocial, @ID_Rubro, @CUIT, @ID, @Contacto)
	
	SELECT @@Identity AS ID
END



GO


