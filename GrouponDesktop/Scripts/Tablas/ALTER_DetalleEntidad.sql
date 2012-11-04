/*
   domingo, 04 de noviembre de 201205:19:23 p.m.
   Usuario: 
   Servidor: localhost\SQLEXPRESS
   Base de datos: GD2C2012
   Aplicación: 
*/

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
ALTER TABLE GRUPO_N.DetalleEntidad
	DROP CONSTRAINT FK_DetalleEntidad_Usuario
GO
ALTER TABLE GRUPO_N.Usuario SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Usuario', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Usuario', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Usuario', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE GRUPO_N.Tmp_DetalleEntidad
	(
	ID int NOT NULL IDENTITY (1, 1),
	Telefono numeric(18, 0) NOT NULL,
	Email nvarchar(255) NULL,
	ID_Usuario int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE GRUPO_N.Tmp_DetalleEntidad SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT GRUPO_N.Tmp_DetalleEntidad ON
GO
IF EXISTS(SELECT * FROM GRUPO_N.DetalleEntidad)
	 EXEC('INSERT INTO GRUPO_N.Tmp_DetalleEntidad (ID, Telefono, Email, ID_Usuario)
		SELECT ID, Telefono, Email, ID_Usuario FROM GRUPO_N.DetalleEntidad WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT GRUPO_N.Tmp_DetalleEntidad OFF
GO
ALTER TABLE GRUPO_N.Cliente
	DROP CONSTRAINT FK_Ciente_DetalleEntidad
GO
ALTER TABLE GRUPO_N.Direccion
	DROP CONSTRAINT FK_Direccion_DetalleEntidad
GO
ALTER TABLE GRUPO_N.Proveedor
	DROP CONSTRAINT FK_Proveedor_DetalleEntidad
GO
DROP TABLE GRUPO_N.DetalleEntidad
GO
EXECUTE sp_rename N'GRUPO_N.Tmp_DetalleEntidad', N'DetalleEntidad', 'OBJECT' 
GO
ALTER TABLE GRUPO_N.DetalleEntidad ADD CONSTRAINT
	PK_DetalleEntidad PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE GRUPO_N.DetalleEntidad ADD CONSTRAINT
	FK_DetalleEntidad_Usuario FOREIGN KEY
	(
	ID_Usuario
	) REFERENCES GRUPO_N.Usuario
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.DetalleEntidad', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.DetalleEntidad', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.DetalleEntidad', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE GRUPO_N.Proveedor ADD CONSTRAINT
	FK_Proveedor_DetalleEntidad FOREIGN KEY
	(
	ID_Detalle
	) REFERENCES GRUPO_N.DetalleEntidad
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE GRUPO_N.Proveedor SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
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
select Has_Perms_By_Name(N'GRUPO_N.Direccion', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Direccion', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Direccion', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE GRUPO_N.Cliente ADD CONSTRAINT
	FK_Ciente_DetalleEntidad FOREIGN KEY
	(
	ID_Detalle
	) REFERENCES GRUPO_N.DetalleEntidad
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE GRUPO_N.Cliente SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Cliente', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Cliente', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Cliente', 'Object', 'CONTROL') as Contr_Per 