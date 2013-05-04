source 'https://rubygems.org'
ruby '1.9.3' # You’ll need to install 1.2.0 of bundler to use the ruby keyword.

gem 'rails', '3.2.13'
gem 'jquery-rails'
gem 'thin'

gem 'therubyracer'
gem 'less-rails'
gem 'twitter-bootstrap-rails'

gem 'rails_config'
gem 'rails-i18n'
gem 'safe_yaml', '0.8.6'
gem 'rails_admin'
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-github'
gem 'string_markdown'
gem 'kaminari'
gem 'rails_autolink'
gem 'pusher'
gem 'em-http-request'
gem 'paper_trail'
gem 'delayed_job'
gem 'delayed_job_active_record'
gem 'showdown-rails'
gem 'fog'
gem 'figaro'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'foreman'
end

group :test, :development do
  gem 'sqlite3'
  # Rspec
  gem 'rspec-rails'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'delorean'
  gem 'shoulda-matchers'

  # Capybara
  gem 'capybara'
  gem 'poltergeist'
  gem 'launchy'

  # Debug tool
  gem 'pry'
  gem 'pry-rails'
  gem 'tapp'
  gem 'awesome_print'

  # Testing tools
  gem 'database_cleaner'
  gem "brakeman"
  gem "webmock", require: false

  # Guard
  gem 'spork'
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-rails-assets'
  gem 'rb-fsevent'

  # Capistrano
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'capistrano_colors'
  gem 'rvm-capistrano'

  # Jasmine
  gem 'jasmine-rails'
  gem 'jasmine-headless-webkit', :github => 'johnbintz/jasmine-headless-webkit'
  gem 'guard-rails-assets'
  gem 'guard-jasmine-headless-webkit'
end

group :production do
  gem 'pg'
  gem 'newrelic_rpm'
end
