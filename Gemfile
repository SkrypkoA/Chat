source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use Puma as the app server
# gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use NoMethodError: undefined method `stages'Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#гемы по тз
gem 'pg'
gem 'kaminari'
gem 'devise'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'carrierwave', '>= 1.0.0.rc', '< 2.0'
gem "haml-rails", "~> 0.9"
gem 'friendly_id', github: 'norman/friendly_id'
gem "recaptcha", require: "recaptcha/rails"
gem 'omniauth'
gem "omniauth-google-oauth2"
gem 'omniauth-github', github: 'intridea/omniauth-github'
#gem 'sidekiq'
gem 'redis', '~> 3.2'
#gem 'sucker_punch', '~> 2.0'
#gem 'resque'
#gem 'resque-scheduler'
#gem 'active_scheduler'
#gem 'rails-i18n', '~> 5.0.0'
gem 'unicorn'
gem 'dotenv-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'rvm-capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano3-unicorn'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
ruby "2.3.1"