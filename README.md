# Love Fern (Back End)


## Table of Contents
- [Love Fern (Back End)](#love-fern-back-end)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Getting Started](#getting-started)
    - [Installation](#installation)
    - [RSpec Suite](#rspec-suite)
    - [Calling APIs](#calling-apis)
  - [Available Endpoints](#available-endpoints)
    - [Create a New User](#create-a-new-user)
    - [Return all ferns for user](#return-all-ferns-for-user)
    - [Create a New Fern](#create-a-new-fern)
    - [Return Single Fern (Fern Show)](#return-single-fern-fern-show)
    - [Update Fern Status (Water Fern)](#update-fern-status-water-fern)
    - [Update Fern Information \[Name / Shelf / Contact Method\]](#update-fern-information-name--shelf--contact-method)
    - [Delete Fern](#delete-fern)
    - [Get All Shelves \& Ferns](#get-all-shelves--ferns)
    - [Get One Random Activity Suggestion](#get-one-random-activity-suggestion)
  - [Goals](#goals)
      - [Learning Goals (keep updated)](#learning-goals-keep-updated)
      - [Future Goals](#future-goals)
      - [Known Issues](#known-issues)
  - [Database \& Schema](#database--schema)
  - [Build Methods](#build-methods)
  - [Authors \& Acknowledgments](#authors--acknowledgments)

## Description

Love Fern is an application that allows the user to cultivate their relationships with others in their lives, by taking care of a fern. This is the backend service of the application.

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

## Available Endpoints

Note: Necessary parameters marked with {}

### Create a New User
Note: pass `name`, `google_id`, & `email` in request body

```bash
POST '/api/v1/users'
```

### Return all ferns for user

```bash
GET '/api/v1/users/{google_id}/ferns'
```

### Create a New Fern

Note: pass `name`, `shelf`, & `preferred_contact_method` in request body

```bash
POST '/api/v1/users/{google_id}/ferns'
```

### Return Single Fern (Fern Show)

```bash
GET '/api/v1/users/{google_id}/ferns/{fern_id}'
```

### Update Fern Status (Water Fern) 

Note: pass `interaction` as the message to be analyzed in response body 

```bash
PATCH '/api/v1/users/{google_id}/ferns/{fern_id}'
```

### Update Fern Information [Name / Shelf / Contact Method]

Note: pass `name`, `shelf`, or `preferred_contact_method` in request body

```bash
PATCH '/api/v1/users/{google_id}/ferns/{fern_id}'
```

### Delete Fern

```bash
DELETE '/api/v1/users/{google_id}/ferns/{fern_id}'
```

### Get All Shelves & Ferns

```bash
GET '/api/v1/users/{google_id}/shelves'
```

### Get One Random Activity Suggestion

```bash
GET '/api/v1/activities'
```

## Goals

Love Fern was germinated to satisfy the requirements for a Turing Backend Mod 3 group project, Consultancy. Official project requirements can be read [here](https://backend.turing.edu/module3/projects/consultancy/).
#### Learning Goals (keep updated)
- Design API endpoints so as to be easily digestible on the front end.
- Explore how Open Authorization on the front end interacts with database access on the back end.
- Building a full-scale application from scratch using service-oriented architecture.
- Interact with two unique external APIs.
#### Future Goals

- Implement "watering frequency," which indicates how often a user wishes to interact with their fern before it starts to decay.
- Add more detailed stats to the fern show page, including time since last contact and information about the nature of that contact.
- Add the ability to search for a fern by name and order ferns by health.
- Suggest multiple activities and gestures corresponding to varying levels of care needed for the fern.
- Build out the fern health algorithm to incorporate activities and gifts, as well as a more nuanced interpretation of Google's sentiment analysis.
#### Known Issues

- In its current state, Love Fern's backend API is not private. Future goals are to require a private token that only the Love Fern frontend will have. Until then, please do not provide any information you deem sensitive.
- The fertilize feature currently suggests a random activity to do with your fern's person. Please consider real life consequences are not our responsibility if you do ask your fern's person to do this activity.

## Database & Schema

## Build Methods

## Authors & Acknowledgments

:bust_in_silhouette: **Samuel Cox** 
- samc1253@gmail.com
- [GitHub](https://github.com/sambcox)
- [LinkedIn](https://www.linkedin.com/in/samuel-bingham-cox/)

:bust_in_silhouette: **Drew Layton** 
- dlayton66@gmail.com
- [GitHub](https://github.com/dlayton66)
- [LinkedIn](https://www.linkedin.com/in/drew-layton-6009a4153/)

:bust_in_silhouette: **Anthony Ongaro** 
- aongaro@gmail.com
- [GitHub](https://github.com/ajongaro)
- [LinkedIn](https://www.linkedin.com/in/ajongaro/)

:bust_in_silhouette: **Brady Rohrig** 
- brady.rohrig@gmail.com
- [GitHub](https://github.com/BRohrig)
- [LinkedIn](https://www.linkedin.com/in/brady-rohrig-5305a923/)

:bust_in_silhouette: **J Seymour** 
- JustJakeSeymour@gmail.com
- [GitHub](https://github.com/JustJakeSeymour)
- [LinkedIn](https://www.linkedin.com/in/j-seymour/)

:bust_in_silhouette: **Anthony Blackwell Tallent** 
- anthonytallent567@gmail.com
- [GitHub](https://github.com/anthonytallent)
- [LinkedIn](https://www.linkedin.com/in/anthony-blackwell-tallent-b36916255/)
