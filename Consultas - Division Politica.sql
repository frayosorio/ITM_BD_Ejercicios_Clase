
select * from Pais P
	JOIN Continente C ON P.IdContinente=C.Id
	JOIN TipoRegion T ON P.IdTipoRegion=T.Id