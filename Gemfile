source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

gem 'active_model_serializers'

gem 'rswag-api', '~> 2.5.1'
gem 'rswag-ui', '~> 2.5.1'

group :development, :test do
  gem 'awesome_print'
  gem 'database_cleaner'
  gem 'dotenv-rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rswag-specs', '~> 2.5.1'
end

group :test do
  gem 'faker'
  gem 'database_cleaner-active_record'
  gem 'test-prof'
end

