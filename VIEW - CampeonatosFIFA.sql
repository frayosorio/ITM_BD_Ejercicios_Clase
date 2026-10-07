--Creación de la vista de ENCUENTROS
CREATE OR ALTER VIEW vEncuentros
AS
	SELECT E.Id, E.Fecha,
		E.IdPais1 IdSeleccion1,
		P1.Pais Seleccion1, E.Goles1, E.Penalties1, E.Penalties2, E.Goles2, P2.Pais Seleccion2,
		E.IdPais2 IdSeleccion2,
		F.Fase, E.IdFase,
		C.Campeonato, E.IdCampeonato,
		ES.Estadio + '-' + CD.Ciudad + ' (' + PE.Pais + ')' Estadio, E.IdEstadio
		FROM Encuentro E
			JOIN Pais P1 ON E.IdPais1 = P1.Id
			JOIN Pais P2 ON E.IdPais2 = P2.Id
			JOIN Fase F ON E.IdFase = F.Id
			JOIN Campeonato C ON C.Id = E.IdCampeonato
			JOIN Estadio ES ON ES.Id = E.IdEstadio
			JOIN Ciudad CD ON CD.Id = ES.IdCiudad
			JOIN Pais PE ON PE.Id = CD.IdPais
GO

--Uso de la vista
--Listar los encuentros de un grupo
SELECT G.Grupo, E.*
	FROM vEncuentros E
		JOIN Grupo G ON G.IdCampeonato=E.IdCampeonato
		JOIN GrupoPais GP ON GP.IdGrupo=G.Id
							AND GP.IdPais=E.IdSeleccion1
	WHERE G.Id=16 -- Grupo H FIFA 2026
		AND E.IdFase=1
	ORDER BY E.Fecha


-- Vista de ESTADIOS
CREATE OR ALTER VIEW vEstadios
AS
	SELECT ES.Id, ES.Estadio, CD.Ciudad,
		PE.Pais, ES.Capacidad
		FROM Estadio ES
			JOIN Ciudad CD ON CD.Id = ES.IdCiudad
			JOIN Pais PE ON PE.Id = CD.IdPais
GO

--Prueba
SELECT *
	FROM vEstadios
	WHERE Pais LIKE '%Esta%'

-- Lista de Valores
SELECT *
	FROM (
	VALUES
	(112, 0, 0, '2026-06-15', 18),
	(99, 1, 1, '2026-06-15', 25),
	(93, 4, 0, '2026-06-21', 18),
	(118, 2, 2, '2026-06-21', 25),
	(74, 1, 0, '2026-06-26', 13),
	(106, 0, 0, '2026-06-26', 22)
	) AS Datos(Id, Goles1, Goles2, Fecha, IdEstadio)

-- Actualizar con base en lista de Valores
UPDATE E
SET
	E.Goles1= Datos.Goles1,
	E.Goles2= Datos.Goles2,
	E.Fecha= Datos.Fecha,
	E.IdEstadio= Datos.IdEstadio
FROM Encuentro E
	JOIN (
		VALUES
		(112, 0, 0, '2026-06-15', 18),
		(99, 1, 1, '2026-06-15', 25),
		(93, 4, 0, '2026-06-21', 18),
		(118, 2, 2, '2026-06-21', 25),
		(74, 1, 0, '2026-06-26', 13),
		(106, 0, 0, '2026-06-26', 22)
		) AS Datos(Id, Goles1, Goles2, Fecha, IdEstadio)
	ON E.Id = Datos.Id