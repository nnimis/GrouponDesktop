USE [GD2C2012]
GO

BEGIN TRANSACTION

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[GRUPO_N].[FK_PagosTarjeta_Tarjeta]') AND parent_object_id = OBJECT_ID(N'[GRUPO_N].[PagosTarjetas]'))
ALTER TABLE GRUPO_N.[PagosTarjetas]
	DROP CONSTRAINT [FK_PagosTarjeta_Tarjeta]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[GRUPO_N].[FK_Cliente_Tarjeta]') AND parent_object_id = OBJECT_ID(N'[GRUPO_N].[Tarjeta]'))
ALTER TABLE [GRUPO_N].[Tarjeta] DROP CONSTRAINT [FK_Cliente_Tarjeta]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[Tarjeta]') AND type in (N'U'))
DROP TABLE [GRUPO_N].[Tarjeta]
GO

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

ALTER TABLE [GRUPO_N].[Tarjeta]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Tarjeta] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO

ALTER TABLE [GRUPO_N].[Tarjeta] CHECK CONSTRAINT [FK_Cliente_Tarjeta]
GO

ALTER TABLE [GRUPO_N].[PagosTarjetas]  WITH CHECK ADD  CONSTRAINT [FK_PagosTarjeta_Tarjeta] FOREIGN KEY([ID_Tarjeta])
REFERENCES [GRUPO_N].[Tarjeta] ([ID])
GO

ALTER TABLE [GRUPO_N].[PagosTarjetas] CHECK CONSTRAINT [FK_PagosTarjeta_Tarjeta]
GO

COMMIT