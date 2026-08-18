# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class EvalRunSucceededWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the eval run succeeded.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::EvalRunSucceededWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::EvalRunSucceededWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `eval.run.succeeded`.
        #
        #   @return [Symbol, :"eval.run.succeeded"]
        required :type, const: :"eval.run.succeeded"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::EvalRunSucceededWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::EvalRunSucceededWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"eval.run.succeeded")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::EvalRunSucceededWebhookEvent} for more details.
        #
        #   Sent when an eval run has succeeded.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the eval run succeeded.
        #
        #   @param data [OpenAI::Models::Webhooks::EvalRunSucceededWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::EvalRunSucceededWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"eval.run.succeeded"] The type of the event. Always `eval.run.succeeded`.

        # @see OpenAI::Models::Webhooks::EvalRunSucceededWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the eval run.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::EvalRunSucceededWebhookEvent::Data} for more details.
          #
          #   Event data payload.
          #
          #   @param id [String] The unique ID of the eval run.
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::EvalRunSucceededWebhookEvent#object
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
