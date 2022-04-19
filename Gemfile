# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '3.1.1'
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
gem 'pry'
gem 'rails', '7.0.2.3'

# Replace outdated sass-rails gem with cssbundling-rails for 6.0
gem 'cssbundling-rails', '~> 1.1'

# Use Uglifier as compressor for JavaScript assets
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

group :assets do
end

# Use sqlite3 as the database for Active Record
group :development, :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  # Needed in new OS X Sierra for this version of Ruby with Pry
  gem 'railroady'
  gem 'rb-readline'
  # Spring Gem recommended by Everyday RSpec - greatly speeds test runs
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'spring-commands-rspec'
  gem 'sqlite3'
end

group :production do
  gem 'aws-sdk-s3', require: false
  gem 'puma', '~> 5.6.4'
  gem 'rails_12factor'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
