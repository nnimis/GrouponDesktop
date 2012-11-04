/*
   domingo, 04 de noviembre de 201205:36:26 p.m.
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
ALTER TABLE GRUPO_N.Ciudad SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Ciudad', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Ciudad', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Ciudad', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE GRUPO_N.Proveedor
	DROP CONSTRAINT FK_Proveedor_DetalleEntidad
GO
ALTER TABLE GRUPO_N.DetalleEntidad SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.DetalleEntidad', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.DetalleEntidad', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.DetalleEntidad', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE GRUPO_N.Proveedor
	DROP CONSTRAINT FK_Proveedor_Rubro
GO
ALTER TABLE GRUPO_N.Rubro SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Rubro', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Rubro', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Rubro', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE GRUPO_N.Tmp_Proveedor
	(
	ID int NOT NULL IDENTITY (1, 1),
	RazonSocial nvarchar(100) NOT NULL,
	ID_Detalle int NOT NULL,
	CUIT nvarchar(20) NOT NULL,
	ID_Rubro int NOT NULL,
	ID_Ciudad int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE GRUPO_N.Tmp_Proveedor SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT GRUPO_N.Tmp_Proveedor ON
GO
IF EXISTS(SELECT * FROM GRUPO_N.Proveedor)
	 EXEC('INSERT INTO GRUPO_N.Tmp_Proveedor (ID, RazonSocial, ID_Detalle, CUIT, ID_Rubro)
		SELECT ID, RazonSocial, ID_Detalle, CUIT, ID_Rubro FROM GRUPO_N.Proveedor WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT GRUPO_N.Tmp_Proveedor OFF
GO
ALTER TABLE GRUPO_N.Cupon
	DROP CONSTRAINT FK_Cupon_Proveedor
GO
DROP TABLE GRUPO_N.Proveedor
GO
EXECUTE sp_rename N'GRUPO_N.Tmp_Proveedor', N'Proveedor', 'OBJECT' 
GO
ALTER TABLE GRUPO_N.Proveedor ADD CONSTRAINT
	PK_Proveedor PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE GRUPO_N.Proveedor ADD CONSTRAINT
	FK_Proveedor_Rubro FOREIGN KEY
	(
	ID_Rubro
	) REFERENCES GRUPO_N.Rubro
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
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
ALTER TABLE GRUPO_N.Proveedor ADD CONSTRAINT
	FK_Proveedor_Ciudad FOREIGN KEY
	(
	ID_Ciudad
	) REFERENCES GRUPO_N.Ciudad
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE GRUPO_N.Cupon ADD CONSTRAINT
	FK_Cupon_Proveedor FOREIGN KEY
	(
	ID_Proveedor
	) REFERENCES GRUPO_N.Proveedor
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE GRUPO_N.Cupon SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Cupon', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Cupon', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Cupon', 'Object', 'CONTROL') as Contr_Per 