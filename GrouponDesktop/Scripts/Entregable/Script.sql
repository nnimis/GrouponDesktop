USE [master]
GO

/****** Object:  Database [GD2C2012]    Script Date: 10/20/2012 11:55:02 ******/
CREATE DATABASE [GD2C2012] ON  PRIMARY 
( NAME = N'GD2C2012', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\GD2C2012.mdf' , SIZE = 1011712KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'GD2C2012_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\GD2C2012_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [GD2C2012] SET COMPATIBILITY_LEVEL = 100
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GD2C2012].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [GD2C2012] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [GD2C2012] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [GD2C2012] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [GD2C2012] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [GD2C2012] SET ARITHABORT OFF 
GO

ALTER DATABASE [GD2C2012] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [GD2C2012] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [GD2C2012] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [GD2C2012] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [GD2C2012] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [GD2C2012] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [GD2C2012] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [GD2C2012] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [GD2C2012] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [GD2C2012] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [GD2C2012] SET  DISABLE_BROKER 
GO

ALTER DATABASE [GD2C2012] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [GD2C2012] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [GD2C2012] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [GD2C2012] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [GD2C2012] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [GD2C2012] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [GD2C2012] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [GD2C2012] SET  READ_WRITE 
GO

ALTER DATABASE [GD2C2012] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [GD2C2012] SET  MULTI_USER 
GO

ALTER DATABASE [GD2C2012] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [GD2C2012] SET DB_CHAINING OFF 
GO

USE [GD2C2012]
GO
/****** Object:  Schema [GRUPO_N]    Script Date: 10/20/2012 11:58:15 ******/
CREATE SCHEMA [GRUPO_N] AUTHORIZATION [gd]
GO

/****** Object:  Table [GRUPO_N].[Funcionalidad]    Script Date: 10/20/2012 11:59:17 ******/
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
/****** Object:  Table [GRUPO_N].[Factura]    Script Date: 10/20/2012 11:59:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Factura](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Numero] [numeric](18, 0) NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Factura] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[TipoPago]    Script Date: 10/20/2012 11:59:17 ******/
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
/****** Object:  Table [GRUPO_N].[Rol]    Script Date: 10/20/2012 11:59:17 ******/
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
/****** Object:  Table [GRUPO_N].[Ciudad]    Script Date: 10/20/2012 11:59:17 ******/
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
/****** Object:  Table [GRUPO_N].[Rubro]    Script Date: 10/20/2012 11:59:17 ******/
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
/****** Object:  Table [GRUPO_N].[Usuario]    Script Date: 10/20/2012 11:59:17 ******/
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
/****** Object:  Table [GRUPO_N].[RolesFuncionalidades]    Script Date: 10/20/2012 11:59:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[RolesFuncionalidades](
	[ID_Rol] [int] NOT NULL,
	[ID_Funcionalidad] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[DetalleEntidad]    Script Date: 10/20/2012 11:59:17 ******/
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[Proveedor]    Script Date: 10/20/2012 11:59:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Proveedor](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RazonSocial] [nvarchar](100) NOT NULL,
	[ID_Detalle] [int] NOT NULL,
	[CUIT] [nvarchar](20) NOT NULL,
	[ID_Rubro] [int] NOT NULL,
 CONSTRAINT [PK_Proveedor] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[Direccion]    Script Date: 10/20/2012 11:59:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Direccion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](255) NOT NULL,
	[ID_Ciudad] [int] NOT NULL,
	[ID_Detalle] [int] NOT NULL,
 CONSTRAINT [PK_Direccion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[Cliente]    Script Date: 10/20/2012 11:59:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Cliente](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DNI] [numeric](18, 0) NOT NULL,
	[Nombre] [nvarchar](255) NOT NULL,
	[Apellido] [nchar](255) NOT NULL,
	[FechaNacimiento] [datetime] NOT NULL,
	[ID_Detalle] [int] NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[ClienteCiudad]    Script Date: 10/20/2012 11:59:17 ******/
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
/****** Object:  Table [GRUPO_N].[Cupon]    Script Date: 10/20/2012 11:59:17 ******/
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
	[FechaVencimmiento] [datetime] NOT NULL,
	[Stock] [numeric](18, 0) NOT NULL,
	[Descripcion] [nvarchar](255) NOT NULL,
	[ID_Proveedor] [int] NOT NULL,
	[CantidadPorUsuario] [int] NOT NULL,
	[Publicado] [bit] NOT NULL,
 CONSTRAINT [PK_Cupon] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[Pago]    Script Date: 10/20/2012 11:59:17 ******/
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
/****** Object:  Table [GRUPO_N].[GiftCard]    Script Date: 10/20/2012 11:59:17 ******/
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
/****** Object:  Table [GRUPO_N].[Tarjeta]    Script Date: 10/20/2012 11:59:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Tarjeta](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](255) NOT NULL,
	[ID_Cliente] [int] NOT NULL,
 CONSTRAINT [PK_Tarjeta] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[PagosTarjetas]    Script Date: 10/20/2012 11:59:17 ******/
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
/****** Object:  Table [GRUPO_N].[Devolucion]    Script Date: 10/20/2012 11:59:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [GRUPO_N].[Devolucion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_Cupon] [int] NOT NULL,
	[ID_Cliente] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Motivo] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Devolucion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [GRUPO_N].[CuponCiudad]    Script Date: 10/20/2012 11:59:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[CuponCiudad](
	[ID_Cupon] [int] NOT NULL,
	[ID_Ciudad] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [GRUPO_N].[CompraCupon]    Script Date: 10/20/2012 11:59:17 ******/
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
/****** Object:  Table [GRUPO_N].[CanjeCupon]    Script Date: 10/20/2012 11:59:17 ******/
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
/****** Object:  Table [GRUPO_N].[FacturasCanjesCupones]    Script Date: 10/20/2012 11:59:17 ******/
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

/****** Object:  Table [GRUPO_N].[Perfil]    Script Date: 11/03/2012 13:05:16 ******/
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

/****** Object:  ForeignKey [FK_Perfil_Rol]    Script Date: 11/04/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[Perfil]  WITH CHECK ADD  CONSTRAINT [FK_Perfil_Rol] FOREIGN KEY([ID_Rol])
REFERENCES [GRUPO_N].[Rol] ([ID])
GO

ALTER TABLE [GRUPO_N].[Perfil] CHECK CONSTRAINT [FK_Perfil_Rol]
GO
/****** Object:  Default [DF_Cupon_Publicado]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[Cupon] ADD  CONSTRAINT [DF_Cupon_Publicado]  DEFAULT ((0)) FOR [Publicado]
GO
/****** Object:  ForeignKey [FK_CanjeCupon_CompraCupon]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[CanjeCupon]  WITH CHECK ADD  CONSTRAINT [FK_CanjeCupon_CompraCupon] FOREIGN KEY([ID_CompraCupon])
REFERENCES [GRUPO_N].[CompraCupon] ([ID])
GO
ALTER TABLE [GRUPO_N].[CanjeCupon] CHECK CONSTRAINT [FK_CanjeCupon_CompraCupon]
GO
/****** Object:  ForeignKey [FK_Cliente_DetalleEntidad]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_DetalleEntidad] FOREIGN KEY([ID_Detalle])
REFERENCES [GRUPO_N].[DetalleEntidad] ([ID])
GO
ALTER TABLE [GRUPO_N].[Cliente] CHECK CONSTRAINT [FK_Cliente_DetalleEntidad]
GO
/****** Object:  ForeignKey [FK_ClienteCiudad_Cliente]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[ClienteCiudad]  WITH CHECK ADD  CONSTRAINT [FK_ClienteCiudad_Cliente] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO
ALTER TABLE [GRUPO_N].[ClienteCiudad] CHECK CONSTRAINT [FK_ClienteCiudad_Cliente]
GO
/****** Object:  ForeignKey [FK_ClienteCiudad_Ciudad]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[ClienteCiudad]  WITH CHECK ADD  CONSTRAINT [FK_ClienteCiudad_Ciudad] FOREIGN KEY([ID_Ciudad])
REFERENCES [GRUPO_N].[Ciudad] ([ID])
GO
ALTER TABLE [GRUPO_N].[ClienteCiudad] CHECK CONSTRAINT [FK_ClienteCiudad_Ciudad]
GO
/****** Object:  ForeignKey [FK_CompraCupon_Cliente]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[CompraCupon]  WITH CHECK ADD  CONSTRAINT [FK_CompraCupon_Cliente] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO
ALTER TABLE [GRUPO_N].[CompraCupon] CHECK CONSTRAINT [FK_CompraCupon_Cliente]
GO
/****** Object:  ForeignKey [FK_CompraCupon_Cupon]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[CompraCupon]  WITH CHECK ADD  CONSTRAINT [FK_CompraCupon_Cupon] FOREIGN KEY([ID_Cupon])
REFERENCES [GRUPO_N].[Cupon] ([ID])
GO
ALTER TABLE [GRUPO_N].[CompraCupon] CHECK CONSTRAINT [FK_CompraCupon_Cupon]
GO
/****** Object:  ForeignKey [FK_Cupon_Proveedor]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[Cupon]  WITH CHECK ADD  CONSTRAINT [FK_Cupon_Proveedor] FOREIGN KEY([ID_Proveedor])
REFERENCES [GRUPO_N].[Proveedor] ([ID])
GO
ALTER TABLE [GRUPO_N].[Cupon] CHECK CONSTRAINT [FK_Cupon_Proveedor]
GO
/****** Object:  ForeignKey [FK_CuponCiudad_Ciudad]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[CuponCiudad]  WITH CHECK ADD  CONSTRAINT [FK_CuponCiudad_Ciudad] FOREIGN KEY([ID_Ciudad])
REFERENCES [GRUPO_N].[Ciudad] ([ID])
GO
ALTER TABLE [GRUPO_N].[CuponCiudad] CHECK CONSTRAINT [FK_CuponCiudad_Ciudad]
GO
/****** Object:  ForeignKey [FK_CuponCiudad_Cupon]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[CuponCiudad]  WITH CHECK ADD  CONSTRAINT [FK_CuponCiudad_Cupon] FOREIGN KEY([ID_Cupon])
REFERENCES [GRUPO_N].[Cupon] ([ID])
GO
ALTER TABLE [GRUPO_N].[CuponCiudad] CHECK CONSTRAINT [FK_CuponCiudad_Cupon]
GO
/****** Object:  ForeignKey [FK_DetalleEntidad_Usuario]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[DetalleEntidad]  WITH CHECK ADD  CONSTRAINT [FK_DetalleEntidad_Usuario] FOREIGN KEY([ID_Usuario])
REFERENCES [GRUPO_N].[Usuario] ([ID])
GO
ALTER TABLE [GRUPO_N].[DetalleEntidad] CHECK CONSTRAINT [FK_DetalleEntidad_Usuario]
GO
/****** Object:  ForeignKey [FK_Devolucion_Cliente]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[Devolucion]  WITH CHECK ADD  CONSTRAINT [FK_Devolucion_Cliente] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO
ALTER TABLE [GRUPO_N].[Devolucion] CHECK CONSTRAINT [FK_Devolucion_Cliente]
GO
/****** Object:  ForeignKey [FK_Devolucion_Cupon]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[Devolucion]  WITH CHECK ADD  CONSTRAINT [FK_Devolucion_Cupon] FOREIGN KEY([ID_Cupon])
REFERENCES [GRUPO_N].[Cupon] ([ID])
GO
ALTER TABLE [GRUPO_N].[Devolucion] CHECK CONSTRAINT [FK_Devolucion_Cupon]
GO
/****** Object:  ForeignKey [FK_Direccion_Ciudad]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[Direccion]  WITH CHECK ADD  CONSTRAINT [FK_Direccion_Ciudad] FOREIGN KEY([ID_Ciudad])
REFERENCES [GRUPO_N].[Ciudad] ([ID])
GO
ALTER TABLE [GRUPO_N].[Direccion] CHECK CONSTRAINT [FK_Direccion_Ciudad]
GO
/****** Object:  ForeignKey [FK_Direccion_DetalleEntidad]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[Direccion]  WITH CHECK ADD  CONSTRAINT [FK_Direccion_DetalleEntidad] FOREIGN KEY([ID_Detalle])
REFERENCES [GRUPO_N].[DetalleEntidad] ([ID])
GO
ALTER TABLE [GRUPO_N].[Direccion] CHECK CONSTRAINT [FK_Direccion_DetalleEntidad]
GO
/****** Object:  ForeignKey [FK_FacturasCanjesCupones_CanjeCupon]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[FacturasCanjesCupones]  WITH CHECK ADD  CONSTRAINT [FK_FacturasCanjesCupones_CanjeCupon] FOREIGN KEY([ID_CanjeCupon])
REFERENCES [GRUPO_N].[CanjeCupon] ([ID])
GO
ALTER TABLE [GRUPO_N].[FacturasCanjesCupones] CHECK CONSTRAINT [FK_FacturasCanjesCupones_CanjeCupon]
GO
/****** Object:  ForeignKey [FK_FacturasCanjesCupones_Factura]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[FacturasCanjesCupones]  WITH CHECK ADD  CONSTRAINT [FK_FacturasCanjesCupones_Factura] FOREIGN KEY([ID_Factura])
REFERENCES [GRUPO_N].[Factura] ([ID])
GO
ALTER TABLE [GRUPO_N].[FacturasCanjesCupones] CHECK CONSTRAINT [FK_FacturasCanjesCupones_Factura]
GO
/****** Object:  ForeignKey [FK_GiftCard_Cliente_Destino]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[GiftCard]  WITH CHECK ADD  CONSTRAINT [FK_GiftCard_Cliente_Destino] FOREIGN KEY([ID_Cliente_Destino])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO
ALTER TABLE [GRUPO_N].[GiftCard] CHECK CONSTRAINT [FK_GiftCard_Cliente_Destino]
GO
/****** Object:  ForeignKey [FK_GiftCard_Cliente_Origen]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[GiftCard]  WITH CHECK ADD  CONSTRAINT [FK_GiftCard_Cliente_Origen] FOREIGN KEY([ID_Cliente_Origen])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO
ALTER TABLE [GRUPO_N].[GiftCard] CHECK CONSTRAINT [FK_GiftCard_Cliente_Origen]
GO
/****** Object:  ForeignKey [FK_Pago_Cliente]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[Pago]  WITH CHECK ADD  CONSTRAINT [FK_Pago_Cliente] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO
ALTER TABLE [GRUPO_N].[Pago] CHECK CONSTRAINT [FK_Pago_Cliente]
GO
/****** Object:  ForeignKey [FK_Pago_TipoPago]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[Pago]  WITH CHECK ADD  CONSTRAINT [FK_Pago_TipoPago] FOREIGN KEY([ID_TipoPago])
REFERENCES [GRUPO_N].[TipoPago] ([ID])
GO
ALTER TABLE [GRUPO_N].[Pago] CHECK CONSTRAINT [FK_Pago_TipoPago]
GO
/****** Object:  ForeignKey [FK_PagosTarjetas_Pago]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[PagosTarjetas]  WITH CHECK ADD  CONSTRAINT [FK_PagosTarjetas_Pago] FOREIGN KEY([ID_Tarjeta])
REFERENCES [GRUPO_N].[Pago] ([ID])
GO
ALTER TABLE [GRUPO_N].[PagosTarjetas] CHECK CONSTRAINT [FK_PagosTarjetas_Pago]
GO
/****** Object:  ForeignKey [FK_PagosTarjetas_Tarjeta]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[PagosTarjetas]  WITH CHECK ADD  CONSTRAINT [FK_PagosTarjetas_Tarjeta] FOREIGN KEY([ID_Tarjeta])
REFERENCES [GRUPO_N].[Tarjeta] ([ID])
GO
ALTER TABLE [GRUPO_N].[PagosTarjetas] CHECK CONSTRAINT [FK_PagosTarjetas_Tarjeta]
GO
/****** Object:  ForeignKey [FK_Proveedor_DetalleEntidad]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[Proveedor]  WITH CHECK ADD  CONSTRAINT [FK_Proveedor_DetalleEntidad] FOREIGN KEY([ID_Detalle])
REFERENCES [GRUPO_N].[DetalleEntidad] ([ID])
GO
ALTER TABLE [GRUPO_N].[Proveedor] CHECK CONSTRAINT [FK_Proveedor_DetalleEntidad]
GO
/****** Object:  ForeignKey [FK_Proveedor_Rubro]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[Proveedor]  WITH CHECK ADD  CONSTRAINT [FK_Proveedor_Rubro] FOREIGN KEY([ID_Rubro])
REFERENCES [GRUPO_N].[Rubro] ([ID])
GO
ALTER TABLE [GRUPO_N].[Proveedor] CHECK CONSTRAINT [FK_Proveedor_Rubro]
GO
/****** Object:  ForeignKey [FK_RolesFuncionalidades_Funcionalidad]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[RolesFuncionalidades]  WITH CHECK ADD  CONSTRAINT [FK_RolesFuncionalidades_Funcionalidad] FOREIGN KEY([ID_Funcionalidad])
REFERENCES [GRUPO_N].[Funcionalidad] ([ID])
GO
ALTER TABLE [GRUPO_N].[RolesFuncionalidades] CHECK CONSTRAINT [FK_RolesFuncionalidades_Funcionalidad]
GO
/****** Object:  ForeignKey [FK_RolesFuncionalidades_Rol]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[RolesFuncionalidades]  WITH CHECK ADD  CONSTRAINT [FK_RolesFuncionalidades_Rol] FOREIGN KEY([ID_Rol])
REFERENCES [GRUPO_N].[Rol] ([ID])
GO
ALTER TABLE [GRUPO_N].[RolesFuncionalidades] CHECK CONSTRAINT [FK_RolesFuncionalidades_Rol]
GO
/****** Object:  ForeignKey [FK_Tarjeta_Cliente]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[Tarjeta]  WITH CHECK ADD  CONSTRAINT [FK_Tarjeta_Cliente] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO
ALTER TABLE [GRUPO_N].[Tarjeta] CHECK CONSTRAINT [FK_Tarjeta_Cliente]
GO
/****** Object:  ForeignKey [FK_Usuario_Rol]    Script Date: 10/20/2012 11:59:17 ******/
ALTER TABLE [GRUPO_N].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Rol] FOREIGN KEY([ID_Rol])
REFERENCES [GRUPO_N].[Rol] ([ID])
GO

ALTER TABLE [GRUPO_N].[Usuario] CHECK CONSTRAINT [FK_Usuario_Rol]
GO

ALTER TABLE [GRUPO_N].[Usuario] ADD  CONSTRAINT [DF_Usuario_Intentos]  DEFAULT ((0)) FOR [Intentos]
GO

ALTER TABLE [GRUPO_N].[Usuario] ADD  CONSTRAINT [DF_Usuario_Activo]  DEFAULT ((1)) FOR [Activo]
GO

ALTER TABLE [GRUPO_N].[Rol] ADD  CONSTRAINT [DF_Rol_Activo]  DEFAULT ((1)) FOR [Activo]
GO



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

--INSERT Usuario ADMINISTRADOR
INSERT INTO GRUPO_N.Rol (Descripcion) VALUES ('Administrativo');
INSERT INTO GRUPO_N.Rol (Descripcion) VALUES ('Proveedor');
INSERT INTO GRUPO_N.Rol (Descripcion) VALUES ('Cliente');

INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
SELECT 1, ID FROM GRUPO_N.Funcionalidad

INSERT INTO GRUPO_N.Usuario (Nombre, Password, ID_Rol)
VALUES ('Admin', 'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7', 1)






-- MIGRACION DE DATOS