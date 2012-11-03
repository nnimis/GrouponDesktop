CREATE FUNCTION RolClienteID ()
RETURNS int
AS
	BEGIN
	  DECLARE @ID_Rol_Cliente AS int ;
	  SELECT  @ID_Rol_Cliente = ID
	  FROM    GRUPO_N.Rol AS Rol
	  WHERE   Rol.Descripcion = 'Cliente';
	  RETURN @ID_Rol_Cliente ;
	END;
GO

CREATE PROCEDURE Ingresar_Cliente
		@Cli_Nombre nvarchar(255),
		@Cli_Apellido nvarchar(255),
		@Cli_DNI numeric(18,0),
		@Cli_Direccion nvarchar(255),
		@Cli_Telefono numeric(18,0),
		@Cli_Mail nvarchar(255),
		@Cli_Fecha_Nacimiento datetime, 
		@Cli_Ciudad nvarchar(255),
AS
BEGIN
	DECLARE
		@Id_Detalle int,
		@Id_Rol_Cliente int,
		@Id_Cliente int,
		@Id_Usuario int

	SELECT @Id_Cliente=ID FROM GRUPO_N.Cliente WHERE DNI = @Cli_DNI AND Nombre=@Cli_Nombre AND Apellido=@Cli_Apellido;
	
	IF (@Id_Cliente IS NULL)
		BEGIN
			--Ingreso el usuario
			PRINT 'Se va a crear el cliente ' + @Cli_Nombre + ' ' + @Cli_Apellido
			SET @Id_Rol_Cliente = RolClienteID();	
			INSERT INTO GRUPO_N.Usuario (Nombre,Password,ID_Rol) VALUES (@Cli_Telefono,'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7',@Id_Rol_Cliente);
			SELECT @Id_Usuario=ID FROM GRUPO_N.Usuario WHERE Nombre=@Cli_Telefono;
			INSERT INTO GRUPO_N.DetalleEntidad (Telefono,Email,ID_Usuario) VALUES (@Cli_Telefono, @Cli_Mail,@Id_Usuario);
			SELECT @Id_Detalle=ID FROM DetalleEntidad WHERE Telefono=@Cli_Telefono AND Email=@Cli_Mail;
			INSERT INTO GRUPO_N.Cliente (DNI, Nombre, Apellido,FechaNacimiento,ID_Detalle) VALUES (@Cli_DNI, @Cli_Nombre, @Cli_Apellido, @Cli_Fecha_Nacimiento, @Id_Detalle);
		END
END
GO	


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
		@Cli_Dest_Dni numeric,
		@Cli_Dest_Direccion nvarchar(255),
		@Cli_Dest_Telefono numeric,
		@Cli_Dest_Mail nvarchar(255),
		@Cli_Dest_Fecha_Nac datetime,
		@Cli_Dest_Ciudad nvarchar(255),
		@GiftCard_Fecha datetime,
		@GiftCard_Monto numeric,
		@Provee_RS nvarchar(100),
		@Provee_Dom nvarchar(100),
		@Provee_Ciudad nvarchar(255) ,
		@Provee_Telefono numeric ,
		@Provee_CUIT nvarchar(20) ,
		@Provee_Rubro nvarchar(100),
		@Groupon_Precio numeric ,
		@Groupon_Precio_Ficticio numeric ,
		@Groupon_Fecha datetime ,
		@Groupon_Fecha_Venc datetime ,
		@Groupon_Cantidad numeric ,
		@Groupon_Descripcion nvarchar(255) ,
		@Groupon_Fecha_Compra datetime ,
		@Groupon_Codigo nvarchar(50) ,
		@Groupon_Devolucion_Fecha datetime, 
		@Groupon_Entregado_Fecha datetime ,
		@Factura_Nro numeric ,
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
	EXECUTE Ingresar_Cliente @Cli_Nombre, @Cli_Apellido, @Cli_DNI, @Cli_Direccion, @Cli_Telefono, @Cli_Mail, @Cli_Fecha_Nacimiento, @Cli_Ciudad;
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
	
	
	