# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class ResponseIncompleteWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the model response was interrupted.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::ResponseIncompleteWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::ResponseIncompleteWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `response.incomplete`.
        #
        #   @return [Symbol, :"response.incomplete"]
        required :type, const: :"response.incomplete"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::ResponseIncompleteWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::ResponseIncompleteWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"response.incomplete")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::ResponseIncompleteWebhookEvent} for more details.
        #
        #   Sent when a background response has been interrupted.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the model response was interrupted.
        #
        #   @param data [OpenAI::Models::Webhooks::ResponseIncompleteWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::ResponseIncompleteWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"response.incomplete"] The type of the event. Always `response.incomplete`.

        # @see OpenAI::Models::Webhooks::ResponseIncompleteWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the model response.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::ResponseIncompleteWebhookEvent::Data} for more
          #   details.
          #
          #   Event data payload.
          #
          #   @param id [String] The unique ID of the model response.
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::ResponseIncompleteWebhookEvent#object
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
