-- Mostrar el cliente o los clientes que mas han comprado
WITH MayorValorComprado AS (
	SELECT TOP 1 SUM(VD.Cantidad * VD.Precio - VD.Descuento) ValorTotal
		FROM Venta V 
			JOIN VentaDetalle VD ON V.Id = VD.IdVenta
		GROUP BY V.IdCliente
		ORDER BY 1 DESC
	),
	VentasAcumuladasCliente AS (
		SELECT C.Nombre Cliente, TD.Sigla + ' ' + C.Identificacion Identificacion,
			SUM(VD.Cantidad * VD.Precio - VD.Descuento) TotalValorComprado
			FROM Cliente C
				JOIN TipoDocumento TD ON C.IdTipoDocumento = TD.Id
				JOIN Venta V ON V.IdCliente = C.Id
				JOIN VentaDetalle VD ON V.Id = VD.IdVenta
			GROUP BY C.Nombre, TD.Sigla, C.Identificacion
	)
	SELECT VC.Cliente, VC.Identificacion, VC.TotalValorComprado
		FROM VentasAcumuladasCliente VC
			JOIN MayorValorComprado MV ON MV.ValorTotal = VC.TotalValorComprado

-- Obtener el top 5 de los clientes que más han comprado
WITH VentasAcumuladasCliente AS (
		SELECT C.Nombre Cliente, TD.Sigla + ' ' + C.Identificacion Identificacion,
			SUM(VD.Cantidad * VD.Precio - VD.Descuento) TotalValorComprado
			FROM Cliente C
				JOIN TipoDocumento TD ON C.IdTipoDocumento = TD.Id
				JOIN Venta V ON V.IdCliente = C.Id
				JOIN VentaDetalle VD ON V.Id = VD.IdVenta
			GROUP BY C.Nombre, TD.Sigla, C.Identificacion
	),
	RankingVentas AS (
		SELECT *,
			RANK() OVER (ORDER BY TotalValorComprado DESC) Puesto
			FROM VentasAcumuladasCliente

	)
	SELECT *
		FROM RankingVentas
		WHERE Puesto <=5
