require 'dieter/locale_asset'
require 'sprockets/base'

module Dieter
  class Environment < Sprockets::Base
    def initialize(backend, options = {})
      @backend = backend

      self.logger = Logger.new($stderr)
    end

    # def call(env)
    #   super
    # end

    def content_type_of(path)
      'application/javascript'
    end

    def index
      self
    end

    def find_asset(path, options = {})
      if path =~ /^([A-Za-z-]+)\.js$/
        locale = $1
        LocaleAsset.new(locale)
      end
    end
  end
end
