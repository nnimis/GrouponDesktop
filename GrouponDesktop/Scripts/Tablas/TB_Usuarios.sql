﻿USE [GD1C2012]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[GRUPO_N].[FK_Usuario_Rol]') AND parent_object_id = OBJECT_ID(N'[GRUPO_N].[Usuario]'))
ALTER TABLE [GRUPO_N].[Usuario] DROP CONSTRAINT [FK_Usuario_Rol]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Usuario_Intentos]') AND type = 'D')
BEGIN
ALTER TABLE [GRUPO_N].[Usuario] DROP CONSTRAINT [DF_Usuario_Intentos]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[Usuario]') AND type in (N'U'))
DROP TABLE [GRUPO_N].[Usuario]
GO

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
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [GRUPO_N].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Rol] FOREIGN KEY([ID_Rol])
REFERENCES [GRUPO_N].[Rol] ([ID])
GO

ALTER TABLE [GRUPO_N].[Usuario] CHECK CONSTRAINT [FK_Usuario_Rol]
GO

ALTER TABLE [GRUPO_N].[Usuario] ADD  CONSTRAINT [DF_Usuario_Intentos]  DEFAULT ((0)) FOR [Intentos]
GO