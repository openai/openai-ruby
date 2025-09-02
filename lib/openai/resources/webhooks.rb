# frozen_string_literal: true

module OpenAI
  module Resources
    class Webhooks
      # Validates that the given payload was sent by OpenAI and parses the payload.
      #
      # @param payload [String] The raw webhook payload as a string
      #
      # @return [OpenAI::Models::Webhooks::BatchCancelledWebhookEvent, OpenAI::Models::Webhooks::BatchCompletedWebhookEvent, OpenAI::Models::Webhooks::BatchExpiredWebhookEvent, OpenAI::Models::Webhooks::BatchFailedWebhookEvent, OpenAI::Models::Webhooks::EvalRunCanceledWebhookEvent, OpenAI::Models::Webhooks::EvalRunFailedWebhookEvent, OpenAI::Models::Webhooks::EvalRunSucceededWebhookEvent, OpenAI::Models::Webhooks::FineTuningJobCancelledWebhookEvent, OpenAI::Models::Webhooks::FineTuningJobFailedWebhookEvent, OpenAI::Models::Webhooks::FineTuningJobSucceededWebhookEvent, OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent, OpenAI::Models::Webhooks::ResponseCancelledWebhookEvent, OpenAI::Models::Webhooks::ResponseCompletedWebhookEvent, OpenAI::Models::Webhooks::ResponseFailedWebhookEvent, OpenAI::Models::Webhooks::ResponseIncompleteWebhookEvent]
      def unwrap(payload)
        parsed = JSON.parse(payload, symbolize_names: true)
        OpenAI::Internal::Type::Converter.coerce(OpenAI::Models::Webhooks::UnwrapWebhookEvent, parsed)
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
