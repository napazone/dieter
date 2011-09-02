require 'rack/request'
require 'dieter/converter'

module Dieter
  class LocaleEndpoint
    def call(env)
      req = Rack::Request.new(env)
      if req.path =~ %r{/([A-Za-z-]+)\.js$}
        locale = $1
        body = Converter.new([locale]).js_body

        [200,
         {'Content-Type' => 'application/javascript'},
         [body]]
      else
        [404, {}, []]
      end
    end
  end
end
