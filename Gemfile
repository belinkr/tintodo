source :rubygems

gem 'i18n'
gem 'virtus'
gem 'aequitas'
gem 'sinatra', require: 'sinatra/base'
gem 'uuidtools'
gem 'sanitize'
gem 'redis'
gem 'tinto', '3.0.2'

group :development do
  gem 'rb-inotify', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-fchange', require: false
  gem 'guard'
  gem 'warbler', git: 'https://github.com/vanyak/warbler.git'
end

group :test do
  gem 'guard-minitest'
  gem 'minitest', require: 'minitest/autorun'
  gem 'rack-test', require: 'rack/test'
end

