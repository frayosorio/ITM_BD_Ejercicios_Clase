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