# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class ResponseCompletedWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the model response was completed.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::ResponseCompletedWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::ResponseCompletedWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `response.completed`.
        #
        #   @return [Symbol, :"response.completed"]
        required :type, const: :"response.completed"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::ResponseCompletedWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::ResponseCompletedWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"response.completed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::ResponseCompletedWebhookEvent} for more details.
        #
        #   Sent when a background response has been completed.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the model response was completed.
        #
        #   @param data [OpenAI::Models::Webhooks::ResponseCompletedWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::ResponseCompletedWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"response.completed"] The type of the event. Always `response.completed`.

        # @see OpenAI::Models::Webhooks::ResponseCompletedWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the model response.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::ResponseCompletedWebhookEvent::Data} for more
          #   details.
          #
          #   Event data payload.
          #
          #   @param id [String] The unique ID of the model response.
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::ResponseCompletedWebhookEvent#object
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
