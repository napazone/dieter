module Dieter
  class Converter
    def initialize(scopes = ['*'])
      @scopes = scopes
    end

    def js_body
      <<-JS
      var I18n = I18n || {};
      I18n.translations = #{translations.to_json};
      JS
    end

    def translations
      [@scopes].flatten.reduce({}) { |result, scope| deep_merge!(result, filter(all_translations, scope)) }
    end

    # Filter translations according to the specified scope.
    # Scope_path is a dot-separated string with keys and/or * wildcards.
    #
    def filter(translations, scope_path)
      scope_path = scope_path.split('.').collect(&:to_sym) if scope_path.is_a?(String)

      if scope_path.empty?
        translations
      else
        (key, *rest) = scope_path
        if key == :'*'
          subset = translations.keys.collect { |k| [k, filter(translations[k], rest)] }
          Hash[* subset.reject { |p| p[1] == {} }.flatten]
        else
          (val = translations[key]) ? Hash[key, filter(val, rest)] : {}
        end
      end
    end

    # TODO: Put an all_translations method into i18n gem API
    # Meanwhile, this hack works for I18n::Simple, at least.
    #
    def all_translations
      backend = ::I18n.backend
      if backend.respond_to?(:all_translations)
        backend.all_translations
      else
        ::I18n.backend.instance_eval do
          init_translations unless initialized?
          translations
        end
      end
    end

    # deep_merge by Stefan Rusterholz, see http://www.ruby-forum.com/topic/142809
    MERGER = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &MERGER) : v2 }

    def deep_merge!(target, hash) # :nodoc:
      target.merge!(hash, &MERGER)
    end
  end
end
