USE [GD1C2012]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[GRUPO_N].[FK_Usuario_Rol]') AND parent_object_id = OBJECT_ID(N'[GRUPO_N].[Usuario]'))
ALTER TABLE [GRUPO_N].[Usuario] DROP CONSTRAINT [FK_Usuario_Rol]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Usuario_Intentos]') AND type = 'D')
BEGIN
ALTER TABLE [GRUPO_N].[Usuario] DROP CONSTRAINT [DF_Usuario_Intentos]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Usuario_Activo]') AND type = 'D')
BEGIN
ALTER TABLE [GRUPO_N].[Usuario] DROP CONSTRAINT [DF_Usuario_Activo]
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
	[Activo] [bit] NOT NULL,
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

ALTER TABLE [GRUPO_N].[Usuario] ADD  CONSTRAINT [DF_Usuario_Activo]  DEFAULT ((1)) FOR [Activo]
GO

/* Para evitar posibles problemas de pérdida de datos, debe revisar este script detalladamente antes de ejecutarlo fuera del contexto del diseñador de base de datos.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX IX_Usuario ON GRUPO_N.Usuario
	(
	Nombre
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE GRUPO_N.Usuario SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
