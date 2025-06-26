# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class EvalRunCanceledWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the eval run was canceled.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::EvalRunCanceledWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::EvalRunCanceledWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `eval.run.canceled`.
        #
        #   @return [Symbol, :"eval.run.canceled"]
        required :type, const: :"eval.run.canceled"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::EvalRunCanceledWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::EvalRunCanceledWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"eval.run.canceled")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::EvalRunCanceledWebhookEvent} for more details.
        #
        #   Sent when an eval run has been canceled.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the eval run was canceled.
        #
        #   @param data [OpenAI::Models::Webhooks::EvalRunCanceledWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::EvalRunCanceledWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"eval.run.canceled"] The type of the event. Always `eval.run.canceled`.

        # @see OpenAI::Models::Webhooks::EvalRunCanceledWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the eval run.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::EvalRunCanceledWebhookEvent::Data} for more details.
          #
          #   Event data payload.
          #
          #   @param id [String] The unique ID of the eval run.
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::EvalRunCanceledWebhookEvent#object
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
