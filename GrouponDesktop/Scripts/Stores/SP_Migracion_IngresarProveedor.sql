USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[Migracion_Ingresar_Proveedor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[Migracion_Ingresar_Proveedor]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[Migracion_Ingresar_Proveedor]
		@Provee_RS nvarchar(100),
		@Provee_Dom nvarchar(100),
		@Provee_Ciudad nvarchar(255) ,
		@Provee_Telefono numeric(18,0),
		@Provee_CUIT nvarchar(20),
		@Provee_Rubro nvarchar(100),
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
		@Id_Rol_Proveedor int,
		@Id_Proveedor int,
		@Id_Usuario int,
		@Id_Ciudad int,
		@Id_Rubro int
IF (@Provee_RS IS NOT NULL AND @Groupon_Devolucion_Fecha IS NULL AND @Groupon_Entregado_Fecha IS NULL AND @Factura_Fecha IS NULL)
	BEGIN
		SELECT @Id_Proveedor=ID FROM GRUPO_N.Proveedor WHERE RazonSocial = @Provee_RS;
		
		IF (@Id_Proveedor IS NULL)
			BEGIN
				--Ingreso el usuario
				--PRINT 'Se va a crear el Proveedor ' + @Provee_RS
				SET @Id_Rol_Proveedor = GRUPO_N.GetIdRolByName('Proveedor');	
				INSERT INTO GRUPO_N.Usuario (Nombre,Password,ID_Rol) VALUES (@Provee_RS,'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7',@Id_Rol_Proveedor);
				SELECT @Id_Usuario=ID FROM GRUPO_N.Usuario WHERE Nombre=@Provee_RS;
				INSERT INTO GRUPO_N.DetalleEntidad (Telefono,Email,ID_Usuario) VALUES (@Provee_Telefono, NULL,@Id_Usuario);
				SELECT @Id_Detalle=ID FROM DetalleEntidad WHERE Telefono=@Provee_Telefono AND Email IS NULL;
				--Ingresar la ciudad si no está
				SELECT  @Id_Ciudad = ID FROM GRUPO_N.Ciudad WHERE Descripcion = @Provee_Ciudad;
				IF (@Id_Ciudad IS NULL)
				BEGIN
					--PRINT 'La Ciudad a ingresar es ' + @Provee_Ciudad
					INSERT INTO Ciudad (Descripcion) VALUES (@Provee_Ciudad);
					SELECT  @Id_Ciudad = ID FROM GRUPO_N.Ciudad WHERE Descripcion = @Provee_Ciudad;	
				END
				--Ingresar Rubro si no está 
				SELECT  @Id_Rubro = ID FROM GRUPO_N.Rubro WHERE Descripcion = @Provee_Rubro;
				IF (@Id_Rubro IS NULL)
				BEGIN
					--PRINT 'El Rubro a ingresar es ' + @Provee_Rubro
					INSERT INTO Rubro (Descripcion) VALUES (@Provee_Rubro);
					SELECT  @Id_Rubro = ID FROM GRUPO_N.Rubro WHERE Descripcion = @Provee_Rubro;	
				END				
				--Ingreso al proveedor
				INSERT INTO GRUPO_N.Proveedor (RazonSocial, CUIT,ID_Detalle,ID_Rubro, ID_Ciudad) VALUES (@Provee_RS, @Provee_CUIT, @Id_Detalle, @Id_Rubro, @Id_Ciudad);
			END
	END
END
GO