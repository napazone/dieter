require 'tilt'

module Dieter
  class LocaleTemplate < Tilt::Template
    def self.default_mime_type
      'application/javascript'
    end

    # Scopes can be given in a comma-separated line in the .locale file.
    #
    def prepare
      loc_scope_line = data.strip
      loc_scopes = loc_scope_line.empty? ? [I18n.locale.to_s] : loc_scope_line.split(/\s*,\s*/)
      js = Converter.new(loc_scopes).js_body
      @code = js.dump
    end

    def precompiled_template(locals)
      @code
    end

    def precompiled(locals)
      source, offset = super
      [source, offset + 1]
    end
  end
end
