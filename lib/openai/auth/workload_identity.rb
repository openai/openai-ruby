# frozen_string_literal: true

module OpenAI
  module Auth
    class WorkloadIdentity
      attr_reader :client_id, :identity_provider_id, :service_account_id, :provider, :refresh_buffer_seconds

      def initialize(
        client_id:,
        identity_provider_id:,
        service_account_id:,
        provider:,
        refresh_buffer_seconds: 1200
      )
        @client_id = client_id.to_s
        @identity_provider_id = identity_provider_id.to_s
        @service_account_id = service_account_id.to_s
        @provider = provider
        @refresh_buffer_seconds = refresh_buffer_seconds.to_i
      end
    end
  end
end
