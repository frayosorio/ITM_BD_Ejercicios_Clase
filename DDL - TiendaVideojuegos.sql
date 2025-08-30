CREATE DATABASE TiendaVideoJuegosITM


USE TiendaVideoJuegosITM

--Crear la tabla TIPODOCUMENTO
CREATE TABLE TipoDocumento(
	Id int IDENTITY NOT NULL,
	Nombre varchar(100) NOT NULL,
	Sigla varchar(5) NOT NULL
)

ALTER TABLE TipoDocumento
	ADD CONSTRAINT pk_TipoDocumento_Id PRIMARY KEY(Id)

--Crear los índices de la tabla TIPODOCUMENTO
CREATE UNIQUE INDEX ix_TipoDocumento_Nombre
	ON TipoDocumento(Nombre)

CREATE UNIQUE INDEX ix_TipoDocumento_Sigla
	ON TipoDocumento(Sigla)

--Crear la tabla FORMATO
CREATE TABLE Formato(
	Id int IDENTITY NOT NULL,
	CONSTRAINT pk_Formato_Id PRIMARY KEY(Id),
	Nombre varchar(50) NOT NULL
)

--Crear los índices de la tabla FORMATO
CREATE UNIQUE INDEX ix_Formato_Nombre
	ON Formato(Nombre)

--Crear la tabla CATEGORIA
CREATE TABLE Categoria(
	Id int IDENTITY NOT NULL,
	CONSTRAINT pk_Categoria_Id PRIMARY KEY(Id),
	Nombre varchar(50) NOT NULL
)

--Crear los índices de la tabla Categoria
CREATE UNIQUE INDEX ix_Categoria_Nombre
	ON Categoria(Nombre)

--Crear la tabla PLATAFORMA
CREATE TABLE Plataforma(
	Id int IDENTITY NOT NULL,
	CONSTRAINT pk_Plataforma_Id PRIMARY KEY(Id),
	Nombre varchar(50) NOT NULL,
	Año int NULL,
	Portable bit NOT NULL
)

--Crear los índices de la tabla PLATAFORMA
CREATE UNIQUE INDEX ix_Plataforma_Nombre
	ON Plataforma(Nombre)

--Crear la tabla FORMATO
CREATE TABLE Pais(
	Id int IDENTITY NOT NULL,
	CONSTRAINT pk_Pais_Id PRIMARY KEY(Id),
	Nombre varchar(50) NOT NULL,
	CodigoAlfa VARCHAR(5) NOT NULL,
	Indicativo INT NULL
)

--Crear los índices de la tabla FORMATO
CREATE UNIQUE INDEX ix_Pais_Nombre
	ON Pais(Nombre)

CREATE UNIQUE INDEX ix_Pais_CodigoAlfa
	ON Pais(CodigoAlfa)

--Crear la tabla REGION
CREATE TABLE Region(
	Id int IDENTITY NOT NULL,
	CONSTRAINT pk_Region_Id PRIMARY KEY(Id),
	Nombre varchar(50) NOT NULL,
	Codigo varchar(5) NOT NULL,
	IdPais int NOT NULL,
	CONSTRAINT fk_Region_IdPais FOREIGN KEY(IdPais) REFERENCES Pais(Id)
)

--Crear los índices de la tabla REGION
CREATE UNIQUE INDEX ix_Region_Nombre
	ON Region(IdPais, Nombre)

--Crear tabla DESARROLLADOR
CREATE TABLE Desarrollador(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Desarrolador_Id PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	IdPais INT NOT NULL,
	CONSTRAINT fk_Desarrollador_IdPais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
)

--Crear indice de la tabla DESARROLLADOR
CREATE UNIQUE INDEX ix_Desarrollador_Nombre
	ON Desarrollador(Nombre)

--Crear tabla TITULO
CREATE TABLE Titulo(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Titulo_Id PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	Año INT NULL,
	Version VARCHAR(20) NOT NULL DEFAULT '1',
	PrecioActual FLOAT NOT NULL DEFAULT 0,
	IdDesarrollador INT NOT NULL,
	CONSTRAINT fk_Titulo_IdDesarrollador FOREIGN KEY (IdDesarrollador) REFERENCES Desarrollador(Id)
)

--Crear indice de la tabla TITULO
CREATE UNIQUE INDEX ix_Titulo_Nombre
	ON Titulo(Nombre, Version)

--Crear tabla TITULOFORMATO
CREATE TABLE TituloFormato(
	IdTitulo INT NOT NULL,
	CONSTRAINT fk_TituloFormato_IdTitulo 
		FOREIGN KEY (IdTitulo) REFERENCES Titulo(Id),
	IdFormato INT NOT NULL,
	CONSTRAINT fk_TituloFormato_IdFormato 
		FOREIGN KEY (IdFormato) REFERENCES Formato(Id),
	CONSTRAINT pk_TituloFormato
		PRIMARY KEY(IdTitulo, IdFormato)
)

