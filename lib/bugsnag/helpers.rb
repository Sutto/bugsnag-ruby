module Bugsnag
  module Helpers
    def self.cleanup_hash(hash)
      return nil unless hash
      hash.inject({}) do |h, (k, v)|
        h[k.to_s.gsub(/\./, "-")] = v.to_s
        h
      end
    end
    
    def self.apply_filters(hash, filters)
      return nil unless hash
      return hash unless filters

      hash.each do |k, v|
        if filters.any? {|f| k.to_s.include?(f.to_s) }
          hash[k] = "[FILTERED]"
        elsif v.respond_to?(:to_hash)
          apply_filters(hash[k])
        end
      end
    end
    
    def self.param_context(params)
      "#{params[:controller]}##{params[:action]}" if params && params[:controller] && params[:action]
    end

    def self.request_context(request)
      "#{request.request_method} #{request.path}" if request
    end
  end
end