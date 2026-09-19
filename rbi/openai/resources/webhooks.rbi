# typed: strong

module OpenAI
  module Resources

    class Webhooks

      sig { returns(OpenAI::Resources::Webhooks::EventTypes) }
      attr_reader :event_types

      # Creates a webhook endpoint for the authenticated project.
      sig {
        params(
          event_types: T::Array[OpenAI::Webhooks::WebhookCreateParams::EventType::OrSymbol],
          name: String,
          url: String,
          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(OpenAI::Webhooks::WebhookEndpointWithSecret)
      }
      def create(
        # The event types that trigger deliveries to this endpoint.
        event_types:,
        # A human-readable name for the webhook endpoint.
        name:,
        # The HTTPS URL that receives webhook deliveries.
        url:,
        request_options: {}
      )
      end

      # Retrieves a webhook endpoint for the authenticated project.
      sig {
        params(webhook_endpoint_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
          OpenAI::Webhooks::WebhookEndpoint
        )
      }
      def retrieve(
        # The ID of the webhook endpoint to retrieve.
        webhook_endpoint_id,
        request_options: {}
      )
      end

      # Updates a webhook endpoint for the authenticated project.
      sig {
        params(
          webhook_endpoint_id: String,
          event_types: T::Array[OpenAI::Webhooks::WebhookUpdateParams::EventType::OrSymbol],
          name: String,
          url: String,
          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(OpenAI::Webhooks::WebhookEndpoint)
      }
      def update(
        # The ID of the webhook endpoint to update.
        webhook_endpoint_id,
        # The complete set of event types that should trigger deliveries.
        event_types: nil,
        # A new human-readable name for the webhook endpoint.
        name: nil,
        # A new HTTPS URL that receives webhook deliveries.
        url: nil,
        request_options: {}
      )
      end

      # Returns webhook endpoints for the authenticated project in newest-first order.
      sig {
        params(after: T.nilable(String), limit: Integer, request_options: OpenAI::RequestOptions::OrHash).returns(
          OpenAI::Internal::CursorPage[OpenAI::Webhooks::WebhookEndpoint]
        )
      }
      def list(
        # ID of the last webhook endpoint from the previous page.
        after: nil,
        # Maximum number of webhook endpoints to return. Defaults to 20.
        limit: nil,
        request_options: {}
      )
      end

      # Deletes a webhook endpoint for the authenticated project.
      sig {
        params(webhook_endpoint_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
          OpenAI::Webhooks::DeletedWebhookEndpoint
        )
      }
      def delete(
        # The ID of the webhook endpoint to delete.
        webhook_endpoint_id,
        request_options: {}
      )
      end

      # Rotates the signing secret for a webhook endpoint in the authenticated project.
      sig {
        params(
          webhook_endpoint_id: String,
          keep_old_secret_active_for_24_hours: T::Boolean,
          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(OpenAI::Webhooks::WebhookEndpointWithSecret)
      }
      def rotate_secret(
        # The ID of the webhook endpoint whose signing secret will be rotated.
        webhook_endpoint_id,
        # Whether to keep the previous signing secret valid for 24 hours after rotation.
        # Defaults to false, which invalidates the previous secret immediately.
        keep_old_secret_active_for_24_hours: nil,
        request_options: {}
      )
      end

      # Sends a sample event to a webhook endpoint for the authenticated project.
      sig {
        params(
          webhook_endpoint_id: String,
          event_type: OpenAI::Webhooks::WebhookTestParams::EventType::OrSymbol,
          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(OpenAI::Webhooks::WebhookEndpointTestResult)
      }
      def test_(
        # The ID of the webhook endpoint to test.
        webhook_endpoint_id,
        # The event type to send as a sample delivery.
        event_type:,
        request_options: {}
      )
      end

      # Validates that the given payload was sent by OpenAI and parses the payload.
      sig {
        params(
          payload: String,
          headers: T.nilable(T::Hash[T.any(String, Symbol), String]),
          webhook_secret: T.nilable(String)
        )
          .returns(
            T.any(
              OpenAI::Webhooks::BatchCancelledWebhookEvent,
              OpenAI::Webhooks::BatchCompletedWebhookEvent,
              OpenAI::Webhooks::BatchExpiredWebhookEvent,
              OpenAI::Webhooks::BatchFailedWebhookEvent,
              OpenAI::Webhooks::EvalRunCanceledWebhookEvent,
              OpenAI::Webhooks::EvalRunFailedWebhookEvent,
              OpenAI::Webhooks::EvalRunSucceededWebhookEvent,
              OpenAI::Webhooks::FineTuningJobCancelledWebhookEvent,
              OpenAI::Webhooks::FineTuningJobFailedWebhookEvent,
              OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent,
              OpenAI::Webhooks::LiveCallIncomingWebhookEvent,
              OpenAI::Webhooks::LiveTransportIncomingWebhookEvent,
              OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent,
              OpenAI::Webhooks::ResponseCancelledWebhookEvent,
              OpenAI::Webhooks::ResponseCompletedWebhookEvent,
              OpenAI::Webhooks::ResponseFailedWebhookEvent,
              OpenAI::Webhooks::ResponseIncompleteWebhookEvent,
              OpenAI::Webhooks::SafetyAlertCreatedWebhookEvent,
              OpenAI::Webhooks::SafetyDeactivationIssuedWebhookEvent,
              OpenAI::Webhooks::SafetyOrgAlertCreatedWebhookEvent,
              OpenAI::Webhooks::SafetyWarningIssuedWebhookEvent
            )
          )
      }
      def unwrap(
        # The raw webhook payload as a string
        payload,
        # The raw HTTP headers that came with the payload
        headers = {},
        # The webhook signing key
        webhook_secret = nil
      )
      end

      # Validates whether or not the webhook payload was sent by OpenAI.
      sig {
        params(
          payload: String,
          headers: T::Hash[T.any(String, Symbol), String],
          webhook_secret: T.nilable(String),
          tolerance: Integer
        )
          .void
      }
      def verify_signature(
        # The raw webhook payload as a string
        payload,
        # The raw HTTP headers that came with the payload
        headers,
        # The webhook signing key
        webhook_secret = nil,
        # Maximum age of the webhook in seconds
        tolerance = 300
      )
      end

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end

  end
end
