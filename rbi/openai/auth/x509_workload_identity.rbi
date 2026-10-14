# typed: strong

module OpenAI
  module Auth
    class X509WorkloadIdentity
      sig { returns(String) }
      attr_reader :identity_provider_id

      sig { returns(String) }
      attr_reader :service_account_id

      sig { returns(Integer) }
      attr_reader :refresh_buffer_seconds

      # @api private
      sig { returns(T.nilable(OpenAI::Auth::X509Transport)) }
      attr_reader :transport

      sig do
        params(
          identity_provider_id: T.nilable(T.any(String, Symbol)),
          service_account_id: T.nilable(T.any(String, Symbol)),
          refresh_buffer_seconds: Integer,
          http_client: T.nilable(OpenAI::NetHTTPClient),
          proxy: Symbol,
          api_origin: String
        )
          .void
      end
      def initialize(
        identity_provider_id: ENV["IDENTITY_PROVIDER_ID"],
        service_account_id: ENV["SERVICE_ACCOUNT_ID"],
        refresh_buffer_seconds: 1200,
        http_client: nil,
        proxy: :direct,
        api_origin: "https://mtls.api.openai.com"
      )
      end

      sig { returns(String) }
      def inspect
      end
    end
  end
end
