# typed: strong

module OpenAI
  module Auth
    # @api private
    class WorkloadIdentityAuth
      DEFAULT_TOKEN_EXCHANGE_URL =
        T.let("https://auth.openai.com/oauth/token", String)

      sig do
        params(
          config:
            T.any(
              OpenAI::Auth::WorkloadIdentity,
              OpenAI::Auth::X509WorkloadIdentity
            ),
          organization_id: T.nilable(String),
          token_exchange_url: String,
          http_client: T.untyped,
          sleeper: T.proc.params(delay: Float).void,
          monotonic_clock: T.proc.returns(Float)
        ).returns(T.attached_class)
      end
      def self.new(
        config,
        organization_id,
        token_exchange_url: OpenAI::Auth::WorkloadIdentityAuth::DEFAULT_TOKEN_EXCHANGE_URL,
        http_client: nil,
        sleeper: ->(delay) { sleep(delay) },
        monotonic_clock: -> { OpenAI::Internal::Util.monotonic_secs }
      )
      end

      # @api private
      sig { returns(String) }
      def inspect
      end

      private

      # @api private
      sig do
        params(deadline: T.nilable(Float)).returns(
          OpenAI::Auth::TokenExchange::TokenData
        )
      end
      def fetch_token_from_exchange(deadline: nil)
      end

      # @api private
      sig do
        params(response: Net::HTTPResponse).returns(
          OpenAI::Auth::TokenExchange::TokenData
        )
      end
      def handle_token_response(response)
      end

      # @api private
      sig { params(response: Net::HTTPResponse).returns(T.untyped) }
      def parse_response_body(response)
      end
    end
  end
end
