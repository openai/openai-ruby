# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class EvalRunFailedWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the eval run failed.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::EvalRunFailedWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::EvalRunFailedWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `eval.run.failed`.
        #
        #   @return [Symbol, :"eval.run.failed"]
        required :type, const: :"eval.run.failed"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::EvalRunFailedWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::EvalRunFailedWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"eval.run.failed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::EvalRunFailedWebhookEvent} for more details.
        #
        #   Sent when an eval run has failed.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the eval run failed.
        #
        #   @param data [OpenAI::Models::Webhooks::EvalRunFailedWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::EvalRunFailedWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"eval.run.failed"] The type of the event. Always `eval.run.failed`.

        # @see OpenAI::Models::Webhooks::EvalRunFailedWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the eval run.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::EvalRunFailedWebhookEvent::Data} for more details.
          #
          #   Event data payload.
          #
          #   @param id [String] The unique ID of the eval run.
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::EvalRunFailedWebhookEvent#object
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
