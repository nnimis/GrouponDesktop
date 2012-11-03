﻿USE [GD1C2012]
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

ALTER TABLE [GRUPO_N].[Perfil]  WITH CHECK ADD  CONSTRAINT [FK_Perfil_Rol] FOREIGN KEY([ID_Rol])
REFERENCES [GRUPO_N].[Rol] ([ID])
GO

ALTER TABLE [GRUPO_N].[Perfil] CHECK CONSTRAINT [FK_Perfil_Rol]
GO


