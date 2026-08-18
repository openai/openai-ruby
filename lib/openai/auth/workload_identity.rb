# frozen_string_literal: true

module OpenAI
  module Auth
    class WorkloadIdentity
      attr_reader :client_id, :identity_provider_id, :service_account_id, :provider, :refresh_buffer_seconds

      def initialize(
        provider:,
        identity_provider_id: ENV["IDENTITY_PROVIDER_ID"],
        service_account_id: ENV["SERVICE_ACCOUNT_ID"],
        client_id: nil,
        refresh_buffer_seconds: 1200
      )
        if identity_provider_id.to_s.strip.empty?
          raise(
            ArgumentError,
            "identity_provider_id must not be blank; pass identity_provider_id: or set IDENTITY_PROVIDER_ID"
          )
        end

        if service_account_id.to_s.strip.empty?
          raise(
            ArgumentError,
            "service_account_id must not be blank; pass service_account_id: or set SERVICE_ACCOUNT_ID"
          )
        end

        @client_id = client_id&.to_s
        @identity_provider_id = identity_provider_id.to_s
        @service_account_id = service_account_id.to_s
        @provider = provider
        @refresh_buffer_seconds = refresh_buffer_seconds.to_i
      end
    end
  end
end
