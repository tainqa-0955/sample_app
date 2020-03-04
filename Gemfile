source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.6.3"

gem "bcrypt", "3.1.12"
gem "bootsnap", ">= 1.4.2", require: false
gem "bootstrap-sass", "~> 3.4.1"
gem "bootstrap-will_paginate", "1.0.0"
gem "carrierwave", "1.2.2"
gem "config"
gem "faker", "1.7.3"
gem "i18n-js"
gem "jbuilder", "~> 2.9.1"
gem "jquery-rails"
gem "mini_magick", "4.9.5"
gem "puma", "~> 3.12.4"
gem "rails", "~> 6.0.0"
gem "rubocop", "~> 0.74.0", require: false
gem "rubocop-rails"
gem "sass-rails", "~> 5.1.0"
gem "turbolinks", "~> 5.2.0"
gem "webpacker", "~> 4.0.7"
gem "will_paginate", "3.1.7"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "sqlite3", "1.4"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.1"
  gem "web-console", "4.0.1"
end

group :test do
  gem "capybara",                 "3.28.0"
  gem "guard",                    "2.15.0"
  gem "guard-minitest",           "2.4.6"
  gem "minitest",                 "5.11.3"
  gem "minitest-reporters",       "1.3.8"
  gem "rails-controller-testing", "1.0.4"
  gem "selenium-webdriver",       "3.142.3"
  gem "webdrivers",               "4.1.2"
end

group :production do
  gem "fog", "1.42"
  gem "pg", "1.1.4"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
