--Obtener la tabla de psociciones de un grupo
-- (Por ejemplo el Grupo A del Campeonato FIFA U-20 Women''s World Cup Colombia 2024
-- cuyo ID es el 19)

WITH Resultados AS (
	SELECT GP.IdPais,
		COUNT(*) PJ,
		SUM(CASE WHEN ((E.IdPais1=GP.IdPais AND E.Goles1>E.Goles2) OR 
				(E.IdPais2=GP.IdPais AND E.Goles2>E.Goles1))
			THEN 1
			ELSE 0
			END) PG,
		SUM(CASE WHEN E.Goles1=E.Goles2
			THEN 1
			ELSE 0
			END) PE,
		SUM(CASE WHEN ((E.IdPais1=GP.IdPais AND E.Goles1<E.Goles2) OR 
				(E.IdPais2=GP.IdPais AND E.Goles2<E.Goles1))
			THEN 1
			ELSE 0
			END) PP,
		SUM(CASE WHEN E.IdPais1 = GP.IdPais THEN E.Goles1 ELSE E.Goles2 END) GF,
		SUM(CASE WHEN E.IdPais1 = GP.IdPais THEN E.Goles2 ELSE E.Goles1 END) GC
		FROM Grupo G
			JOIN GrupoPais GP ON GP.IdGrupo=G.Id
			JOIN Encuentro E ON G.IdCampeonato=E.IdCampeonato
				AND E.IdFase=1
				AND (GP.IdPais=E.IdPais1 OR GP.IdPais=E.IdPais2)
		WHERE G.Id = 19
		GROUP BY GP.IdPais
	),
	Posiciones AS (
	SELECT ROW_NUMBER() OVER(ORDER BY R.PG*3+R.PE DESC, R.GF-R.GC DESC, R.GF DESC) Posicion,
		IdPais, P.Pais, R.PJ, R.PG, R.PE, R.PP, R.GF, R.GC, 
		R.GF-R.GC Diferencia, R.PG*3+R.PE Puntos
		FROM Resultados R
			JOIN Pais P ON R.IdPais=P.Id
	)
	SELECT *
		FROM Posiciones