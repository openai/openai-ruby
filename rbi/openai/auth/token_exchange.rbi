# typed: strong

module OpenAI
  module Auth
    # @api private
    module TokenExchange
      DEFAULT_URL = T.let("https://auth.openai.com/oauth/token", String)
      TokenData =
        T.type_alias { { id: String, expires_in: T.any(Integer, Float) } }

      sig do
        params(
          config:
            T.any(
              OpenAI::Auth::WorkloadIdentity,
              OpenAI::Auth::X509WorkloadIdentity
            ),
          token_exchange_url: String,
          http_client: T.untyped,
          sleeper: T.proc.params(delay: Float).void
        ).returns(
          T.any(
            OpenAI::Auth::TokenExchange::SubjectToken,
            OpenAI::Auth::TokenExchange::X509
          )
        )
      end
      def self.build(config, token_exchange_url:, http_client:, sleeper:)
      end

      # @api private
      class SubjectToken
        sig { returns(URI::Generic) }
        attr_reader :url

        sig do
          params(
            config: OpenAI::Auth::WorkloadIdentity,
            token_exchange_url: String
          ).returns(T.attached_class)
        end
        def self.new(
          config,
          token_exchange_url: OpenAI::Auth::TokenExchange::DEFAULT_URL
        )
        end

        sig { returns(OpenAI::Auth::TokenExchange::TokenData) }
        def fetch
        end
      end

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
          ).returns(T.attached_class)
        end
        def self.new(config, token_exchange_url:, http_client:, sleeper:)
        end

        sig { returns(OpenAI::Auth::TokenExchange::TokenData) }
        def fetch
        end
      end
    end
  end
end
