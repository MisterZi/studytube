# README

1) run `docker-compose build app` to build app
2) run `docker-compose run --rm app rake db:create db:migrate` to prepare database
3) run `docker-compose run --rm test rake db:create db:migrate` to prepare test database
5) run `docker-compose up -d app` to start

API documentation: `http://127.0.0.1:3000/swagger/` 
