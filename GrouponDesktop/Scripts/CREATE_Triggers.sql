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
IF OBJECT_ID ('GRUPO_N.GiftcardInserted', 'TR') IS NOT NULL
   DROP TRIGGER GRUPO_N.GiftcardInserted
GO
CREATE TRIGGER GRUPO_N.GiftcardInserted
ON GRUPO_N.GiftCard
AFTER INSERT
AS
BEGIN
	UPDATE GRUPO_N.Cliente SET
	Saldo = Saldo - T.Credito
	FROM GRUPO_N.Cliente c
	INNER JOIN (SELECT ID_Cliente_Origen ID_Cliente, Credito FROM Inserted) AS T
	ON c.ID = T.ID_Cliente
	
	UPDATE GRUPO_N.Cliente SET
	Saldo = Saldo + T.Credito
	FROM GRUPO_N.Cliente c
	INNER JOIN (SELECT ID_Cliente_Destino ID_Cliente, Credito FROM Inserted) AS T
	ON c.ID = T.ID_Cliente
END
GO

IF OBJECT_ID ('GRUPO_N.PagoInserted', 'TR') IS NOT NULL
   DROP TRIGGER GRUPO_N.PagoInserted
GO
CREATE TRIGGER GRUPO_N.PagoInserted
ON GRUPO_N.Pago
AFTER INSERT
AS
BEGIN
	UPDATE GRUPO_N.Cliente SET
	Saldo = Saldo + T.Credito
	FROM GRUPO_N.Cliente c
	INNER JOIN (SELECT ID_Cliente, Credito FROM Inserted) AS T
	ON c.ID = T.ID_Cliente
END
GO