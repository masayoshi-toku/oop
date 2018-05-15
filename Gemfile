source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "2.5.1"

gem "rails", "~> 5.2.0"

gem "bootsnap", ">= 1.1.0", require: false
gem "coffee-rails", "~> 4.2"
gem "haml-rails"
gem "puma", "~> 3.11"
gem "sass-rails", "~> 5.0"
gem "sqlite3"
gem "turbolinks", "~> 5"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "uglifier", ">= 1.3.0"

group :test do
  gem "database_rewinder"
  gem "debase", group: :development
  gem "factory_bot_rails", group: :development
  gem "onkcop", group: :development
  gem "pry", group: :development
  gem "rspec-rails"
  gem "ruby-debug-ide", "~> 0.7.0.beta", group: :development
  gem "simplecov", require: false
  gem "letter_opener", group: :development
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2  "
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end
