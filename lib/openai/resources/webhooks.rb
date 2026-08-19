# frozen_string_literal: true

module OpenAI
  module Resources
    class Webhooks
      # Validates that the given payload was sent by OpenAI and parses the payload.
      #
      # @param payload [String] The raw webhook payload as a string
      #
      # @param headers [Hash{String, Symbol=>String}] The raw HTTP headers that came with the payload
      #
      # @param webhook_secret [String, nil] The webhook signing key
      #
      # @return [OpenAI::Models::Webhooks::BatchCancelledWebhookEvent, OpenAI::Models::Webhooks::BatchCompletedWebhookEvent, OpenAI::Models::Webhooks::BatchExpiredWebhookEvent, OpenAI::Models::Webhooks::BatchFailedWebhookEvent, OpenAI::Models::Webhooks::EvalRunCanceledWebhookEvent, OpenAI::Models::Webhooks::EvalRunFailedWebhookEvent, OpenAI::Models::Webhooks::EvalRunSucceededWebhookEvent, OpenAI::Models::Webhooks::FineTuningJobCancelledWebhookEvent, OpenAI::Models::Webhooks::FineTuningJobFailedWebhookEvent, OpenAI::Models::Webhooks::FineTuningJobSucceededWebhookEvent, OpenAI::Models::Webhooks::LiveCallIncomingWebhookEvent, OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent, OpenAI::Models::Webhooks::ResponseCancelledWebhookEvent, OpenAI::Models::Webhooks::ResponseCompletedWebhookEvent, OpenAI::Models::Webhooks::ResponseFailedWebhookEvent, OpenAI::Models::Webhooks::ResponseIncompleteWebhookEvent]
      def unwrap(
        payload,
        headers = {},
        webhook_secret = @client.webhook_secret || ENV["OPENAI_WEBHOOK_SECRET"]
      )
        verify_signature(payload, headers, webhook_secret)

        parsed = JSON.parse(payload, symbolize_names: true)
        OpenAI::Internal::Type::Converter.coerce(OpenAI::Models::Webhooks::UnwrapWebhookEvent, parsed)
      end

      # Validates whether or not the webhook payload was sent by OpenAI.
      #
      # @param payload [String] The raw webhook payload as a string
      #
      # @param headers [Hash{String, Symbol=>String}] The raw HTTP headers that came with the payload
      #
      # @param webhook_secret [String, nil] The webhook signing key
      #
      # @param tolerance [Integer] Maximum age of the webhook in seconds
      def verify_signature(
        payload,
        headers,
        webhook_secret = @client.webhook_secret || ENV["OPENAI_WEBHOOK_SECRET"],
        tolerance = 300
      )
        if webhook_secret.nil? || webhook_secret.strip.empty?
          message = [
            "The webhook secret must either be set using the env var, OPENAI_WEBHOOK_SECRET,",
            "or passed to this function"
          ].join(" ")
          raise ArgumentError, message
        end

        header_names = %w[webhook-signature webhook-timestamp webhook-id]
        normalized_headers = {}
        headers.each do |name, value|
          name = name.to_s.downcase.delete_prefix("http_").tr("_", "-")
          next unless header_names.include?(name)

          if normalized_headers.key?(name) && normalized_headers[name] != value
            raise ArgumentError, "Conflicting values for #{name} header"
          end

          normalized_headers[name] = value
        end

        signature_header, timestamp_header, webhook_id = normalized_headers.values_at(*header_names)
        raise ArgumentError, "Missing required webhook-signature header" if signature_header.nil?
        raise ArgumentError, "Missing required webhook-timestamp header" if timestamp_header.nil?
        raise ArgumentError, "Missing required webhook-id header" if webhook_id.nil?

        begin
          timestamp_seconds = timestamp_header.to_i
        rescue ArgumentError
          raise ArgumentError, "Invalid webhook timestamp format"
        end

        now = Time.now.to_i
        if now - timestamp_seconds > tolerance
          raise OpenAI::Errors::InvalidWebhookSignatureError, "Webhook timestamp is too old"
        end

        if timestamp_seconds > now + tolerance
          raise OpenAI::Errors::InvalidWebhookSignatureError, "Webhook timestamp is too new"
        end

        signatures = signature_header.split.map do |part|
          part.start_with?("v1,") ? part[3..] : part
        end

        decoded_secret = webhook_secret
        if webhook_secret.start_with?("whsec_")
          decoded_secret = Base64.strict_decode64(webhook_secret.delete_prefix("whsec_"))
        end

        raise ArgumentError, "The webhook secret must not be empty" if decoded_secret.empty?

        signed_payload = "#{webhook_id}.#{timestamp_header}.#{payload}"
        expected_signature = Base64.strict_encode64(
          OpenSSL::HMAC.digest("sha256", decoded_secret, signed_payload)
        )
        verified = signatures.any? do |signature|
          signature.bytesize == expected_signature.bytesize &&
            OpenSSL.secure_compare(expected_signature, signature)
        end

        unless verified
          raise(
            OpenAI::Errors::InvalidWebhookSignatureError,
            "The given webhook signature does not match the expected signature"
          )
        end
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
      end
    end
  end
end
