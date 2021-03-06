/*
   jueves, 08 de noviembre de 201210:01:31 a.m.
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
ALTER TABLE GRUPO_N.CompraCupon SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.CompraCupon', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.CompraCupon', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.CompraCupon', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE GRUPO_N.Devolucion
	DROP CONSTRAINT FK_Devolucion_Cupon
GO
ALTER TABLE GRUPO_N.Cupon SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Cupon', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Cupon', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Cupon', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE GRUPO_N.Devolucion ADD CONSTRAINT
	FK_Devolucion_CompraCupon FOREIGN KEY
	(
	ID_CompraCupon
	) REFERENCES GRUPO_N.CompraCupon
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE GRUPO_N.Devolucion SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Devolucion', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Devolucion', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Devolucion', 'Object', 'CONTROL') as Contr_Per 