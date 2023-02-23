# Love Fern (Front End)

[IMAGE / GIF]

Love Fern is an application that allows the user to cultivate their relationships with others in their lives, by taking care of a fern. This is the back end of the application, which will focus on ______________________________.

## Getting Started

This is a Ruby on Rails application which establishes API endpoints to be called in the `love_fern_fe` repository. To run the entire application locally, both repositories will need to be cloned and set up.

### Installation

To install gems, run:
```
bundle install
```
Then to establish a database, run:
```
rails db:create
```
Because this is the back end repository, database migration is also necessary, run:
```
rails db:migrate
```
Inspect the `/db/schema.rb` and compare to the 'Schema' section below to ensure this migration has been done sucessfully.

### RSpec Suite

Once `love_fern_be` is correctly installed, run tests to ensure the repository works as intended locally.

To test the entire spec suite, run:
```
bundle exec rspec spec/
```
All tests should be passing if installation is successful.

### Calling APIs

- APIs can be called locally using a program like Postman. (link)

## List of Endpoints

- GET '/ferns?user_id={{user.id}}' Returns all ferns
## Goals

### Learning Goals

### Future Goals

### Known Issues

## Database and Schema

## Authors & Acknowledgments