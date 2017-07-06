#!/usr/bin/env bash
echo "Waiting for database server to start properly ..." && sleep 20
RAILS_ENV=development bundle exec rake db:create
RAILS_ENV=development bundle exec rake db:migrate
RAILS_ENV=development bundle exec rake db:seed
RAILS_ENV=development bundle exec rails server -b 0.0.0.0 -p 5000
