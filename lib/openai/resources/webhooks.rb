# frozen_string_literal: true

module OpenAI
  module Resources
    class Webhooks
      # @return [OpenAI::Resources::Webhooks::EventTypes]
      attr_reader :event_types

      # Creates a webhook endpoint for the authenticated project.
      #
      # @overload create(event_types:, name:, url:, request_options: {})
      #
      # @param event_types [Array<Symbol, OpenAI::Models::Webhooks::WebhookCreateParams::EventType>]
      #   The event types that trigger deliveries to this endpoint.
      #
      # @param name [String]
      #   A human-readable name for the webhook endpoint.
      #
      # @param url [String]
      #   The HTTPS URL that receives webhook deliveries.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Webhooks::WebhookEndpointWithSecret]
      #
      # @see OpenAI::Models::Webhooks::WebhookCreateParams
      def create(params)
        parsed, options = OpenAI::Webhooks::WebhookCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "webhook_endpoints",
          body: parsed,
          model: OpenAI::Webhooks::WebhookEndpointWithSecret,
          security: {bearer_auth: true},
          options: options
        )
      end

      # Retrieves a webhook endpoint for the authenticated project.
      #
      # @overload retrieve(webhook_endpoint_id, request_options: {})
      #
      # @param webhook_endpoint_id [String]
      #   The ID of the webhook endpoint to retrieve.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Webhooks::WebhookEndpoint]
      #
      # @see OpenAI::Models::Webhooks::WebhookRetrieveParams
      def retrieve(webhook_endpoint_id, params = {})
        @client.request(
          method: :get,
          path: ["webhook_endpoints/%1$s", webhook_endpoint_id],
          model: OpenAI::Webhooks::WebhookEndpoint,
          security: {bearer_auth: true},
          options: params[:request_options]
        )
      end

      # Updates a webhook endpoint for the authenticated project.
      #
      # @overload update(webhook_endpoint_id, event_types: nil, name: nil, url: nil, request_options: {})
      #
      # @param webhook_endpoint_id [String]
      #   The ID of the webhook endpoint to update.
      #
      # @param event_types [Array<Symbol, OpenAI::Models::Webhooks::WebhookUpdateParams::EventType>]
      #   The complete set of event types that should trigger deliveries.
      #
      # @param name [String]
      #   A new human-readable name for the webhook endpoint.
      #
      # @param url [String]
      #   A new HTTPS URL that receives webhook deliveries.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Webhooks::WebhookEndpoint]
      #
      # @see OpenAI::Models::Webhooks::WebhookUpdateParams
      def update(webhook_endpoint_id, params = {})
        parsed, options = OpenAI::Webhooks::WebhookUpdateParams.dump_request(params)
        @client.request(
          method: :post,
          path: ["webhook_endpoints/%1$s", webhook_endpoint_id],
          body: parsed,
          model: OpenAI::Webhooks::WebhookEndpoint,
          security: {bearer_auth: true},
          options: options
        )
      end

      # Returns webhook endpoints for the authenticated project in newest-first order.
      #
      # @overload list(after: nil, limit: nil, request_options: {})
      #
      # @param after [String, nil]
      #   ID of the last webhook endpoint from the previous page.
      #
      # @param limit [Integer]
      #   Maximum number of webhook endpoints to return. Defaults to 20.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Webhooks::WebhookEndpoint>]
      #
      # @see OpenAI::Models::Webhooks::WebhookListParams
      def list(params = {})
        parsed, options = OpenAI::Webhooks::WebhookListParams.dump_request(params)
        query = OpenAI::Internal::Util.encode_query_params(parsed)
        @client.request(
          method: :get,
          path: "webhook_endpoints",
          query: query,
          page: OpenAI::Internal::CursorPage,
          model: OpenAI::Webhooks::WebhookEndpoint,
          security: {bearer_auth: true},
          options: options
        )
      end

      # Deletes a webhook endpoint for the authenticated project.
      #
      # @overload delete(webhook_endpoint_id, request_options: {})
      #
      # @param webhook_endpoint_id [String]
      #   The ID of the webhook endpoint to delete.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Webhooks::DeletedWebhookEndpoint]
      #
      # @see OpenAI::Models::Webhooks::WebhookDeleteParams
      def delete(webhook_endpoint_id, params = {})
        @client.request(
          method: :delete,
          path: ["webhook_endpoints/%1$s", webhook_endpoint_id],
          model: OpenAI::Webhooks::DeletedWebhookEndpoint,
          security: {bearer_auth: true},
          options: params[:request_options]
        )
      end

      # Rotates the signing secret for a webhook endpoint in the authenticated project.
      #
      # @overload rotate_secret(webhook_endpoint_id, keep_old_secret_active_for_24_hours: nil, request_options: {})
      #
      # @param webhook_endpoint_id [String]
      #   The ID of the webhook endpoint whose signing secret will be rotated.
      #
      # @param keep_old_secret_active_for_24_hours [Boolean]
      #   Whether to keep the previous signing secret valid for 24 hours after rotation.
      #   Defaults to false, which invalidates the previous secret immediately.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Webhooks::WebhookEndpointWithSecret]
      #
      # @see OpenAI::Models::Webhooks::WebhookRotateSecretParams
      def rotate_secret(webhook_endpoint_id, params = {})
        parsed, options = OpenAI::Webhooks::WebhookRotateSecretParams.dump_request(params)
        @client.request(
          method: :post,
          path: ["webhook_endpoints/%1$s/rotate_secret", webhook_endpoint_id],
          body: parsed,
          model: OpenAI::Webhooks::WebhookEndpointWithSecret,
          security: {bearer_auth: true},
          options: options
        )
      end

      # Sends a sample event to a webhook endpoint for the authenticated project.
      #
      # @overload test_(webhook_endpoint_id, event_type:, request_options: {})
      #
      # @param webhook_endpoint_id [String]
      #   The ID of the webhook endpoint to test.
      #
      # @param event_type [Symbol, OpenAI::Models::Webhooks::WebhookTestParams::EventType]
      #   The event type to send as a sample delivery.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Webhooks::WebhookEndpointTestResult]
      #
      # @see OpenAI::Models::Webhooks::WebhookTestParams
      def test_(webhook_endpoint_id, params)
        parsed, options = OpenAI::Webhooks::WebhookTestParams.dump_request(params)
        @client.request(
          method: :post,
          path: ["webhook_endpoints/%1$s/test", webhook_endpoint_id],
          body: parsed,
          model: OpenAI::Webhooks::WebhookEndpointTestResult,
          security: {bearer_auth: true},
          options: options
        )
      end

      # Validates that the given payload was sent by OpenAI and parses the payload.
      #
      # @param payload [String] The raw webhook payload as a string
      #
      # @param headers [Hash{String, Symbol=>String}] The raw HTTP headers that came with the payload
      #
      # @param webhook_secret [String, nil] The webhook signing key
      #
      # @return [OpenAI::Models::Webhooks::BatchCancelledWebhookEvent, OpenAI::Models::Webhooks::BatchCompletedWebhookEvent, OpenAI::Models::Webhooks::BatchExpiredWebhookEvent, OpenAI::Models::Webhooks::BatchFailedWebhookEvent, OpenAI::Models::Webhooks::EvalRunCanceledWebhookEvent, OpenAI::Models::Webhooks::EvalRunFailedWebhookEvent, OpenAI::Models::Webhooks::EvalRunSucceededWebhookEvent, OpenAI::Models::Webhooks::FineTuningJobCancelledWebhookEvent, OpenAI::Models::Webhooks::FineTuningJobFailedWebhookEvent, OpenAI::Models::Webhooks::FineTuningJobSucceededWebhookEvent, OpenAI::Models::Webhooks::LiveCallIncomingWebhookEvent, OpenAI::Models::Webhooks::LiveTransportIncomingWebhookEvent, OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent, OpenAI::Models::Webhooks::ResponseCancelledWebhookEvent, OpenAI::Models::Webhooks::ResponseCompletedWebhookEvent, OpenAI::Models::Webhooks::ResponseFailedWebhookEvent, OpenAI::Models::Webhooks::ResponseIncompleteWebhookEvent, OpenAI::Models::Webhooks::SafetyAlertCreatedWebhookEvent, OpenAI::Models::Webhooks::SafetyOrgAlertCreatedWebhookEvent]
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
        @event_types = OpenAI::Resources::Webhooks::EventTypes.new(client: client)
      end
    end
  end
end
