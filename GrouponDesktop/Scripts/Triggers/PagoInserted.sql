USE GD2C2012;
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