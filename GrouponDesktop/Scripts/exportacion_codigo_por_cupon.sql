USE [GD2C2012]
GO

-- Ingreso los clientes.
PRINT 'Ingreso los clientes...'
GO
DECLARE
@Id_Rol_Cliente int

SET @Id_Rol_Cliente = GRUPO_N.GetIdRolByName('Cliente');

INSERT INTO GRUPO_N.Usuario (Activo,ID_Rol,Intentos,Nombre,Password)
SELECT DISTINCT 1,@Id_Rol_Cliente,0,LTRIM(RTRIM(CAST(Cli_telefono AS NVARCHAR(255)))),'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7' 
FROM gd_esquema.Maestra WHERE 1=1;

INSERT INTO GRUPO_N.DetalleEntidad (Email,ID_Usuario,Telefono) 
SELECT distinct m.Cli_Mail, u.ID, m.Cli_Telefono FROM gd_esquema.Maestra m INNER JOIN GRUPO_N.Usuario u ON CAST(m.Cli_Telefono AS NVARCHAR(255))=u.Nombre 
WHERE m.Groupon_Devolucion_Fecha IS NULL AND m.Groupon_Entregado_Fecha IS NULL AND m.Factura_Fecha IS NULL

INSERT INTO GRUPO_N.Cliente (Apellido,DNI,FechaNacimiento,ID,Nombre,saldo)
SELECT DISTINCT m.Cli_Apellido, m.Cli_Dni, m.Cli_Fecha_Nac, u.ID, m.Cli_Nombre, 0 FROM GRUPO_N.Usuario u 
INNER JOIN gd_esquema.Maestra m ON u.Nombre = CAST(m.Cli_Telefono AS NVARCHAR(255))
WHERE u.ID_Rol = @Id_Rol_Cliente;
GO
--Ingreso las ciudades de los diferentes proveedores 
PRINT 'Ingreso las ciudades de los diferentes proveedores y clientes...'
INSERT INTO GRUPO_N.Ciudad (Descripcion)
SELECT DISTINCT nombreCiudad FROM (SELECT distinct cli_ciudad as nombreCiudad FROM gd_esquema.Maestra WHERE Provee_RS IS NULL
UNION SELECT DISTINCT Provee_Ciudad as nombreCiudad FROM gd_esquema.Maestra WHERE Provee_RS IS NOT NULL) m

INSERT INTO GRUPO_N.ClienteCiudad (ID_Ciudad,ID_Cliente)
SELECT ciu.ID as ID_CIUDAD, U.ID AS ID_USUARIO  FROM (SELECT DISTINCT Cli_Telefono, Cli_Ciudad FROM gd_esquema.Maestra WHERE Provee_RS IS NULL) m 
	INNER JOIN GRUPO_N.Usuario u ON u.Nombre=CAST( m.Cli_Telefono AS NVARCHAR(255))
	INNER JOIN GRUPO_N.Ciudad ciu ON ciu.Descripcion = m.Cli_Ciudad

INSERT INTO GRUPO_N.Direccion (CP,Descripcion,ID_Ciudad,ID_Detalle)
SELECT NULL AS CP, m.Cli_Direccion, ciu.ID, de.ID as ID_Detalle 
FROM (SELECT DISTINCT Cli_Telefono, Cli_Ciudad, Cli_Direccion FROM gd_esquema.Maestra WHERE Provee_RS IS NULL) m 
	INNER JOIN GRUPO_N.DetalleEntidad de ON de.Telefono = m.Cli_Telefono 
	INNER JOIN GRUPO_N.Ciudad ciu ON ciu.Descripcion = m.Cli_Ciudad

GO
--Ingresar las cargas de crédito
PRINT 'Ingresar las cargas de crédito...'
GO
INSERT INTO GRUPO_N.Pago (Credito, Fecha, ID_TipoPago, ID_Cliente)
SELECT m.Carga_Credito, m.Carga_Fecha, tp.ID, u.ID
FROM gd_esquema.Maestra m 
INNER JOIN GRUPO_N.TipoPago tp ON tp.Descripcion=m.Tipo_Pago_Desc
INNER JOIN GRUPO_N.Usuario u ON u.Nombre=CAST(m.Cli_Telefono AS NVARCHAR(255))
GO
--Ingresar las tarjetas
PRINT 'Ingresar las tarjetas...'
GO
INSERT INTO GRUPO_N.Tarjeta (Banco, Numero, ID_Cliente)
SELECT DISTINCT 'Banco de importacion previa', 'Numero de importacion precia',  p.ID_Cliente FROM GRUPO_N.Pago p
INNER JOIN GRUPO_N.TipoPago tp ON tp.ID=p.ID_TipoPago
WHERE tp.Descripcion='Crédito'
GO
--Ingresar relacion tarjeta - carga
PRINT 'Ingresar relacion tarjeta - carga...'
GO
INSERT INTO GRUPO_N.PagosTarjetas (ID_Pago, ID_Tarjeta)
SELECT p.ID, t.ID FROM GRUPO_N.Pago p
INNER JOIN GRUPO_N.TipoPago tp ON tp.ID=p.ID_TipoPago
INNER JOIN GRUPO_N.Tarjeta t ON t.ID_Cliente=p.ID_Cliente
WHERE tp.Descripcion='Crédito'
GO
--Ingreso los rubros de los proveedores
PRINT 'Ingreso los rubros de los proveedores...'
GO

INSERT INTO GRUPO_N.Rubro (Descripcion) 
SELECT DISTINCT Provee_Rubro FROM gd_esquema.Maestra WHERE Provee_Rubro IS NOT NULL;

GO
--Ingreso los proveedores
PRINT 'Ingreso los proveedores...'
GO
DECLARE 
@Id_Rol_Proveedor int
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

INSERT INTO GRUPO_N.Direccion (CP,Descripcion,ID_Ciudad,ID_Detalle)
SELECT NULL AS CP, m.Provee_Dom, ciu.ID, de.ID as ID_Detalle 
FROM (SELECT DISTINCT Provee_RS, Provee_Ciudad, Provee_Dom FROM gd_esquema.Maestra WHERE Provee_RS IS NOT NULL) m 
	INNER JOIN GRUPO_N.Proveedor p ON p.RazonSocial = m.Provee_RS
	INNER JOIN GRUPO_N.DetalleEntidad de ON de.ID_Usuario = p.ID 
	INNER JOIN GRUPO_N.Ciudad ciu ON ciu.Descripcion = m.Provee_Ciudad
GO
--Ingreso los cupones
PRINT 'Ingreso los cupones...'
GO
INSERT INTO GRUPO_N.Cupon (Precio, PrecioOriginal, FechaPublicacion,FechaVigencia,FechaVencimiento,Stock,Descripcion,ID_Proveedor,CantidadPorUsuario,Publicado ,Codigo)
SELECT distinct [Groupon_Precio_Ficticio], [Groupon_Precio] ,[Groupon_Fecha] ,[Groupon_Fecha_Venc], DATEADD(MONTH,2,[Groupon_Fecha_Venc]) ,[Groupon_Cantidad] ,[Groupon_Descripcion],p.ID,[Groupon_Cantidad], 1 , substring(m.Groupon_Codigo,1,10)
  FROM [GD2C2012].[gd_esquema].[Maestra] m
  INNER JOIN GRUPO_N.Proveedor p ON m.Provee_RS=p.RazonSocial WHERE Provee_RS IS NOT NULL 
GO

--Ingreso las ciudades de los cupones
PRINT 'Ingreso las ciudades de los cupones...'
GO
INSERT INTO GRUPO_N.CuponCiudad (ID_Cupon,ID_Ciudad)
SELECT c.ID, ciu.ID FROM GRUPO_N.Cupon c
INNER JOIN GRUPO_N.Proveedor p ON  p.ID=c.ID_Proveedor 
INNER JOIN 
(SELECT distinct  substring(m.Groupon_Codigo,1,10) as codigo, Provee_Ciudad FROM gd_esquema.Maestra m 
WHERE m.Groupon_Devolucion_Fecha IS NULL AND m.Groupon_Entregado_Fecha IS NULL AND m.Factura_Fecha IS NULL AND m.Provee_RS IS NOT NULL)
 m ON m.codigo = c.Codigo  
INNER JOIN GRUPO_N.Ciudad ciu ON  ciu.Descripcion = m.Provee_Ciudad
GO

--Ingreso la compra de los cupones
PRINT 'Ingreso la compra de los cupones...'
GO
DECLARE
@Id_Rol_Cliente int

SET @Id_Rol_Cliente = GRUPO_N.GetIdRolByName('Cliente');

INSERT INTO GRUPO_N.CompraCupon (ID_Cliente, ID_Cupon, Codigo, Fecha) 
SELECT u.ID, c.ID, Groupon_Codigo,Groupon_Fecha_Compra 
	FROM gd_esquema.Maestra m 
	INNER JOIN GRUPO_N.Usuario u ON u.Nombre = m.Cli_Telefono
	INNER JOIN GRUPO_N.Cupon c ON c.Codigo=substring(m.Groupon_Codigo,1,10) 
	INNER JOIN GRUPO_N.Proveedor p ON c.ID_Proveedor= p.ID
	WHERE Groupon_Fecha_Compra IS NOT NULL AND Groupon_Devolucion_Fecha IS NULL
	  AND Groupon_Entregado_Fecha IS NULL AND Factura_Fecha IS NULL AND u.ID_Rol =@Id_Rol_Cliente AND m.Provee_RS = p.RazonSocial
GO
--Ingreso la devolucion de los cupones
PRINT 'Ingreso la devolucion de los cupones...'
GO
INSERT INTO GRUPO_N.Devolucion(ID_CompraCupon, ID_Cliente, Fecha, Motivo)
SELECT cc.ID, u.ID_Usuario,Groupon_Devolucion_Fecha, 'Devolucion en sistema previo' FROM gd_esquema.Maestra m 
INNER JOIN GRUPO_N.DetalleEntidad u ON u.Telefono = m.Cli_Telefono
INNER JOIN GRUPO_N.Proveedor p ON p.RazonSocial=m.Provee_RS
INNER JOIN GRUPO_N.CompraCupon cc ON cc.ID_Cliente=u.ID_Usuario AND cc.Codigo = m.Groupon_Codigo and cc.Fecha=m.Groupon_Fecha_Compra 								 										 
WHERE Groupon_Devolucion_Fecha IS NOT NULL
GO  
--Ingreso el retiro de cupones
PRINT 'Ingreso el retiro de cupones...'
GO
INSERT INTO GRUPO_N.CanjeCupon(Fecha,ID_CompraCupon)
SELECT Groupon_Entregado_Fecha, cc.ID FROM gd_esquema.Maestra m 
INNER JOIN GRUPO_N.DetalleEntidad u ON u.Telefono = m.Cli_Telefono
INNER JOIN GRUPO_N.Proveedor p ON p.RazonSocial=m.Provee_RS
INNER JOIN GRUPO_N.CompraCupon cc ON cc.ID_Cliente=u.ID_Usuario AND cc.Codigo = m.Groupon_Codigo and cc.Fecha=m.Groupon_Fecha_Compra 										 
WHERE Groupon_Entregado_Fecha IS NOT NULL
GO
--Ingreso la facturacion de los cupones
PRINT 'Ingreso la facturacion de los cupones...'
GO
INSERT INTO GRUPO_N.Factura(Numero, Fecha, ID_Proveedor)
SELECT DISTINCT m.Factura_Nro,m.Factura_Fecha, p.ID FROM gd_esquema.Maestra m 
INNER JOIN GRUPO_N.Proveedor p ON p.RazonSocial=m.Provee_RS
WHERE Factura_Fecha IS NOT NULL order by Factura_Nro asc
GO

INSERT INTO GRUPO_N.FacturasCanjesCupones (ID_Factura, ID_CanjeCupon)
SELECT (SELECT ID FROM GRUPO_N.Factura f WHERE f.Fecha=m.Factura_Fecha AND f.Numero=m.Factura_Nro AND f.ID_Proveedor=p.ID), canje.ID 
FROM gd_esquema.Maestra m 
INNER JOIN GRUPO_N.DetalleEntidad u ON u.Telefono = m.Cli_Telefono
INNER JOIN GRUPO_N.Proveedor p ON p.RazonSocial=m.Provee_RS
INNER JOIN GRUPO_N.CompraCupon cc ON cc.ID_Cliente=u.ID_Usuario AND cc.Codigo = m.Groupon_Codigo and cc.Fecha=m.Groupon_Fecha_Compra
INNER JOIN GRUPO_N.CanjeCupon canje ON canje.ID_CompraCupon= cc.ID
WHERE Factura_Fecha IS NOT NULL

--Ingresar los tipos de Pagos 
--PRINT 'Ingresar los tipos de Pagos...'
--GO
--INSERT INTO GRUPO_N.TipoPago (Descripcion) 
--SELECT DISTINCT
--      [Tipo_Pago_Desc]
--  FROM [GD2C2012].[gd_esquema].[Maestra]
--  WHERE Tipo_Pago_Desc IS NOT NULL
GO  
--Ingreso de las GiftCards
PRINT 'Ingreso de las GiftCards...'
GO
INSERT INTO GRUPO_N.GiftCard (ID_Cliente_Origen,ID_Cliente_Destino,Fecha,Credito)
SELECT u.ID, ud.ID, m.GiftCard_Fecha, m.GiftCard_Monto FROM gd_esquema.Maestra m
INNER JOIN GRUPO_N.Usuario u ON u.Nombre=CAST(m.Cli_Telefono AS NVARCHAR(255))
INNER JOIN GRUPO_N.Usuario ud ON ud.Nombre=CAST(m.Cli_Dest_Telefono AS NVARCHAR(255))
WHERE m.GiftCard_Fecha IS NOT NULL
GO
--Recalculo los saldos con un cursor
PRINT 'Recalculando los saldos...'
GO
DECLARE
@Id_Cliente int,
@Temp numeric(18,2),
@Saldo numeric(18,2)

DECLARE GRUPO_N_CLIENTES CURSOR FOR  
SELECT ID 
FROM GRUPO_N.Cliente

OPEN GRUPO_N_CLIENTES   
FETCH NEXT FROM GRUPO_N_CLIENTES INTO @Id_Cliente   

WHILE @@FETCH_STATUS = 0   
BEGIN   
	   -- Busco el saldo de carga de crédito que le suma saldo
       SELECT @Saldo=sum(Credito) FROM GRUPO_N.Pago WHERE ID_Cliente=@Id_Cliente
       
       -- Busco las giftcards que recibió que le suma saldo
       SELECT @Temp=sum(Credito) FROM GRUPO_N.GiftCard WHERE ID_Cliente_Destino=@Id_Cliente;
       SET @Saldo = @Saldo + @Temp 
       
       -- Busco los cupones que devolvió que le suma saldo
       SELECT @Temp=sum(c.Precio) FROM GRUPO_N.Devolucion dev 
		INNER JOIN GRUPO_N.CompraCupon cc ON cc.ID=dev.ID_CompraCupon
		INNER JOIN GRUPO_N.Cupon c ON c.ID = cc.ID_Cupon
		WHERE dev.ID_Cliente=@Id_Cliente;
		SET @Saldo = @Saldo + @Temp 
       
       -- Busco los cupones que compró que le resta saldo
       SELECT @Temp=sum(c.Precio)  FROM GRUPO_N.CompraCupon cc 
		INNER JOIN GRUPO_N.Cupon c ON cc.ID_Cupon=c.ID
		WHERE cc.ID_Cliente=@Id_Cliente;
		SET @Saldo = @Saldo - @Temp
		
       -- Busco las giftcard que envió que le resta saldo
       SELECT @Temp=sum(Credito) FROM GRUPO_N.GiftCard WHERE ID_Cliente_Origen=@Id_Cliente;
       SET @Saldo = @Saldo + @Temp       
       
       --Actualizo el saldo del tipo
       --PRINT 'Id ' + CAST(@Id_Cliente AS NVARCHAR(255)) + ' con saldo ' + CAST(@Saldo AS NVARCHAR(255))
       UPDATE GRUPO_N.Cliente SET Saldo=@Saldo WHERE ID=@Id_Cliente
		
       FETCH NEXT FROM GRUPO_N_CLIENTES INTO @Id_Cliente   
END   

CLOSE GRUPO_N_CLIENTES   
DEALLOCATE GRUPO_N_CLIENTES
GO

PRINT 'Proceso finalizado con éxito!'
GO