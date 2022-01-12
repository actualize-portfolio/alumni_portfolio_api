# Alumni Portfolio API

This is the backend portfolio application for the Alumni of Actualize Coding Bootcamp. It features curated experiences that are personally relevent to the contributors. The participants are expected to adhere to a work-like development pattern and treat this repository as though it meant the difference of uptime vs downtime for a production application. This means, but is not limited to...

- Attributing work to stories in the [development project board](https://github.com/actualize-portfolio/alumni_portfolio_vue/projects/1).
- Keeping PRs in scope to avoid [scope-creep](https://galvintech.com/software-development-how-to-prevent-scope-creep/).
- Testing new code both [unit and end-to-end](https://prodperfect.com/blog/test-development/end-to-end-or-unit-testing-which-tests-for-which-bugs/).
- Seeking [peer review](https://www.atlassian.com/blog/git/written-unwritten-guide-pull-requests) for PRs.
- Protecting secrets during the development process.
- Shepparding PRs throught the deployment.

The main goals are to give Actualize alumni with a chance to experience working in a production stack without major risk and provide a place to showcase work they are proud of.

## Running Locally

This App can be run locally in 2 easy ways. You can do traditional local Rails development or run it from a docker container with a few commands.

### Creating the `.env.local` File

If you attempt to run the project immediately after bundle install, you'll encounter an error such as `Missing required configuration key: ["GITHUB_API_TOKEN"...] (Dotenv::MissingKeys)`. This is expected. Do the following from the project root...

```
touch .env.local
echo -e \
"CLOUDINARY_URL=obtain_me_from_jamie"\
"\nSIDEKIQ_USERNAME=invent_me"\
"\nSIDEKIQ_PASSWORD=invent_me"\
"\nSENTRY_DSN=not_required_locally"\
"\nGITHUB_API_TOKEN=create_me_on_github"\
"\nRAILS_MASTER_KEY=obtain_me_from_jamie" >> .env.local
```

Then replace the mock values with real ones and proceed with running locally (this is not required). Here's a rundown of what these are used for.

- `SIDEKIQ_USERNAME` and `SIDEKIQ_PASSWORD` are used to access the Sidekiq UI at [localhost:3000/sidekiq](localhost:3000/sidekiq). They can be set to whatever values you desire in development but are established if accessing in production.
- `SENTRY_DSN` is a url that is sent error messages in production.
- `GITHUB_API_TOKEN` if set will authenicate your github requests allowing wider API access.
- `RAILS_MASTER_KEY` should only be needed if updating credentials.

### `development` Mode

1. Run `bundle install`
1. Using 2 terminals, run `bundle exec sidekiq` in one and `bundle exec rails server` in the other.

### Run in `production` Locally

1. Run `RAILS_ENV=production docker-compose up --build`

## Error Monitoring

Production errors are sent to [sentry.io](https://sentry.io/organizations/gatorjuice/projects/alumni-portfolio-api/?project=6139958). See `gatorjuice` for access.

## API Collection

All resources are nested under `/api/v1/` but are conceptually unrelated.
