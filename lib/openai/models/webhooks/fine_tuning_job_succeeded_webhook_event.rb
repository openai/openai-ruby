# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class FineTuningJobSucceededWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the fine-tuning job succeeded.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::FineTuningJobSucceededWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `fine_tuning.job.succeeded`.
        #
        #   @return [Symbol, :"fine_tuning.job.succeeded"]
        required :type, const: :"fine_tuning.job.succeeded"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::FineTuningJobSucceededWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"fine_tuning.job.succeeded")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::FineTuningJobSucceededWebhookEvent} for more details.
        #
        #   Sent when a fine-tuning job has succeeded.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the fine-tuning job succeeded.
        #
        #   @param data [OpenAI::Models::Webhooks::FineTuningJobSucceededWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::FineTuningJobSucceededWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"fine_tuning.job.succeeded"] The type of the event. Always `fine_tuning.job.succeeded`.

        # @see OpenAI::Models::Webhooks::FineTuningJobSucceededWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the fine-tuning job.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::FineTuningJobSucceededWebhookEvent::Data} for more
          #   details.
          #
          #   Event data payload.
          #
          #   @param id [String] The unique ID of the fine-tuning job.
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::FineTuningJobSucceededWebhookEvent#object
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
