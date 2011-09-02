require 'rails'
require 'dieter'
require 'dieter/locale_template'

module Dieter
  class Engine < ::Rails::Engine
    initializer 'dieter.locale_template', :after => 'sprockets.environment' do |app|
      app.assets.register_engine '.locale', LocaleTemplate
    end
  end
end
