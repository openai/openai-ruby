# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class ThreadStreamEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute data
        #   Represents a thread that contains
        #   [messages](https://platform.openai.com/docs/api-reference/messages).
        #
        #   @return [OpenAI::Models::Beta::Thread]
        required :data, -> { OpenAI::Models::Beta::Thread }

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
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::ThreadStreamEvent} for more details.
        #
        #   Occurs when a new
        #   [thread](https://platform.openai.com/docs/api-reference/threads/object) is
        #   created.
        #
        #   @param data [OpenAI::Models::Beta::Thread] Represents a thread that contains [messages](https://platform.openai.com/docs/ap
        #   ...
        #
        #   @param enabled [Boolean] Whether to enable input audio transcription.
        #
        #   @param event [Symbol, :"thread.created"]
      end
    end
  end
end
