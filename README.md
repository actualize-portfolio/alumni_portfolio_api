# Alumni Portfolio API

API supporting the Vue.js Alumni Portfolio Project.

![CI-CD](https://github.com/gatorjuice/alumni_portfolio_api/actions/workflows/tests.yml/badge.svg)

## Running Locally

This App can be run locally in 2 easy ways. You can do traditional local Rails development or run it from a docker container with a few commands.

### `development` Mode

1. Run `bundle install`
1. Using 2 terminals, run `bundle exec sidekiq` in one and `bundle exec rails server` in the other.

### Run in `production` Locally

1. Run `RAILS_ENV=production docker-compose up --build`

## API Collection

All resources are nested under `/api/v1/` but are conceptually unrelated.
