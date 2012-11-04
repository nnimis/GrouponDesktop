-- Declaracion de variables para el cursor
DECLARE @Cli_Nombre nvarchar(255),
		@Cli_Apellido nvarchar(255),
		@Cli_DNI numeric(18,0),
		@Cli_Direccion nvarchar(255),
		@Cli_Telefono numeric(18,0),
		@Cli_Mail nvarchar(255),
		@Cli_Fecha_Nacimiento datetime, 
		@Cli_Ciudad nvarchar(255),
		@Credito_Monto numeric(18,2),
		@Credito_Fecha_Carga datetime,
		@Credito_Tipo_Pago nvarchar(100),
		@Cli_Destino_Nombre nvarchar(255),
		@Cli_Dest_Apellido nvarchar(255),
		@Cli_Dest_Dni numeric(18,0),
		@Cli_Dest_Direccion nvarchar(255),
		@Cli_Dest_Telefono numeric(18,0),
		@Cli_Dest_Mail nvarchar(255),
		@Cli_Dest_Fecha_Nac datetime,
		@Cli_Dest_Ciudad nvarchar(255),
		@GiftCard_Fecha datetime,
		@GiftCard_Monto numeric(18,2),
		@Provee_RS nvarchar(100),
		@Provee_Dom nvarchar(100),
		@Provee_Ciudad nvarchar(255) ,
		@Provee_Telefono numeric(18,0),
		@Provee_CUIT nvarchar(20),
		@Provee_Rubro nvarchar(100),
		@Groupon_Precio numeric(18,2),
		@Groupon_Precio_Ficticio numeric(18,2),
		@Groupon_Fecha datetime ,
		@Groupon_Fecha_Venc datetime ,
		@Groupon_Cantidad numeric(18,0),
		@Groupon_Descripcion nvarchar(255) ,
		@Groupon_Fecha_Compra datetime ,
		@Groupon_Codigo nvarchar(50) ,
		@Groupon_Devolucion_Fecha datetime, 
		@Groupon_Entregado_Fecha datetime ,
		@Factura_Nro numeric(18,0),
		@Factura_Fecha datetime 

-- Declaración del cursor
DECLARE cTablaMaestra CURSOR FOR
SELECT  [Cli_Nombre] ,[Cli_Apellido], [Cli_Dni], [Cli_Direccion], [Cli_Telefono], [Cli_Mail]
      ,[Cli_Fecha_Nac], [Cli_Ciudad], [Carga_Credito], [Carga_Fecha], [Tipo_Pago_Desc], [Cli_Dest_Nombre]
      ,[Cli_Dest_Apellido], [Cli_Dest_Dni], [Cli_Dest_Direccion], [Cli_Dest_Telefono], [Cli_Dest_Mail]
      ,[Cli_Dest_Fecha_Nac], [Cli_Dest_Ciudad], [GiftCard_Fecha], [GiftCard_Monto], [Provee_RS]
      ,[Provee_Dom], [Provee_Ciudad], [Provee_Telefono], [Provee_CUIT], [Provee_Rubro], [Groupon_Precio]
      ,[Groupon_Precio_Ficticio], [Groupon_Fecha], [Groupon_Fecha_Venc], [Groupon_Cantidad], [Groupon_Descripcion]
      ,[Groupon_Fecha_Compra], [Groupon_Codigo], [Groupon_Devolucion_Fecha], [Groupon_Entregado_Fecha]
      ,[Factura_Nro],[Factura_Fecha]
FROM gd_esquema.Maestra WHERE 1=1

-- Apertura del cursor
PRINT 'Abriendo cursor con tabla maestra...'
OPEN cTablaMaestra
PRINT 'Cursor Abierto. Procesando los Datos...'
-- Lectura de la primera fila del cursor
FETCH cTablaMaestra INTO @Cli_Nombre, @Cli_Apellido, @Cli_DNI, @Cli_Direccion, @Cli_Telefono, @Cli_Mail, @Cli_Fecha_Nacimiento, @Cli_Ciudad, @Credito_Monto, @Credito_Fecha_Carga,
		@Credito_Tipo_Pago, @Cli_Destino_Nombre, @Cli_Dest_Apellido, @Cli_Dest_Dni, @Cli_Dest_Direccion, @Cli_Dest_Telefono, @Cli_Dest_Mail, @Cli_Dest_Fecha_Nac,
		@Cli_Dest_Ciudad, @GiftCard_Fecha, @GiftCard_Monto, @Provee_RS, @Provee_Dom, @Provee_Ciudad, @Provee_Telefono, @Provee_CUIT, @Provee_Rubro, @Groupon_Precio,
		@Groupon_Precio_Ficticio, @Groupon_Fecha, @Groupon_Fecha_Venc, @Groupon_Cantidad, @Groupon_Descripcion, @Groupon_Fecha_Compra, @Groupon_Codigo,	@Groupon_Devolucion_Fecha, 
		@Groupon_Entregado_Fecha, @Factura_Nro, @Factura_Fecha 


WHILE (@@FETCH_STATUS = 0 )
BEGIN
	-- Cargo el cliente 
	EXECUTE GRUPO_N.Migracion_Ingresar_Cliente @Cli_Nombre, @Cli_Apellido, @Cli_DNI, @Cli_Direccion, @Cli_Telefono, @Cli_Mail, @Cli_Fecha_Nacimiento, @Cli_Ciudad;
	
	--Cargo Proveedores, ciudades y rubros de los mismos
	EXECUTE GRUPO_N.Migracion_Ingresar_Proveedor @Provee_RS, @Provee_Dom, @Provee_Ciudad, @Provee_Telefono, @Provee_CUIT, @Provee_Rubro;

	--PRINT @Cli_Nombre + ' ' + @Cli_Apellido --+ ' DNI:' + @Cli_DNI
	-- Lectura de la siguiente fila del cursor
	FETCH cTablaMaestra INTO @Cli_Nombre, @Cli_Apellido, @Cli_DNI, @Cli_Direccion, @Cli_Telefono, @Cli_Mail, @Cli_Fecha_Nacimiento, @Cli_Ciudad, @Credito_Monto, @Credito_Fecha_Carga,
			@Credito_Tipo_Pago, @Cli_Destino_Nombre, @Cli_Dest_Apellido, @Cli_Dest_Dni, @Cli_Dest_Direccion, @Cli_Dest_Telefono, @Cli_Dest_Mail, @Cli_Dest_Fecha_Nac,
			@Cli_Dest_Ciudad, @GiftCard_Fecha, @GiftCard_Monto, @Provee_RS, @Provee_Dom, @Provee_Ciudad, @Provee_Telefono, @Provee_CUIT, @Provee_Rubro, @Groupon_Precio,
			@Groupon_Precio_Ficticio, @Groupon_Fecha, @Groupon_Fecha_Venc, @Groupon_Cantidad, @Groupon_Descripcion, @Groupon_Fecha_Compra, @Groupon_Codigo,	@Groupon_Devolucion_Fecha, 
			@Groupon_Entregado_Fecha, @Factura_Nro, @Factura_Fecha 
END

 
PRINT 'Proceso Finalizado con éxito.'
-- Cierre del cursor
CLOSE cTablaMaestra

-- Liberar los recursos
DEALLOCATE cTablaMaestra
	
	
	