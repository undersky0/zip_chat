

Welcome! To get started, clone the repository and push it to a new repository.

## Requirements

You'll need the following installed to run the template successfully:

* Ruby 3.2+
* Node.js v20+
* PostgreSQL 12+ (can be switched to SQLite or MySQL)
* Libvips or Imagemagick
* [Stripe CLI](https://stripe.com/docs/stripe-cli) for Stripe webhooks in development

If you use Homebrew, dependencies are listed in `Brewfile` so you can install them using:

```bash
brew bundle install --no-upgrade
```

Then you can start the database servers:

```bash
brew services start postgresql
brew services start redis
```

## Create Your Repository

Create a [new Git](https://github.com/new) repository for your project. Then you can clone Jumpstart Pro and push it to your new repository.

```bash
git clone git@github.com:jumpstart-pro/jumpstart-pro-rails.git myapp
cd myapp
git remote rename origin jumpstart-pro
git remote add origin git@github.com:your-account/your-repo.git # Replace with your new Git repository url
git push -u origin main
```

## Initial Setup

First, edit `config/database.yml` and change the database credentials for your server.

Run `bin/setup` to install Ruby and JavaScript dependencies and setup your database.

```bash
bin/setup
```

## Running

To run your application, you'll use the `bin/dev` command:

```bash
1.To run js and css compilers:
overmind start 
2. Run server:
rails s
```

You will need to add ruby open ai key(didn't want to just add it here as this is a public repo):
config/initializers/ruby_llm.rb 
config.openai_api_key = Rails.application.credentials.dig(:open_ai, :api_key)

