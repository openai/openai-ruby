# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class BatchCancelledWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the batch API request was cancelled.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::BatchCancelledWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::BatchCancelledWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `batch.cancelled`.
        #
        #   @return [Symbol, :"batch.cancelled"]
        required :type, const: :"batch.cancelled"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::BatchCancelledWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::BatchCancelledWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"batch.cancelled")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::BatchCancelledWebhookEvent} for more details.
        #
        #   Sent when a batch API request has been cancelled.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the batch API request was cancelled.
        #
        #   @param data [OpenAI::Models::Webhooks::BatchCancelledWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::BatchCancelledWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"batch.cancelled"] The type of the event. Always `batch.cancelled`.

        # @see OpenAI::Models::Webhooks::BatchCancelledWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the batch API request.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::BatchCancelledWebhookEvent::Data} for more details.
          #
          #   Event data payload.
          #
          #   @param id [String] The unique ID of the batch API request.
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::BatchCancelledWebhookEvent#object
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
