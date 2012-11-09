USE [GD2C2012]
GO

DECLARE
@Id_Rol_Cliente int,
@Id_Rol_Proveedor int

-- Ingreso los clientes.

SET @Id_Rol_Cliente = GRUPO_N.GetIdRolByName('Cliente');

INSERT INTO GRUPO_N.Usuario (Activo,ID_Rol,Intentos,Nombre,Password)
SELECT DISTINCT 1,@Id_Rol_Cliente,0,Cli_telefono,'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7' 
FROM gd_esquema.Maestra WHERE 1=1;

INSERT INTO GRUPO_N.DetalleEntidad (Email,ID_Usuario,Telefono) 
SELECT distinct m.Cli_Mail, u.ID, m.Cli_Telefono FROM gd_esquema.Maestra m INNER JOIN GRUPO_N.Usuario u ON CAST(m.Cli_Telefono AS NVARCHAR(255))=u.Nombre 
WHERE m.Groupon_Devolucion_Fecha IS NULL AND m.Groupon_Entregado_Fecha IS NULL AND m.Factura_Fecha IS NULL

INSERT INTO GRUPO_N.Cliente (Apellido,DNI,FechaNacimiento,ID,Nombre,saldo)
SELECT DISTINCT m.Cli_Apellido, m.Cli_Dni, m.Cli_Fecha_Nac, u.ID, m.Cli_Nombre, 0 FROM GRUPO_N.Usuario u 
INNER JOIN gd_esquema.Maestra m ON u.Nombre = CAST(m.Cli_Telefono AS NVARCHAR(255))
WHERE u.ID_Rol = @Id_Rol_Cliente;

--Ingreso las ciudades de lso diferentes proveedores 
INSERT INTO GRUPO_N.Ciudad (Descripcion) 
SELECT DISTINCT Provee_Ciudad FROM gd_esquema.Maestra WHERE Provee_Ciudad IS NOT NULL;

--Ingreso los rubros de los proveedores
INSERT INTO GRUPO_N.Rubro (Descripcion) 
SELECT DISTINCT Provee_Rubro FROM gd_esquema.Maestra WHERE Provee_Rubro IS NOT NULL;

--Ingreso los proveedores
SET @Id_Rol_Proveedor = GRUPO_N.GetIdRolByName('Proveedor');

INSERT INTO GRUPO_N.Usuario (Activo,ID_Rol,Intentos,Nombre,Password)
SELECT DISTINCT 1,@Id_Rol_Proveedor,0,Provee_RS,'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7' 
FROM gd_esquema.Maestra WHERE Provee_RS IS NOT NULL;

INSERT INTO GRUPO_N.DetalleEntidad (Email,ID_Usuario,Telefono) 
SELECT distinct NULL, u.ID, m.Provee_Telefono FROM gd_esquema.Maestra m INNER JOIN GRUPO_N.Usuario u ON CAST(m.Provee_RS AS NVARCHAR(255))=u.Nombre 
WHERE m.Groupon_Devolucion_Fecha IS NULL AND m.Groupon_Entregado_Fecha IS NULL AND m.Factura_Fecha IS NULL

INSERT INTO GRUPO_N.Proveedor (Contacto,CUIT,ID,ID_Rubro,RazonSocial)
SELECT DISTINCT NULL,M.Provee_CUIT, u.ID ,r.ID,M.Provee_RS
FROM gd_esquema.Maestra m
INNER JOIN GRUPO_N.Usuario u ON u.Nombre=m.Provee_RS
INNER JOIN GRUPO_N.Rubro r ON r.Descripcion=m.Provee_Rubro

--Ingreso los cupones
INSERT INTO GRUPO_N.Cupon (Precio, PrecioOriginal, FechaPublicacion,FechaVigencia,FechaVencimmiento,Stock,Descripcion,ID_Proveedor,CantidadPorUsuario,Publicado) --,Codigo)
SELECT distinct [Groupon_Precio_Ficticio], [Groupon_Precio] ,[Groupon_Fecha] ,[Groupon_Fecha_Venc], DATEADD(MONTH,2,[Groupon_Fecha_Venc]) ,[Groupon_Cantidad] ,[Groupon_Descripcion],p.ID,[Groupon_Cantidad], 1 --, GRUPO_N.RemoveNonAlphaCharacters(m.Groupon_Codigo)
  FROM [GD2C2012].[gd_esquema].[Maestra] m
  INNER JOIN GRUPO_N.Proveedor p ON m.Provee_RS=p.RazonSocial WHERE Provee_RS IS NOT NULL 
  
--Ingreso la compra de los cupones
INSERT INTO GRUPO_N.CompraCupon (ID_Cliente, ID_Cupon, Codigo, Fecha) 
SELECT u.ID, c.ID, Groupon_Codigo,Groupon_Fecha_Compra FROM gd_esquema.Maestra m 
INNER JOIN GRUPO_N.Usuario u ON u.Nombre = m.Cli_Telefono
INNER JOIN GRUPO_N.Cupon c ON c.Precio = m.Groupon_Precio_Ficticio and c.PrecioOriginal=m.Groupon_Precio AND
										 c.FechaPublicacion = m.Groupon_Fecha AND c.FechaVigencia = m.Groupon_Fecha_Venc AND
										 c.Stock = m.Groupon_Cantidad AND c.Descripcion = m.Groupon_Descripcion 
INNER JOIN GRUPO_N.Proveedor p ON c.ID_Proveedor= p.ID
WHERE Groupon_Fecha_Compra IS NOT NULL AND u.ID_Rol =@Id_Rol_Cliente AND m.Provee_RS = p.RazonSocial

--Ingreso la devolucion de los cupones
INSERT INTO GRUPO_N.Devolucion(ID_CompraCupon, ID_Cliente, Fecha, Motivo)
SELECT c.ID, u.ID, Groupon_Codigo,Groupon_Devolucion_Fecha, 'Devolucion en sistema previo' FROM gd_esquema.Maestra m 
INNER JOIN GRUPO_N.Usuario u ON u.Nombre = m.Cli_Telefono
INNER JOIN GRUPO_N.Cupon c ON c.Precio = m.Groupon_Precio_Ficticio and c.PrecioOriginal=m.Groupon_Precio AND
										 c.FechaPublicacion = m.Groupon_Fecha AND c.FechaVigencia = m.Groupon_Fecha_Venc AND
										 c.Stock = m.Groupon_Cantidad AND c.Descripcion = m.Groupon_Descripcion 
INNER JOIN GRUPO_N.Proveedor p ON c.ID_Proveedor= p.ID
WHERE Groupon_Devolucion_Fecha IS NOT NULL AND u.ID_Rol =@Id_Rol_Cliente AND m.Provee_RS = p.RazonSocial
  
--Ingreso el retiro de cupones
INSERT INTO GRUPO_N.CanjeCupon(Fecha, ID_CompraCupon)
SELECT Groupon_Entregado_Fecha, c.ID FROM gd_esquema.Maestra m 
INNER JOIN GRUPO_N.Cupon c ON c.Precio = m.Groupon_Precio_Ficticio and c.PrecioOriginal=m.Groupon_Precio AND
										 c.FechaPublicacion = m.Groupon_Fecha AND c.FechaVigencia = m.Groupon_Fecha_Venc AND
										 c.Stock = m.Groupon_Cantidad AND c.Descripcion = m.Groupon_Descripcion 
INNER JOIN GRUPO_N.Proveedor p ON c.ID_Proveedor= p.ID
WHERE Groupon_Entregado_Fecha IS NOT NULL AND m.Provee_RS = p.RazonSocial

--Ingreso la facturacion de los cupones
INSERT INTO GRUPO_N.Factura(Numero, Fecha)
SELECT Factura_Nro,Factura_Fecha FROM gd_esquema.Maestra WHERE Factura_Fecha IS NOT NULL

INSERT INTO GRUPO_N.FacturasCanjesCupones (ID_Factura, ID_CanjeCupon)
