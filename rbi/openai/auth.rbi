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
      sig { returns(T.nilable(String)) }
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
          provider: SubjectTokenProvider,
          identity_provider_id: T.nilable(T.any(String, Symbol)),
          service_account_id: T.nilable(T.any(String, Symbol)),
          client_id: T.nilable(T.any(String, Symbol)),
          refresh_buffer_seconds: Integer
        )
          .void
      end
      def initialize(
        provider:,
        identity_provider_id: ENV["IDENTITY_PROVIDER_ID"],
        service_account_id: ENV["SERVICE_ACCOUNT_ID"],
        client_id: nil,
        refresh_buffer_seconds: 1200
      )
      end
    end

    class WorkloadIdentityAuth
      sig { params(deadline: T.nilable(Float)).returns(String) }
      def get_token(deadline: nil)
      end

      sig { void }
      def invalidate_token
      end
    end
  end
end
