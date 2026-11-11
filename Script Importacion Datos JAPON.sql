USE DivisionPolitica
GO

--Cargar los datos desde el archivo CSV

-- Eliminar la tabla temporal si ya existe
IF OBJECT_ID('tempdb..#DatosJapon') IS NOT NULL
    DROP TABLE #DatosJapon
GO

CREATE TABLE #DatosJapon(
	Prefectura varchar(100) NOT NULL,
	Capital varchar(100) NOT NULL,
	Area float NULL,
	Poblacion int null
)

BULK INSERT #DatosJapon
	FROM 'C:\Catedra\ITM\Bases de Datos\Ejercicios\Proyecto Division Politica\Japon.csv'
	WITH (
		DATAFILETYPE = 'char',
		FIELDTERMINATOR = ','
	)

DECLARE @IdPais int

SELECT @IdPais=Id
	FROM Pais
	WHERE Nombre='Japón'

IF @IdPais IS NULL
BEGIN
	DECLARE @IdContinente int,
		@IdTipoRegion int

	SELECT @IdContinente=Id
		FROM Continente
		WHERE Nombre='Asia'


	IF @IdContinente IS NULL
	BEGIN
		INSERT INTO Continente
			(Nombre)
			VALUES ('Asia')
		SET @IdContinente = @@IDENTITY
	END

	SELECT @IdTipoRegion=Id
		FROM TipoRegion
		WHERE TipoRegion='Prefectura'


	IF @IdTipoRegion IS NULL
	BEGIN
		INSERT INTO TipoRegion
			(TipoRegion)
			VALUES ('Prefectura')
		SET @IdTipoRegion = @@IDENTITY
	END

	INSERT INTO Pais
		(Nombre, IdContinente, IdTipoRegion, Moneda)
		VALUES('Japón', @IdContinente, @IdTipoRegion, 'Yen')

	SET @IdPais=@@IDENTITY
END

--PRINT('IdPais='+ISNULL(CONVERT(varchar, @IdPais),'** No encontrado **'))

INSERT INTO Region
	(Nombre, Area, Poblacion, IdPais)
	SELECT D.Prefectura, D.Area, D.Poblacion, @IdPais
		FROM #DatosJapon D
	WHERE NOT EXISTS(
		SELECT 1
			FROM Region R
			WHERE R.Nombre = D.Prefectura
				AND R.IdPais = @IdPais
	)

INSERT INTO Ciudad
	(Nombre, IdRegion, CapitalRegion)
	SELECT D.Capital, R.Id, 1
		FROM #DatosJapon D
			JOIN Region R
				ON R.Nombre = D.Prefectura AND R.IdPais = @IdPais
	WHERE NOT EXISTS(
		SELECT 1
			FROM Ciudad C
			WHERE C.Nombre = D.Capital 
				AND C.IdRegion = R.Id
	)

