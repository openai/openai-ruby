# typed: strong

module OpenAI
  module Auth
    module TokenType
      JWT = T.let(:jwt, Symbol)
      ID = T.let(:id, Symbol)
    end

    module SubjectTokenProvider
      sig { returns(Symbol) }
      def token_type
      end

      sig { returns(String) }
      def get_token
      end
    end

    class WorkloadIdentity
      sig { returns(String) }
      attr_reader :client_id

      sig { returns(String) }
      attr_reader :identity_provider_id

      sig { returns(String) }
      attr_reader :service_account_id

      sig { returns(SubjectTokenProvider) }
      attr_reader :provider

      sig { returns(Integer) }
      attr_reader :refresh_buffer_seconds

      sig do
        params(
          client_id: T.any(String, Symbol),
          identity_provider_id: T.any(String, Symbol),
          service_account_id: T.any(String, Symbol),
          provider: SubjectTokenProvider,
          refresh_buffer_seconds: Integer
        ).void
      end
      def initialize(
        client_id:,
        identity_provider_id:,
        service_account_id:,
        provider:,
        refresh_buffer_seconds: 1200
      )
      end
    end
  end
end
