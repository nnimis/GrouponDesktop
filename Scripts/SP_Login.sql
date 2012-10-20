USE [GD1C2012]
GO

/****** Object:  StoredProcedure [dbo].[Login]    Script Date: 10/20/2012 12:19:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Login]
	-- Add the parameters for the stored procedure here
	@Nombre nvarchar(255),
	@Password nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ID, ID_Rol, Nombre FROM GRUPO_N.Usuario WHERE
	Nombre = @Nombre AND Password = @Password
END

GO


