USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[Migracion_Ingresar_Cupon]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[Migracion_Ingresar_Cupon]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[Migracion_Ingresar_Cupon]
		@Provee_RS nvarchar(100),
		@Groupon_Precio numeric(18,2),
		@Groupon_Precio_Ficticio numeric(18,2),
		@Groupon_Fecha datetime ,
		@Groupon_Fecha_Venc datetime ,
		@Groupon_Cantidad numeric(18,0),
		@Groupon_Descripcion nvarchar(255)
AS
BEGIN
	DECLARE
	@Id_Proveedor int,
	@Id_Cupon int
	
	IF(@Groupon_Descripcion IS NOT NULL)
	BEGIN
		
		SET @Id_Proveedor = GRUPO_N.GetIdProveedorByName(@Provee_RS);
		SELECT @Id_Cupon = ID FROM Cupon WHERE FechaPublicacion = @Groupon_Fecha AND ID_Proveedor = @Id_Proveedor AND Descripcion = @Groupon_Descripcion AND Stock=@Groupon_Cantidad

		IF(@Id_Cupon IS NULL)
		BEGIN
			PRINT 'Vamos a ingresar un cupon ' + @Groupon_Descripcion
			INSERT INTO Cupon (Precio, PrecioOriginal, FechaPublicacion,FechaVigencia,FechaVencimmiento,Stock,Descripcion,ID_Proveedor,CantidadPorUsuario,Publicado) VALUES
							(@Groupon_Precio_Ficticio,@Groupon_Precio,@Groupon_Fecha,@Groupon_Fecha_Venc, DATEADD(MONTH,2,@Groupon_Fecha_Venc),@Groupon_Cantidad,@Groupon_Descripcion,@Id_Proveedor,@Groupon_Cantidad,1);

			SELECT @Id_Cupon = ID FROM Cupon WHERE FechaPublicacion = @Groupon_Fecha AND ID_Proveedor = @Id_Proveedor AND Descripcion = @Groupon_Descripcion AND Stock=@Groupon_Cantidad;
			INSERT INTO CuponCiudad (ID_Cupon,ID_Ciudad) VALUES (@Id_Cupon, GRUPO_N.GetIdCiudadByProveedor(@Provee_RS));
		END
	END
END