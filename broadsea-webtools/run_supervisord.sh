#!/bin/sh

# This script run the supervisord after setting the environment variables

env "datasource_url=jdbc:postgresql://cdm:5432/$POSTGRES_DB" \
env "datasource_driverClassName=org.postgresql.Driver" \
env "datasource.cdm.schema=$CDM_SCHEMA_NAME" \
env "datasource.ohdsi.schema=$WEB_API_SCHEMA_NAME" \
env "datasource_url=jdbc:postgresql://cdm/$POSTGRES_DB" \
env "datasource_username=$POSTGRES_USER" \
env "datasource_password=$POSTGRES_PASSWORD" \
env "spring.jpa.properties.hibernate.default_schema=$WEB_API_SCHEMA_NAME" \
env "spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect" \
env "spring.batch.repository.tableprefix=$WEB_API_SCHEMA_NAME.BATCH_" \
env "flyway_datasource_url=jdbc:postgresql://cdm/$POSTGRES_DB" \
env "flyway_schemas=$WEB_API_SCHEMA_NAME" \
env "flyway.placeholders.ohdsiSchema=$WEB_API_SCHEMA_NAME" \
env "flyway_datasource_username=$POSTGRES_USER" \
env "flyway_datasource_password=$POSTGRES_PASSWORD" \
env "flyway.locations=classpath:db/migration/postgresql" \
env "flyway_datasource_driverClassName=org.postgresql.Driver" \
env "env=webapi-postgresql" \
/usr/bin/supervisord