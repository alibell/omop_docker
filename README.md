# OMOP Docker

## Aim of this repository

This repository provide DockerFile and docker compose for an OMOP + WebAPI + ATLAS installation. Useful for educational purpose.

## How to use

### Configuration

The configuration is performed by defining the environment variables in the `env` file.  
The variables are:

|Parameter|Description|
|:--------|:----------|
|POSTGRES_USER|Username of the postgres database|
|POSTGRES_PASSWORD|Password of the postgres database|
|POSTGRES_DB|Name of the postgres database|
|CDM_SCHEMA_NAME|Schema for the OMOP CDM database|
|WEB_API_SCHEMA_NAME|Schema for the WebAPI and Atlas database|
|TEMP_SCHEMA_NAME|Schema for the temporary tables database|
|WEBAPI_URL|Expected URL for the WEBAPI with port|

### Get OMOP vocabularies

The Vocabularies should be Downloaded from [ATHENA website](https://athena.ohdsi.org/) and the CSV file copied in the `CDM/data/vocabularies` folder.  
If you want to use your own local Vocabularies files, the expected files are : `CONCEPT.csv` `CONCEPT_ANCESTOR.csv` `CONCEPT_CLASS.csv` `CONCEPT_RELATIONSHIP.csv` `CONCEPT_SYNONYM.csv` `DOMAIN.csv` `DRUG_STRENGTH.csv` `RELATIONSHIP.csv` `VOCABULARY.csv`.  
Any missing file will result in an empty corresponding table.  
The files should be **tabulation separated**, containing and header and encoded in **UTF-8**.

### Run the docker

`docker compose up`

### Acces to Atlas and WebAPI

Atlas is located in `http://$WEBAPI_URL/atlas`, by default: `http://localhost:8080/atlas`
WebAPI is located in `http://$WEBAPI_URL/WebAPI`, by default: `http://localhost:8080/WebAPI`


## To do

- [x] CDM DockerFile
  - [x] Configure the Posgresql database
  - [x] Integrate the ATHENA vocabularies in the database
  - [ ] Data generation (Synthea) according to the environment variable parameters (/!\ Synthea is slow /!\)
- [x] WebAPI and Atlas DockerFile