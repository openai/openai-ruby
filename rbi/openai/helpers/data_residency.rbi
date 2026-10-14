# typed: strong

module OpenAI
  module Internal
    # @api private
    module ClientOptions
      # @api private
      DATA_RESIDENCY_URLS = T.let(T.unsafe(nil), T::Hash[String, String])

      class << self
        # @api private
        sig do
          params(
            data_residency: T.untyped,
            base_url: T.untyped,
            provider: T.nilable(OpenAI::Provider)
          )
            .returns(T.untyped)
        end
        def resolve_data_residency(data_residency, base_url:, provider:)
        end
      end
    end
  end
end
