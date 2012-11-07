USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[Migracion_Ingresar_Cliente]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[Migracion_Ingresar_Cliente]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[Migracion_Ingresar_Cliente]
		@Cli_Nombre nvarchar(255),
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
AS
BEGIN
	DECLARE
		@Id_Detalle int,
		@Id_Rol_Cliente int,
		@Id_Cliente int,
		@Id_Usuario int
	IF (@Provee_RS IS NULL)
	BEGIN
		SELECT @Id_Cliente=ID FROM GRUPO_N.Cliente WHERE DNI = @Cli_DNI AND Nombre=@Cli_Nombre AND Apellido=@Cli_Apellido;
		
		IF (@Id_Cliente IS NULL)
			BEGIN
				--Ingreso el usuario
				--PRINT 'Se va a crear el cliente ' + @Cli_Nombre + ' ' + @Cli_Apellido
				SET @Id_Rol_Cliente = GRUPO_N.GetIdRolByName('Cliente');	
				INSERT INTO GRUPO_N.Usuario (Nombre,Password,ID_Rol) VALUES (@Cli_Telefono,'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7',@Id_Rol_Cliente);
				SELECT @Id_Usuario=ID FROM GRUPO_N.Usuario WHERE Nombre=CAST(@Cli_Telefono AS NVARCHAR(255));
				INSERT INTO GRUPO_N.DetalleEntidad (Telefono,Email,ID_Usuario) VALUES (@Cli_Telefono, @Cli_Mail,@Id_Usuario);
				SELECT @Id_Detalle=ID FROM DetalleEntidad WHERE Telefono=@Cli_Telefono AND Email=@Cli_Mail;
				INSERT INTO GRUPO_N.Cliente (DNI, Nombre, Apellido,FechaNacimiento,ID_Detalle) VALUES (@Cli_DNI, @Cli_Nombre, @Cli_Apellido, @Cli_Fecha_Nacimiento, @Id_Detalle);
			END
	END
END
GO