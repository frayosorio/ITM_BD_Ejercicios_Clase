SELECT *
	FROM EstadoVenta

SELECT * FROM TipoDocumento

SELECT * FROM Pais
	WHERE Id=170

SELECT COUNT(*) FROM Pais

SELECT *
	FROM Region
		JOIN Pais ON Region.IdPais=Pais.Id

SELECT COUNT(*) FROM Ciudad