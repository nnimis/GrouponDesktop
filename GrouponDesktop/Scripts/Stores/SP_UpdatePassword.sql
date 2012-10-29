USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[UpdateUserPassword]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[UpdateUserPassword]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE GRUPO_N.UpdateUserPassword
	@ID_Usuario int,
	@OldPassword nvarchar(255),
	@NewPassword nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

    SELECT 1 FROM GRUPO_N.Usuario
	WHERE ID = @ID_Usuario AND Password = @OldPassword

	IF @@ROWCOUNT = 1
	BEGIN
		UPDATE GRUPO_N.Usuario 
		SET Password = @NewPassword
		WHERE ID = @ID_Usuario
	END

END
GO