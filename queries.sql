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

-- Queries to answer quetions
SELECT COUNT(*) AS all_animals FROM animals;

SELECT COUNT(escape_attempts) AS animals_without_escape FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) AS all_escapes FROM animals GROUP BY neutered ORDER BY all_escapes DESC;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) AS average_escape_of_1990_to_2000_borns FROM animals WHERE date_of_birth BETWEEN '1990,01,01' AND '2000,01,01' GROUP BY species;


SELECT name AS pets_of_Melody FROM animals JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT animals.name AS all_pokemons FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT owners.full_name AS owner, animals.name AS animals FROM owners LEFT JOIN animals ON owners.id = animals.owners_id;

SELECT species.name AS species, COUNT(animals.name) AS total_animals FROM species RIGHT JOIN animals ON species.id = animals.species_id GROUP BY species.name;

SELECT animals.name AS all_Jennifer_Digimons FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name AS all_no_ecape_animals_of_Dean FROM animals JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name AS owner_with_most_animals, COUNT(animals.name) AS number_of_animals FROM owners RIGHT JOIN animals ON owners.id = animals.owners_id GROUP BY owners.full_name ORDER BY number_of_animals DESC LIMIT 1;


SELECT animals.name AS last_animal_seen_by_William FROM animals INNER JOIN visits ON animals.id = visits.animal_id INNER JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'William Tatcher' ORDER BY visits.date_of_visit DESC LIMIT 1;

SELECT COUNT(DISTINCT visits.animal_id) AS kinds_of_animals_Stephanie_seen FROM visits INNER JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name, species.name AS specialty FROM vets LEFT JOIN specialization ON vets.id = specialization.vets_id LEFT JOIN species ON specialization.species_id = species.id;