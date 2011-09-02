require 'rack/request'
require 'dieter/cache'

module Dieter
  class LocaleEndpoint
    def initialize
      @cache = {}
    end

    def call(env)
      req = Rack::Request.new(env)
      if req.path =~ %r{/([A-Za-z-]+)(?:-([0-9a-f]+))?\.js$}
        locale = $1
        digest = $2
        body = Cache.find_asset(locale, digest)
        return [
          200,
          {'Content-Type' => 'application/javascript',
           'Cache-Control' => "public, max-age=#{1.year.to_i}"},
           [body]
        ] if body
      end

      [404, {}, []]
    end
  end
end
