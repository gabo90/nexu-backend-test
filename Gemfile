source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.5'

gem 'bootsnap', require: false
gem 'interactor'
gem 'jsonapi-serializer'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors', '~> 1.1'
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'rspec-rails'
end
