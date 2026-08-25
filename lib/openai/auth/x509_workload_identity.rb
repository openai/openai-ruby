# frozen_string_literal: true

module OpenAI
  module Auth
    # Immutable configuration for certificate-authenticated workload identity.
    # Certificate and private-key ownership remain with the attested transport.
    class X509WorkloadIdentity
      # @return [String]
      attr_reader :identity_provider_id

      # @return [String]
      attr_reader :service_account_id

      # @return [Integer]
      attr_reader :refresh_buffer_seconds

      def initialize(
        identity_provider_id: ENV["IDENTITY_PROVIDER_ID"],
        service_account_id: ENV["SERVICE_ACCOUNT_ID"],
        refresh_buffer_seconds: 1200
      )
        @identity_provider_id = validate_identifier(identity_provider_id, "identity_provider_id").freeze
        @service_account_id = validate_identifier(service_account_id, "service_account_id").freeze
        @refresh_buffer_seconds = Integer(refresh_buffer_seconds)
        if @refresh_buffer_seconds.negative?
          raise ArgumentError, "refresh_buffer_seconds must be greater than or equal to zero"
        end

        freeze
      end

      private def validate_identifier(value, name)
        identifier = String.new(value.to_s)
        unless identifier.valid_encoding?
          raise ArgumentError, "#{name} must contain valid UTF-8"
        end

        begin
          identifier = identifier.encode(Encoding::UTF_8)
        rescue Encoding::InvalidByteSequenceError, Encoding::UndefinedConversionError
          raise ArgumentError, "#{name} must contain valid UTF-8", cause: nil
        end

        if identifier.strip.empty?
          raise ArgumentError, "#{name} must not be blank; pass #{name}: or set #{name.upcase}"
        end

        identifier
      end
    end
  end
end
