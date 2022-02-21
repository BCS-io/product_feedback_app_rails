require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ProductFeedbackAppRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.active_record.schema_format = :sql

    config.generators do |g|
      g.assets false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
      g.helper false
      g.jbuilder false
      g.stylesheets false
      g.test_framework :rspec

      g.controller_specs false
      g.helper_specs false
      g.request_specs false
      g.routing_specs false
      g.view_specs false
    end
  end
end
