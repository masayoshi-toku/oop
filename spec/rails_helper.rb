# This file is copied to spec/ when you run 'rails generate rspec:install'
require "simplecov"
SimpleCov.start "rails"

require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"

ActiveRecord::Migration.maintain_test_schema!

Dir[Rails.root.join("spec", "support", "**", "*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include ActiveSupport::Testing::TimeHelpers

  config.before :suite do
    DatabaseRewinder.clean_all
    load(Rails.root.join('db', 'seeds.rb'))
  end

  config.after do
    DatabaseRewinder.clean
  end
end
