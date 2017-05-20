[![asciicast](https://asciinema.org/a/121532.png)](https://asciinema.org/a/121532)

# Install Docker

### import gpg key
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

### add repository
```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

### install
```bash
sudo apt-get update
sudo apt-get install -y docker-ce
```

### update user permissions
```bash
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart
```

# Install docker compose
```bash
sudo -i
curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
exit
```

### using pip
```bash
sudo apt-get install -y python-pip
sudo pip install -U pip
sudo pip install -U docker-compose
```

# Hello, World!
```bash
docker images
docker pull hello-world
docker run -it --rm hello-world
```

# MySQL
```bash
docker pull mysql:latest
docker run --rm -d --name mysql-doc -e MYSQL_ROOT_PASSWORD=root -p 3300:3306 mysql
docker logs mysql-doc -f
mysql -P 3300 -h 0.0.0.0 -u root -p
docker ps
docker stop mysql-doc
```
# Ruby
```bash
docker pull ruby:latest
docker run --rm --name ruby-doc ruby ruby -v
```

# Running a rails app in docker
```bash
cd SampleApp
mkdir docker
cd docker

mkdir mysql
cd mysql
touch Dockerfile
```
copy the following in Dockerfile
......................................................................................
```
FROM mysql:latest
```
......................................................................................
```bash
cd ..

mkdir rails
cd rails
touch Dockerfile
```
copy the following in Dockerfile
......................................................................................
```
FROM ruby:latest
RUN apt-get update &&\
    apt-get -y install mysql-client postgresql-client sqlite3 nodejs --no-install-recommends &&\
    rm -rf /var/lib/apt/lists/*
RUN gem install bundler
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY ./Gemfile /usr/src/app/
COPY ./Gemfile.lock /usr/src/app/
RUN bundle install
COPY . /usr/src/app
COPY ./docker/rails/entry-point.sh /usr/src/app/entry-point.sh
COPY ./docker/rails/database.yml /usr/src/app/config/database.yml
EXPOSE 5000
CMD ["bash", "/usr/src/app/entry-point.sh"]
```
......................................................................................
```bash
touch entry-point.sh
```
copy the following in entry-point.sh
......................................................................................
```bash
#!/usr/bin/env bash
echo "Waiting for database server to start properly ..." && sleep 30
RAILS_ENV=development bundle exec rake db:create
RAILS_ENV=development bundle exec rake db:migrate
RAILS_ENV=development bundle exec rake db:seed
RAILS_ENV=development bundle exec rails server -b 0.0.0.0 -p 5000
```
......................................................................................
```bash
touch database.yml
```
copy the following in database.yml
......................................................................................
```yaml
---
development:
  adapter: mysql2
  encoding: utf8
  pool: 5
  timeout: 5000
  username: root
  password: root
  database: sample_app_development
  host: databasehost
test:
  adapter: mysql2
  encoding: utf8
  pool: 5
  timeout: 5000
  username: root
  password: root
  database: sample_app_test
  host: databasehost
staging:
  adapter: mysql2
  encoding: utf8
  pool: 5
  timeout: 5000
  username: root
  password: root
  database: sample_app_staging
  host: databasehost
production:
  adapter: mysql2
  encoding: utf8
  pool: 5
  timeout: 5000
  username: root
  password: root
  database: sample_app_production
  host: databasehost
```
......................................................................................
```bash
cd ../..

docker build -f docker/mysql/Dockerfile -t mysql_rails .
docker build -f docker/rails/Dockerfile -t rails_app .

docker run --rm -d --name mysql_rails_1 -e MYSQL_ROOT_PASSWORD=root -p 3300:3306 mysql_rails
docker run --rm -d --name rails_app_1 --link mysql_rails_1:databasehost -p 5000:5000 rails_app
```

# Using docker-compose
```bash
cd SampleApp
touch docker-compose.yml
```
copy the following in docker-compose.yml file
......................................................................................
```yaml
version: '3'
services:
  rails:
    build:
      context: .
      dockerfile: ./docker/rails/Dockerfile/
    expose:
      - '5000'
    ports:
      - '5000:5000'
    links:
      - 'mysql:databasehost'
    depends_on:
      - mysql
  mysql:
    build:
      context: .
      dockerfile: ./docker/mysql/Dockerfile
    volumes:
      - './docker/mysql/data_dir:/var/lib/mysql:rw'
    ports:
      - '3300:3306'
    environment:
      - MYSQL_ROOT_PASSWORD=root
```
......................................................................................
```bash
docker-compose build --no-cache --force-rm --pull
docker-compose up -d
docker-compose logs -f
docker-compose stop
docker-compose down
```

### Demo

[![asciicast](https://asciinema.org/a/121534.png)](https://asciinema.org/a/121534)
