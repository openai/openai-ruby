# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class BatchExpiredWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the batch API request expired.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::BatchExpiredWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::BatchExpiredWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `batch.expired`.
        #
        #   @return [Symbol, :"batch.expired"]
        required :type, const: :"batch.expired"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::BatchExpiredWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::BatchExpiredWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"batch.expired")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::BatchExpiredWebhookEvent} for more details.
        #
        #   Sent when a batch API request has expired.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the batch API request expired.
        #
        #   @param data [OpenAI::Models::Webhooks::BatchExpiredWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::BatchExpiredWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"batch.expired"] The type of the event. Always `batch.expired`.

        # @see OpenAI::Models::Webhooks::BatchExpiredWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the batch API request.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::BatchExpiredWebhookEvent::Data} for more details.
          #
          #   Event data payload.
          #
          #   @param id [String] The unique ID of the batch API request.
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::BatchExpiredWebhookEvent#object
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
