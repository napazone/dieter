require 'rails'
require 'dieter'
require 'dieter/helpers'
require 'dieter/locale_endpoint'
require 'dieter/locale_template'

module Dieter
  class Engine < ::Rails::Engine
    initializer "dieter.locale_template", :group => :all do |app|
      app.config.assets.configure do |sprockets_env|
        if sprockets_env.respond_to?(:register_transformer)
          sprockets_env.register_mime_type 'application/vnd.dieter.locale+text', extensions: ['.locale']
          sprockets_env.register_transformer 'application/vnd.dieter.locale+text', 'application/javascript', LocaleTemplate
        end

        if sprockets_env.respond_to?(:register_engine)
          args = ['.locale', LocaleTemplate]
          args << { silence_deprecation: true } if Sprockets::VERSION.start_with?("3")
          sprockets_env.register_engine(*args)
        end
      end
    end

    initializer 'dieter.helpers' do
      ActionController::Base.helper(Helpers)
    end

    config.to_prepare do
      Dieter::Cache.clear unless Rails.configuration.action_controller.perform_caching
    end
  end
end
