# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class ResponseCancelledWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the model response was cancelled.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::ResponseCancelledWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::ResponseCancelledWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `response.cancelled`.
        #
        #   @return [Symbol, :"response.cancelled"]
        required :type, const: :"response.cancelled"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::ResponseCancelledWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::ResponseCancelledWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"response.cancelled")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::ResponseCancelledWebhookEvent} for more details.
        #
        #   Sent when a background response has been cancelled.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the model response was cancelled.
        #
        #   @param data [OpenAI::Models::Webhooks::ResponseCancelledWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::ResponseCancelledWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"response.cancelled"] The type of the event. Always `response.cancelled`.

        # @see OpenAI::Models::Webhooks::ResponseCancelledWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the model response.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::ResponseCancelledWebhookEvent::Data} for more
          #   details.
          #
          #   Event data payload.
          #
          #   @param id [String] The unique ID of the model response.
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::ResponseCancelledWebhookEvent#object
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
