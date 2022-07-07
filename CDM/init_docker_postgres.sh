#!/bin/sh

# Populate tables
echo "Populating tables"
psql -U $POSTGRES_USER -c "CREATE SCHEMA IF NOT EXISTS $TEMP_SCHEMA_NAME;"
psql -U $POSTGRES_USER -c "CREATE SCHEMA IF NOT EXISTS $WEB_API_SCHEMA_NAME;"
psql -U $POSTGRES_USER -d $POSTGRES_DB -c "CREATE SCHEMA IF NOT EXISTS $CDM_SCHEMA_NAME;"
sed "s/@cdmDatabaseSchema/$CDM_SCHEMA_NAME/g" /data/DDL/OMOPCDM_postgresql_5.4_ddl.sql | psql -U $POSTGRES_USER -d $POSTGRES_DB 
sed "s/@cdmDatabaseSchema/$CDM_SCHEMA_NAME/g" /data/DDL/OMOPCDM_postgresql_5.4_indices.sql | psql -U $POSTGRES_USER -d $POSTGRES_DB 
sed "s/@cdmDatabaseSchema/$CDM_SCHEMA_NAME/g" /data/DDL/OMOPCDM_postgresql_5.4_primary_keys.sql | psql -U $POSTGRES_USER -d $POSTGRES_DB 

# Populate vocabularies
fileNames=("CONCEPT" "CONCEPT_ANCESTOR" "CONCEPT_CLASS" "CONCEPT_RELATIONSHIP" "CONCEPT_SYNONYM" "DOMAIN" "DRUG_STRENGTH" "RELATIONSHIP" "VOCABULARY")
echo "Populating vocabularies"
for fileName in ${fileNames[@]}; do
    if test -f "/data/vocabularies/$fileName.csv"; then
        echo "-- $fileName"
        psql -U $POSTGRES_USER -c "\COPY $CDM_SCHEMA_NAME.$fileName FROM '/data/vocabularies/$fileName.csv' DELIMITER E'\t' CSV HEADER QUOTE E'\b';"
    fi
done

# Populating constraints
sed "s/@cdmDatabaseSchema/$CDM_SCHEMA_NAME/g" /data/DDL/OMOPCDM_postgresql_5.4_constraints.sql | psql -U $POSTGRES_USER -d $POSTGRES_DB 
