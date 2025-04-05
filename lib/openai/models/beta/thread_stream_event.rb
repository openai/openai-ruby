# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class ThreadStreamEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute data
        #   Represents a thread that contains
        #     [messages](https://platform.openai.com/docs/api-reference/messages).
        #
        #   @return [OpenAI::Models::Beta::Thread]
        required :data, -> { OpenAI::Models::Beta::Thread }

        # @!attribute event
        #
        #   @return [Symbol, :"thread.created"]
        required :event, const: :"thread.created"

        # @!attribute [r] enabled
        #   Whether to enable input audio transcription.
        #
        #   @return [Boolean, nil]
        optional :enabled, OpenAI::Internal::Type::Boolean

        # @!parse
        #   # @return [Boolean]
        #   attr_writer :enabled

        # @!parse
        #   # Occurs when a new
        #   #   [thread](https://platform.openai.com/docs/api-reference/threads/object) is
        #   #   created.
        #   #
        #   # @param data [OpenAI::Models::Beta::Thread]
        #   # @param enabled [Boolean]
        #   # @param event [Symbol, :"thread.created"]
        #   #
        #   def initialize(data:, enabled: nil, event: :"thread.created", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
