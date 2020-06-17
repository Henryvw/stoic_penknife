# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '2.7.1'
gem 'activeadmin', github: 'activeadmin'
gem 'autoprefixer-rails'
gem 'bootstrap', '~> 4.3.1'
gem 'bootstrap_form', '>= 4.2.0'
gem 'cancancan'
gem 'cocoon', '1.2.6'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'geocoder'
gem 'haml'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.6.0'
gem 'jquery-rails'
gem 'mini_magick', '>= 4.9.4'
gem 'pg'
gem 'rails', '5.2.3'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

group :assets do
end

# Use sqlite3 as the database for Active Record
group :development, :test do
  gem 'capybara', '~> 3.18.0'
  gem 'codecov', require: false, group: :test
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'pry'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 4.0.0.beta2'
  gem 'rubocop', '~> 0.67.2', require: false
  # Needed in new OS X Sierra for this version of Ruby with Pry
  gem 'railroady'
  gem 'rb-readline'
  # Spring Gem recommended by Everyday RSpec - greatly speeds test runs
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'spring-commands-rspec'
  gem 'sqlite3', '~> 1.3.6'
end

group :production do
  gem 'aws-sdk-s3', require: false
  gem 'puma'
  gem 'puma-heroku'
  gem 'rails_12factor'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
