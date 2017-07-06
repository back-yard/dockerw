
CREATE DATABASE IF NOT EXISTS sampleapp_development;
CREATE DATABASE IF NOT EXISTS sampleapp_test;
CREATE DATABASE IF NOT EXISTS sampleapp_staging;
CREATE DATABASE IF NOT EXISTS sampleapp_production;
GRANT ALL PRIVILEGES ON sampleapp_development.* TO 'user'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON sampleapp_test.* TO 'user'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON sampleapp_staging.* TO 'user'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON sampleapp_production.* TO 'user'@'%' WITH GRANT OPTION;
SHOW DATABASES ;
