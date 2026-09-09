# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class ThreadStreamEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute data
        #   Represents a thread that contains
        #   [messages](https://developers.openai.com/api/docs/assistants/migration).
        #
        #   @return [OpenAI::Models::Beta::Thread]
        required :data, -> { OpenAI::Beta::Thread }

        # @!attribute event
        #
        #   @return [Symbol, :"thread.created"]
        required :event, const: :"thread.created"

        # @!attribute enabled
        #   Whether to enable input audio transcription.
        #
        #   @return [Boolean, nil]
        optional :enabled, OpenAI::Internal::Type::Boolean

        # @!method initialize(data:, enabled: nil, event: :"thread.created")
        #   Occurs when a new
        #   [thread](https://developers.openai.com/api/docs/assistants/migration) is
        #   created.
        #
        #   @param data [OpenAI::Models::Beta::Thread]
        #     Represents a thread that contains
        #     [messages](https://developers.openai.com/api/docs/assistants/migration).
        #
        #   @param enabled [Boolean]
        #     Whether to enable input audio transcription.
        #
        #   @param event [Symbol, :"thread.created"]
      end
    end
  end
end
