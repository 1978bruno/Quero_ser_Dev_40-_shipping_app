source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

gem 'bootstrap'
gem 'devise'
gem 'faraday'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4'
gem 'sprockets-rails'
gem 'sqlite3', '~> 1.4'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'capybara'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-extension-generator'
  gem 'rubocop-rails', require: false
  gem 'simplecov', require: false
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
