# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class FineTuningJobCancelledWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the fine-tuning job was cancelled.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::FineTuningJobCancelledWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::FineTuningJobCancelledWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `fine_tuning.job.cancelled`.
        #
        #   @return [Symbol, :"fine_tuning.job.cancelled"]
        required :type, const: :"fine_tuning.job.cancelled"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::FineTuningJobCancelledWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::FineTuningJobCancelledWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"fine_tuning.job.cancelled")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::FineTuningJobCancelledWebhookEvent} for more details.
        #
        #   Sent when a fine-tuning job has been cancelled.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the fine-tuning job was cancelled.
        #
        #   @param data [OpenAI::Models::Webhooks::FineTuningJobCancelledWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::FineTuningJobCancelledWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"fine_tuning.job.cancelled"] The type of the event. Always `fine_tuning.job.cancelled`.

        # @see OpenAI::Models::Webhooks::FineTuningJobCancelledWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the fine-tuning job.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::FineTuningJobCancelledWebhookEvent::Data} for more
          #   details.
          #
          #   Event data payload.
          #
          #   @param id [String] The unique ID of the fine-tuning job.
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::FineTuningJobCancelledWebhookEvent#object
        module Object
          extend OpenAI::Internal::Type::Enum

          EVENT = :event

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
