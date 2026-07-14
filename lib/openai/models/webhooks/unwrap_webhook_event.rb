# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      # Sent when a batch API request has been cancelled.
      module UnwrapWebhookEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Sent when a batch API request has been cancelled.
        variant :"batch.cancelled", -> { OpenAI::Webhooks::BatchCancelledWebhookEvent }

        # Sent when a batch API request has been completed.
        variant :"batch.completed", -> { OpenAI::Webhooks::BatchCompletedWebhookEvent }

        # Sent when a batch API request has expired.
        variant :"batch.expired", -> { OpenAI::Webhooks::BatchExpiredWebhookEvent }

        # Sent when a batch API request has failed.
        variant :"batch.failed", -> { OpenAI::Webhooks::BatchFailedWebhookEvent }

        # Sent when an eval run has been canceled.
        variant :"eval.run.canceled", -> { OpenAI::Webhooks::EvalRunCanceledWebhookEvent }

        # Sent when an eval run has failed.
        variant :"eval.run.failed", -> { OpenAI::Webhooks::EvalRunFailedWebhookEvent }

        # Sent when an eval run has succeeded.
        variant :"eval.run.succeeded", -> { OpenAI::Webhooks::EvalRunSucceededWebhookEvent }

        # Sent when a fine-tuning job has been cancelled.
        variant :"fine_tuning.job.cancelled", -> { OpenAI::Webhooks::FineTuningJobCancelledWebhookEvent }

        # Sent when a fine-tuning job has failed.
        variant :"fine_tuning.job.failed", -> { OpenAI::Webhooks::FineTuningJobFailedWebhookEvent }

        # Sent when a fine-tuning job has succeeded.
        variant :"fine_tuning.job.succeeded", -> { OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent }

        # Sent when Realtime API Receives a incoming SIP call.
        variant :"realtime.call.incoming", -> { OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent }

        # Sent when a background response has been cancelled.
        variant :"response.cancelled", -> { OpenAI::Webhooks::ResponseCancelledWebhookEvent }

        # Sent when a background response has been completed.
        variant :"response.completed", -> { OpenAI::Webhooks::ResponseCompletedWebhookEvent }

        # Sent when a background response has failed.
        variant :"response.failed", -> { OpenAI::Webhooks::ResponseFailedWebhookEvent }

        # Sent when a background response has been interrupted.
        variant :"response.incomplete", -> { OpenAI::Webhooks::ResponseIncompleteWebhookEvent }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Webhooks::BatchCancelledWebhookEvent, OpenAI::Models::Webhooks::BatchCompletedWebhookEvent, OpenAI::Models::Webhooks::BatchExpiredWebhookEvent, OpenAI::Models::Webhooks::BatchFailedWebhookEvent, OpenAI::Models::Webhooks::EvalRunCanceledWebhookEvent, OpenAI::Models::Webhooks::EvalRunFailedWebhookEvent, OpenAI::Models::Webhooks::EvalRunSucceededWebhookEvent, OpenAI::Models::Webhooks::FineTuningJobCancelledWebhookEvent, OpenAI::Models::Webhooks::FineTuningJobFailedWebhookEvent, OpenAI::Models::Webhooks::FineTuningJobSucceededWebhookEvent, OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent, OpenAI::Models::Webhooks::ResponseCancelledWebhookEvent, OpenAI::Models::Webhooks::ResponseCompletedWebhookEvent, OpenAI::Models::Webhooks::ResponseFailedWebhookEvent, OpenAI::Models::Webhooks::ResponseIncompleteWebhookEvent)]
      end
    end
  end
end
