/*
   sábado, 10 de noviembre de 201211:03:51 a.m.
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
ALTER TABLE GRUPO_N.Proveedor SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE GRUPO_N.Tmp_Factura
	(
	ID int NOT NULL IDENTITY (1, 1),
	Numero numeric(18, 0) NOT NULL,
	Fecha datetime NOT NULL,
	ID_Proveedor int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE GRUPO_N.Tmp_Factura SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT GRUPO_N.Tmp_Factura ON
GO
IF EXISTS(SELECT * FROM GRUPO_N.Factura)
	 EXEC('INSERT INTO GRUPO_N.Tmp_Factura (ID, Numero, Fecha)
		SELECT ID, Numero, Fecha FROM GRUPO_N.Factura WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT GRUPO_N.Tmp_Factura OFF
GO
ALTER TABLE GRUPO_N.FacturasCanjesCupones
	DROP CONSTRAINT FK_FacturasCanjesCupones_Factura
GO
DROP TABLE GRUPO_N.Factura
GO
EXECUTE sp_rename N'GRUPO_N.Tmp_Factura', N'Factura', 'OBJECT' 
GO
ALTER TABLE GRUPO_N.Factura ADD CONSTRAINT
	PK_Factura PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE GRUPO_N.Factura ADD CONSTRAINT
	FK_Factura_Proveedor FOREIGN KEY
	(
	ID
	) REFERENCES GRUPO_N.Proveedor
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Factura', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Factura', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Factura', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE GRUPO_N.FacturasCanjesCupones ADD CONSTRAINT
	FK_FacturasCanjesCupones_Factura FOREIGN KEY
	(
	ID_Factura
	) REFERENCES GRUPO_N.Factura
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE GRUPO_N.FacturasCanjesCupones SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.FacturasCanjesCupones', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.FacturasCanjesCupones', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.FacturasCanjesCupones', 'Object', 'CONTROL') as Contr_Per 