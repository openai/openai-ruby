# typed: strong

module OpenAI
  module Resources
    class Webhooks
      # Validates that the given payload was sent by OpenAI and parses the payload.
      sig do
        params(
          payload: String,
          headers: T.nilable(T::Hash[T.any(String, Symbol), String]),
          webhook_secret: T.nilable(String)
        ).returns(
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
            OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent,
            OpenAI::Webhooks::ResponseCancelledWebhookEvent,
            OpenAI::Webhooks::ResponseCompletedWebhookEvent,
            OpenAI::Webhooks::ResponseFailedWebhookEvent,
            OpenAI::Webhooks::ResponseIncompleteWebhookEvent
          )
        )
      end
      def unwrap(
        # The raw webhook payload as a string
        payload,
        # The webhook headers
        headers = {},
        # The webhook secret (optional, will use ENV["OPENAI_WEBHOOK_SECRET"] if not provided)
        webhook_secret = nil
      )
      end

      # Validates whether or not the webhook payload was sent by OpenAI.
      sig do
        params(
          payload: String,
          headers: T::Hash[T.any(String, Symbol), String],
          webhook_secret: T.nilable(String),
          tolerance: Integer
        ).void
      end
      def verify_signature(
        # The webhook payload as a string
        payload,
        # The webhook headers
        headers,
        # The webhook secret (optional, will use ENV["OPENAI_WEBHOOK_SECRET"] if not provided)
        webhook_secret = nil,
        # Maximum age of the webhook in seconds (default: 300 = 5 minutes)
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
