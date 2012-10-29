USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[GetDefaultRoleID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[GetDefaultRoleID]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[GetDefaultRoleID]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [GRUPO_N].[GetIdRolDefault]() AS ID
END

GO