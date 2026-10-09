# typed: strong

module OpenAI
  module Models

    module Webhooks

      # Sent when setup fails for a prewarmed OpenAI-hosted environment before it is
      # attached to a session.
      module UnwrapWebhookEvent
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Webhooks::AgentEnvironmentFailedWebhookEvent,
            OpenAI::Webhooks::AgentEnvironmentReadyWebhookEvent,
            OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent,
            OpenAI::Webhooks::AgentSessionCreatedWebhookEvent,
            OpenAI::Webhooks::AgentSessionFailedWebhookEvent,
            OpenAI::Webhooks::AgentSessionIdleWebhookEvent,
            OpenAI::Webhooks::AgentSessionInProgressWebhookEvent,
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
        end

        sig { override.returns(T::Array[OpenAI::Webhooks::UnwrapWebhookEvent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
