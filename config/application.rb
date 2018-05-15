require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module Oop
  class Application < Rails::Application
    config.load_defaults 5.2
    config.generators.system_tests = nil

    config.generators do |g|
      g.assets false
      g.test_framework :rspec,
                       fixture: true,
                       fixture_replacement: :factory_bot,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false
    end
  end
end
