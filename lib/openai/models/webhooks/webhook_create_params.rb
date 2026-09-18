# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      # @see OpenAI::Resources::Webhooks#create
      class WebhookCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute event_types
        #   The event types that trigger deliveries to this endpoint.
        #
        #   @return [Array<Symbol, OpenAI::Models::Webhooks::WebhookCreateParams::EventType>]
        required(
          :event_types,
          -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Webhooks::WebhookCreateParams::EventType] }
        )

        # @!attribute name
        #   A human-readable name for the webhook endpoint.
        #
        #   @return [String]
        required :name, String

        # @!attribute url
        #   The HTTPS URL that receives webhook deliveries.
        #
        #   @return [String]
        required :url, String

        # @!method initialize(event_types:, name:, url:, request_options: {})
        #   @param event_types [Array<Symbol, OpenAI::Models::Webhooks::WebhookCreateParams::EventType>]
        #     The event types that trigger deliveries to this endpoint.
        #
        #   @param name [String]
        #     A human-readable name for the webhook endpoint.
        #
        #   @param url [String]
        #     The HTTPS URL that receives webhook deliveries.
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
