--Obtener el valor total de cada venta
SELECT V.Id, V.NumeroFactura,
	SUM(VD.Cantidad*VD.Precio-VD.Descuento) TotalVenta
	FROM Venta V
		JOIN VentaDetalle VD ON V.Id = VD.IdVenta
	GROUP BY V.Id, V.NumeroFactura

--Mostrar las ventas superiores a $ 100000 con el respectivo cliente
SELECT V.Id, V.NumeroFactura,
	C.Nombre Cliente,
	SUM(VD.Cantidad*VD.Precio-VD.Descuento) TotalVenta
	FROM Venta V
		JOIN VentaDetalle VD ON V.Id = VD.IdVenta
		JOIN Cliente C ON V.IdCliente = C.Id
	GROUP BY V.Id, V.NumeroFactura, C.Nombre
	HAVING SUM(VD.Cantidad*VD.Precio-VD.Descuento)>=100000

--Cual es el cliente con más valor comprado
SELECT TOP 1 C.Nombre Cliente,
	SUM(VD.Cantidad*VD.Precio-VD.Descuento) TotalVenta
	FROM Venta V
		JOIN VentaDetalle VD ON V.Id = VD.IdVenta
		JOIN Cliente C ON V.IdCliente = C.Id
	GROUP BY C.Nombre
	ORDER BY 2 DESC

SELECT C.Nombre Cliente,
	SUM(VD.Cantidad*VD.Precio-VD.Descuento) TotalVenta
	FROM Venta V
		JOIN VentaDetalle VD ON V.Id = VD.IdVenta
		JOIN Cliente C ON V.IdCliente = C.Id
	GROUP BY C.Nombre
	HAVING SUM(VD.Cantidad*VD.Precio-VD.Descuento) = (
				SELECT TOP 1 SUM(VD.Cantidad*VD.Precio-VD.Descuento) TotalVenta
				FROM Venta V
					JOIN VentaDetalle VD ON V.Id = VD.IdVenta
					JOIN Cliente C ON V.IdCliente = C.Id
				GROUP BY C.Nombre
				ORDER BY 1 DESC
				)

--Que departamentos de COLOMBIA tienen mas de 100 municipios
SELECT R.Nombre, COUNT(*) TotalMunicipios
	FROM Pais P
		JOIN Region R ON P.Id = R.IdPais
		JOIN Ciudad C ON R.Id = C.IdRegion
	WHERE P.Nombre = 'Colombia'
	GROUP BY R.Nombre
	HAVING COUNT(*) > 100


