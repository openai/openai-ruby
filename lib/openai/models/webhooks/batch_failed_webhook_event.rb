# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class BatchFailedWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the batch API request failed.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::BatchFailedWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::BatchFailedWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `batch.failed`.
        #
        #   @return [Symbol, :"batch.failed"]
        required :type, const: :"batch.failed"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::BatchFailedWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::BatchFailedWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"batch.failed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::BatchFailedWebhookEvent} for more details.
        #
        #   Sent when a batch API request has failed.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the batch API request failed.
        #
        #   @param data [OpenAI::Models::Webhooks::BatchFailedWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::BatchFailedWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"batch.failed"] The type of the event. Always `batch.failed`.

        # @see OpenAI::Models::Webhooks::BatchFailedWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the batch API request.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::BatchFailedWebhookEvent::Data} for more details.
          #
          #   Event data payload.
          #
          #   @param id [String] The unique ID of the batch API request.
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::BatchFailedWebhookEvent#object
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
