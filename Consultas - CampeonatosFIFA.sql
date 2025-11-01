SELECT *
	FROM vEstadios
	WHERE Pais='Catar'


SELECT *
	FROM vGrupos
	WHERE Campeonato LIKE '%2022%'

SELECT G.*, C.Año
	FROM vGrupos G
		JOIN Campeonato C ON G.IdCampeonato=C.Id

SELECT *
	FROM vEncuentros
	WHERE Pais1 LIKE '%bra%' OR Pais2 LIKE '%bra%' 

SELECT MAX(Id) FROM Grupo

SELECT * FROM Grupo

SELECT * FROM Pais 
	WHERE Pais LIKE '%Gales%'

SELECT MAX(Id) FROM Pais

--Agregar Paises Faltantes
SET IDENTITY_INSERT Pais ON
INSERT INTO Pais
	(Id, Pais, Entidad)
	VALUES(72, 'Gales', 'Asociación de Fútbol de Gales')
SET IDENTITY_INSERT Pais ON

--Agregar Grupo al Campeonato
SET IDENTITY_INSERT Grupo ON
INSERT INTO Grupo
	(Id, Grupo,IdCampeonato)
	VALUES (26, 'B', 11)
INSERT INTO Grupo
	(Id, Grupo,IdCampeonato)
	VALUES (27, 'C', 11)
SET IDENTITY_INSERT Grupo OFF

--Agregar Paises al Grupo
INSERT INTO GrupoPais
	(IdGrupo,IdPais)
	VALUES (26, 28),
		(26, 7),
		(26, 55),
		(26, 72)