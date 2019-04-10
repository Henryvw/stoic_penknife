source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '2.6.2'
gem 'rails', '5.2.3'
gem 'haml'
gem 'cocoon', '1.2.6'
gem 'devise'
gem 'cancancan', '~> 1.9'
gem 'geocoder'

#Below needed for ActiveAdmin
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
gem 'activeadmin', github: 'activeadmin'

gem 'bootstrap-sass', '~> 3.4.1'
gem 'autoprefixer-rails'

group :assets do
end

# Use sqlite3 as the database for Active Record
group :development, :test do
  gem 'sqlite3', '~> 1.3.6'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'rubocop', '~> 0.67.2', require: false
  gem 'capybara'
  gem 'launchy'
  gem 'factory_bot_rails'
  # Needed in new OS X Sierra for this version of Ruby with Pry
  gem 'rb-readline'
  gem 'railroady'
  #Spring Gem recommended by Everyday RSpec - greatly speeds test runs
  gem 'spring-commands-rspec'
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  # Dynopoker is for Heroku to start a separate thread to ping the application and keep it awake in Heroku.
  gem 'puma'
  gem 'puma-heroku'
end


# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.6.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
