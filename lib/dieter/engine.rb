require 'rails'
require 'dieter'
require 'dieter/helpers'
require 'dieter/locale_endpoint'
require 'dieter/locale_template'

module Dieter
  class Engine < ::Rails::Engine
    initializer 'dieter.locale_template', :after => 'sprockets.environment' do |app|
      app.assets.register_engine '.locale', LocaleTemplate
    end

    initializer 'dieter.helpers' do
      ActionController::Base.helper(Helpers)
    end

    config.to_prepare do
      Dieter::Cache.clear unless Rails.configuration.action_controller.perform_caching
    end
  end
end
