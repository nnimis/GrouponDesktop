USE [GD2C2012]
GO

/****** Object:  Index [Migracion]    Script Date: 11/05/2012 21:40:06 ******/
CREATE NONCLUSTERED INDEX [Migracion] ON [GRUPO_N].[Cupon] 
(
	[Precio] ASC,
	[PrecioOriginal] ASC,
	[FechaPublicacion] ASC,
	[FechaVigencia] ASC,
	[Stock] ASC,
	[Descripcion] ASC,
	[ID_Proveedor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


