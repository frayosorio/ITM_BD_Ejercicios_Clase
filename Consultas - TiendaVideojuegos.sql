SELECT *
	FROM EstadoVenta

SELECT * FROM TipoDocumento

SELECT * FROM Pais
	WHERE Id=170

SELECT COUNT(*) FROM Pais

SELECT *
	FROM Region R
		JOIN Pais P ON R.IdPais=P.Id

--Consultar todos los paises con sus regiones (si las tiene) y sus ciudades (si las hay)
SELECT *
	FROM Pais P 
		LEFT JOIN Region R ON R.IdPais=P.Id
		LEFT JOIN Ciudad C ON R.Id=C.IdRegion
	ORDER BY P.Nombre, R.Nombre, C.Nombre


SELECT COUNT(*) FROM Ciudad

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



--Listar los paises con sus regiones
--basado en la vista VCIUDADES
SELECT DISTINCT Pais, Region
	FROM vCiudades

SELECT COUNT(*) FROM vCiudades

SELECT B.*, A.Ciudad+' '+A.Region+' '+A.Pais
	FROM vCiudades A
		JOIN Cliente B ON B.IdCiudad=A.IdCiudad

--Consultar las ventas en la segunda quincena del año
SELECT *
	FROM vVentas
	WHERE Fecha BETWEEN '2025-01-15' AND '2025-01-31'

--Cuales ciudades tienen entre 5 y más clientes
SELECT CD.Nombre Ciudad, COUNT(*) Total_Clientes
	FROM Cliente CL
		JOIN Ciudad CD ON CL.IdCiudad=CD.Id
	GROUP BY CD.Nombre
	HAVING COUNT(*)>=5

--Cuantas ventas hay por cada estado durante ENERO
SELECT E.Nombre Estado, COUNT(*)
	FROM EstadoVenta E
		JOIN Venta V ON E.Id=V.IdEstado
	WHERE MONTH(V.Fecha)=1
	GROUP BY E.Nombre