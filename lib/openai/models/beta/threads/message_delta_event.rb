# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageDeltaEvent < OpenAI::BaseModel
          # @!attribute id
          #   The identifier of the message, which can be referenced in API endpoints.
          #
          #   @return [String]
          required :id, String

          # @!attribute delta
          #   The delta containing the fields that have changed on the Message.
          #
          #   @return [OpenAI::Models::Beta::Threads::MessageDelta]
          required :delta, -> { OpenAI::Models::Beta::Threads::MessageDelta }

          # @!attribute object
          #   The object type, which is always `thread.message.delta`.
          #
          #   @return [Symbol, :"thread.message.delta"]
          required :object, const: :"thread.message.delta"

          # @!parse
          #   # Represents a message delta i.e. any changed fields on a message during
          #   #   streaming.
          #   #
          #   # @param id [String]
          #   # @param delta [OpenAI::Models::Beta::Threads::MessageDelta]
          #   # @param object [Symbol, :"thread.message.delta"]
          #   #
          #   def initialize(id:, delta:, object: :"thread.message.delta", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end
      end
    end
  end
end
