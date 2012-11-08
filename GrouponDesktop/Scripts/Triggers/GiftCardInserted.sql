USE GD2C2012;
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