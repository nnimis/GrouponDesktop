/*
   domingo, 04 de noviembre de 201207:27:55 p.m.
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
CREATE TABLE GRUPO_N.Tmp_Rubro
	(
	ID int NOT NULL IDENTITY (1, 1),
	Descripcion nvarchar(100) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE GRUPO_N.Tmp_Rubro SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT GRUPO_N.Tmp_Rubro ON
GO
IF EXISTS(SELECT * FROM GRUPO_N.Rubro)
	 EXEC('INSERT INTO GRUPO_N.Tmp_Rubro (ID, Descripcion)
		SELECT ID, CONVERT(nvarchar(100), Descripcion) FROM GRUPO_N.Rubro WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT GRUPO_N.Tmp_Rubro OFF
GO
ALTER TABLE GRUPO_N.Proveedor
	DROP CONSTRAINT FK_Proveedor_Rubro
GO
DROP TABLE GRUPO_N.Rubro
GO
EXECUTE sp_rename N'GRUPO_N.Tmp_Rubro', N'Rubro', 'OBJECT' 
GO
ALTER TABLE GRUPO_N.Rubro ADD CONSTRAINT
	PK_Rubro PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Rubro', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Rubro', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Rubro', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
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
ALTER TABLE GRUPO_N.Proveedor SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'GRUPO_N.Proveedor', 'Object', 'CONTROL') as Contr_Per 