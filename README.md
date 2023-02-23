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
Inspect the `/db/schema.rb` and compare to the 'Schema' section below to ensure this migration has been done successfully.

### RSpec Suite

Once `love_fern_be` is correctly installed, run tests to ensure the repository works as intended locally.

To test the entire spec suite, run:
```
bundle exec rspec spec/
```
All tests should be passing if installation is successful.

### Calling APIs

- APIs can be called locally using a program like Postman. (link)

## List of Endpoints (keep updated)

- GET '/ferns?user_id={{user.id}}' Returns all ferns
## Goals

Love Fern was germinated to satisfy the requirements for a Turing Backend Mod 3 group project, Consultancy. Official project requirements can be read [here](https://backend.turing.edu/module3/projects/consultancy/).
#### Learning Goals (keep updated)

- Interact with two unique APIs.
- Collaborate with a front end application to supply API endpoints in necessary ways
#### Future Goals

- Implement "watering frequency," which indicates how often a user wishes to interact with their fern before it starts to decay.
- Add more detailed stats to the fern show page, including time since last contact and information about the nature of that contact.
- Add the ability to search for a fern by name and order ferns by health.
- Suggest multiple activities and gestures corresponding to varying levels of care needed for the fern.
- Build out the fern health algorithm to incorporate activities and gifts, as well as a more nuanced interpretation of Google's sentiment analysis.

#### Known Issues

- In its current state, Love Fern's backend API is not private. Future goals are to require a private token that only the Love Fern frontend will have. Until then, please do not provide any information you deem sensitive.
- The fertilize feature currently suggests a random activity to do with your fern's person. Please consider real life consequences are not our responsibility if you do ask your fern's person to do this activity.

## Deployment

## Authors & Acknowledgments

- Samuel Cox - samc1253@gmail.com
- Drew Layton - dlayton66@gmail.com
- Anthony Ongaro - aongaro@gmail.com
- Brady Rohrig - brady.rohrig@gmail.com
- J Seymour - JustJakeSeymour@gmail.com
- Anthony Blackwell Tallent - anthonytallent567@gmail.com
