# Technical

### Expected reader Knowledge
  - Ruby rails enginner

Table of Content
- [Technical](#technical)
    - [Expected reader Knowledge](#expected-reader-knowledge)
  - [Frontend](#frontend)
    - [CSS Framework](#css-framework)
      - [Tailwind pros / cons](#tailwind-pros--cons)
    - [Javascript Framework](#javascript-framework)
  - [Authentication](#authentication)
  - [Authorization](#authorization)
  - [Configuration](#configuration)
  - [Database](#database)
    - [Integer Enum vs Postgres type Enum within the application](#integer-enum-vs-postgres-type-enum-within-the-application)
  - [Gems](#gems)
    - [1. view_component](#1-view_component)
    - [2. Pundit](#2-pundit)
    - [3. aws-sdk-s3](#3-aws-sdk-s3)
  - [Choices](#choices)

## Frontend

Frontend mentor uses complex responsive designs to test people's css and JS skills. These problems are easier to solve with CSS Grid and Flexbox. This has the downside of not working on IE 11. In addition to this I am using CSS Framework Tailwindcss and the JS framework Stimulus JS.

### CSS Framework

[Tailwindcss](https://tailwindcss.com/) is a CSS utility framework used for styling. There's no "right" or "wrong" choice for CSS just what I'm going to use. My requirements are that a framework is easy to customize and to change responsively - many frameworks would pass these tests.

From a personal experience I find Tailwindcss productive. In particular, [Tailwindcss has made responsive design changes trivial, compared to media queries, which will be useful for this project.](https://tailwindcss.com/docs/responsive-design). Finally, [Tailwind will be setup with Rails 7 by using a css flag](https://github.com/rails/rails/pull/43110) so it's a good time to get experience on this CSS framework.

#### Tailwind pros / cons
| Argument type | Reasons                                                         |
|:--------------|:----------------------------------------------------------------|
| Pro           | Unique looking site benefits from customizable CSS framework    |
|               | Abstractions through @apply and componentization                |
|               | [Rails 7 is embracing Tailwindcss](https://tailwindcss.com/docs/responsive-design) |
| Cons          | 'Excessive' CSS classes in the HTML make code difficult to read |
|               | Vendor lock-in - as with any CSS framework.                     |
|               | Not free - you have to pay to use Tailwind's official component library "TailwindUI" | 

<br>

### Javascript Framework

[Stimulus JS](https://stimulus.hotwired.dev/) is not a popular JS framework. However, it is part of the Javascript strategy for Rails going forward which is reason enough to try it. There are also components which cover most of the requirements for a standard website such as this so there's no reason to expect having too many issues with JS:

| JS Libraries                    |
|:--------------------------------|
|[Tailwindcss Stimulus Components](https://github.com/excid3/tailwindcss-stimulus-components) |
|[Stimulus Components](https://stimulus-components.netlify.app/)

## Authentication

Authentication was with Devise. This is the industry standard. The configuration changes are kept within ApplicationController with the exception of skipping authentication when the user isn't changing the application data.

The application only uses the default Devise modules.
Devise configuration changes:
  - Username and avatar were added to the base devise user model
  - [Users can sign in with username or email](https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address)
    - The application seemed to use usernames so this felt more in keeping with requirements
  - Sign In has been styled but no other devise page
  - Sign up can be used by a determined user who knows the urls it isn't styled
    - A number of logins have already been made available for testing purposes
  - [after_sign_in_path_for](https://github.com/heartcombo/devise/wiki/How-To:-Redirect-to-a-specific-page-on-successful-sign-in)

<br>

## Authorization

- authorization is by [Pundit](https://github.com/varvet/pundit)

Authorization is fairly simple. A guest is someone who can look around the application but not change any data. A customer can change data _except_ the feedback status. Staff can change anything.

| User Type | Authorization                            |
|:----------|:-----------------------------------------|
| Guest     | Visit the home page / suggestions        |
|           | Visit the Roadmap page                   |
| Customer  | Everything a guest can but also:         |
|           | Create feedbacks as suggestions          |
|           | Comment                                  |
|           | Vote                                     |
| Staff     | Everything a customer can but also:      |
|           | Can change the status of suggestions     |

## Configuration

Configuration is through environmental variables. This means dotenv in development and setting environment in production - which is on Heroku.

Alternative way of saving configuration would be [Credentials](https://edgeguides.rubyonrails.org/security.html#custom-credentials). I have found environments less "fiddly" than credentials. And anyway, for this project the only environmental variable is the database URL. 

## Database

For a toy application I should have kept to SQLite to make it easier for anyone interested in using it. I ended up using postgres as I was working with Heroku, where it is the expected database. And I wanted to try using the Postgres type ENUM as it was meant to make reading the code easier, as you could use the name of the enum rather than the number.

### Integer Enum vs Postgres type Enum within the application

I used the Postgres type enum in this application. This section looks at how it might have been if I had used an "Integer enum" which I define as an enum declared as hash where the integer is the value.


Fig 1: Integer Enum vs Postgres type Enum Declaration

```ruby
  def feedback
    ...
    # Integer ENUM
    enum status: { suggestion: 0, planned: 1, in_progress: 2, live: 3}
    # Postgres type ENUM 
    enum status: { suggestion: "suggestion", planned: "planned", in_progress: "in_progress", live: "live"}
    ...
  end
```


Fig 2: Integer Enum vs Postgres type Enum active record query

```ruby
    def self.roadmap_status_count
      # Integer ENUM
      Feedback.where(status: %w[planned in_progress live])
              .group(:status)
              .count
      # with Postgres type ENUM 
      Feedback.where(status: [:planned, :in_progress, :live])
              .group(:status)
              .count
    end
```

I can see the point in having Postgres ENUM type but for a small demo application like this. I would prefer to keep it flexible for new users by using SQLite over the advantages of improving the code.


## Gems

### 1. view_component

- [A framework for building reusable, testable & encapsulated view components in Ruby on Rails.](https://github.com/github/view_component)

It's a class with a view, a better partial which can have some unit testing on it. It can also have Stimulus `sidecar` in the view_component but I've avoided that as it was experimental. I've kept it as boring as boring as possible. I don't know it very well but I enjoy the testing which allows me to know it's doing what I expect.

[View components are well documented](https://viewcomponent.org/guide/javascript_and_css.html)

### 2. Pundit

Authorization using Pundit. There wasn't anything interesting to say, which is good. 

### 3. aws-sdk-s3

- Configure ActiveStorage S3 using the environment
- Default Rails configuration using credentials
  - my opinion is it's less 'fiddly' to configure everything in the environment

```ruby
  # config/environments/production.rb
  config.active_storage.service = :amazon
```

```ruby
 # config/storage.yml
amazon:
  service: S3
  access_key_id: <%= ENV["ACCESS_KEY_ID"] %>
  secret_access_key: <%= ENV["SECRET_ACCESS_KEY"] %>
  region: <%= ENV["REGION"] %>
  bucket: <%= ENV["BUCKET"] %>
```

## Choices

I struggled with going 'back' as there were two possible routes that a site user could have come from. In the end I chose to use sessions. I've detailed the choices in a webposting to Dev.to as a way to check my decisions and see if I have missed anything.  

[Rails going backwards](https://dev.to/notapatch/rails-going-backwards-56h5)
