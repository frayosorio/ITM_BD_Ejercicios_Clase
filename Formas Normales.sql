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

-- Ejemplos de incumplimiento:
CREATE TABLE Pais(
    Id int IDENTITY(1,1),
    Nombre varchar(100) NOT NULL,
    CodigoAlfa varchar(5) NOT NULL,
	Ciudades varchar(max) -- "Medellín, Bogotá, Cali"
)

--------------------------------------------
CREATE TABLE ProgramaAcademico(
    Id int IDENTITY(1,1),
    Nombre varchar(100) NOT NULL,
    Asignaturas varchar(max), -- "Base de Datos, Lógica de Programación, Lenguajes de Progrmación",
	Estudiantes varchar(max) -- "Elber Gómez Torva, Rosa Mesa Cabeza, Alan Brito"
)

-- Esto viola la 1FN porque guardan múltiples valores.

--Lo correcto para el primer ejemplo sería:
CREATE TABLE Pais(
    Id int IDENTITY(1,1),
    CONSTRAINT pkPais_Id PRIMARY KEY (Id),
    Nombre varchar(100) NOT NULL,
    CodigoAlfa varchar(5) NOT NULL
)

CREATE TABLE Ciudad(
    Id int IDENTITY(1,1),
    CONSTRAINT pkCiudad_Id PRIMARY KEY (Id),
    Nombre varchar(100) NOT NULL,
    IdPais int NOT NULL,
    CONSTRAINT fkCiudad_Pais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
)

--Lo correcto para el segundo ejemplo sería:
CREATE TABLE ProgramaAcademico(
    Id int IDENTITY(1,1),
    CONSTRAINT pkProgramaAcademico_Id PRIMARY KEY (Id),
    Nombre varchar(100) NOT NULL
)

CREATE TABLE Persona(
    Id int IDENTITY(1,1),
    CONSTRAINT pkPersona_Id PRIMARY KEY (Id),
    Nombre varchar(100) NOT NULL,
    ...
)

CREATE TABLE Asignatura(
    Id int IDENTITY(1,1),
    CONSTRAINT pkAsignatura_Id PRIMARY KEY (Id),
    Nombre varchar(100) NOT NULL,
    Codigo varchar(20) NOT NULL,
    ...
)

CREATE TABLE Matricula(
    IdPersona INT NOT NULL,
    IdPrograma INT NOT NULL,
    CONSTRAINT pkMatricula PRIMARY KEY (IdPersona, IdPrograma),
    CONSTRAINT fkMatricula_Persona FOREIGN KEY (IdPersona) REFERENCES Persona(Id),
    CONSTRAINT fkMatricula_Programa FOREIGN KEY (IdPrograma) REFERENCES ProgramaAcademico(Id)
)

CREATE TABLE ProgramaAsignatura(
    IdAsignatura INT NOT NULL,
    IdPrograma INT NOT NULL,
    Nivel INT NOT NULL,
    CONSTRAINT pkProgramaAsignatura PRIMARY KEY (IdAsignatura, IdPrograma),
    CONSTRAINT fkProgramaAsignatura_Asignatura FOREIGN KEY (IdAsignatura) REFERENCES Asignatura(Id),
    CONSTRAINT fkProgramaAsignatura_Programa FOREIGN KEY (IdPrograma) REFERENCES ProgramaAcademico(Id)
)

-- ***** Segunda Forma Normal (2FN) *****
-- Aplica solo si hay claves primarias compuestas.
-- Una tabla está en 2FN si:
-- * Está 1FN
-- * Cada atributo no clave, depende de toda la clave primaria, no de una parte

-- Ejemplo de incumplimiento:
CREATE TABLE GrupoPais (
	IdGrupo int NOT NULL,
	IdPais int NOT NULL,
    CONSTRAINT pkGrupoPais PRIMARY KEY (IdGrupo, IdPais),
	NombreGrupo varchar(10) NOT NULL
)

-- Esto viola la 2FN porque [NombreGrupo] depende solo de [IdGrupo], no de ambos.

----------------------------------

CREATE TABLE Campeonato(
    Id int IDENTITY(1,1),
    CONSTRAINT pkCampeonato PRIMARY KEY (Id),
    Nombre varchar(100) NOT NULL,
    Año int
)

CREATE TABLE CampeonatoPais(
    IdCampeonato int,
    IdPais int,
    CONSTRAINT pkCampeonatoPais PRIMARY KEY (IdCampeonato, IdPais),
    CONSTRAINT fkCampeonatoPais_Campeonato FOREIGN KEY (IdCampeonato) REFERENCES Campeonato(Id),
    NombrePais varchar(100) NOT NULL
)

+---+----------------+------+
|Id | Nombre         | Año  |
+---+----------------+------+
| 1 | World Cup 1970 | 1970 |
| 2 | World Cup 1986 | 1986 |
| 3 | World Cup 2026 | 2026 |


+-------------+--------+----------------+
|IdCampeonato | IdPais | NombrePais     |
+-------------+--------+----------------+
| 1           | 1      | México         |
| 2           | 4      | Colombia       |
| 3           | 1      | México         |
| 3           | 2      | Estados Unidos |
| 3           | 3      | Canadá         |

-- Esto viola la 2FN porque [NombrePais] depende solo de [IdPais], no de ambos.

--Lo correcto para este ejemplo sería:

CREATE TABLE Campeonato(
    Id int IDENTITY(1,1),
    CONSTRAINT pkCampeonato PRIMARY KEY (Id),
    Nombre varchar(100) NOT NULL,
    Año int
)

CREATE TABLE Pais(
    Id int IDENTITY(1,1),
    CONSTRAINT pkPais_Id PRIMARY KEY (Id),
    Nombre varchar(100) NOT NULL,
    ...
)

CREATE TABLE CampeonatoPais(
    IdCampeonato int,
    IdPais int,
    CONSTRAINT pkCampeonatoPais PRIMARY KEY (IdCampeonato, IdPais),
    CONSTRAINT fkCampeonatoPais_Campeonato FOREIGN KEY (IdCampeonato) REFERENCES Campeonato(Id),
    CONSTRAINT fkCampeonatoPais_Pais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
)

-- ***** Tercera Forma Normal (3FN) *****
-- Una tabla está en 3FN si:
-- * Está 2FN
-- * No tiene dependencias transitivas, es decir, un campo no clave depende de otro campo no clave

-- Ejemplos de incumplimiento:
CREATE TABLE Ciudad(
	Id int IDENTITY(1,1) NOT NULL,
	Nombre varchar(100) NOT NULL,
	IdPais int NOT NULL,
	NombrePais varchar(100) NOT NULL,
	BancoCentral varchar(100) NULL
)

--Lo correcto para este ejemplo sería:
CREATE TABLE Pais(
    Id int IDENTITY(1,1) NOT NULL,
    CONSTRAINT pkPais_Id PRIMARY KEY (Id),
	Nombre varchar(100) NOT NULL,
	BancoCentral varchar(100) NULL
)

CREATE TABLE Ciudad(
	Id int IDENTITY(1,1) NOT NULL,
    CONSTRAINT pkCiudad_Id PRIMARY KEY (Id),
	Nombre varchar(100) NOT NULL,
	IdPais int NOT NULL,
    CONSTRAINT fkCiudad_Pais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
    )