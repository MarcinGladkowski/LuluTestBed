-- Database: MusicStore

-- DROP DATABASE MusicStore;

CREATE DATABASE MusicStore
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


CREATE TABLE Band(
  Id SERIAL PRIMARY KEY,
  BandName VARCHAR(100) NOT NULL
);

CREATE TABLE Album(
  Id SERIAL PRIMARY KEY,
  AlbumName VARCHAR(100) NOT NULL,
  ReleaseDate DATE,
  BandId INTEGER NOT NULL,

  CONSTRAINT AlbumBand
    FOREIGN KEY (BandId)
    REFERENCES Band(Id)
    MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
);

CREATE TABLE Song(
  Id SERIAL PRIMARY KEY,
  SongName VARCHAR(100) NOT NULL,
  ReleaseDate DATE,
  AlbumId INTEGER,

  CONSTRAINT SongAlbum
    FOREIGN KEY (AlbumId)
    REFERENCES Album(Id)
    MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
);


CREATE TABLE Sale(
  Id SERIAL PRIMARY KEY,
  DateOfSale DATE DEFAULT NOW()::DATE
);

CREATE TABLE LineItem(
  Id SERIAL PRIMARY KEY,
  SaleId INTEGER NOT NULL,
  AlbumId INTEGER NOT NULL,
  Price MONEY DEFAULT '$9.99',

  CONSTRAINT SaleLineItem
    FOREIGN KEY (SaleId)
    REFERENCES Sale(Id)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
  
  CONSTRAINT AlbumLineItem
    FOREIGN KEY (AlbumId)
    REFERENCES Album(Id)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
);

CREATE TABLE PriceMap(
	AlbumId INTEGER NOT NULL,
	Price MONEY NOT NULL,

	CONSTRAINT PriceMapAlbum
		FOREIGN KEY (AlbumId)
		REFERENCES Album(Id)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);

INSERT INTO PriceMap SELECT Id, RANDOM()*30::MONEY FROM Album;