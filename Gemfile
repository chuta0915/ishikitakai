source :rubygems
ruby '1.9.3'

gem 'rails', '3.2.8'
gem 'jquery-rails'
gem 'thin'
gem 'twitter-bootstrap-rails'
gem 'rails_config'
gem 'rails-i18n'
gem 'rails_admin'
gem 'i18n-js', '~> 3.0.0.rc'
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-github'
gem 'string_markdown'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'heroku', :github => 'heroku/heroku'
  gem 'foreman'
  gem 'guard-livereload'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'debugger'
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'webrat'
  gem 'spork', '~> 0.9.0.rc'
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'taps'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rb-readline'
  gem 'jasmine-rails'
  gem 'jasmine-headless-webkit', :github => 'johnbintz/jasmine-headless-webkit'
  gem 'guard-rails-assets'
  gem 'guard-jasmine-headless-webkit'
end

group :production do
  gem 'pg'
  gem 'newrelic_rpm'
end
