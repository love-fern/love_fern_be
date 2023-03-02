# 🪴 Love Fern [Back End] 🪴

## 👋 Welcome to Love Fern!

We believe that strong relationships are the foundation of a happy and fulfilling life. That's why we've created a tool that empowers you to build and maintain meaningful connections with the people you care about most. Try Love Fern today and see how it can transform your relationships!

## 🔗 Links

[⚡️ Production Website](https://www.lovefern.app)

[🔌 Fernando (Our Backend Service)](https://fernando.herokuapp.com)

[🪡 Front End Repository](https://github.com/love-fern/love_fern_fe)

[🧵 Back End Repository](https://github.com/love-fern/love_fern_be)

## Table of Contents

- [🪴 Love Fern \[Back End\] 🪴](#-love-fern-back-end-)
  - [👋 Welcome to Love Fern!](#-welcome-to-love-fern)
  - [🔗 Links](#-links)
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
    - [Learning Goals](#learning-goals)
    - [Future Goals](#future-goals)
    - [Known Issues](#known-issues)
  - [Database \& Schema](#database--schema)
  - [Authors \& Acknowledgments](#authors--acknowledgments)

## Description

Love Fern is an application that allows the user to cultivate their relationships with others in their lives, by taking care of a fern. This is the backend service of the application.

## Getting Started

This is a Ruby on Rails application which establishes API endpoints to be called in the `love_fern_fe` repository. To run the application locally, both frontend and backend repositories will need to be cloned and set up.

### Installation

To install gems, run:

```bash
bundle install
```

Then to establish a database, run:

```bash
rails db:create
```

Because this is the back end repository, database migration is also necessary, run:

```bash
rails db:migrate
```

Inspect the `/db/schema.rb` and compare to the 'Schema' section below to ensure this migration has been done successfully.

### RSpec Suite

Once `love_fern_be` is correctly installed, run tests locally to ensure the repository works as intended.

To test the entire spec suite, run:

```bash
bundle exec rspec spec/
```

All tests should be passing if installation is successful.

### Calling APIs

- APIs can be called locally using a program like [Postman](https://www.postman.com). 

## Available Endpoints

*Note:* Necessary parameters marked with {}

### Create a New User
*Note:* pass `name`, `google_id`, & `email` in request body

```bash
POST '/api/v1/users'
```

### Return all ferns for user

```bash
GET '/api/v1/users/{google_id}/ferns'
```

### Create a New Fern

*Note:* pass `name`, `shelf`, & `preferred_contact_method` in request body

```bash
POST '/api/v1/users/{google_id}/ferns'
```

### Return Single Fern (Fern Show)

```bash
GET '/api/v1/users/{google_id}/ferns/{fern_id}'
```

### Update Fern Status (Water Fern) 

*Note:* pass `interaction` as the message to be analyzed in response body 

```bash
PATCH '/api/v1/users/{google_id}/ferns/{fern_id}'
```

### Update Fern Information [Name / Shelf / Contact Method]

*Note:* pass `name`, `shelf`, or `preferred_contact_method` in request body

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

Love Fern was germinated to satisfy the requirements (and beyond) for a Turing Backend Mod 3 group project, **Consultancy**. See official [project requirements](https://backend.turing.edu/module3/projects/consultancy/).

### Learning Goals

- Design easily consumable API end-points to create accessible, robust backend service.
- Implement a secure connection between front and backend services deployed to Heroku. 
- Interact with two unique external APIs with efficient data processing and caching.

### Future Goals

- Implement "Soil Moisture" which indicates how often a user wishes to interact with their fern before the soil is completely dry.
- Add the ability to search for a fern by name and order ferns by health.
- Suggest multiple activities and gestures corresponding to varying levels of care needed for the fern.
- Implement a homegrown sentiment analysis feature to pair with Google's services, eventually reducing dependence on external services.

### Known Issues

- In current state, sentiment analysis has linear affect on fern status.
- No automated system for generating secret keys to authenticate new FE services. 

## Database & Schema

![screenshot_2023-03-02_at_9 28 56_am_480](https://user-images.githubusercontent.com/43623494/222551163-1998f69c-f610-413c-8db0-ce8d48ff6db1.png)

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
