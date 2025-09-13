SELECT *
	FROM EstadoVenta

SELECT * FROM TipoDocumento

SELECT * FROM Pais
	WHERE Id=170

SELECT COUNT(*) FROM Pais

SELECT *
	FROM Region R
		JOIN Pais P ON R.IdPais=P.Id

SELECT *
	FROM Pais P 
		LEFT JOIN Region R ON R.IdPais=P.Id
		LEFT JOIN Ciudad C ON R.Id=C.IdRegion
	ORDER BY P.Nombre, R.Nombre, C.Nombre

SELECT DISTINCT Pais, Region
	FROM vCiudades

SELECT COUNT(*) FROM Ciudad

SELECT COUNT(*) FROM vCiudades

SELECT MAX(Id)
	FROM Ciudad

SELECT * FROM Ciudad

SELECT * FROM Plataforma

SELECT * FROM Categoria

SELECT * FROM Formato

SELECT * FROM VentaDetalle

SELECT * FROM Empleado

--Modificar datos del empleado
UPDATE Empleado
	SET Nombre='Elber Gomez Torva',
		NumeroIdentificacion='1040888777'
	WHERE Id=1


