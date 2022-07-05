#!/bin/sh

# Populate tables
psql -U $POSTGRES_USER -d $POSTGRES_DB -c "CREATE SCHEMA IF NOT EXISTS $OMOP_SCHEMA_NAME;"
sed "s/@cdmDatabaseSchema/$OMOP_SCHEMA_NAME/g" /data/DDL/OMOPCDM_postgresql_5.4_ddl.sql | psql -U $POSTGRES_USER -d $POSTGRES_DB 
sed "s/@cdmDatabaseSchema/$OMOP_SCHEMA_NAME/g" /data/DDL/OMOPCDM_postgresql_5.4_indices.sql | psql -U $POSTGRES_USER -d $POSTGRES_DB 
sed "s/@cdmDatabaseSchema/$OMOP_SCHEMA_NAME/g" /data/DDL/OMOPCDM_postgresql_5.4_primary_keys.sql | psql -U $POSTGRES_USER -d $POSTGRES_DB 

# Populate vocabularies
fileNames=("CONCEPT" "VOCABULARY" "DOMAIN" "CONCEPT_CLASS" "CONCEPT_ANCESTOR" "CONCEPT_RELATIONSHIP" "CONCEPT_SYNONYM" "DRUG_STRENGTH" "RELATIONSHIP")

for fileName in ${fileNames[@]}; do
    echo "/data/vocabularies/$fileName.csv"
    if test -f "/data/vocabularies/$fileName.csv"; then
        psql -U $POSTGRES_USER -d $POSTGRES_DB -c "\COPY $OMOP_SCHEMA_NAME.$fileName FROM '/data/vocabularies/$fileName.csv' DELIMITER E'\t' CSV HEADER QUOTE E'\b';"
    fi
done

# Populate constraints
sed "s/@cdmDatabaseSchema/$OMOP_SCHEMA_NAME/g" /data/DDL/OMOPCDM_postgresql_5.4_constraints.sql | psql -U $POSTGRES_USER -d $POSTGRES_DB 