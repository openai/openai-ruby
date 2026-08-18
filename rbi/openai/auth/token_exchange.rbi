# typed: strong

module OpenAI
  module Auth
    # @api private
    module TokenExchange
      DEFAULT_URL = T.let("https://auth.openai.com/oauth/token", String)
      TokenData = T.type_alias { {id: String, expires_in: T.any(Integer, Float)} }

      # @api private
      class X509
        sig { returns(URI::Generic) }
        attr_reader :url

        sig do
          params(
            config: OpenAI::Auth::X509WorkloadIdentity,
            token_exchange_url: String,
            http_client: T.untyped,
            sleeper: T.proc.params(delay: Float).void
          )
            .returns(T.attached_class)
        end
        def self.new(config, token_exchange_url:, http_client:, sleeper:)
        end

        sig do
          params(timeout: T.nilable(Float)).returns(
            OpenAI::Auth::TokenExchange::TokenData
          )
        end
        def fetch(timeout: nil)
        end
      end
    end
  end
end
