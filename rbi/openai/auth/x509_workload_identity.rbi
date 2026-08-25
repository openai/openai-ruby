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

      sig do
        params(
          identity_provider_id: T.nilable(T.any(String, Symbol)),
          service_account_id: T.nilable(T.any(String, Symbol)),
          refresh_buffer_seconds: Integer
        )
          .void
      end
      def initialize(
        identity_provider_id: ENV["IDENTITY_PROVIDER_ID"],
        service_account_id: ENV["SERVICE_ACCOUNT_ID"],
        refresh_buffer_seconds: 1200
      )
      end

      sig { returns(String) }
      def inspect
      end
    end
  end
end
