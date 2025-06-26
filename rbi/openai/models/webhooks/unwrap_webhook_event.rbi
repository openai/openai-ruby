# typed: strong

module OpenAI
  module Models
    module Webhooks
      # Sent when a batch API request has been cancelled.
      module UnwrapWebhookEvent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
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
          end

        sig do
          override.returns(
            T::Array[OpenAI::Webhooks::UnwrapWebhookEvent::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
