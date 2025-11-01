SELECT * FROM Grupo

SELECT * FROM GrupoPais

SELECT * FROM Campeonato

SELECT * FROM Pais

SELECT * FROM Encuentro

GO

CREATE OR ALTER VIEW vGrupos
	AS
	SELECT G.IdCampeonato, C.Campeonato,
		C.IdPais IdPaisOrganizador, P.Pais PaisOrganizador,
		G.Id, G.Grupo,
		GP.IdPais, PG.Pais
		FROM Grupo G
			JOIN Campeonato C ON G.IdCampeonato=C.Id
			JOIN Pais P ON C.IdPais=P.Id
			LEFT JOIN GrupoPais GP ON GP.IdGrupo=G.Id
			LEFT JOIN Pais PG ON GP.IdPais=PG.Id
GO

CREATE OR ALTER VIEW vEncuentros
AS
	SELECT E.Fecha, E.IdPais1, P1.Pais Pais1, E.Goles1, E.IdPais2, P2.Pais Pais2, E.Goles2,
        C.Campeonato, E.IdCampeonato, E.IdFase, F.Fase, ES.Estadio+' ('+CD.Ciudad+')' Estadio, E.IdEStadio
		FROM Encuentro E
			JOIN Pais P1 ON E.IdPais1=P1.Id
			JOIN Pais P2 ON E.IdPais2=P2.Id
			JOIN Campeonato C ON E.IdCampeonato=C.Id
            JOIN Estadio ES ON E.IdEstadio=ES.Id
			JOIN Ciudad CD ON ES.IdCiudad=CD.Id
            JOIN Fase F ON E.IdFase=F.Id;
GO	

CREATE OR ALTER VIEW vEstadios
AS
	SELECT C.IdPais, P.Pais, E.IdCiudad, C.Ciudad, E.Id IdEstadio, E.Estadio, E.Capacidad
		FROM Pais P
			LEFT JOIN Ciudad C ON P.Id=C.IdPais
			LEFT JOIN Estadio E ON E.IdCiudad=C.Id