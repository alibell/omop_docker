FROM ohdsi/broadsea-webtools

# Copying files
COPY config-local.js /usr/local/tomcat/webapps/atlas/js/config-local.js
COPY entrypoint.sh /script/entrypoint.sh
COPY run_supervisord.sh /script/run_supervisord.sh
COPY sql /sql
RUN chmod +x /script/entrypoint.sh
RUN chmod +x /script/run_supervisord.sh

# Getting psql and bc
RUN apt-get update && apt-get install -y postgresql-client bc

# Setting environment variables default values
ENV POSTGRES_USER=omop
ENV POSTGRES_PASSWORD=password
ENV POSTGRES_DB=omop
ENV CDM_SCHEMA_NAME=omop
ENV WEB_API_SCHEMA_NAME=webapi
ENV TEMP_SCHEMA_NAME=temp
ENV WEBAPI_URL="0.0.0.0:8080"

ENTRYPOINT ["/script/entrypoint.sh"]
CMD ["/script/run_supervisord.sh"]