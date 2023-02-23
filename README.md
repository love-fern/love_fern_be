# Love Fern (Back End)

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
- Design API endpoints so as to be easily digestible on the front end.
- Explore how Open Authorization on the front end interacts with database access on the back end.
- Building a full-scale application from scratch using service-oriented architecture.

### Future Goals

- Implement "watering frequency," which indicates how often a user wishes to interact with their fern before it starts to decay.
- Add more detailed stats to the fern show page, including time since last contact and information about the nature of that contact.
- Add the ability to search for a fern by name and order ferns by health.
- Suggest multiple activities and gifts corresponding to varying levels of care to the fern.
- Build out the fern health algorithm to incorporate activities and gifts, as well as a more nuanced interpretation of Google's sentiment analysis.

### Known Issues
  - In its current state, Love Fern's backend API is not private. Future goals are to require a private token that only the Love Fern frontend will have. Until then, please do not provide any information you deem sensitive.

## Database and Schema

## Authors & Acknowledgments

- Samuel Cox - samc1253@gmail.com
- Drew Layton - dlayton66@gmail.com
- Anthony Ongaro - aongaro@gmail.com
- Brady Rohrig - brady.rohrig@gmail.com
- J Seymour - JustJakeSeymour@gmail.com
- Anthony Blackwell Tallent - anthonytallent567@gmail.com
