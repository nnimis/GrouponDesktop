USE [GD2C2012]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GRUPO_N].[ComprarCuponCliente]') AND type in (N'P', N'PC'))
DROP PROCEDURE [GRUPO_N].[ComprarCuponCliente]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GRUPO_N].[ComprarCuponCliente]
	@ID_Cliente int,
	@ID_Cupon int,
	@Fecha datetime
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @NumeroCupon int
	DECLARE @CantidadPorUsuario int
	DECLARE @CantidadComprada int
	DECLARE @CodigoCupon nvarchar(50)

	SELECT @NumeroCupon = COUNT(*) + 1 FROM GRUPO_N.CompraCupon
	WHERE ID_Cupon = @ID_Cupon 
	GROUP BY ID_Cupon
	
	SELECT @CantidadComprada = COUNT(ID_Cupon) - COUNT(d.ID_Cliente) FROM GRUPO_N.CompraCupon cc
	LEFT JOIN GRUPO_N.Devolucion d ON d.ID_CompraCupon = cc.ID
	WHERE ID_Cupon = @ID_Cupon
	AND cc.ID_Cliente = @ID_Cliente
	GROUP BY ID_Cupon, cc.ID_Cliente

	IF @CantidadComprada IS NULL
		SET @CantidadComprada = 0

	IF @NumeroCupon IS NULL
		SET @NumeroCupon = 1

	SELECT 
		@CodigoCupon = Codigo + CAST(@NumeroCupon as varchar(10)), 
		@CantidadPorUsuario = CantidadPorUsuario 
	FROM GRUPO_N.Cupon
	WHERE ID = @ID_Cupon

	IF @CantidadComprada < @CantidadPorUsuario
	BEGIN
		INSERT INTO GRUPO_N.CompraCupon (Fecha, ID_Cliente, ID_Cupon, Codigo)
		VALUES (@Fecha, @ID_Cliente, @ID_Cupon, @CodigoCupon)

		SELECT @NumeroCupon
	END
END

GO
