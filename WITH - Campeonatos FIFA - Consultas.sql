SELECT *
	FROM vGrupos
	WHERE Campeonato='FIFA U-20 Women''s World Cup Colombia 2024'
	AND Grupo='A'

SELECT DISTINCT G.Grupo, E.*
	FROM vEncuentros E
		JOIN Grupo G ON G.IdCampeonato=E.IdCampeonato
		JOIN GrupoPais GP ON GP.IdGrupo=G.Id
							AND (GP.IdPais=E.IdPais1 OR GP.IdPais=E.IdPais2)
	WHERE Campeonato='FIFA U-20 Women''s World Cup Colombia 2024'
	AND Fase = 'Grupos'
	AND G.Grupo = 'A'
