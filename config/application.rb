require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
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
    #

    # Set up a custom logger which logs to STDOUT.
    # Docker expects application to log to STDOUT/STDERR and to be ran in the foreground.
    config.log_level = :debug
    config.log_tags = [:subdomain, :uuid]
    config.logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))

    # Since we're using Redis for Sidekiq, we might as well use Redis to back our cache store.
    # This keeps our application stateless as well.
    config.cache_store = :redis_cache_store, ENV['CACHE_URL'], { namespace: 'green::cache' }

    # Use Sidekiq as the asynchronous background job queue.
    config.active_job.queue_adapter = :sidekiq

    # Disable warning about using SQLite3 in production.
    config.active_record.sqlite3_production_warning = false
  end
end
