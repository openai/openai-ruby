# frozen_string_literal: true

module OpenAI
  module Auth
    # Configuration for X.509 workload identity federation.
    #
    # Client certificates, private keys, passphrases, trust, and connection
    # lifecycle remain owned by the configured HTTP transport.
    class X509WorkloadIdentity
      attr_reader :identity_provider_id, :service_account_id, :refresh_buffer_seconds

      def initialize(
        identity_provider_id: ENV["IDENTITY_PROVIDER_ID"],
        service_account_id: ENV["SERVICE_ACCOUNT_ID"],
        refresh_buffer_seconds: 1200
      )
        if identity_provider_id.to_s.strip.empty?
          raise ArgumentError,
                "identity_provider_id must not be blank; pass identity_provider_id: " \
                "or set IDENTITY_PROVIDER_ID"
        end

        if service_account_id.to_s.strip.empty?
          raise ArgumentError,
                "service_account_id must not be blank; pass service_account_id: or set SERVICE_ACCOUNT_ID"
        end

        refresh_buffer_seconds = Integer(refresh_buffer_seconds)
        if refresh_buffer_seconds.negative?
          raise ArgumentError, "refresh_buffer_seconds must be greater than or equal to zero"
        end

        @identity_provider_id = identity_provider_id.to_s
        @service_account_id = service_account_id.to_s
        @refresh_buffer_seconds = refresh_buffer_seconds
      end
    end
  end
end
