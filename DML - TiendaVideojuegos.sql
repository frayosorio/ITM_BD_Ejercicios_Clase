USE TiendaVideoJuegosITM

SET IDENTITY_INSERT EstadoVenta ON
INSERT INTO EstadoVenta
	(Id, Nombre, Descripcion)
	VALUES(1, 'Pendiente', 'La venta ha sido registrada pero a�n no ha sido procesada.')

INSERT INTO EstadoVenta
	(Id, Nombre, Descripcion)
	VALUES(2, 'Confirmada', 'La venta ha sido confirmada y est� lista para su procesamiento.'),
	(3, 'En Proceso', 'La orden de venta est� siendo preparada y empaquetada.'),
	(4, 'Enviada', 'La venta ha sido enviada al cliente.'),
	(5, 'Entregada', 'La mercanc�a ha sido recibida por el cliente.'),
	(6, 'Cancelada', 'La venta ha sido cancelada por el cliente o la empresa.'),
	(7, 'Devuelta', 'La mercanc�a ha sido devuelta por el cliente.')

SET IDENTITY_INSERT EstadoVenta OFF