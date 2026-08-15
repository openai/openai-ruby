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
        ).returns(T.attached_class)
      end
      def self.new(
        identity_provider_id: ENV["IDENTITY_PROVIDER_ID"],
        service_account_id: ENV["SERVICE_ACCOUNT_ID"],
        refresh_buffer_seconds: 1200
      )
      end
    end
  end
end
