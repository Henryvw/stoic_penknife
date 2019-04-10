# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '2.6.2'
gem 'activeadmin', github: 'activeadmin'
gem 'autoprefixer-rails'
gem 'bootstrap-sass', '~> 3.4.1'
gem 'cancancan', '~> 1.9'
gem 'cocoon', '1.2.6'
gem 'devise'
gem 'geocoder'
gem 'haml'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
gem 'rails', '5.2.3'

group :assets do
end

# Use sqlite3 as the database for Active Record
group :development, :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'pry'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop', '~> 0.67.2', require: false
  # Needed in new OS X Sierra for this version of Ruby with Pry
  gem 'railroady'
  gem 'rb-readline'
  # Spring Gem recommended by Everyday RSpec - greatly speeds test runs
  gem 'spring-commands-rspec'
  gem 'sqlite3', '~> 1.3.6'
end

group :production do
  gem 'pg'
  gem 'puma'
  gem 'puma-heroku'
  gem 'rails_12factor'
end

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.6.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
