source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.4.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'cancancan', '~> 1.10'
gem 'bcrypt', '~> 3.1.7'
gem 'cowsay', '~> 0.3.0'
gem 'faker', github: 'stympy/faker'
gem 'bootstrap', '~> 4.0.0.beta'
gem 'jquery-rails'
gem 'chosen-rails'
gem 'font-awesome-rails'
gem 'rails_12factor', group: :production
gem 'delayed_job_active_record'
gem "delayed_job_web"
gem 'active_model_serializers'
gem 'faraday'
gem 'rack-cors'
gem 'simple_form'
gem 'friendly_id', '~> 5.2.0'
gem 'carrierwave', '~> 1.0'
gem "mini_magick"
gem 'fog'
gem "cocoon"
gem 'jwt'
gem 'geocoder'
gem 'country_select'
gem 'gmaps4rails'
gem 'underscore-rails'
gem 'aasm'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry' #pry gem itself
  gem 'pry-rails' #a gem that integrates pry with rails seemlessly
  gem 'hirb'
  gem "letter_opener"
  
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
