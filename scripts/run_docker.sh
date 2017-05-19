#!/usr/bin/env bash

cd ~/SampleApp
docker-compose build --no-cache --force-rm --pull
docker-compose up -d
docker-compose logs -f
