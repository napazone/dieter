require 'dieter/converter'

module Dieter
  class Cache
    @cache = {}

    def self.find_asset(locale, digest)
      body, current_digest = @cache[locale] || build_asset(locale)
      body if !digest || digest == current_digest
    end

    private

    def self.current_digest(locale)
      body, current_digest = @cache[locale] || build_asset(locale)
      current_digest
    end

    def self.build_asset(locale)
      body = Converter.new([locale]).js_body
      digest = Digest::MD5.hexdigest(body)
      @cache[locale] = [body, digest]
    end
  end
end
