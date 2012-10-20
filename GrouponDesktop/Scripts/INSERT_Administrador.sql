INSERT INTO GRUPO_N.Rol (Descripcion) VALUES ('Administrador')

INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
SELECT 1, ID FROM GRUPO_N.Funcionalidad

INSERT INTO GRUPO_N.Usuario (Nombre, Password, ID_Rol)
VALUES ('Admin', 'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7', 1)