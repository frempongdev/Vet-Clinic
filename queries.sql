/*Queries that provide answers to the questions from all projects.*/

-- SELECT * from animals WHERE name = 'Luna';

SELECT * FROM animals;

SELECT * FROM animals WHERE name::text LIKE '%mon';

SELECT name FROM animals where date_of_birth BETWEEN '2016,01,01' AND '2019,01,01';

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');

SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name NOT IN ('Gabumon');

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <=17.3;

-- Transaction (Rolledback), that add 'unspecified' to spcecies column of all animals 
BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

-- Transaction that sets the species of all animals 
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name::text LIKE '%mon';
SELECT * FROM animals;

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;

-- Tansaction to Delete all content of the animals Table.
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Transaction to change all negative weights to positive weights in the animal Table.
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022,01,1';
SELECT * FROM animals;

SAVEPOINT SP1;

UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;

ROLLBACK TO SAVEPOINT SP1;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;

COMMIT;