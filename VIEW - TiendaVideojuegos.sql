--Vista para la División Política
CREATE VIEW vCiudades
AS
	SELECT R.IdPais, P.Nombre Pais, P.CodigoAlfa, P.Indicativo,
		C.IdRegion, R.Nombre Region, 
		C.Id IdCiudad, C.Nombre Ciudad
		FROM Region R
			JOIN Pais P ON R.IdPais=P.Id
			JOIN Ciudad C ON R.Id=C.IdRegion
GO

--Vista para las ventas
CREATE VIEW vVentas
AS
	SELECT V.*,
		TD.Sigla+' '+C.NumeroIdentificacion Cliente_Identifcacion,
		C.Nombre Clíente_Nombre,
		TE.Sigla+' '+E.NumeroIdentificacion Empleado_Identifcacion,
		E.Nombre Empleado_Nombre,
		EV.Nombre Estado_Venta,
		VD.*,
		T.Nombre Titulo
		FROM Venta V
			JOIN Cliente C ON V.IdCliente=C.Id
			JOIN TipoDocumento TD ON C.IdTipoDocumento=TD.Id
			JOIN Empleado E ON V.IdEmpleado=E.Id
			JOIN TipoDocumento TE ON E.IdTipoDocumento=TE.Id
			JOIN EstadoVenta EV ON V.IdEstado=EV.Id
			JOIN VentaDetalle VD ON V.Id=VD.IdVenta
			JOIN Titulo T ON VD.IdTitulo=T.Id

/*
	SELECT A.*,
		C.Sigla+' '+B.NumeroIdentificacion Cliente_Identifcacion,
		C.Nombre Clíente_Nombre,
		C.Sigla+' '+B.NumeroIdentificacion Empleado_Identifcacion,
		E.Nombre Empleado_Nombre,
		F.Nombre Estado_Venta,
		G.*,
		H.Nombre Titulo
		FROM Venta A
			JOIN Cliente B ON A.IdCliente=B.Id
			JOIN TipoDocumento C ON B.IdTipoDocumento=C.Id
			JOIN Empleado D ON A.IdEmpleado=D.Id
			JOIN TipoDocumento E ON D.IdTipoDocumento=E.Id
			JOIN EstadoVenta F ON A.IdEstado=F.Id
			JOIN VentaDetalle G ON A.Id=G.IdVenta
			JOIN Titulo H ON G.IdTitulo=H.Id
*/