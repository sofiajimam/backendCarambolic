require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
#require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Carambolic
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # for the env variables
    config.before_configuration do
      # Load environment variables from a YAML file if it exists
      env_file = File.join(Rails.root, "config", "local_env.yml")
      if File.exist?(env_file)
        yaml_content = File.read(env_file)
        env_vars = YAML.safe_load(yaml_content)
        env_vars.each do |key, value|
          ENV[key] = value.to_s
        end
      end
    end

    OpenAI.configure do |config|
      config.access_token = ENV.fetch("OPENAI_ACCESS_TOKEN")
      config.organization_id = ENV.fetch("OPENAI_ORGANIZATION_ID") # Optional.
    end

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.api_only = true
    config.active_job.queue_adapter = :sidekiq
  end
end
