/*
   sábado, 10 de noviembre de 201211:57:27 a.m.
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
ALTER TABLE GRUPO_N.Factura
	DROP CONSTRAINT FK_Factura_Proveedor
GO
ALTER TABLE GRUPO_N.Proveedor SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE GRUPO_N.Factura ADD CONSTRAINT
	FK_Factura_Proveedor FOREIGN KEY
	(
	ID_Proveedor
	) REFERENCES GRUPO_N.Proveedor
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE GRUPO_N.Factura SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Factura', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Factura', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Factura', 'Object', 'CONTROL') as Contr_Per 