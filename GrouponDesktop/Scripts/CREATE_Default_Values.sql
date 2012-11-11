USE [GD2C2012]
GO
-- INSERT DE FUNCIONALIDADES
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('AdministrarClientes');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('AdministrarProveedores');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('AdministrarCupones');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('CargarCredito');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('CrearCupon');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('ComprarCupones');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('GiftCards');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('Facturar');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('VerHistorialCupones');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('ListarEstadisticas');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('PedirDevoluciones');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('PublicarCupones');
INSERT INTO GRUPO_N.Funcionalidad (Descripcion) VALUES ('RegistrarConsumoCupones');

--INSERT Usuario ADMINISTRADOR
INSERT INTO GRUPO_N.Rol (Descripcion) VALUES ('Administrativo');
INSERT INTO GRUPO_N.Rol (Descripcion) VALUES ('Proveedor');
INSERT INTO GRUPO_N.Rol (Descripcion) VALUES ('Cliente');

INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
SELECT 1, ID FROM GRUPO_N.Funcionalidad

INSERT INTO GRUPO_N.Usuario (Nombre, Password, ID_Rol)
VALUES ('Admin', 'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7', 1)

INSERT INTO GRUPO_N.TipoPago (Descripcion) VALUES ('Efectivo');
INSERT INTO GRUPO_N.TipoPago (Descripcion) VALUES ('Crédito');