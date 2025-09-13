CREATE VIEW vCiudades
AS
	SELECT R.IdPais, P.Nombre Pais, P.CodigoAlfa, P.Indicativo,
	C.IdRegion, R.Nombre Region, 
	C.Id IdCiudad, C.Nombre Ciudad
	FROM Region R
		JOIN Pais P ON R.IdPais=P.Id
		JOIN Ciudad C ON R.Id=C.IdRegion