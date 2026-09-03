# typed: strong

module OpenAI
  module Resources

    class Webhooks

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
              OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent,
              OpenAI::Webhooks::ResponseCancelledWebhookEvent,
              OpenAI::Webhooks::ResponseCompletedWebhookEvent,
              OpenAI::Webhooks::ResponseFailedWebhookEvent,
              OpenAI::Webhooks::ResponseIncompleteWebhookEvent,
              OpenAI::Webhooks::SafetyAlertCreatedWebhookEvent,
              OpenAI::Webhooks::SafetyOrgAlertCreatedWebhookEvent
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
