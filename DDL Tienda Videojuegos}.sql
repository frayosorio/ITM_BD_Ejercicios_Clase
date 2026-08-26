--Crear la base de datos
CREATE DATABASE TiendaVideojuegosITM
GO

USE TiendaVideojuegosITM
GO

--Crear la tabla PAIS
CREATE TABLE Pais (
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	CodigoAlfa VARCHAR(10) NOT NULL,
	Indicativo INT NULL,
	CONSTRAINT pkPais_Id PRIMARY KEY(Id)
)
GO

--Crear los indices de la tabla PAIS
CREATE UNIQUE INDEX ixPais_Nombre
	ON Pais(Nombre)
GO

CREATE UNIQUE INDEX ixPais_CodigoAlfa
	ON Pais(CodigoAlfa)
GO

--Crear la tabla REGION
CREATE TABLE Region (
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	Codigo VARCHAR(10) NULL,
	IdPais INT NOT NULL,
	CONSTRAINT pkRegion_Id PRIMARY KEY(Id),
	CONSTRAINT fkRegion_Pais FOREIGN KEY(IdPais) REFERENCES Pais(Id)
)
GO

--Crear los indices de la tabla REGION
CREATE UNIQUE INDEX ixRegion_Nombre
	ON Region(IdPais, Nombre)
GO

--Crear la tabla DESARROLLADOR
CREATE TABLE Desarrollador (
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	IdPais INT NOT NULL,
	CONSTRAINT pkDesarrollador_Id PRIMARY KEY(Id),
	CONSTRAINT fkDesarrollador_Pais FOREIGN KEY(IdPais) REFERENCES Pais(Id)
)
GO

--Crear los indices de la tabla DESARROLLADOR
CREATE UNIQUE INDEX ixDesarrollador_Nombre
	ON Desarrollador(Nombre)
GO

--Crear la tabla TITULO
CREATE TABLE Titulo(
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	Año INT NOT NULL,
	Version VARCHAR(20) NULL,
	Descripcion VARCHAR(MAX) NULL,
	PrecioActual DECIMAL(10,2) NULL,
	Existencia INT NOT NULL DEFAULT 0,
	IdDesarrollador INT NOT NULL,
	CONSTRAINT pkTitulo PRIMARY KEY (Id),
	CONSTRAINT fkTitulo_Desarrollador FOREIGN KEY (IdDesarrollador) REFERENCES Desarrollador(Id)
)
GO

CREATE UNIQUE INDEX ixTitulo_Nombre
	ON Titulo(Nombre, Año)
GO

--Crear la tabla FORMATO
CREATE TABLE Formato (
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	CONSTRAINT pkFormato PRIMARY KEY (Id)
)

CREATE UNIQUE INDEX ixFormato_Nombre
	ON Formato(Nombre)
GO

--Crear la tabla TITULO-FORMATO
CREATE TABLE TituloFormato (
	IdTitulo INT NOT NULL,
	IdFormato INT NOT NULL,
	CONSTRAINT pkTituloFormato PRIMARY KEY (IdTitulo, IdFormato),
	CONSTRAINT fkTituloFormato_Titulo FOREIGN KEY (IdTitulo) REFERENCES Titulo(Id),
	CONSTRAINT fkTituloFormato_Formato FOREIGN KEY (IdFormato) REFERENCES Formato(Id)
)
GO
