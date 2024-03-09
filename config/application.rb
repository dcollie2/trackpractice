# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Trackpractice
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    config.active_support.cache_format_version = 7.0
    config.active_support.disable_to_s_conversion = true
    config.assets.js_compressor  = :terser
    config.assets.css_compressor = :scss

    config.middleware.use Rack::Deflater
    config.middleware.use Rack::Brotli

    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.active_record.default_timezone = :utc
    config.time_zone = 'Central Time (US & Canada)'
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
