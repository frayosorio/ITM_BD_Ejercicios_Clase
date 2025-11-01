USE DivisionPolitica
GO

--Verificar si el pais existe
DECLARE @IdPais INT 
SELECT @IdPais=Id FROM Pais WHERE Nombre='Japón'

IF @IdPais IS NULL
BEGIN
	--Obtener el codigo de CONTINENTE
	DECLARE @IdContinente int
	SELECT @IdContinente=Id FROM Continente WHERE Nombre='Asia'

	IF @IdContinente IS NULL
	BEGIN
		INSERT INTO Continente
			(Nombre)
			VALUES('Asia')
		SET @IdContinente=@@IDENTITY
	END

	--Obtener el codigo de TIPOREGION
	DECLARE @IdTipoRegion int
	SELECT @IdTipoRegion=Id FROM TipoRegion WHERE TipoRegion='Prefectura'

	IF @IdTipoRegion IS NULL
	BEGIN
		INSERT INTO TipoRegion
			(TipoRegion)
			VALUES('Prefectura')
		SET @IdTipoRegion=@@IDENTITY
	END

	--Agregar el PAIS
	INSERT INTO Pais
		(Nombre, IdContinente, IdTipoRegion)
		VALUES('Japón', @IdContinente, @IdTipoRegion)
END

CREATE TABLE #DatosJapon(
	Prefectura varchar(50) NOT NULL, 
	Capital varchar(50) NOT NULL, 
	Area float NULL, 
	Poblacion int NULL
	)

BULK INSERT #DatosJapon
	FROM 'D:\Catedra\ITM\Bases de Datos\Cursos\Curso 2025-2\Ejercicios\Japon.csv'
	WITH ( DATAFILETYPE = 'CHAR', FIELDTERMINATOR = ',')

INSERT INTO Region
	(Nombre, IdPais, Area, Poblacion)
	SELECT Prefectura, @IdPais, Area, Poblacion 
		FROM #DatosJapon


--Verificando las actualizaciones
SELECT *
	FROM Pais P 
		JOIN Region R ON P.Id=R.IdPais
		--JOIN Ciudad C ON R.Id=C.IdRegion
	WHERE P.Nombre='Japón'