USE [GD2C2012]
GO
IF  EXISTS (SELECT * FROM sys.schemas WHERE name = N'GRUPO_N')
DROP SCHEMA [GRUPO_N]
GO
/****** Object:  Schema [GRUPO_N]    Script Date: 11/12/2012 20:20:08 ******/
CREATE SCHEMA [GRUPO_N] AUTHORIZATION [gd]
GO
/****** Object:  Table [GRUPO_N].[Ciudad]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Ciudad](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Ciudad] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[Funcionalidad]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Funcionalidad](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Funcionalidad] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[TipoPago]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[TipoPago](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_TipoPago] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[Rol]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Rol](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[Rubro]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Rubro](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Rubro] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[RolesFuncionalidades]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[RolesFuncionalidades](
	[ID_Rol] [int] NOT NULL,
	[ID_Funcionalidad] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [GRUPO_N].[UpdateRole]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[UpdateRole]
	@Description nvarchar(100),
	@ID int
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE GRUPO_N.Rol SET Descripcion = @Description
	WHERE ID = @ID
END
GO
/****** Object:  Table [GRUPO_N].[Perfil]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Perfil](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
	[ID_Rol] [int] NOT NULL,
 CONSTRAINT [PK_Perfil] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[Usuario]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Usuario](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[ID_Rol] [int] NOT NULL,
	[Intentos] [int] NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetCiudades]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetCiudades]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT ID, Descripcion FROM GRUPO_N.Ciudad
END
GO
/****** Object:  UserDefinedFunction [GRUPO_N].[GetFunctionalityByName]    Script Date: 11/12/2012 20:20:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [GRUPO_N].[GetFunctionalityByName] 
(
	@Func_Name nvarchar(255)
)
RETURNS int
AS
BEGIN
	DECLARE @Func_ID int

	SELECT @Func_ID = ID FROM GRUPO_N.Funcionalidad
	WHERE Descripcion = @Func_Name

	RETURN @Func_ID
END
GO
/****** Object:  UserDefinedFunction [GRUPO_N].[GetIdRolDefault]    Script Date: 11/12/2012 20:20:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [GRUPO_N].[GetIdRolDefault] ()
RETURNS int
AS
BEGIN
	DECLARE @Rol_ID int

	SELECT @Rol_ID = ID FROM GRUPO_N.Rol
	WHERE Descripcion = 'Rol por Defecto'

	RETURN @Rol_ID
END
GO
/****** Object:  UserDefinedFunction [GRUPO_N].[GetIdRolByName]    Script Date: 11/12/2012 20:20:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [GRUPO_N].[GetIdRolByName]
(
	@RoleName NVARCHAR(100)
)
RETURNS int
AS
BEGIN
	DECLARE @Rol_ID int

	SELECT @Rol_ID = ID FROM GRUPO_N.Rol
	WHERE Descripcion = @RoleName

	RETURN @Rol_ID
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetRubros]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetRubros]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT ID, Descripcion FROM GRUPO_N.Rubro
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetRoles]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetRoles]
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT ID, Descripcion FROM GRUPO_N.Rol
	WHERE Activo = 1
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[InsertRole]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[InsertRole]
	@Description nvarchar(100)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO GRUPO_N.Rol (Descripcion) VALUES (@Description)
	SELECT @@Identity AS ID
END
GO
/****** Object:  Table [GRUPO_N].[DetalleEntidad]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[DetalleEntidad](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Telefono] [numeric](18, 0) NOT NULL,
	[Email] [nvarchar](255) NULL,
	[ID_Usuario] [int] NOT NULL,
 CONSTRAINT [PK_DetalleEntidad] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_DetalleEntidad_Telefono] UNIQUE NONCLUSTERED 
(
	[Telefono] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [GRUPO_N].[DeleteUser]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[DeleteUser]
	@User_ID int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE GRUPO_N.Usuario SET Activo = 0 WHERE ID = @User_ID
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[DeleteRoleFunctionalities]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[DeleteRoleFunctionalities]
	@Rol_ID int
AS
BEGIN
	DELETE FROM GRUPO_N.RolesFuncionalidades
	WHERE ID_Rol = @Rol_ID
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[DeleteRole]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[DeleteRole]
	@Rol_ID int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE GRUPO_N.Rol SET Activo = 0 WHERE ID = @Rol_ID
	UPDATE GRUPO_N.Usuario SET ID_Rol = [GRUPO_N].[GetIdRolDefault]() WHERE ID_Rol = @Rol_ID
END
GO
/****** Object:  Table [GRUPO_N].[Cliente]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Cliente](
	[ID] [int] NOT NULL,
	[DNI] [numeric](18, 0) NOT NULL,
	[Nombre] [nvarchar](255) NOT NULL,
	[Apellido] [nchar](255) NOT NULL,
	[FechaNacimiento] [datetime] NOT NULL,
	[Saldo] [numeric](18, 2) NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetUserLoginAttempts]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetUserLoginAttempts]
	@Nombre nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Intentos FROM GRUPO_N.Usuario WHERE Nombre = @Nombre
	IF(@@ROWCOUNT = 0)
		SELECT 0 AS Intentos
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetRoleFunctionalities]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetRoleFunctionalities]
	@Rol_ID int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT F.Descripcion AS Descripcion FROM GRUPO_N.Funcionalidad F
	INNER JOIN GRUPO_N.RolesFuncionalidades RF ON F.ID = RF.ID_Funcionalidad
	WHERE RF.ID_Rol = @Rol_ID
END
GO
/****** Object:  UserDefinedFunction [GRUPO_N].[GetIdRoleByProfile]    Script Date: 11/12/2012 20:20:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [GRUPO_N].[GetIdRoleByProfile]
(
	@ProfileName NVARCHAR(100)
)
RETURNS int
AS
BEGIN
	DECLARE @ID_Rol int

	SELECT @ID_Rol = ID_Rol FROM GRUPO_N.Perfil
	WHERE Descripcion = @ProfileName

	RETURN @ID_Rol
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetDefaultRoleID]    Script Date: 11/12/2012 20:20:11 ******/
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
/****** Object:  UserDefinedFunction [GRUPO_N].[GetIdProfileByName]    Script Date: 11/12/2012 20:20:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [GRUPO_N].[GetIdProfileByName]
(
	@ProfileName NVARCHAR(100)
)
RETURNS int
AS
BEGIN
	DECLARE @Profile_ID int

	SELECT @Profile_ID = ID FROM GRUPO_N.Perfil
	WHERE Descripcion = @ProfileName

	RETURN @Profile_ID
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[UpdateUserPassword]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[UpdateUserPassword]
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
/****** Object:  Table [GRUPO_N].[Proveedor]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Proveedor](
	[ID] [int] NOT NULL,
	[RazonSocial] [nvarchar](100) NOT NULL,
	[CUIT] [nvarchar](20) NOT NULL,
	[ID_Rubro] [int] NOT NULL,
	[Contacto] [nvarchar](255) NULL,
 CONSTRAINT [PK_Proveedor] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [GRUPO_N].[Login]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[Login]
	@Nombre nvarchar(255),
	@Password nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, ID_Rol, Nombre FROM GRUPO_N.Usuario WHERE
	Nombre = @Nombre AND Password = @Password AND Activo = 1
	
	IF @@ROWCOUNT = 0
		BEGIN
			UPDATE GRUPO_N.Usuario SET Intentos = Intentos + 1
			WHERE Nombre = @Nombre
		END
	ELSE
		BEGIN
			UPDATE GRUPO_N.Usuario SET Intentos = 0
			WHERE Nombre = @Nombre
		END
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[InsertUser]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[InsertUser]
	@UserName nvarchar(255),
	@Password nvarchar(255),
	@ID_Rol int
AS
BEGIN
	INSERT INTO GRUPO_N.Usuario (Nombre, Password, ID_Rol, Activo, Intentos) VALUES
	(@UserName, @Password, @ID_Rol, 1, 0)
	SELECT @@Identity AS ID
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[InsertRoleFunctionality]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[InsertRoleFunctionality]
	@Rol_ID int,
	@Funcionalidad nvarchar(255)
AS
BEGIN
	INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
	VALUES (@Rol_ID, [GRUPO_N].[GetFunctionalityByName](@Funcionalidad))
END
GO
/****** Object:  Table [GRUPO_N].[Pago]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Pago](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Credito] [numeric](18, 2) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[ID_TipoPago] [int] NOT NULL,
	[ID_Cliente] [int] NOT NULL,
 CONSTRAINT [PK_Pago] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[Tarjeta]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Tarjeta](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Banco] [nvarchar](255) NOT NULL,
	[Numero] [nvarchar](255) NOT NULL,
	[ID_Cliente] [int] NOT NULL,
 CONSTRAINT [PK_Tarjeta] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [GRUPO_N].[UpdateCliente]    Script Date: 11/12/2012 20:20:11 ******/
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
/****** Object:  StoredProcedure [GRUPO_N].[UpdateProveedor]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[UpdateProveedor]
	@CUIT nvarchar(20),
	@RazonSocial nvarchar(255),
	@ID_Rubro int,
	@ID int,
	@Contacto nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE GRUPO_N.Proveedor SET
	RazonSocial = @RazonSocial, ID_Rubro = @ID_Rubro, CUIT = @CUIT, Contacto = @Contacto
	WHERE ID = @ID
END
GO
/****** Object:  Table [GRUPO_N].[ClienteCiudad]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[ClienteCiudad](
	[ID_Cliente] [int] NOT NULL,
	[ID_Ciudad] [int] NOT NULL,
 CONSTRAINT [PK_ClienteCiudad] PRIMARY KEY CLUSTERED 
(
	[ID_Cliente] ASC,
	[ID_Ciudad] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [GRUPO_N].[GetIdProveedorByName]    Script Date: 11/12/2012 20:20:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [GRUPO_N].[GetIdProveedorByName]
(
	@ProveedorName NVARCHAR(100)
)
RETURNS int
AS
BEGIN
	DECLARE @Proveedor_ID int

	SELECT @Proveedor_ID = ID FROM GRUPO_N.Proveedor
	WHERE RazonSocial = @ProveedorName

	RETURN @Proveedor_ID
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[InsertProveedor]    Script Date: 11/12/2012 20:20:11 ******/
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
/****** Object:  StoredProcedure [GRUPO_N].[InsertProfileUser]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[InsertProfileUser]
	@UserName nvarchar(255),
	@Password nvarchar(255),
	@ProfileName nvarchar(100)
AS
BEGIN
	INSERT INTO GRUPO_N.Usuario (Nombre, Password, ID_Rol, Activo, Intentos) VALUES
	(@UserName, @Password, GRUPO_N.GetIdRoleByProfile(@ProfileName), 1, 0)
	SELECT @@Identity AS ID
END
GO
/****** Object:  Table [GRUPO_N].[GiftCard]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[GiftCard](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_Cliente_Origen] [int] NOT NULL,
	[ID_Cliente_Destino] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Credito] [numeric](18, 2) NOT NULL,
 CONSTRAINT [PK_GiftCard] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [GRUPO_N].[InsertCliente]    Script Date: 11/12/2012 20:20:11 ******/
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
/****** Object:  Table [GRUPO_N].[Cupon]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Cupon](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Precio] [numeric](18, 2) NOT NULL,
	[PrecioOriginal] [numeric](18, 2) NOT NULL,
	[FechaPublicacion] [datetime] NOT NULL,
	[FechaVigencia] [datetime] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[Stock] [numeric](18, 0) NOT NULL,
	[Descripcion] [nvarchar](255) NOT NULL,
	[ID_Proveedor] [int] NOT NULL,
	[CantidadPorUsuario] [int] NOT NULL,
	[Publicado] [bit] NOT NULL,
	[Codigo] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Cupon] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[Factura]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Factura](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Numero] [numeric](18, 0) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[ID_Proveedor] [int] NOT NULL,
 CONSTRAINT [PK_Factura] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[Direccion]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Direccion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](255) NOT NULL,
	[ID_Ciudad] [int] NOT NULL,
	[ID_Detalle] [int] NOT NULL,
	[CP] [nvarchar](50) NULL,
 CONSTRAINT [PK_Direccion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [GRUPO_N].[DeleteCiudadesCliente]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[DeleteCiudadesCliente]
@ID_Cliente int
AS
BEGIN
	DELETE FROM GRUPO_N.ClienteCiudad
	WHERE ID_Cliente = @ID_Cliente
END
GO
/****** Object:  Table [GRUPO_N].[CuponCiudad]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[CuponCiudad](
	[ID_Cupon] [int] NOT NULL,
	[ID_Ciudad] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [GRUPO_N].[InsertCupon]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[InsertCupon]
	@Precio numeric(18,2),
	@PrecioOriginal numeric(18,2),
	@FechaPublicacion datetime,
	@FechaVigencia datetime,
	@FechaVencimiento datetime,
	@Stock numeric(18,0),
	@Descripcion nvarchar(255),
	@ID_Proveedor int,
	@CantidadPorUsuario int,
	@Publicado bit,
	@Codigo nvarchar(50)
AS
BEGIN
	INSERT INTO [GRUPO_N].[Cupon]
	   ([Precio]
	   ,[PrecioOriginal]
	   ,[FechaPublicacion]
	   ,[FechaVigencia]
	   ,[FechaVencimiento]
	   ,[Stock]
	   ,[Descripcion]
	   ,[ID_Proveedor]
	   ,[CantidadPorUsuario]
	   ,[Publicado]
	   ,[Codigo])
	 VALUES
	   (@Precio,
		@PrecioOriginal,
		@FechaPublicacion,
		@FechaVigencia,
		@FechaVencimiento,
		@Stock,
		@Descripcion,
		@ID_Proveedor,
		@CantidadPorUsuario,
		@Publicado,
		@Codigo)
	
	SELECT @@IDENTITY
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[InsertCiudadCliente]    Script Date: 11/12/2012 20:20:11 ******/
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
/****** Object:  StoredProcedure [GRUPO_N].[InsertFactura]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[InsertFactura]
	@ID_Proveedor int,
	@Fecha datetime
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @NroFactura numeric(18,0)
	SELECT @NroFactura = MAX(Numero) + 1 FROM GRUPO_N.Factura
	
	IF @NroFactura IS NULL
		SET @NroFactura = 1

	INSERT INTO GRUPO_N.Factura(Numero, Fecha, ID_Proveedor)
	VALUES (@NroFactura, @Fecha, @ID_Proveedor)
	
	SELECT @@IDENTITY AS ID_Factura, @NroFactura AS NroFactura
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[InsertDetalleEntidad]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[InsertDetalleEntidad]
	@Telefono numeric(18,0),
	@Email nvarchar(255),
	@ID_Usuario int,
	@Direccion nvarchar(255),
	@ID_Ciudad int,
	@CP nvarchar(50)
AS
BEGIN
	DECLARE @DetalleEntidad int
	SET NOCOUNT ON;
	INSERT INTO GRUPO_N.DetalleEntidad (Telefono, Email, ID_Usuario) VALUES (@Telefono, @Email, @ID_Usuario)
	
	SET @DetalleEntidad = @@Identity
	INSERT INTO GRUPO_N.Direccion (Descripcion, ID_Ciudad, ID_Detalle, CP) VALUES (@Direccion, @ID_Ciudad, @DetalleEntidad, @CP)
	
	SELECT @DetalleEntidad AS ID
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetCiudadesCliente]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetCiudadesCliente]
@ID_Cliente int
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT *
	FROM GRUPO_N.ClienteCiudad
	WHERE ID_Cliente = @ID_Cliente
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetProveedores]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetProveedores]
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT p.ID, p.RazonSocial, p.CUIT, p.ID_Rubro, p.Contacto,
		d.Email, d.Telefono, di.Descripcion AS Direccion, di.ID_Ciudad,
		di.CP, u.Nombre AS UserName, u.ID_Rol
	FROM GRUPO_N.Proveedor p
	INNER JOIN GRUPO_N.DetalleEntidad d ON d.ID_Usuario = p.ID
	INNER JOIN GRUPO_N.Direccion di ON d.ID = di.ID_Detalle
	INNER JOIN GRUPO_N.Usuario u ON p.ID = u.ID
	WHERE u.Activo = 1
	ORDER BY p.RazonSocial
END
GO
/****** Object:  Table [GRUPO_N].[CompraCupon]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[CompraCupon](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_Cliente] [int] NOT NULL,
	[ID_Cupon] [int] NOT NULL,
	[Codigo] [nvarchar](50) NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_CompraCupon] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetGiftCardCliente]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetGiftCardCliente]
	@ID_Cliente int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT g.*, uo.Nombre AS ClienteOrigen, ud.Nombre AS ClienteDestino
    FROM GRUPO_N.GiftCard g
    INNER JOIN GRUPO_N.Usuario uo ON g.ID_Cliente_Origen = uo.ID
    INNER JOIN GRUPO_N.Usuario ud ON g.ID_Cliente_Destino = ud.ID
    WHERE uo.ID = @ID_Cliente
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetCodigoCuponExists]    Script Date: 11/12/2012 20:20:11 ******/
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
/****** Object:  StoredProcedure [GRUPO_N].[GetClientes]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetClientes]
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT c.ID, c.Nombre, c.Apellido, c.DNI, c.FechaNacimiento,
		d.Email, d.Telefono, di.Descripcion AS Direccion, di.ID_Ciudad,
		di.CP, u.Nombre AS UserName, u.ID_Rol
	FROM GRUPO_N.Cliente c
	INNER JOIN GRUPO_N.DetalleEntidad d ON d.ID_Usuario = c.ID
	INNER JOIN GRUPO_N.Direccion di ON d.ID = di.ID_Detalle
	INNER JOIN GRUPO_N.Usuario u ON c.ID = u.ID
	WHERE u.Activo = 1
	ORDER BY c.Apellido, c.Nombre
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetCuponesProveedor]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetCuponesProveedor]
@ID_Proveedor int
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT * FROM GRUPO_N.Cupon c
	WHERE c.ID_Proveedor = @ID_Proveedor
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetCuponesParaPublicar]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetCuponesParaPublicar]
@Fecha_Publicacion datetime
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT c.*, p.RazonSocial FROM GRUPO_N.Cupon c
	INNER JOIN GRUPO_N.Proveedor p ON c.ID_Proveedor = p.ID
	WHERE c.FechaPublicacion >= @Fecha_Publicacion
	AND c.FechaPublicacion < DATEADD(d,1,@Fecha_Publicacion)
	AND c.Publicado = 0
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[UpdateDetalleEntidad]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[UpdateDetalleEntidad]
	@Telefono numeric(18,0),
	@Email nvarchar(255),
	@ID_Usuario int,
	@Direccion nvarchar(255),
	@ID_Ciudad int,
	@CP nvarchar(50)
AS
BEGIN
	DECLARE @DetalleEntidad int
	
	UPDATE GRUPO_N.DetalleEntidad SET 
	Telefono = @Telefono, Email = @Email
	WHERE ID_Usuario = @ID_Usuario
	
	SET @DetalleEntidad = (SELECT ID FROM GRUPO_N.DetalleEntidad WHERE ID_Usuario = @ID_Usuario)
	
	UPDATE GRUPO_N.Direccion SET 
	Descripcion = @Direccion, 
	ID_Ciudad = @ID_Ciudad,
	CP = @CP
	WHERE ID_Detalle = @DetalleEntidad
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[PublicarCupon]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[PublicarCupon]
@ID datetime
AS
BEGIN
	SET NOCOUNT ON;
    
	UPDATE GRUPO_N.Cupon
	SET Publicado = 1
	WHERE ID = @ID
END
GO
/****** Object:  Table [GRUPO_N].[PagosTarjetas]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[PagosTarjetas](
	[ID_Pago] [int] NOT NULL,
	[ID_Tarjeta] [int] NOT NULL,
 CONSTRAINT [PK_PagosTarjetas] PRIMARY KEY CLUSTERED 
(
	[ID_Pago] ASC,
	[ID_Tarjeta] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [GRUPO_N].[InsertGiftCard]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[InsertGiftCard]
	@ID_ClienteOrigen int,
	@ID_ClienteDestino int,
	@Fecha datetime,
	@Credito numeric(18,2)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO GRUPO_N.GiftCard (Credito, Fecha, ID_Cliente_Origen, ID_Cliente_Destino)
	VALUES (@Credito, @Fecha, @ID_ClienteOrigen, @ID_ClienteDestino)
	
	SELECT @@IDENTITY
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetCuponesCliente]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetCuponesCliente]
@Fecha_Publicacion datetime,
@ID_Cliente int
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT DISTINCT c.* FROM GRUPO_N.Cupon c
	INNER JOIN GRUPO_N.CuponCiudad cc ON cc.ID_Cupon = c.ID
	INNER JOIN GRUPO_N.ClienteCiudad cu ON cu.ID_Ciudad = cc.ID_Ciudad
	WHERE c.Publicado = 1
	AND cu.ID_Cliente = @ID_Cliente
	AND c.FechaPublicacion <= @Fecha_Publicacion
	AND c.FechaVigencia >= @Fecha_Publicacion
	ORDER BY c.Descripcion
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetCiudadesCupon]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetCiudadesCupon]
@ID_Cupon int
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT c.ID, c.Descripcion
	FROM GRUPO_N.CuponCiudad cc
	INNER JOIN GRUPO_N.Ciudad c ON cc.ID_Ciudad = c.ID
	WHERE ID_Cupon = @ID_Cupon
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetPagosCliente]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetPagosCliente]
	@ID_Cliente int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT p.*, t.Banco, t.Numero FROM GRUPO_N.Pago p
    LEFT JOIN PagosTarjetas pt ON pt.ID_Pago = p.ID
    LEFT JOIN Tarjeta t ON pt.ID_Tarjeta = t.ID
    WHERE p.ID_Cliente = @ID_Cliente
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[InsertPago]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[InsertPago]
	@ID_Cliente int,
	@Credito numeric(18,2),
	@Fecha datetime,
	@ID_TipoPago int,
	@Tarjeta nvarchar(255),
	@Banco nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ID_Pago int
	DECLARE @ID_Tarjeta int

	INSERT INTO GRUPO_N.Pago (Credito, Fecha, ID_Cliente, ID_TipoPago)
	VALUES (@Credito, @Fecha, @ID_Cliente, @ID_TipoPago)
	
    SET @ID_Pago = @@IDENTITY
    
    IF @ID_TipoPago = 2
    BEGIN
		INSERT INTO GRUPO_N.Tarjeta (Banco, Numero, ID_Cliente)
		VALUES (@Banco, @Tarjeta, @ID_Cliente)
		
		SET @ID_Tarjeta = @@IDENTITY
		INSERT INTO GRUPO_N.PagosTarjetas (ID_Pago, ID_Tarjeta)
		VALUES (@ID_Pago, @ID_Tarjeta)
    END
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[InsertCuponCiudad]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[InsertCuponCiudad]
	@ID_Cupon int,
	@ID_Ciudad int
AS
BEGIN
	INSERT INTO [GRUPO_N].[CuponCiudad]
	   (ID_Ciudad, ID_Cupon)
	 VALUES
	   (@ID_Ciudad, @ID_Cupon)
END
GO
/****** Object:  Table [GRUPO_N].[Devolucion]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [GRUPO_N].[Devolucion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_Cliente] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Motivo] [varchar](max) NOT NULL,
	[ID_CompraCupon] [int] NOT NULL,
 CONSTRAINT [PK_Devolucion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [GRUPO_N].[CanjeCupon]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[CanjeCupon](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[ID_CompraCupon] [int] NOT NULL,
 CONSTRAINT [PK_CanjeCupon] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX IX_CanjeCupon_Fecha ON GRUPO_N.CanjeCupon
	(
	Fecha
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [GRUPO_N].[ComprarCuponCliente]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[ComprarCuponCliente]
	@ID_Cliente int,
	@ID_Cupon int,
	@Fecha datetime
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @NumeroCupon int
	DECLARE @CantidadPorUsuario int
	DECLARE @CantidadComprada int
	DECLARE @CodigoCupon nvarchar(50)

	SELECT @NumeroCupon = COUNT(*) + 1 FROM GRUPO_N.CompraCupon
	WHERE ID_Cupon = @ID_Cupon 
	GROUP BY ID_Cupon
	
	SELECT @CantidadComprada = COUNT(ID_Cupon) - COUNT(d.ID_Cliente) FROM GRUPO_N.CompraCupon cc
	LEFT JOIN GRUPO_N.Devolucion d ON d.ID_CompraCupon = cc.ID
	WHERE ID_Cupon = @ID_Cupon
	AND cc.ID_Cliente = @ID_Cliente
	GROUP BY ID_Cupon, cc.ID_Cliente

	IF @CantidadComprada IS NULL
		SET @CantidadComprada = 0

	IF @NumeroCupon IS NULL
		SET @NumeroCupon = 1

	SELECT 
		@CodigoCupon = Codigo + CAST(@NumeroCupon as varchar(10)), 
		@CantidadPorUsuario = CantidadPorUsuario 
	FROM GRUPO_N.Cupon
	WHERE ID = @ID_Cupon

	IF @CantidadComprada < @CantidadPorUsuario
	BEGIN
		INSERT INTO GRUPO_N.CompraCupon (Fecha, ID_Cliente, ID_Cupon, Codigo)
		VALUES (@Fecha, @ID_Cliente, @ID_Cupon, @CodigoCupon)

		SELECT @NumeroCupon
	END
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[InsertDevolucionCompra]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[InsertDevolucionCompra]
	@ID_Cliente int,
	@ID_CompraCupon int,
	@Fecha datetime,
	@Motivo varchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Existe int
	SET @Existe = 0

	SELECT @Existe = 1 FROM GRUPO_N.CanjeCupon WHERE ID_CompraCupon = @ID_CompraCupon

	IF @Existe = 0
	BEGIN
		INSERT INTO GRUPO_N.Devolucion (ID_Cliente, Fecha, Motivo, ID_CompraCupon)
		VALUES (@ID_Cliente, @Fecha, @Motivo, @ID_CompraCupon)
		
		SELECT @@IDENTITY
	END
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[InsertCanjeCupon]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[InsertCanjeCupon]
	@ID_CompraCupon int,
	@Fecha datetime
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO GRUPO_N.CanjeCupon (ID_CompraCupon, Fecha) 
	VALUES (@ID_CompraCupon, @Fecha)
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetComprasCliente]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetComprasCliente]
	@ID_Cliente int,
	@FechaDesde datetime,
	@FechaHasta datetime
AS
BEGIN
	SET NOCOUNT ON;

	SELECT cc.*, c.Descripcion, c.Precio, c.FechaVencimiento AS FechaVencimiento, 
		d.ID AS ID_Devolucion, ca.ID AS ID_Canje
	FROM GRUPO_N.CompraCupon cc
	INNER JOIN GRUPO_N.Cupon c ON cc.ID_Cupon = c.ID
	LEFT JOIN GRUPO_N.Devolucion d ON d.ID_CompraCupon = cc.ID
	LEFT JOIN GRUPO_N.CanjeCupon ca ON ca.ID_CompraCupon = cc.ID
	WHERE cc.ID_Cliente = @ID_Cliente
	AND cc.Fecha <= @FechaHasta
	AND cc.Fecha >= @FechaDesde
	ORDER BY cc.Fecha DESC
END
GO
/****** Object:  Table [GRUPO_N].[FacturasCanjesCupones]    Script Date: 11/12/2012 20:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[FacturasCanjesCupones](
	[ID_Factura] [int] NOT NULL,
	[ID_CanjeCupon] [int] NOT NULL,
 CONSTRAINT [PK_FacturasCanjesCupones] PRIMARY KEY CLUSTERED 
(
	[ID_Factura] ASC,
	[ID_CanjeCupon] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [GRUPO_N].[Get_TOPGiftCard]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[Get_TOPGiftCard]
	@fecha_inicio AS NVARCHAR(50),
	@fecha_fin AS NVARCHAR(50)
AS
BEGIN

	SELECT TOP 5 c.Nombre, c.Apellido, crg.credito AS [Crédito], gst.Consumo AS Consumo
	FROM
	(
		SELECT SUM(gf.Credito) AS credito, gf.ID_Cliente_Destino
		FROM GRUPO_N.GiftCard gf
		WHERE gf.Fecha BETWEEN @fecha_inicio AND @fecha_fin
		GROUP BY gf.ID_Cliente_Destino
	) crg 
	INNER JOIN
	(
		SELECT SUM(c.Precio) AS Consumo, ccp.ID_Cliente
		FROM GRUPO_N.CanjeCupon cac
			INNER JOIN GRUPO_N.CompraCupon ccp ON ccp.ID = cac.ID_CompraCupon
			INNER JOIN GRUPO_N.Cupon c ON c.ID = ccp.ID_Cupon
		WHERE ccp.Fecha BETWEEN @fecha_inicio AND @fecha_fin
		GROUP BY ccp.ID_Cliente
	) gst ON gst.ID_Cliente = crg.ID_Cliente_Destino
	INNER JOIN GRUPO_N.Cliente c ON c.ID = crg.ID_Cliente_Destino
	WHERE crg.credito <= gst.consumo
	ORDER BY crg.credito DESC
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[Get_TOPDevoluciones]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[Get_TOPDevoluciones]
	@fecha_inicio AS NVARCHAR(50),
	@fecha_fin AS NVARCHAR(50)
AS
BEGIN
	SELECT TOP 5 cmp.RazonSocial AS [Razón Social], cmp.compras AS Compras, dev.Devoluciones AS Devoluciones, 
		STR(100*CONVERT(FLOAT,dev.devoluciones)/CONVERT(FLOAT,cmp.compras), 12, 2) + '%' AS Porcentaje
	FROM 
	(
		SELECT p1.RazonSocial, COUNT(*) AS compras
		FROM GRUPO_N.Proveedor p1
		INNER JOIN GRUPO_N.Cupon cu1 ON cu1.ID_Proveedor=p1.ID
		INNER JOIN GRUPO_N.CompraCupon cc1 ON cc1.ID_Cupon=cu1.ID
		WHERE (cc1.Fecha BETWEEN @fecha_inicio AND @fecha_fin)
		GROUP BY p1.RazonSocial
	) cmp
	INNER JOIN
	(
		SELECT p2.RazonSocial, COUNT(*) AS Devoluciones
		FROM GRUPO_N.Proveedor p2
		INNER JOIN GRUPO_N.Cupon cu2 ON cu2.ID_Proveedor=p2.ID
		INNER JOIN GRUPO_N.CompraCupon cc2 ON cc2.ID_Cupon=cu2.ID
		INNER JOIN GRUPO_N.Devolucion dv2 ON dv2.ID_CompraCupon=cc2.ID
		WHERE (cc2.Fecha BETWEEN @fecha_inicio AND @fecha_fin) AND (dv2.Fecha BETWEEN @fecha_inicio AND @fecha_fin)
		GROUP BY p2.RazonSocial
	)dev ON dev.RazonSocial=cmp.RazonSocial
	ORDER BY 4 DESC
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetComprasProveedor]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetComprasProveedor]
	@ID_Proveedor int,
	@FechaVencimiento datetime
AS
BEGIN
	SET NOCOUNT ON;

	SELECT cc.*, c.Descripcion, c.Precio, cl.Nombre AS Cliente
	FROM GRUPO_N.CompraCupon cc
		INNER JOIN GRUPO_N.Cupon c ON cc.ID_Cupon = c.ID
		INNER JOIN GRUPO_N.Usuario cl ON cc.ID_Cliente = cl.ID
		LEFT JOIN GRUPO_N.Devolucion d ON d.ID_CompraCupon = cc.ID
		LEFT JOIN GRUPO_N.CanjeCupon ca ON ca.ID_CompraCupon = cc.ID
	WHERE c.ID_Proveedor = @ID_Proveedor
		AND c.FechaVencimiento > @FechaVencimiento
		AND d.ID_CompraCupon IS NULL
		AND ca.ID_CompraCupon IS NULL
	ORDER BY cc.Fecha DESC
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[InsertFacturaCanjeCupon]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[InsertFacturaCanjeCupon]
	@ID_Factura int,
	@ID_CanjeCupon int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO GRUPO_N.FacturasCanjesCupones(ID_CanjeCupon, ID_Factura)
	VALUES (@ID_CanjeCupon, @ID_Factura)
END
GO
/****** Object:  StoredProcedure [GRUPO_N].[GetComprasParaFacturar]    Script Date: 11/12/2012 20:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GRUPO_N].[GetComprasParaFacturar]
	@ID_Proveedor int,
	@FechaDesde datetime,
	@FechaHasta datetime
AS
BEGIN
	SET NOCOUNT ON;

	SELECT cc.*, c.Descripcion, c.Precio, cl.Nombre AS Cliente, ca.ID AS ID_Canje
	FROM GRUPO_N.CompraCupon cc
		INNER JOIN GRUPO_N.Cupon c ON cc.ID_Cupon = c.ID
		INNER JOIN GRUPO_N.Usuario cl ON cc.ID_Cliente = cl.ID
		INNER JOIN GRUPO_N.CanjeCupon ca ON ca.ID_CompraCupon = cc.ID
		LEFT JOIN GRUPO_N.FacturasCanjesCupones fc ON ca.ID = fc.ID_CanjeCupon
	WHERE c.ID_Proveedor = @ID_Proveedor
		AND ca.Fecha >= @FechaDesde
		AND ca.Fecha <= @FechaHasta
		AND fc.ID_CanjeCupon IS NULL
	ORDER BY ca.Fecha DESC
END
GO
/****** Object:  Default [DF_Ciente_Saldo]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Cliente] ADD  CONSTRAINT [DF_Ciente_Saldo]  DEFAULT ((10)) FOR [Saldo]
GO
/****** Object:  Default [DF_Cupon_Publicado]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Cupon] ADD  CONSTRAINT [DF_Cupon_Publicado]  DEFAULT ((0)) FOR [Publicado]
GO
/****** Object:  Default [DF_Rol_Activo]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Rol] ADD  CONSTRAINT [DF_Rol_Activo]  DEFAULT ((1)) FOR [Activo]
GO
/****** Object:  Default [DF_Usuario_Intentos]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Usuario] ADD  CONSTRAINT [DF_Usuario_Intentos]  DEFAULT ((0)) FOR [Intentos]
GO
/****** Object:  Default [DF_Usuario_Activo]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Usuario] ADD  CONSTRAINT [DF_Usuario_Activo]  DEFAULT ((1)) FOR [Activo]
GO
/****** Object:  Check [CK_Cliente_Saldo]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Cliente]  WITH CHECK ADD  CONSTRAINT [CK_Cliente_Saldo] CHECK  (([Saldo]>=(0)))
GO
ALTER TABLE [GRUPO_N].[Cliente] CHECK CONSTRAINT [CK_Cliente_Saldo]
GO
/****** Object:  ForeignKey [FK_CanjeCupon_CompraCupon]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[CanjeCupon]  WITH CHECK ADD  CONSTRAINT [FK_CanjeCupon_CompraCupon] FOREIGN KEY([ID_CompraCupon])
REFERENCES [GRUPO_N].[CompraCupon] ([ID])
GO
ALTER TABLE [GRUPO_N].[CanjeCupon] CHECK CONSTRAINT [FK_CanjeCupon_CompraCupon]
GO
/****** Object:  ForeignKey [FK_Cliente_Usuario]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Usuario] FOREIGN KEY([ID])
REFERENCES [GRUPO_N].[Usuario] ([ID])
GO
ALTER TABLE [GRUPO_N].[Cliente] CHECK CONSTRAINT [FK_Cliente_Usuario]
GO
/****** Object:  ForeignKey [FK_Cliente_Ciudad]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[ClienteCiudad]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Ciudad] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO
ALTER TABLE [GRUPO_N].[ClienteCiudad] CHECK CONSTRAINT [FK_Cliente_Ciudad]
GO
/****** Object:  ForeignKey [FK_ClienteCiudad_Ciudad]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[ClienteCiudad]  WITH CHECK ADD  CONSTRAINT [FK_ClienteCiudad_Ciudad] FOREIGN KEY([ID_Ciudad])
REFERENCES [GRUPO_N].[Ciudad] ([ID])
GO
ALTER TABLE [GRUPO_N].[ClienteCiudad] CHECK CONSTRAINT [FK_ClienteCiudad_Ciudad]
GO
/****** Object:  ForeignKey [FK_CompraCupon_Cliente]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[CompraCupon]  WITH CHECK ADD  CONSTRAINT [FK_CompraCupon_Cliente] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO
ALTER TABLE [GRUPO_N].[CompraCupon] CHECK CONSTRAINT [FK_CompraCupon_Cliente]
GO
/****** Object:  ForeignKey [FK_CompraCupon_Cupon]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[CompraCupon]  WITH CHECK ADD  CONSTRAINT [FK_CompraCupon_Cupon] FOREIGN KEY([ID_Cupon])
REFERENCES [GRUPO_N].[Cupon] ([ID])
GO
ALTER TABLE [GRUPO_N].[CompraCupon] CHECK CONSTRAINT [FK_CompraCupon_Cupon]
GO
/****** Object:  ForeignKey [FK_Cupon_Proveedor]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Cupon]  WITH CHECK ADD  CONSTRAINT [FK_Cupon_Proveedor] FOREIGN KEY([ID_Proveedor])
REFERENCES [GRUPO_N].[Proveedor] ([ID])
GO
ALTER TABLE [GRUPO_N].[Cupon] CHECK CONSTRAINT [FK_Cupon_Proveedor]
GO
/****** Object:  ForeignKey [FK_CuponCiudad_Ciudad]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[CuponCiudad]  WITH CHECK ADD  CONSTRAINT [FK_CuponCiudad_Ciudad] FOREIGN KEY([ID_Ciudad])
REFERENCES [GRUPO_N].[Ciudad] ([ID])
GO
ALTER TABLE [GRUPO_N].[CuponCiudad] CHECK CONSTRAINT [FK_CuponCiudad_Ciudad]
GO
/****** Object:  ForeignKey [FK_CuponCiudad_Cupon]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[CuponCiudad]  WITH CHECK ADD  CONSTRAINT [FK_CuponCiudad_Cupon] FOREIGN KEY([ID_Cupon])
REFERENCES [GRUPO_N].[Cupon] ([ID])
GO
ALTER TABLE [GRUPO_N].[CuponCiudad] CHECK CONSTRAINT [FK_CuponCiudad_Cupon]
GO
/****** Object:  ForeignKey [FK_DetalleEntidad_Usuario]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[DetalleEntidad]  WITH CHECK ADD  CONSTRAINT [FK_DetalleEntidad_Usuario] FOREIGN KEY([ID_Usuario])
REFERENCES [GRUPO_N].[Usuario] ([ID])
GO
ALTER TABLE [GRUPO_N].[DetalleEntidad] CHECK CONSTRAINT [FK_DetalleEntidad_Usuario]
GO
/****** Object:  ForeignKey [FK_Cliente_Devolucion]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Devolucion]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Devolucion] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO
ALTER TABLE [GRUPO_N].[Devolucion] CHECK CONSTRAINT [FK_Cliente_Devolucion]
GO
/****** Object:  ForeignKey [FK_Devolucion_CompraCupon]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Devolucion]  WITH CHECK ADD  CONSTRAINT [FK_Devolucion_CompraCupon] FOREIGN KEY([ID_CompraCupon])
REFERENCES [GRUPO_N].[CompraCupon] ([ID])
GO
ALTER TABLE [GRUPO_N].[Devolucion] CHECK CONSTRAINT [FK_Devolucion_CompraCupon]
GO
/****** Object:  ForeignKey [FK_Direccion_Ciudad]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Direccion]  WITH CHECK ADD  CONSTRAINT [FK_Direccion_Ciudad] FOREIGN KEY([ID_Ciudad])
REFERENCES [GRUPO_N].[Ciudad] ([ID])
GO
ALTER TABLE [GRUPO_N].[Direccion] CHECK CONSTRAINT [FK_Direccion_Ciudad]
GO
/****** Object:  ForeignKey [FK_Direccion_DetalleEntidad]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Direccion]  WITH CHECK ADD  CONSTRAINT [FK_Direccion_DetalleEntidad] FOREIGN KEY([ID_Detalle])
REFERENCES [GRUPO_N].[DetalleEntidad] ([ID])
GO
ALTER TABLE [GRUPO_N].[Direccion] CHECK CONSTRAINT [FK_Direccion_DetalleEntidad]
GO
/****** Object:  ForeignKey [FK_Factura_Proveedor]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_Proveedor] FOREIGN KEY([ID_Proveedor])
REFERENCES [GRUPO_N].[Proveedor] ([ID])
GO
ALTER TABLE [GRUPO_N].[Factura] CHECK CONSTRAINT [FK_Factura_Proveedor]
GO
/****** Object:  ForeignKey [FK_FacturasCanjesCupones_CanjeCupon]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[FacturasCanjesCupones]  WITH CHECK ADD  CONSTRAINT [FK_FacturasCanjesCupones_CanjeCupon] FOREIGN KEY([ID_CanjeCupon])
REFERENCES [GRUPO_N].[CanjeCupon] ([ID])
GO
ALTER TABLE [GRUPO_N].[FacturasCanjesCupones] CHECK CONSTRAINT [FK_FacturasCanjesCupones_CanjeCupon]
GO
/****** Object:  ForeignKey [FK_FacturasCanjesCupones_Factura]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[FacturasCanjesCupones]  WITH CHECK ADD  CONSTRAINT [FK_FacturasCanjesCupones_Factura] FOREIGN KEY([ID_Factura])
REFERENCES [GRUPO_N].[Factura] ([ID])
GO
ALTER TABLE [GRUPO_N].[FacturasCanjesCupones] CHECK CONSTRAINT [FK_FacturasCanjesCupones_Factura]
GO
/****** Object:  ForeignKey [FK_Cliente_GiftcardD]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[GiftCard]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_GiftcardD] FOREIGN KEY([ID_Cliente_Destino])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO
ALTER TABLE [GRUPO_N].[GiftCard] CHECK CONSTRAINT [FK_Cliente_GiftcardD]
GO
/****** Object:  ForeignKey [FK_Cliente_GiftcardO]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[GiftCard]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_GiftcardO] FOREIGN KEY([ID_Cliente_Origen])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO
ALTER TABLE [GRUPO_N].[GiftCard] CHECK CONSTRAINT [FK_Cliente_GiftcardO]
GO
/****** Object:  ForeignKey [FK_Cliente_Pago]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Pago]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Pago] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO
ALTER TABLE [GRUPO_N].[Pago] CHECK CONSTRAINT [FK_Cliente_Pago]
GO
/****** Object:  ForeignKey [FK_Pago_TipoPago]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Pago]  WITH CHECK ADD  CONSTRAINT [FK_Pago_TipoPago] FOREIGN KEY([ID_TipoPago])
REFERENCES [GRUPO_N].[TipoPago] ([ID])
GO
ALTER TABLE [GRUPO_N].[Pago] CHECK CONSTRAINT [FK_Pago_TipoPago]
GO
/****** Object:  ForeignKey [FK_PagosTarjeta_Tarjeta]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[PagosTarjetas]  WITH CHECK ADD  CONSTRAINT [FK_PagosTarjeta_Tarjeta] FOREIGN KEY([ID_Tarjeta])
REFERENCES [GRUPO_N].[Tarjeta] ([ID])
GO
ALTER TABLE [GRUPO_N].[PagosTarjetas] CHECK CONSTRAINT [FK_PagosTarjeta_Tarjeta]
GO
/****** Object:  ForeignKey [FK_PagosTarjetas_Pago]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[PagosTarjetas]  WITH CHECK ADD  CONSTRAINT [FK_PagosTarjetas_Pago] FOREIGN KEY([ID_Tarjeta])
REFERENCES [GRUPO_N].[Pago] ([ID])
GO
ALTER TABLE [GRUPO_N].[PagosTarjetas] CHECK CONSTRAINT [FK_PagosTarjetas_Pago]
GO
/****** Object:  ForeignKey [FK_Perfil_Rol]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Perfil]  WITH CHECK ADD  CONSTRAINT [FK_Perfil_Rol] FOREIGN KEY([ID_Rol])
REFERENCES [GRUPO_N].[Rol] ([ID])
GO
ALTER TABLE [GRUPO_N].[Perfil] CHECK CONSTRAINT [FK_Perfil_Rol]
GO
/****** Object:  ForeignKey [FK_Proveedor_Rubro]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Proveedor]  WITH CHECK ADD  CONSTRAINT [FK_Proveedor_Rubro] FOREIGN KEY([ID_Rubro])
REFERENCES [GRUPO_N].[Rubro] ([ID])
GO
ALTER TABLE [GRUPO_N].[Proveedor] CHECK CONSTRAINT [FK_Proveedor_Rubro]
GO
/****** Object:  ForeignKey [FK_Proveedor_Usuario]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Proveedor]  WITH CHECK ADD  CONSTRAINT [FK_Proveedor_Usuario] FOREIGN KEY([ID])
REFERENCES [GRUPO_N].[Usuario] ([ID])
GO
ALTER TABLE [GRUPO_N].[Proveedor] CHECK CONSTRAINT [FK_Proveedor_Usuario]
GO
/****** Object:  ForeignKey [FK_RolesFuncionalidades_Funcionalidad]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[RolesFuncionalidades]  WITH CHECK ADD  CONSTRAINT [FK_RolesFuncionalidades_Funcionalidad] FOREIGN KEY([ID_Funcionalidad])
REFERENCES [GRUPO_N].[Funcionalidad] ([ID])
GO
ALTER TABLE [GRUPO_N].[RolesFuncionalidades] CHECK CONSTRAINT [FK_RolesFuncionalidades_Funcionalidad]
GO
/****** Object:  ForeignKey [FK_RolesFuncionalidades_Rol]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[RolesFuncionalidades]  WITH CHECK ADD  CONSTRAINT [FK_RolesFuncionalidades_Rol] FOREIGN KEY([ID_Rol])
REFERENCES [GRUPO_N].[Rol] ([ID])
GO
ALTER TABLE [GRUPO_N].[RolesFuncionalidades] CHECK CONSTRAINT [FK_RolesFuncionalidades_Rol]
GO
/****** Object:  ForeignKey [FK_Cliente_Tarjeta]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Tarjeta]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Tarjeta] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO
ALTER TABLE [GRUPO_N].[Tarjeta] CHECK CONSTRAINT [FK_Cliente_Tarjeta]
GO
/****** Object:  ForeignKey [FK_Usuario_Rol]    Script Date: 11/12/2012 20:20:14 ******/
ALTER TABLE [GRUPO_N].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Rol] FOREIGN KEY([ID_Rol])
REFERENCES [GRUPO_N].[Rol] ([ID])
GO
ALTER TABLE [GRUPO_N].[Usuario] CHECK CONSTRAINT [FK_Usuario_Rol]
GO

PRINT 'Creando valores por defecto...'
-- INSERT DE FUNCIONALIDADES
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('AdministrarClientes');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('AdministrarProveedores');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('AdministrarCupones');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('CargarCredito');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('CrearCupon');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('ComprarCupones');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('GiftCards');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('Facturar');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('VerHistorialCupones');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('ListarEstadisticas');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('PedirDevoluciones');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('PublicarCupones');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('RegistrarConsumoCupones');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('AdministrarRoles');

INSERT INTO GRUPO_N.TipoPago (Descripcion) VALUES ('Efectivo');
INSERT INTO GRUPO_N.TipoPago (Descripcion) VALUES ('Crédito');

INSERT INTO GRUPO_N.Rol (Descripcion) VALUES ('Rol por Defecto')
INSERT INTO GRUPO_N.Rol (Descripcion) VALUES ('Administrador')
INSERT INTO GRUPO_N.Rol (Descripcion) VALUES ('Proveedor');
INSERT INTO GRUPO_N.Rol (Descripcion) VALUES ('Cliente');

INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
SELECT 1, ID FROM GRUPO_N.Funcionalidad

INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
VALUES (GRUPO_N.GetIdRolByName('Cliente'), 4)
INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
VALUES (GRUPO_N.GetIdRolByName('Cliente'), 6)
INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
VALUES (GRUPO_N.GetIdRolByName('Cliente'), 7)
INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
VALUES (GRUPO_N.GetIdRolByName('Cliente'), 11)
INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
VALUES (GRUPO_N.GetIdRolByName('Cliente'), 9)

INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
VALUES (GRUPO_N.GetIdRolByName('Proveedor'), 5)
INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
VALUES (GRUPO_N.GetIdRolByName('Proveedor'), 13)

INSERT INTO GRUPO_N.Perfil (Descripcion, ID_Rol) VALUES ('Administrador', GRUPO_N.GetIdRolByName('Administrador'));
INSERT INTO GRUPO_N.Perfil (Descripcion, ID_Rol) VALUES ('Proveedor', GRUPO_N.GetIdRolByName('Proveedor'));
INSERT INTO GRUPO_N.Perfil (Descripcion, ID_Rol) VALUES ('Cliente', GRUPO_N.GetIdRolByName('Cliente'));

GO

PRINT 'INICIO DE MIGRACION DE DATOS'

-- Ingresando los clientes.
PRINT 'Ingresando los clientes...'
GO
DECLARE
@Id_Rol_Cliente int

SET @Id_Rol_Cliente = GRUPO_N.GetIdRolByName('Cliente');

INSERT INTO GRUPO_N.Usuario (Activo,ID_Rol,Intentos,Nombre,Password)
SELECT DISTINCT 1,@Id_Rol_Cliente,0,LTRIM(RTRIM(CAST(Cli_telefono AS NVARCHAR(255)))),'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7' 
FROM gd_esquema.Maestra WHERE 1=1;

INSERT INTO GRUPO_N.DetalleEntidad (Email,ID_Usuario,Telefono) 
SELECT distinct m.Cli_Mail, u.ID, m.Cli_Telefono FROM gd_esquema.Maestra m INNER JOIN GRUPO_N.Usuario u ON CAST(m.Cli_Telefono AS NVARCHAR(255))=u.Nombre 
WHERE m.Groupon_Devolucion_Fecha IS NULL AND m.Groupon_Entregado_Fecha IS NULL AND m.Factura_Fecha IS NULL

INSERT INTO GRUPO_N.Cliente (Apellido,DNI,FechaNacimiento,ID,Nombre,saldo)
SELECT DISTINCT m.Cli_Apellido, m.Cli_Dni, m.Cli_Fecha_Nac, u.ID, m.Cli_Nombre, 0 FROM GRUPO_N.Usuario u 
INNER JOIN gd_esquema.Maestra m ON u.Nombre = CAST(m.Cli_Telefono AS NVARCHAR(255))
WHERE u.ID_Rol = @Id_Rol_Cliente;
GO
--Ingresando las ciudades de los diferentes proveedores 
PRINT 'Ingresando las ciudades de los diferentes proveedores y clientes...'
INSERT INTO GRUPO_N.Ciudad (Descripcion)
SELECT DISTINCT nombreCiudad FROM (SELECT distinct cli_ciudad as nombreCiudad FROM gd_esquema.Maestra WHERE Provee_RS IS NULL
UNION SELECT DISTINCT Provee_Ciudad as nombreCiudad FROM gd_esquema.Maestra WHERE Provee_RS IS NOT NULL) m

INSERT INTO GRUPO_N.ClienteCiudad (ID_Ciudad,ID_Cliente)
SELECT ciu.ID as ID_CIUDAD, U.ID AS ID_USUARIO  FROM (SELECT DISTINCT Cli_Telefono, Cli_Ciudad FROM gd_esquema.Maestra WHERE Provee_RS IS NULL) m 
	INNER JOIN GRUPO_N.Usuario u ON u.Nombre=CAST( m.Cli_Telefono AS NVARCHAR(255))
	INNER JOIN GRUPO_N.Ciudad ciu ON ciu.Descripcion = m.Cli_Ciudad

INSERT INTO GRUPO_N.Direccion (CP,Descripcion,ID_Ciudad,ID_Detalle)
SELECT NULL AS CP, m.Cli_Direccion, ciu.ID, de.ID as ID_Detalle 
FROM (SELECT DISTINCT Cli_Telefono, Cli_Ciudad, Cli_Direccion FROM gd_esquema.Maestra WHERE Provee_RS IS NULL) m 
	INNER JOIN GRUPO_N.DetalleEntidad de ON de.Telefono = m.Cli_Telefono 
	INNER JOIN GRUPO_N.Ciudad ciu ON ciu.Descripcion = m.Cli_Ciudad

GO
--Ingresar las cargas de crédito
PRINT 'Ingresar las cargas de crédito...'
GO
INSERT INTO GRUPO_N.Pago (Credito, Fecha, ID_TipoPago, ID_Cliente)
SELECT m.Carga_Credito, m.Carga_Fecha, tp.ID, u.ID
FROM gd_esquema.Maestra m 
INNER JOIN GRUPO_N.TipoPago tp ON tp.Descripcion=m.Tipo_Pago_Desc
INNER JOIN GRUPO_N.Usuario u ON u.Nombre=CAST(m.Cli_Telefono AS NVARCHAR(255))
GO
--Ingresar las tarjetas
PRINT 'Ingresar las tarjetas...'
GO
INSERT INTO GRUPO_N.Tarjeta (Banco, Numero, ID_Cliente)
SELECT DISTINCT 'Banco de importacion previa', 'Numero de importacion previa',  p.ID_Cliente FROM GRUPO_N.Pago p
INNER JOIN GRUPO_N.TipoPago tp ON tp.ID=p.ID_TipoPago
WHERE tp.Descripcion='Crédito'
GO
--Ingresar relacion tarjeta - carga
PRINT 'Ingresar relacion tarjeta - carga...'
GO
INSERT INTO GRUPO_N.PagosTarjetas (ID_Pago, ID_Tarjeta)
SELECT p.ID, t.ID FROM GRUPO_N.Pago p
INNER JOIN GRUPO_N.TipoPago tp ON tp.ID=p.ID_TipoPago
INNER JOIN GRUPO_N.Tarjeta t ON t.ID_Cliente=p.ID_Cliente
WHERE tp.Descripcion='Crédito'
GO
--Ingresando los rubros de los proveedores
PRINT 'Ingresando los rubros de los proveedores...'
GO

INSERT INTO GRUPO_N.Rubro (Descripcion) 
SELECT DISTINCT Provee_Rubro FROM gd_esquema.Maestra WHERE Provee_Rubro IS NOT NULL;

GO
--Ingresando los proveedores
PRINT 'Ingresando los proveedores...'
GO
DECLARE 
@Id_Rol_Proveedor int
SET @Id_Rol_Proveedor = GRUPO_N.GetIdRolByName('Proveedor');

INSERT INTO GRUPO_N.Usuario (Activo,ID_Rol,Intentos,Nombre,Password)
SELECT DISTINCT 1,@Id_Rol_Proveedor,0,Provee_RS,'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7' 
FROM gd_esquema.Maestra WHERE Provee_RS IS NOT NULL;

INSERT INTO GRUPO_N.DetalleEntidad (Email,ID_Usuario,Telefono) 
SELECT distinct NULL, u.ID, m.Provee_Telefono FROM gd_esquema.Maestra m INNER JOIN GRUPO_N.Usuario u ON CAST(m.Provee_RS AS NVARCHAR(255))=u.Nombre 
WHERE m.Groupon_Devolucion_Fecha IS NULL AND m.Groupon_Entregado_Fecha IS NULL AND m.Factura_Fecha IS NULL

INSERT INTO GRUPO_N.Proveedor (Contacto,CUIT,ID,ID_Rubro,RazonSocial)
SELECT DISTINCT NULL,M.Provee_CUIT, u.ID ,r.ID,M.Provee_RS
FROM gd_esquema.Maestra m
INNER JOIN GRUPO_N.Usuario u ON u.Nombre=m.Provee_RS
INNER JOIN GRUPO_N.Rubro r ON r.Descripcion=m.Provee_Rubro

INSERT INTO GRUPO_N.Direccion (CP,Descripcion,ID_Ciudad,ID_Detalle)
SELECT NULL AS CP, m.Provee_Dom, ciu.ID, de.ID as ID_Detalle 
FROM (SELECT DISTINCT Provee_RS, Provee_Ciudad, Provee_Dom FROM gd_esquema.Maestra WHERE Provee_RS IS NOT NULL) m 
	INNER JOIN GRUPO_N.Proveedor p ON p.RazonSocial = m.Provee_RS
	INNER JOIN GRUPO_N.DetalleEntidad de ON de.ID_Usuario = p.ID 
	INNER JOIN GRUPO_N.Ciudad ciu ON ciu.Descripcion = m.Provee_Ciudad
GO
--Ingresando los cupones
PRINT 'Ingresando los cupones...'
GO
INSERT INTO GRUPO_N.Cupon (Precio, PrecioOriginal, FechaPublicacion,FechaVigencia,FechaVencimiento,Stock,Descripcion,ID_Proveedor,CantidadPorUsuario,Publicado ,Codigo)
SELECT distinct [Groupon_Precio_Ficticio], [Groupon_Precio] ,[Groupon_Fecha] ,[Groupon_Fecha_Venc], DATEADD(MONTH,2,[Groupon_Fecha_Venc]) ,[Groupon_Cantidad] ,[Groupon_Descripcion],p.ID,[Groupon_Cantidad], 1 , substring(m.Groupon_Codigo,1,10)
  FROM [GD2C2012].[gd_esquema].[Maestra] m
  INNER JOIN GRUPO_N.Proveedor p ON m.Provee_RS=p.RazonSocial WHERE Provee_RS IS NOT NULL 
GO

--Ingresando las ciudades de los cupones
PRINT 'Ingresando las ciudades de los cupones...'
GO
INSERT INTO GRUPO_N.CuponCiudad (ID_Cupon,ID_Ciudad)
SELECT c.ID, ciu.ID FROM GRUPO_N.Cupon c
INNER JOIN GRUPO_N.Proveedor p ON  p.ID=c.ID_Proveedor 
INNER JOIN 
(SELECT distinct  substring(m.Groupon_Codigo,1,10) as codigo, Provee_Ciudad FROM gd_esquema.Maestra m 
WHERE m.Groupon_Devolucion_Fecha IS NULL AND m.Groupon_Entregado_Fecha IS NULL AND m.Factura_Fecha IS NULL AND m.Provee_RS IS NOT NULL)
 m ON m.codigo = c.Codigo  
INNER JOIN GRUPO_N.Ciudad ciu ON  ciu.Descripcion = m.Provee_Ciudad
GO

--Ingresando la compra de los cupones
PRINT 'Ingresando la compra de los cupones...'
GO
DECLARE
@Id_Rol_Cliente int

SET @Id_Rol_Cliente = GRUPO_N.GetIdRolByName('Cliente');

INSERT INTO GRUPO_N.CompraCupon (ID_Cliente, ID_Cupon, Codigo, Fecha) 
SELECT u.ID, c.ID, Groupon_Codigo,Groupon_Fecha_Compra 
	FROM gd_esquema.Maestra m 
	INNER JOIN GRUPO_N.Usuario u ON u.Nombre = m.Cli_Telefono
	INNER JOIN GRUPO_N.Cupon c ON c.Codigo=substring(m.Groupon_Codigo,1,10) 
	INNER JOIN GRUPO_N.Proveedor p ON c.ID_Proveedor= p.ID
	WHERE Groupon_Fecha_Compra IS NOT NULL AND Groupon_Devolucion_Fecha IS NULL
	  AND Groupon_Entregado_Fecha IS NULL AND Factura_Fecha IS NULL AND u.ID_Rol =@Id_Rol_Cliente AND m.Provee_RS = p.RazonSocial
GO
--Ingresando la devolucion de los cupones
PRINT 'Ingresando la devolucion de los cupones...'
GO
INSERT INTO GRUPO_N.Devolucion(ID_CompraCupon, ID_Cliente, Fecha, Motivo)
SELECT cc.ID, u.ID_Usuario,Groupon_Devolucion_Fecha, 'Devolucion en sistema previo' FROM gd_esquema.Maestra m 
INNER JOIN GRUPO_N.DetalleEntidad u ON u.Telefono = m.Cli_Telefono
INNER JOIN GRUPO_N.Proveedor p ON p.RazonSocial=m.Provee_RS
INNER JOIN GRUPO_N.CompraCupon cc ON cc.ID_Cliente=u.ID_Usuario AND cc.Codigo = m.Groupon_Codigo and cc.Fecha=m.Groupon_Fecha_Compra 								 										 
WHERE Groupon_Devolucion_Fecha IS NOT NULL
GO  
--Ingresando el retiro de cupones
PRINT 'Ingresando el retiro de cupones...'
GO
INSERT INTO GRUPO_N.CanjeCupon(Fecha,ID_CompraCupon)
SELECT Groupon_Entregado_Fecha, cc.ID FROM gd_esquema.Maestra m 
INNER JOIN GRUPO_N.DetalleEntidad u ON u.Telefono = m.Cli_Telefono
INNER JOIN GRUPO_N.Proveedor p ON p.RazonSocial=m.Provee_RS
INNER JOIN GRUPO_N.CompraCupon cc ON cc.ID_Cliente=u.ID_Usuario AND cc.Codigo = m.Groupon_Codigo and cc.Fecha=m.Groupon_Fecha_Compra 										 
WHERE Groupon_Entregado_Fecha IS NOT NULL
GO
--Ingresando la facturacion de los cupones
PRINT 'Ingresando la facturacion de los cupones...'
GO
INSERT INTO GRUPO_N.Factura(Numero, Fecha, ID_Proveedor)
SELECT DISTINCT m.Factura_Nro,m.Factura_Fecha, p.ID FROM gd_esquema.Maestra m 
INNER JOIN GRUPO_N.Proveedor p ON p.RazonSocial=m.Provee_RS
WHERE Factura_Fecha IS NOT NULL order by Factura_Nro asc
GO

INSERT INTO GRUPO_N.FacturasCanjesCupones (ID_Factura, ID_CanjeCupon)
SELECT (SELECT ID FROM GRUPO_N.Factura f WHERE f.Fecha=m.Factura_Fecha AND f.Numero=m.Factura_Nro AND f.ID_Proveedor=p.ID), canje.ID 
FROM gd_esquema.Maestra m 
INNER JOIN GRUPO_N.DetalleEntidad u ON u.Telefono = m.Cli_Telefono
INNER JOIN GRUPO_N.Proveedor p ON p.RazonSocial=m.Provee_RS
INNER JOIN GRUPO_N.CompraCupon cc ON cc.ID_Cliente=u.ID_Usuario AND cc.Codigo = m.Groupon_Codigo and cc.Fecha=m.Groupon_Fecha_Compra
INNER JOIN GRUPO_N.CanjeCupon canje ON canje.ID_CompraCupon= cc.ID
WHERE Factura_Fecha IS NOT NULL

--Ingresar los tipos de Pagos 
--PRINT 'Ingresar los tipos de Pagos...'
--GO
--INSERT INTO GRUPO_N.TipoPago (Descripcion) 
--SELECT DISTINCT
--      [Tipo_Pago_Desc]
--  FROM [GD2C2012].[gd_esquema].[Maestra]
--  WHERE Tipo_Pago_Desc IS NOT NULL
GO  
--Ingresando de las GiftCards
PRINT 'Ingresando de las GiftCards...'
GO
INSERT INTO GRUPO_N.GiftCard (ID_Cliente_Origen,ID_Cliente_Destino,Fecha,Credito)
SELECT u.ID, ud.ID, m.GiftCard_Fecha, m.GiftCard_Monto FROM gd_esquema.Maestra m
INNER JOIN GRUPO_N.Usuario u ON u.Nombre=CAST(m.Cli_Telefono AS NVARCHAR(255))
INNER JOIN GRUPO_N.Usuario ud ON ud.Nombre=CAST(m.Cli_Dest_Telefono AS NVARCHAR(255))
WHERE m.GiftCard_Fecha IS NOT NULL
GO
--Recalculo los saldos con un cursor
PRINT 'Recalculando los saldos...'
GO
DECLARE
@Id_Cliente int,
@Temp numeric(18,2),
@Saldo numeric(18,2)

DECLARE GRUPO_N_CLIENTES CURSOR FOR  
SELECT ID 
FROM GRUPO_N.Cliente

OPEN GRUPO_N_CLIENTES   
FETCH NEXT FROM GRUPO_N_CLIENTES INTO @Id_Cliente   

WHILE @@FETCH_STATUS = 0   
BEGIN   
	   -- Busco el saldo de carga de crédito que le suma saldo
       SELECT @Saldo=sum(Credito) FROM GRUPO_N.Pago WHERE ID_Cliente=@Id_Cliente
       
       -- Busco las giftcards que recibió que le suma saldo
       SELECT @Temp=sum(Credito) FROM GRUPO_N.GiftCard WHERE ID_Cliente_Destino=@Id_Cliente;
       SET @Saldo = @Saldo + @Temp 
       
       -- Busco los cupones que devolvió que le suma saldo
       SELECT @Temp=sum(c.Precio) FROM GRUPO_N.Devolucion dev 
		INNER JOIN GRUPO_N.CompraCupon cc ON cc.ID=dev.ID_CompraCupon
		INNER JOIN GRUPO_N.Cupon c ON c.ID = cc.ID_Cupon
		WHERE dev.ID_Cliente=@Id_Cliente;
		SET @Saldo = @Saldo + @Temp 
       
       -- Busco los cupones que compró que le resta saldo
       SELECT @Temp=sum(c.Precio)  FROM GRUPO_N.CompraCupon cc 
		INNER JOIN GRUPO_N.Cupon c ON cc.ID_Cupon=c.ID
		WHERE cc.ID_Cliente=@Id_Cliente;
		SET @Saldo = @Saldo - @Temp
		
       -- Busco las giftcard que envió que le resta saldo
       SELECT @Temp=sum(Credito) FROM GRUPO_N.GiftCard WHERE ID_Cliente_Origen=@Id_Cliente;
       SET @Saldo = @Saldo + @Temp       
       
       --Actualizo el saldo del tipo
       --PRINT 'Id ' + CAST(@Id_Cliente AS NVARCHAR(255)) + ' con saldo ' + CAST(@Saldo AS NVARCHAR(255))
       UPDATE GRUPO_N.Cliente SET Saldo=@Saldo WHERE ID=@Id_Cliente
		
       FETCH NEXT FROM GRUPO_N_CLIENTES INTO @Id_Cliente   
END   

CLOSE GRUPO_N_CLIENTES   
DEALLOCATE GRUPO_N_CLIENTES
GO

PRINT 'Creando usuario administrador...'
DECLARE @ID_Administrador_Inicial INT
DECLARE @ID_Detalle_Administrador_Inicial INT

INSERT INTO GRUPO_N.Usuario (Nombre, Password, ID_Rol)
VALUES ('Admin', 'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7', 1)
SET @ID_Administrador_Inicial = @@IDENTITY
INSERT INTO GRUPO_N.DetalleEntidad (ID_Usuario, Telefono) VALUES (@ID_Administrador_Inicial, 0)
SET @ID_Detalle_Administrador_Inicial = @@IDENTITY

INSERT INTO GRUPO_N.Direccion (Descripcion, ID_Ciudad, ID_Detalle) VALUES (' ', 1, @ID_Detalle_Administrador_Inicial)
INSERT INTO GRUPO_N.Cliente (ID, DNI, Nombre, Apellido, FechaNacimiento) VALUES (@ID_Administrador_Inicial, 0, 'Administrador', 'Administrador', GETDATE())
INSERT INTO GRUPO_N.ClienteCiudad (ID_Ciudad, ID_Cliente) SELECT ID, @ID_Administrador_Inicial FROM GRUPO_N.Ciudad
INSERT INTO GRUPO_N.Proveedor (CUIT, ID, ID_Rubro, RazonSocial) VALUES ('Administrador', @ID_Administrador_Inicial, 1, 'Administrador')
GO

PRINT 'Creando Triggers...'
IF OBJECT_ID ('GRUPO_N.CompraCuponInserted', 'TR') IS NOT NULL
   DROP TRIGGER GRUPO_N.CompraCuponInserted
GO
CREATE TRIGGER GRUPO_N.CompraCuponInserted
ON GRUPO_N.CompraCupon
AFTER INSERT
AS
BEGIN
	UPDATE GRUPO_N.Cliente SET
	Saldo = Saldo - T.Credito
	FROM GRUPO_N.Cliente c
	INNER JOIN (SELECT i.ID_Cliente, c.Precio Credito FROM Inserted i
				INNER JOIN Cupon c ON c.ID = i.ID_Cupon) AS T
	ON c.ID = T.ID_Cliente
	
	UPDATE GRUPO_N.Cupon SET
	Stock = Stock - 1
	FROM GRUPO_N.Cupon c
	INNER JOIN (SELECT ID_Cupon FROM Inserted) AS T
	ON c.ID = T.ID_Cupon
END

GO
IF OBJECT_ID ('GRUPO_N.DevolucionInserted', 'TR') IS NOT NULL
   DROP TRIGGER GRUPO_N.DevolucionInserted
GO
CREATE TRIGGER GRUPO_N.DevolucionInserted
ON GRUPO_N.Devolucion
AFTER INSERT
AS
BEGIN
	UPDATE GRUPO_N.Cliente SET
	Saldo = Saldo + c.Precio
	FROM GRUPO_N.Cupon c
	INNER JOIN GRUPO_N.CompraCupon cc
	ON c.ID = cc.ID_Cupon
	INNER JOIN (SELECT ID_CompraCupon FROM Inserted) AS T
	ON cc.ID = T.ID_CompraCupon
	
	UPDATE GRUPO_N.Cupon SET
	Stock = Stock + 1
	FROM GRUPO_N.Cupon c
	INNER JOIN GRUPO_N.CompraCupon cc
	ON c.ID = cc.ID_Cupon
	INNER JOIN (SELECT ID_CompraCupon FROM Inserted) AS T
	ON cc.ID = T.ID_CompraCupon
END
GO
IF OBJECT_ID ('GRUPO_N.GiftcardInserted', 'TR') IS NOT NULL
   DROP TRIGGER GRUPO_N.GiftcardInserted
GO
CREATE TRIGGER GRUPO_N.GiftcardInserted
ON GRUPO_N.GiftCard
AFTER INSERT
AS
BEGIN
	UPDATE GRUPO_N.Cliente SET
	Saldo = Saldo - T.Credito
	FROM GRUPO_N.Cliente c
	INNER JOIN (SELECT ID_Cliente_Origen ID_Cliente, Credito FROM Inserted) AS T
	ON c.ID = T.ID_Cliente
	
	UPDATE GRUPO_N.Cliente SET
	Saldo = Saldo + T.Credito
	FROM GRUPO_N.Cliente c
	INNER JOIN (SELECT ID_Cliente_Destino ID_Cliente, Credito FROM Inserted) AS T
	ON c.ID = T.ID_Cliente
END
GO

IF OBJECT_ID ('GRUPO_N.PagoInserted', 'TR') IS NOT NULL
   DROP TRIGGER GRUPO_N.PagoInserted
GO
CREATE TRIGGER GRUPO_N.PagoInserted
ON GRUPO_N.Pago
AFTER INSERT
AS
BEGIN
	UPDATE GRUPO_N.Cliente SET
	Saldo = Saldo + T.Credito
	FROM GRUPO_N.Cliente c
	INNER JOIN (SELECT ID_Cliente, Credito FROM Inserted) AS T
	ON c.ID = T.ID_Cliente
END
GO

PRINT 'Proceso finalizado con éxito!'
GO