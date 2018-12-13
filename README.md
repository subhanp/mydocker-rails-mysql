# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
============================
About this Repo

This is the Git repo of the Docker official image for [rails] (https://registry.hub.docker.com/_/rails/) and mysql. See these page for the 
full readme on how to use this Docker image and for information regarding contributing and issues.

Pre-Requirements

First install docker, docker compose for your machine and start it. How this is done is very well documented all over the internet.

Build the project

You need generate the Rails skeleton app using docker-compose run:

$ docker-compose run app rails new . --force --database=mysql --skip-bundle

Compose will build the image for the web service using the Dockerfile. Then it’ll run rails new inside a new container, using that image. 
Once it’s done, you should have generated a fresh app:

Now that you’ve got rails app, you need to build the image again.

docker-compose build

Connect the database

The app is now bootable, but you’re not quite there yet. By default, Rails expects a database to be running on localhost - so you need to point it at the mysql container instead. You also need to change the database and username to align with the defaults set by the mysql image.

Replace the contents of config/database.yml with the following:

default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password: "root"
  host: mysql

development:
  <<: *default
  database: dev

test:
  <<: *default
  database: dev

You can now boot the app with:

docker-compose up -d

Finally, you need to create the database. In another terminal, run:

docker-compose run app rake db:create

That’s it. Your app should now be running on port 3000 on your Docker daemon. If you’re using Docker Machine, then docker-machine ip MACHINE_VM returns the Docker host IP address.

$ docker-machine ip default
It will display the Ip

ip:3000


==============
jenkins:
if docker-compose -f docker-compose.yml stop; then docker-compose -f docker-compose.yml rm -f; fi
docker-compose -f docker-compose.yml pull && docker-compose -f docker-compose.yml up -d
