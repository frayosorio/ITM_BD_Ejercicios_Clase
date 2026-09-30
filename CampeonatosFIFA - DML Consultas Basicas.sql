-- Lista de Campeonatos con los grupos y paises organizadores y participantes
SELECT C.Campeonato, STRING_AGG(P.Pais, ', ') Organizadores,
	G.Grupo, PG.Pais Seleccion
	FROM Campeonato C
		JOIN CampeonatoPais CP ON C.Id = CP.IdCampeonato
		JOIN Pais P ON P.Id = CP.IdPais
		JOIN Grupo G ON C.Id = G.IdCampeonato
		JOIN GrupoPais GP ON G.Id = GP.IdGrupo
		JOIN Pais PG ON PG.Id = GP.IdPais
	GROUP BY C.Campeonato, G.Grupo, PG.Pais
	ORDER BY 1, 3, 4

--Consulta con información completa de cada encuentro
SELECT P1.Pais Seleccion1, E.Goles1, E.Goles2, P2.Pais Seleccion2,
	F.Fase, C.Campeonato,
	ES.Estadio + '-' + CD.Ciudad + ' (' + PE.Pais + ')' Estadio
	FROM Encuentro E
		JOIN Pais P1 ON E.IdPais1 = P1.Id
		JOIN Pais P2 ON E.IdPais2 = P2.Id
		JOIN Fase F ON E.IdFase = F.Id
		JOIN Campeonato C ON C.Id = E.IdCampeonato
		JOIN Estadio ES ON ES.Id = E.IdEstadio
		JOIN Ciudad CD ON CD.Id = ES.IdCiudad
		JOIN Pais PE ON PE.Id = CD.IdPais 

	--WHERE P1.Pais = 'Colombia' OR P2.Pais='Colombia'