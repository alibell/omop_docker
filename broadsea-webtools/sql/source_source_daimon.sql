-- remove any previously added database connection configuration data
truncate @schema_api.source CASCADE;
truncate @schema_api.source_daimon;

-- OHDSI CDM source
INSERT INTO @schema_api.source( source_id, source_name, source_key, source_connection, source_dialect)
VALUES (1, 'OHDSI CDM V5 Database', 'OHDSI-CDMV5',
  'jdbc:postgresql://cdm:5432/@db?user=@user&password=@password', 'postgresql');

-- CDM daimon
INSERT INTO @schema_api.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (1, 1, 0, '@schema_cdm', 2);

-- VOCABULARY daimon
INSERT INTO @schema_api.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (2, 1, 1, '@schema_cdm', 2);

-- RESULTS daimon
INSERT INTO @schema_api.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (3, 1, 2, '@schema_api', 2);

-- EVIDENCE daimon
INSERT INTO @schema_api.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (4, 1, 3, '@schema_temp', 2);