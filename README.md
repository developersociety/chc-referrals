# Cardinal Hume Centre Referral System

## About

### Problem

>How can we better show capacity to our partners and provide tools for referrals in order to ensure a diversity of clients so that we can reach the most vulnerable with our services.

### Solution

>A referral system for charities working together providing immigration advice and legal aid in London.

The tool provides an interface for accepting and reviewing form submissions via Typeform's [Embed](https://developer.typeform.com/embed/) and [Webhooks](https://developer.typeform.com/webhooks/) API.

## Development

### Local setup

Prerequisites: [Ruby v2.5.1](https://www.ruby-lang.org), [Bundler](https://bundler.io/), [PostgreSQL](https://www.postgresql.org/), [NodeJS](https://nodejs.org/), [Yarn](https://yarnpkg.com/)

1. `git clone https://github.com/TechforgoodCAST/chc-referrals.git`
2. `cd chc-referrals`
3. `bundle install`
4. `yarn install`
5. `rails db:setup`
6. `rails s` to start local development server

### Running tests

`rails test` for unit tests, and `rails test:system` for system tests.

## Deployment

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/TechforgoodCAST/chc-referrals)

## Contributing

First of all, **thank you** for your help!

Be sure to check out the projects open [issues](https://github.com/suninthesky/slice-and-dice/issues) to see where help is needed.

### Bugs

If you've spotted a bug please file an [issue](https://github.com/suninthesky/slice-and-dice/issues). Even better, submit a [pull request](https://github.com/suninthesky/slice-and-dice/pulls) (details below) with a patch.

### Features

If you want a feature added, the best way to get it done is to submit a pull request that implements it...

1. Fork the repo
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a [pull request](https://github.com/suninthesky/slice-and-dice/pulls)

Alternatively you can submit an [issue](https://github.com/suninthesky/slice-and-dice/issues) describing the feature.

## License

This software is released under the [MIT License](https://opensource.org/licenses/MIT).
