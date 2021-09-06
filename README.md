# README

# Product Feedback App

## Summary

Example Rails 6.1 application based around a frontendmentor design for a "product feedback application"

The product feedback App allows customers to give feedback about the application and then comment and vote on it. The app then allows staff members to select feedback and move it to the development roadmap, where it can be tracked through planned to live.

The application was designed to test frontend skills, so I had to modify it to


## Walkthrough

[Documentation includes a detailed walkthrough of each page of the application.](docs/walkthrough.md)

## Getting Started

1. `git clone git@github.com:BCS-io/product_feedback_app_rails.git`
2. Postgresql is running on your machine
3. `bin/setup` succeeds without error
4. `bin/ci` passes
5. `bin/run`
6. Configure environment: template is: .env.sample
7. Navigate with a browser on the machine to `localhost:3000`

## Tests and CI

1. `bin/ci` contains all the tests and checks for the app
2. `tmp/test.log` will use the production logging format
    *not* the development one.

## Production

* All runtime configuration should be supplied
  in the UNIX environment
* Rails logging uses lograge. `bin/setup help`
  can tell you how to see this locally

## Tested


