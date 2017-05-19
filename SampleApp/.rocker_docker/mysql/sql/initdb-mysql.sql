
CREATE DATABASE IF NOT EXISTS rocker_docker_development;
CREATE DATABASE IF NOT EXISTS rocker_docker_test;
CREATE DATABASE IF NOT EXISTS rocker_docker_staging;
CREATE DATABASE IF NOT EXISTS rocker_docker_production;
GRANT ALL PRIVILEGES ON rocker_docker_development.* TO 'user'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON rocker_docker_test.* TO 'user'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON rocker_docker_staging.* TO 'user'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON rocker_docker_production.* TO 'user'@'%' WITH GRANT OPTION;
SHOW DATABASES ;
