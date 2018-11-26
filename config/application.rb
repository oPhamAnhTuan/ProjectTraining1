require_relative 'boot'

require 'kaminari'

require 'rails/all'

Bundler.require(*Rails.groups)

module EduOnline
  class Application < Rails::Application
    config.load_defaults 5.2

    config.assets.paths << Rails.root.join("vendors", "assets")
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en
    config.time_zone = Settings.time_zone
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: [:get, :post, :options, :delete, :put, :patch]
      end
    end
  end
end
