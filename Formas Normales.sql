-------------------------------------------------------------------------------------
-- Las formas normales (FN) son reglas que garantizan 
-- que una base de datos esté bien diseñada, evitando:
-- * Redundancia innecesaria
-- * Inconsistencias
-- * Anomalías en inserciones, eliminaciones y actualizaciones
--
-- Cada forma normal depende de la anterior.
-------------------------------------------------------------------------------------

-- ***** Primera Forma Normal (1FN) *****
-- Una tabla está en 1FN si:
-- * Cada campo tiene un solo valor (no multivalores, no listas).
-- * Todas las filas son únicas
-- * Todos los datos son atómicos
-- Ejemplo de incumplimiento:

CREATE TABLE Pais(
    Id int IDENTITY(1,1),
    Pais varchar(100) NOT NULL,
    Entidad varchar(100) NOT NULL,
	Ciudades varchar(max) -- "Medellín, Bogotá, Cali"
)

-- Esto viola la 1FN porque guarda múltiples valores.

-- ***** Segunda Forma Normal (2FN) *****
-- Aplica solo si hay claves primarias compuestas.
-- Una tabla está en 2FN si:
-- * Está 1FN
-- * Cada atributo no clave depende toda la clave primaria, no de una parte
-- Ejemplo de incumplimiento:

CREATE TABLE GrupoPais (
	IdGrupo int NOT NULL,
	IdPais int NOT NULL,
	NombreGrupo varchar(10) NOT NULL
	)

-- Esto viola la 2FN porque [NombreGrupo] depende solo de [IdGrupo], no de ambos.

-- ***** Tercera Forma Normal (3FN) *****
-- Una tabla está en 3FN si:
-- * Está 2FN
-- * No tiene dependencias transitivas, es decir, un campo no clave depende de otro campo no clave

CREATE TABLE Ciudad(
	Id int IDENTITY(1,1) NOT NULL,
	Ciudad varchar(100) NOT NULL,
	IdPais int NOT NULL,
	NombrePais varchar(100) NOT NULL,
	Entidad varchar(100) NULL
)

-- Esto viola la 3FN porque [NombrePais] y [Entidad} dependen de [IdPais], no de la Ciudad.

-- ***** Boyce Codd Normal Form (BCNF) *****
-- Un determinante es cualquier atributo o conjunto de atributos 
-- que determina a otro atributo mediante una dependencia funcional.
-- Una tabla está en BCNF si todo determinante es una clave.

CREATE TABLE Encuentro(
	Id int IDENTITY(1,1) NOT NULL, 
	IdPais1 int NOT NULL, 
	IdPais2 int NOT NULL, 
	IdFase int NOT NULL, 
	IdCampeonato int NOT NULL, 
	IdEstadio int NOT NULL, 
	Fecha smalldatetime NULL, 
	Goles1 int NULL, 
	Goles2 int NULL,
	Penalties1 int NULL, 
	Penalties2 int NULL
	)

-- Dado que no puede darse el mismo encuentro entre dos paises en la misma fase
-- si no se crea el siguiente índice, se incumpliría la BCNF

CREATE UNIQUE INDEX ixEncuentro_Encuentro
		ON Encuentro(IdCampeonato, IdFase, IdPais1, IdPais2)

-- ***** Cuarta Forma Normal (4FN) *****
-- Una tabla está en 4FN si:
-- * Está 3FN
-- * No tiene dependencias con multiples valores

CREATE TABLE Titulo(
	Id INT IDENTITY NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	Año INT NULL,
	Version VARCHAR(20) NOT NULL DEFAULT '1',
	PrecioActual FLOAT NOT NULL DEFAULT 0,
	Existencia INT NOT NULL DEFAULT 0,
	IdDesarrollador INT NOT NULL,
	Plataformas varchar(max) NULL,
	Categorias varchar(max) NULL,
)

-- Esto viola la 4FN porque hay dos campos con listas con multiples valores

-- ***** Quinta Forma Normal (5FN) *****
-- Evita redundancias cuando una tabla compleja puede dividirse 
-- en tres o más tablas relacionadas sin pérdida de información.

CREATE TABLE Asignatura(
	Id INT IDENTITY NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	Codigo VARCHAR(10) NOT NULL
)

CREATE TABLE Periodo(
	Id INT IDENTITY NOT NULL,
	Año INT NOT NULL,
	Consecutivo INT NOT NULL
)

CREATE TABLE Curso(
	IdAsignatura INT NOT NULL,
	IdPeriodo INT NOT NULL,
	Consecutivo INT NOT NULL,

	Horario VARCHAR(100),
	CedulaProfesor VARCHAR(10),
	NombreProfesor VARCHAR(100)
	...
)

CREATE TABLE Estudiante(
	Id INT IDENTITY NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	...
)

CREATE TABLE CursoMatriculado(
	IdEstudiante INT NOT NULL,

	IdAsignatura INT NOT NULL,
	IdPeriodo INT NOT NULL,
	Consecutivo INT NOT NULL,

)

-- la tabla [CursoMatriculado] incumple 5FN