require 'dieter/cache'

module Dieter
  module Helpers
    def dieter_js_name(locale = nil)
      locale ||= I18n.locale
      digest = "-#{Cache.current_digest(locale)}" if Rails.configuration.action_controller.perform_caching
      "#{locale}#{digest}"
    end
  end
end
