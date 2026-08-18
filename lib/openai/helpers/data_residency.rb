# frozen_string_literal: true

module OpenAI
  module Internal
    # @api private
    module ClientOptions
      # @api private
      DATA_RESIDENCY_URLS = {
        "global" => "https://api.openai.com/v1",
        "us" => "https://us.api.openai.com/v1",
        "eu" => "https://eu.api.openai.com/v1",
        "ae" => "https://ae.api.openai.com/v1"
      }.freeze

      class << self
        # Resolve the shorthand before environment defaults or inherited options
        # are applied. Only an explicitly supplied base_url is a conflict.
        # @api private
        def resolve_data_residency(data_residency, base_url:, provider:)
          return base_url if data_residency.nil?

          unless base_url.equal?(OpenAI::Internal::OMIT)
            raise ArgumentError, "`data_residency` and `base_url` are mutually exclusive"
          end
          unless provider.nil?
            raise ArgumentError, "`data_residency` cannot be combined with `provider`"
          end

          url = DATA_RESIDENCY_URLS[data_residency.to_s] if data_residency.is_a?(String) || data_residency.is_a?(Symbol)
          return url unless url.nil?

          raise ArgumentError, "`data_residency` must be one of: #{DATA_RESIDENCY_URLS.keys.join(', ')}"
        end
      end
    end
  end
end
