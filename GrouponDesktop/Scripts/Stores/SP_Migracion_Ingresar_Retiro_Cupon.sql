USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[Migracion_Ingresar_Retiro_Cupon]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[Migracion_Ingresar_Retiro_Cupon]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[Migracion_Ingresar_Retiro_Cupon]
		@Provee_RS nvarchar(100),
		@Cli_Telefono numeric(18,0),
		@Groupon_Precio numeric(18,2),
		@Groupon_Precio_Ficticio numeric(18,2),		
		@Groupon_Fecha datetime ,
		@Groupon_Fecha_Venc datetime ,
		@Groupon_Cantidad numeric(18,0),
		@Groupon_Descripcion nvarchar(255),
		@Groupon_Fecha_Compra datetime ,
		@Groupon_Codigo nvarchar(50),
		@Groupon_Devolucion_Fecha datetime, 
		@Groupon_Entregado_Fecha datetime ,
		@Factura_Nro numeric(18,0),
		@Factura_Fecha datetime				
AS
BEGIN
	DECLARE
	@Id_Cupon int,
	@Id_Cliente int,
	@Id_Compra int,
	@Id_Canje int

	IF(@Groupon_Codigo IS NOT NULL AND @Factura_Nro IS NULL AND @Groupon_Devolucion_Fecha IS NULL AND @Groupon_Entregado_Fecha IS NOT NULL)
	BEGIN
		
		SET @Id_Cliente = GRUPO_N.GetIdClienteByTelefono(@Cli_Telefono);
		SET @Id_Cupon = GRUPO_N.GetIdCuponByAllKeys(@Provee_RS,@Groupon_Precio,@Groupon_Precio_Ficticio,@Groupon_Fecha,@Groupon_Fecha_Venc,@Groupon_Cantidad,@Groupon_Descripcion);
		--PRINT 'Se va a ingresar compra con ID_Cliente: ' + CAST(@Id_Cliente AS NVARCHAR(20)) + ' con ID cupon ' + CAST(@Id_Cupon AS NVARCHAR(20))
		IF (@Id_Cupon IS NULL)
			BEGIN
				PRINT 'No se pudo recuperar el ID del cupon ' + @Provee_RS + ' ' + @Groupon_Descripcion
			END
		SELECT @Id_Compra = ID FROM GRUPO_N.CompraCupon WHERE Codigo = @Groupon_Codigo AND Fecha = @Groupon_Fecha_Compra AND ID_Cliente = @Id_Cliente AND ID_Cupon = @Id_Cupon;
		--PRINT 'Recuperando compra para Codigo ' + @Groupon_Codigo + ' Fecha compra ' + CAST(@Groupon_Fecha_Compra AS NVARCHAR(10)) + ' id_cliente ' + CAST(@Id_Cliente AS NVARCHAR(10)) + ' id_cupon ' + CAST(@Id_Cupon AS NVARCHAR(10))
		IF (@Id_Compra IS NULL)
			BEGIN
				PRINT 'No se pudo recuperar el ID de compra del cupon ' + CAST(@Id_Cupon AS NVARCHAR(10))
			END		
		SELECT @Id_Canje = ID FROM GRUPO_N.CanjeCupon WHERE Fecha = @Groupon_Entregado_Fecha AND ID_CompraCupon = @Id_Compra;
		IF(@Id_Canje IS NULL)
		BEGIN
			--PRINT 'Vamos a ingresar el canje de un cupon ' + @Groupon_Descripcion
			INSERT INTO GRUPO_N.CanjeCupon(Fecha, ID_CompraCupon) 
									VALUES (@Groupon_Entregado_Fecha, @Id_Compra);

		END
	END
END