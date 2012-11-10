DELETE FROM GRUPO_N.RolesFuncionalidades

INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
SELECT 1, ID FROM GRUPO_N.Funcionalidad

INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
VALUES (GRUPO_N.GetIdRolByName('Cliente'), 4)
INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
VALUES (GRUPO_N.GetIdRolByName('Cliente'), 6)
INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
VALUES (GRUPO_N.GetIdRolByName('Cliente'), 7)
INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
VALUES (GRUPO_N.GetIdRolByName('Cliente'), 11)
INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
VALUES (GRUPO_N.GetIdRolByName('Cliente'), 9)

INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
VALUES (GRUPO_N.GetIdRolByName('Proveedor'), 5)
INSERT INTO GRUPO_N.RolesFuncionalidades (ID_Rol, ID_Funcionalidad)
VALUES (GRUPO_N.GetIdRolByName('Proveedor'), 13)