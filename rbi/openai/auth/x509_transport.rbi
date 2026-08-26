# typed: strong

module OpenAI
  module Auth
    class X509Transport
      ISSUER_ORIGIN = T.let("https://mtls.auth.openai.com", String)

      sig { returns(String) }
      attr_reader :api_origin

      sig { returns(Symbol) }
      attr_reader :proxy_mode

      sig do
        params(
          http_client: OpenAI::NetHTTPClient,
          certificate_identity: Symbol,
          proxy: Symbol,
          api_origin: String
        )
          .void
      end
      def initialize(
        http_client:,
        certificate_identity:,
        proxy: :direct,
        api_origin: "https://mtls.api.openai.com"
      )
      end

      sig do
        params(request: OpenAI::HTTPClient::Request).returns(
          OpenAI::HTTPClient::Response
        )
      end
      def execute(request)
      end

      sig do
        params(url: URI::Generic, headers: T::Hash[String, String])
          .returns(T::Hash[String, String])
      end
      def validate_api_request!(url:, headers:)
      end

      # @api private
      sig { params(residency: T.any(Symbol, String)).returns(T::Boolean) }
      def supports_data_residency?(residency)
      end
    end
  end
end
