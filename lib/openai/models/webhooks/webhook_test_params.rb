# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      # @see OpenAI::Resources::Webhooks#test_
      class WebhookTestParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute webhook_endpoint_id
        #
        #   @return [String]
        required :webhook_endpoint_id, String

        # @!attribute event_type
        #   The event type to send as a sample delivery.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::WebhookTestParams::EventType]
        required :event_type, enum: -> { OpenAI::Webhooks::WebhookTestParams::EventType }

        # @!method initialize(webhook_endpoint_id:, event_type:, request_options: {})
        #   @param webhook_endpoint_id [String]
        #
        #   @param event_type [Symbol, OpenAI::Models::Webhooks::WebhookTestParams::EventType]
        #     The event type to send as a sample delivery.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # The event type to send as a sample delivery.
        module EventType
          extend OpenAI::Internal::Type::Enum

          BATCH_COMPLETED = :"batch.completed"
          BATCH_FAILED = :"batch.failed"
          BATCH_EXPIRED = :"batch.expired"
          BATCH_CANCELLED = :"batch.cancelled"
          RESPONSE_COMPLETED = :"response.completed"
          RESPONSE_FAILED = :"response.failed"
          RESPONSE_CANCELLED = :"response.cancelled"
          RESPONSE_INCOMPLETE = :"response.incomplete"
          EVAL_RUN_SUCCEEDED = :"eval.run.succeeded"
          EVAL_RUN_FAILED = :"eval.run.failed"
          EVAL_RUN_CANCELED = :"eval.run.canceled"
          FINE_TUNING_JOB_SUCCEEDED = :"fine_tuning.job.succeeded"
          FINE_TUNING_JOB_FAILED = :"fine_tuning.job.failed"
          FINE_TUNING_JOB_CANCELLED = :"fine_tuning.job.cancelled"
          REALTIME_CALL_INCOMING = :"realtime.call.incoming"
          VIDEO_COMPLETED = :"video.completed"
          VIDEO_FAILED = :"video.failed"
          SAFETY_ALERT_CREATED = :"safety.alert.created"

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
