# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageDeltaEvent < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The identifier of the message, which can be referenced in API endpoints.
          #
          #   @return [String]
          required :id, String

          # @!attribute delta
          #   The delta containing the fields that have changed on the Message.
          #
          #   @return [OpenAI::Models::Beta::Threads::MessageDelta]
          required :delta, -> { OpenAI::Beta::Threads::MessageDelta }

          # @!attribute object
          #   The object type, which is always `thread.message.delta`.
          #
          #   @return [Symbol, :"thread.message.delta"]
          required :object, const: :"thread.message.delta"

          # @!method initialize(id:, delta:, object: :"thread.message.delta")
          #   Represents a message delta i.e. any changed fields on a message during
          #   streaming.
          #
          #   @param id [String] The identifier of the message, which can be referenced in API endpoints.
          #
          #   @param delta [OpenAI::Models::Beta::Threads::MessageDelta] The delta containing the fields that have changed on the Message.
          #
          #   @param object [Symbol, :"thread.message.delta"] The object type, which is always `thread.message.delta`.
        end
      end
    end
  end
end
