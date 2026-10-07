-- listar los encuentros del grupo H del Campeonato FIFA 2026

WITH PaisesxGrupo AS (
	SELECT GP.IdPais, G.IdCampeonato
		FROM GrupoPais GP
			JOIN Grupo G ON GP.IdGrupo=G.Id
		WHERE GP.IdGrupo=16 -- Grupo H FIFA 2026
	)
	SELECT E.Fecha, E.Seleccion1, E.Goles1, E.Goles2, E.Seleccion2, E.Estadio
		FROM vEncuentros E
			JOIN PaisesxGrupo PG
				ON PG.IdPais=E.IdSeleccion1 AND PG.IdCampeonato=E.IdCampeonato
		WHERE E.IdFase=1

-- Obtener la tabla de posiciones del grupo H del Campeonato FIFA 2026