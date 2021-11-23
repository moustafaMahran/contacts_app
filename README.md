# README

Steps to get the
application up and running.

Backend is running in port 3000.
Frontend is running in port 8100.

1. git clone https://github.com/moustafaMahran/contacts_app.git
2. cd contacts_app
3. docker-compose run backend rails db:create db:migrate db:seed
4. docker-compose up
