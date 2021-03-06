﻿BEGIN TRANSACTION
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
ALTER TABLE GRUPO_N.Direccion
	DROP CONSTRAINT FK_Direccion_DetalleEntidad
GO
ALTER TABLE GRUPO_N.DetalleEntidad ADD CONSTRAINT
	IX_DetalleEntidad_Telefono UNIQUE NONCLUSTERED 
	(
	Telefono
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE GRUPO_N.DetalleEntidad SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE GRUPO_N.Direccion ADD CONSTRAINT
	FK_Direccion_DetalleEntidad FOREIGN KEY
	(
	ID_Detalle
	) REFERENCES GRUPO_N.DetalleEntidad
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE GRUPO_N.Direccion SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
