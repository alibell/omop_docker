FROM postgres:latest

# Copying the content of the data folder
COPY data /data
COPY init_docker_postgres.sh /docker-entrypoint-initdb.d/

# Set default username
ENV POSTGRES_USER=omop
ENV POSTGRES_DB=omop
ENV CDM_SCHEMA_NAME=cdm
ENV WEB_API_SCHEMA_NAME=webapi

EXPOSE 5432
CMD ["postgres"]