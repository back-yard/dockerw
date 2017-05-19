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
COPY ./.rocker_docker/rails/entry-point.sh /usr/src/app/entry-point.sh
COPY ./.rocker_docker/rails/database.yml /usr/src/app/config/database.yml
COPY ./.rocker_docker/rails/secrets.yml /usr/src/app/config/secrets.yml
EXPOSE 5000
CMD ["bash", "/usr/src/app/entry-point.sh"]
