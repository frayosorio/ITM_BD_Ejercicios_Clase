-- ****** Consultas para probar los  indices y otras restricciones
INSERT INTO Pais
	(Nombre, CodigoAlfa)
	VALUES
	('Colombia', 'CO'),
	('Panamá', 'PA')

SELECT *
	FROM Pais

INSERT INTO Pais
	(Nombre, CodigoAlfa)
	VALUES
	('Estados Unidos', 'US'),
	('Panamá', 'PA')

INSERT INTO Pais
	(Nombre, CodigoAlfa)
	VALUES
	('Paraguay', 'PY')

INSERT INTO Pais
	(Nombre, CodigoAlfa)
	VALUES
	('Brasil', 'BR'),
	('Perú', 'PE'),
	('Venezuela', 'VE')

INSERT INTO Region
	(Nombre, Codigo, IdPais)
	VALUES
	('Antioquia', '05', 1),
	('Florida' ,'FL', 5)

SELECT *
	FROM Region
		JOIN Pais ON Region.IdPais = Pais.Id

INSERT INTO Region
	(Nombre, IdPais)
	VALUES
	('Amazonas',  1),
	('Amazonas',  8),
	('Amazonas',  9),
	('Amazonas', 10)

-- ****** Instrucciones CRUD
-- Create: Agregar información
--        sql -> INSERT
-- Read: Consultar o listar información
--        sql -> SELECT
-- Update: Modificar información
--        sql -> UPDATE
-- Delete: Eliminar información
--        sql -> DELETE

-- ****** Consultas para listar datos agregados

SELECT *
	FROM TipoDocumento

SELECT *
	FROM Cliente

SELECT *
	FROM Titulo

-- Listar todos los clientes con su respectivo tipo de documento
-- La instrucción SELECT la componen 3 operaciones de conjuntos
-- * PROYECCIÓN (lista de campos y expresiones)
-- * SELECCION (filtrado de los datos basado en condiciones)
-- * PRODUCTO CARTESIANO (combinación de los registros de una tabla con los de otra tabla)

SELECT *
	FROM Cliente
		JOIN TipoDocumento ON Cliente.IdTipoDocumento = TipoDocumento.Id

-- Cambiar a CEDULA DE EXTRANJERÍA al cliente con Identificacion = 79530543
UPDATE Cliente
	SET IdTipoDocumento = 22
	WHERE Identificacion = '79530543'

-- consulta que genera error
UPDATE Cliente
	SET Identificacion = '79530543'

-- Cambiar el nombre del unico empleado
SELECT * FROM Empleado
UPDATE Empleado
	SET Nombre = 'Simón Tolomeo'
	WHERE Id=1

-- Listar los clientes con CEDULA DE EXTRANJERÍA		
SELECT *
	FROM Cliente
		JOIN TipoDocumento ON Cliente.IdTipoDocumento = TipoDocumento.Id
	--WHERE TipoDocumento.Nombre = 'Cédula de Extranjería'
	--WHERE TipoDocumento.Sigla= 'CE'
	WHERE TipoDocumento.Nombre LIKE '%extra%'

-- Listar todos los clientes 'JUAN'
SELECT *
	FROM Cliente
		JOIN TipoDocumento ON Cliente.IdTipoDocumento = TipoDocumento.Id
	WHERE Cliente.Nombre LIKE '%JUAN%'

-- Listar las ventas del cliente con Identificacion = 79530543
SELECT C.Nombre Cliente, TD.Sigla + ' ' + C.Identificacion Identificacion,
	C.Direccion + ' de ' + CD.Nombre Residencia,
	V.NumeroFactura, V.Fecha,
	E.Nombre Vendedor
	FROM Cliente C
		JOIN TipoDocumento TD ON C.IdTipoDocumento = TD.Id
		JOIN Ciudad CD ON C.IdCiudad = CD.Id
		JOIN Venta V ON V.IdCliente = C.Id
		JOIN Empleado E ON E.Id = V.IdEmpleado
	WHERE C.Identificacion = '89028942'

-- Agregar detalle a la venta con factura 138
INSERT INTO VentaDetalle
	(IdVenta, IdTitulo, Cantidad, Precio)
	VALUES
	((SELECT Id FROM Venta WHERE NumeroFactura=19), 3, 2, 35000),
	((SELECT Id FROM Venta WHERE NumeroFactura=19), 8, 3, 25000)

-- Listar las ventas con su detalle del cliente con Identificacion = 79530543
SELECT C.Nombre Cliente, TD.Sigla + ' ' + C.Identificacion Identificacion,
	C.Direccion + ' de ' + CD.Nombre Residencia,
	V.NumeroFactura, V.Fecha,
	E.Nombre Vendedor,
	T.Nombre Titulo, VD.Cantidad, VD.Precio,
	VD.Cantidad * VD.Precio - VD.Descuento ValorTotal
	FROM Cliente C
		JOIN TipoDocumento TD ON C.IdTipoDocumento = TD.Id
		JOIN Ciudad CD ON C.IdCiudad = CD.Id
		JOIN Venta V ON V.IdCliente = C.Id
		JOIN Empleado E ON E.Id = V.IdEmpleado
		JOIN VentaDetalle VD ON V.Id = VD.IdVenta
		JOIN Titulo T ON T.Id = VD.IdTitulo
	WHERE C.Identificacion = '89028942'

-- Calcular el valor total comprado por el cliente con Identificacion = 79530543
SELECT SUM(VD.Cantidad * VD.Precio - VD.Descuento) ValorTotalComprado
	FROM Cliente C
		JOIN Venta V ON V.IdCliente = C.Id
		JOIN VentaDetalle VD ON V.Id = VD.IdVenta
	WHERE C.Identificacion = '89028942'

-- Calcular el total de unidades compradas por el cliente con Identificacion = 79530543
SELECT SUM(VD.Cantidad) TotalUnidadesCompradas
	FROM Cliente C
		JOIN Venta V ON V.IdCliente = C.Id
		JOIN VentaDetalle VD ON V.Id = VD.IdVenta
	WHERE C.Identificacion = '89028942'
		 

