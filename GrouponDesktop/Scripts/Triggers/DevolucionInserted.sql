USE GD2C2012;
GO
IF OBJECT_ID ('GRUPO_N.DevolucionInserted', 'TR') IS NOT NULL
   DROP TRIGGER GRUPO_N.DevolucionInserted
GO
CREATE TRIGGER GRUPO_N.DevolucionInserted
ON GRUPO_N.Devolucion
AFTER INSERT
AS
BEGIN
	UPDATE GRUPO_N.Cliente SET
	Saldo = Saldo + c.Precio
	FROM GRUPO_N.Cupon c
	INNER JOIN GRUPO_N.CompraCupon cc
	ON c.ID = cc.ID_Cupon
	INNER JOIN (SELECT ID_CompraCupon FROM Inserted) AS T
	ON cc.ID = T.ID_CompraCupon
	
	UPDATE GRUPO_N.Cupon SET
	Stock = Stock + 1
	FROM GRUPO_N.Cupon c
	INNER JOIN GRUPO_N.CompraCupon cc
	ON c.ID = cc.ID_Cupon
	INNER JOIN (SELECT ID_CompraCupon FROM Inserted) AS T
	ON cc.ID = T.ID_CompraCupon
END
GO