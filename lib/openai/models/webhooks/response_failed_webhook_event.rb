# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class ResponseFailedWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the model response failed.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::ResponseFailedWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::ResponseFailedWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `response.failed`.
        #
        #   @return [Symbol, :"response.failed"]
        required :type, const: :"response.failed"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::ResponseFailedWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::ResponseFailedWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"response.failed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::ResponseFailedWebhookEvent} for more details.
        #
        #   Sent when a background response has failed.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the model response failed.
        #
        #   @param data [OpenAI::Models::Webhooks::ResponseFailedWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::ResponseFailedWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"response.failed"] The type of the event. Always `response.failed`.

        # @see OpenAI::Models::Webhooks::ResponseFailedWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the model response.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::ResponseFailedWebhookEvent::Data} for more details.
          #
          #   Event data payload.
          #
          #   @param id [String] The unique ID of the model response.
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::ResponseFailedWebhookEvent#object
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
