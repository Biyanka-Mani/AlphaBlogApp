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
Validations for User class:

- username must be present and unique, length between 3 and 25 characters

- email must be present and unique, length max of 105 characters

- validate email format using regex (regular expression)

/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
