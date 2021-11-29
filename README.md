# Alumni Portfolio API

This is the backend portfolio application for the Alumni of Actualize Coding Bootcamp. It features curated experiences that are personally relevent to the contributors. The participants are expected to adhere to a work-like development pattern and treat this repository as though it meant the difference of uptime vs downtime for a production application. This means, but is not limited to...

* Attrtibuting work to stories in the [development project board](https://github.com/actualize-portfolio/alumni_portfolio_vue/projects/1).
* Keeping PRs in scope to avoid [scope-creep](https://galvintech.com/software-development-how-to-prevent-scope-creep/). 
* Testing new code both [unit and end-to-end](https://prodperfect.com/blog/test-development/end-to-end-or-unit-testing-which-tests-for-which-bugs/).
* Seeking [peer review](https://www.atlassian.com/blog/git/written-unwritten-guide-pull-requests) for PRs.
* Protecting secrets during the development process.
* Shepparding PRs throught the deployment.

The main goals are to give Actualize alumni with a chance to experience working in a production stack without major risk and provide a place to showcase work they are proud of.

## Running Locally

This App can be run locally in 2 easy ways. You can do traditional local Rails development or run it from a docker container with a few commands.

### `development` Mode

1. Run `bundle install`
1. Using 2 terminals, run `bundle exec sidekiq` in one and `bundle exec rails server` in the other.

### Run in `production` Locally

1. Run `RAILS_ENV=production docker-compose up --build`

## API Collection

All resources are nested under `/api/v1/` but are conceptually unrelated.
