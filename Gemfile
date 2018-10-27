source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap_form'
gem 'coffee-rails', '~> 4.2'
gem 'httparty'
gem 'jbuilder', '~> 2.5'
gem 'less-rails'
gem 'omniauth-github'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.6'
gem 'sass-rails', '~> 5.0', '>= 5.0.6'
gem 'therubyracer'
gem 'turbolinks', '~> 5'
gem 'twitter-bootstrap-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
