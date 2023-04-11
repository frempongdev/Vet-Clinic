/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

 CREATE TABLE animals (id integer PRIMARY KEY, name char(50), date_of_birth date, escape_attempts int, neutered boolean, weight_kg decimal(10,2));







-- CREATE TABLE animals (
--     name varchar(100)
-- );
