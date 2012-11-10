USE [GD2C2012]
GO

BEGIN TRANSACTION

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Ciente_Saldo]') AND type = 'D')
BEGIN
ALTER TABLE [GRUPO_N].[Cliente] DROP CONSTRAINT [DF_Ciente_Saldo]
END

ALTER TABLE GRUPO_N.Tarjeta
	DROP CONSTRAINT FK_Cliente_Tarjeta
GO

ALTER TABLE GRUPO_N.[Pago]
	DROP CONSTRAINT [FK_Cliente_Pago]
GO

ALTER TABLE GRUPO_N.[GiftCard]
	DROP CONSTRAINT [FK_Cliente_GiftcardO]
GO

ALTER TABLE GRUPO_N.[GiftCard]
	DROP CONSTRAINT [FK_Cliente_GiftcardD]
GO

ALTER TABLE GRUPO_N.[ClienteCiudad]
	DROP CONSTRAINT [FK_Cliente_Ciudad]
GO

ALTER TABLE GRUPO_N.[Devolucion]
	DROP CONSTRAINT [FK_Cliente_Devolucion]
GO

/****** Object:  Table [GRUPO_N].[Cliente]    Script Date: 11/06/2012 12:38:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[Cliente]') AND type in (N'U'))
DROP TABLE [GRUPO_N].[Cliente]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [GRUPO_N].[Cliente](
	[ID] int NOT NULL,
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

ALTER TABLE [GRUPO_N].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Usuario] FOREIGN KEY([ID])
REFERENCES [GRUPO_N].[Usuario] ([ID])
GO

ALTER TABLE GRUPO_N.CompraCupon ADD CONSTRAINT
	FK_CompraCupon_Cliente FOREIGN KEY
	(
	ID_Cliente
	) REFERENCES GRUPO_N.Cliente
	(
	ID
	) ON UPDATE  NO ACTION 
	ON DELETE  NO ACTION 
GO

ALTER TABLE GRUPO_N.Cliente ADD CONSTRAINT
	CK_Cliente_Saldo CHECK (Saldo >= 0)
GO

ALTER TABLE [GRUPO_N].[Cliente] CHECK CONSTRAINT [FK_Cliente_Usuario]
GO

ALTER TABLE [GRUPO_N].[Cliente] ADD  CONSTRAINT [DF_Ciente_Saldo]  DEFAULT ((10)) FOR [Saldo]
GO

ALTER TABLE [GRUPO_N].[Pago]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Pago] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO

ALTER TABLE [GRUPO_N].[Pago] CHECK CONSTRAINT [FK_Cliente_Pago]
GO

ALTER TABLE [GRUPO_N].[Tarjeta]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Tarjeta] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO

ALTER TABLE [GRUPO_N].[Tarjeta] CHECK CONSTRAINT [FK_Cliente_Tarjeta]
GO

ALTER TABLE [GRUPO_N].[GiftCard]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_GiftcardO] FOREIGN KEY([ID_Cliente_Origen])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO

ALTER TABLE [GRUPO_N].[GiftCard] CHECK CONSTRAINT [FK_Cliente_GiftcardO]
GO

ALTER TABLE [GRUPO_N].[GiftCard]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_GiftcardD] FOREIGN KEY([ID_Cliente_Destino])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO

ALTER TABLE [GRUPO_N].[GiftCard] CHECK CONSTRAINT [FK_Cliente_GiftcardD]
GO

ALTER TABLE [GRUPO_N].[ClienteCiudad]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Ciudad] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO

ALTER TABLE [GRUPO_N].[ClienteCiudad] CHECK CONSTRAINT [FK_Cliente_Ciudad]
GO

ALTER TABLE [GRUPO_N].[Devolucion]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Devolucion] FOREIGN KEY([ID_Cliente])
REFERENCES [GRUPO_N].[Cliente] ([ID])
GO

ALTER TABLE [GRUPO_N].[Devolucion] CHECK CONSTRAINT [FK_Cliente_Devolucion]
GO

COMMIT