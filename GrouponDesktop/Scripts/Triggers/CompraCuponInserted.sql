USE GD2C2012;
GO
IF OBJECT_ID ('GRUPO_N.CompraCuponInserted', 'TR') IS NOT NULL
   DROP TRIGGER GRUPO_N.CompraCuponInserted
GO
CREATE TRIGGER GRUPO_N.CompraCuponInserted
ON GRUPO_N.CompraCupon
AFTER INSERT
AS
BEGIN
	UPDATE GRUPO_N.Cliente SET
	Saldo = Saldo - T.Credito
	FROM GRUPO_N.Cliente c
	INNER JOIN (SELECT i.ID_Cliente, c.Precio Credito FROM Inserted i
				INNER JOIN Cupon c ON c.ID = i.ID_Cupon) AS T
	ON c.ID = T.ID_Cliente
	
	UPDATE GRUPO_N.Cupon SET
	Stock = Stock - 1
	FROM GRUPO_N.Cupon c
	INNER JOIN (SELECT ID_Cupon FROM Inserted) AS T
	ON c.ID = T.ID_Cupon
END
GO