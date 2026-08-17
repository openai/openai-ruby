# frozen_string_literal: true

module OpenAI
  module Internal
    # Resolved constructor settings for derived clients. This stays handwritten
    # so provider and credential configuration is not inferred from public readers.
    # @api private
    module ClientOptions
      # Marks an already-resolved header set: the constructor must not read
      # OPENAI_CUSTOM_HEADERS again when creating a derived client.
      # @api private
      class ResolvedHeaders < Hash
      end

      class << self
        # @api private
        def capture(**options)
          options.transform_values do |value|
            case value
            when String then value.dup.freeze
            when Hash then value.transform_values { _1.is_a?(String) ? _1.dup.freeze : _1 }.freeze
            else value
            end
          end.freeze
        end

        # @api private
        def copy(defaults, overrides)
          unknown = overrides.keys - defaults.keys
          unless unknown.empty?
            raise ArgumentError, "Unknown client option#{unknown.one? ? '' : 's'}: #{unknown.join(', ')}"
          end

          options = defaults.dup
          provider_changed = overrides.key?(:provider) && !overrides[:provider].equal?(defaults[:provider])
          credentials_changed = [:api_key, :admin_api_key, :workload_identity].any? { overrides.key?(_1) }

          if provider_changed
            [:api_key, :admin_api_key, :workload_identity, :base_url, :organization, :project].each do |name|
              options[name] = nil
            end
            options[:default_headers] = {}
          elsif credentials_changed
            options[:default_headers] = options.fetch(:default_headers).reject do |name, _value|
              OpenAI::Internal::Logging.credential_header?(name)
            end
          end

          # An explicitly selected authentication method replaces the inherited
          # mutually exclusive method. Explicitly conflicting values still fail
          # the ordinary constructor validation.
          if overrides[:api_key] && !overrides.key?(:workload_identity)
            options[:workload_identity] = nil
          elsif overrides[:workload_identity] && !overrides.key?(:api_key)
            options[:api_key] = nil
          end

          headers = options.fetch(:default_headers)
          if overrides.key?(:default_headers)
            supplied = overrides[:default_headers]
            headers = supplied.nil? ? {} : OpenAI::Internal::Util.normalized_headers(headers, supplied)
          end

          options.merge!(overrides)
          options[:default_headers] = ResolvedHeaders.new.replace(headers)
          options
        end
      end
    end
  end
end
