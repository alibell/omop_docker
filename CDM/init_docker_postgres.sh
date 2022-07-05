#!/bin/sh

# Populate tables
psql -U $POSTGRES_USER -d $POSTGRES_DB -c "CREATE SCHEMA IF NOT EXISTS $OMOP_SCHEMA_NAME;"
sed "s/@cdmDatabaseSchema/$OMOP_SCHEMA_NAME/g" /data/DDL/OMOPCDM_postgresql_5.4_ddl.sql | psql -U $POSTGRES_USER -d $POSTGRES_DB 
sed "s/@cdmDatabaseSchema/$OMOP_SCHEMA_NAME/g" /data/DDL/OMOPCDM_postgresql_5.4_indices.sql | psql -U $POSTGRES_USER -d $POSTGRES_DB 
sed "s/@cdmDatabaseSchema/$OMOP_SCHEMA_NAME/g" /data/DDL/OMOPCDM_postgresql_5.4_primary_keys.sql | psql -U $POSTGRES_USER -d $POSTGRES_DB 
sed "s/@cdmDatabaseSchema/$OMOP_SCHEMA_NAME/g" /data/DDL/OMOPCDM_postgresql_5.4_constraints.sql | psql -U $POSTGRES_USER -d $POSTGRES_DB 

# Populate vocabularies