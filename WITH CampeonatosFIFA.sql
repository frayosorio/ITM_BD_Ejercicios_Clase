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
WITH PaisesxGrupo AS (
	SELECT GP.IdPais, G.IdCampeonato
		FROM GrupoPais GP
			JOIN Grupo G ON GP.IdGrupo=G.Id
		WHERE GP.IdGrupo=16 -- Grupo H FIFA 2026
	),
	ResultadosXPais AS (
		SELECT PG.IdPais, COUNT(*) PJ,
			SUM(CASE 
				WHEN E.IdPais1	= PG.IdPais AND E.Goles1 > E.Goles2
					THEN 1
				WHEN E.IdPais2	= PG.IdPais AND E.Goles2 > E.Goles1
					THEN 1
				ELSE 0
			END) PG,
			SUM(CASE 
				WHEN E.Goles1 = E.Goles2
					THEN 1
				ELSE 0
			END) PE,
			SUM(CASE 
				WHEN E.IdPais1	= PG.IdPais AND E.Goles1 < E.Goles2
					THEN 1
				WHEN E.IdPais2	= PG.IdPais AND E.Goles2 < E.Goles1
					THEN 1
				ELSE 0
			END) PP,
			SUM(CASE 
				WHEN E.IdPais1	= PG.IdPais 
					THEN E.Goles1
					ELSE E.Goles2
			END) GF,
			SUM(CASE 
				WHEN E.IdPais1	= PG.IdPais 
					THEN E.Goles2
					ELSE E.Goles1
			END) GC
			FROM PaisesxGrupo PG
				JOIN Encuentro E ON (E.IdPais1=PG.IdPais OR E.IdPais2=PG.IdPais)
					AND E.IdCampeonato = PG.IdCampeonato
					AND E.IdFase = 1
			GROUP BY PG.IdPais
	),
	Posiciones AS (
	SELECT P.Pais, PJ, PG, PE, PP, GF, GC, GF-GC DiferenciaGoles, PG*3+PE Puntos,
		ROW_NUMBER() OVER (ORDER BY PG*3+PE DESC, GF-GC DESC, GF DESC) Posicion
		FROM ResultadosXPais RP
			JOIN Pais P ON RP.IdPais = P.Id
	)
	SELECT *
		FROM Posiciones