# typed: strong

module OpenAI
  module Resources
    class Webhooks
      # Validates that the given payload was sent by OpenAI and parses the payload.
      sig do
        params(payload: String).returns(
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
            OpenAI::Webhooks::ResponseCancelledWebhookEvent,
            OpenAI::Webhooks::ResponseCompletedWebhookEvent,
            OpenAI::Webhooks::ResponseFailedWebhookEvent,
            OpenAI::Webhooks::ResponseIncompleteWebhookEvent
          )
        )
      end
      def unwrap(
        # The raw webhook payload as a string
        payload
      )
      end

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
