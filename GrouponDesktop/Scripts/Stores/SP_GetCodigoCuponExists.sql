USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetCodigoCuponExists]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetCodigoCuponExists]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[GetCodigoCuponExists]
@Codigo nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT 1 FROM GRUPO_N.Cupon
	WHERE Codigo = @Codigo
END

GO