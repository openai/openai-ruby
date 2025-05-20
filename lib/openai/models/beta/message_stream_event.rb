# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Occurs when a
      # [message](https://platform.openai.com/docs/api-reference/messages/object) is
      # created.
      module MessageStreamEvent
        extend OpenAI::Internal::Type::Union

        discriminator :event

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) is created.
        variant :"thread.message.created", -> { OpenAI::Beta::MessageStreamEvent::ThreadMessageCreated }

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) moves to an `in_progress` state.
        variant :"thread.message.in_progress",
                -> {
                  OpenAI::Beta::MessageStreamEvent::ThreadMessageInProgress
                }

        # Occurs when parts of a [Message](https://platform.openai.com/docs/api-reference/messages/object) are being streamed.
        variant :"thread.message.delta", -> { OpenAI::Beta::MessageStreamEvent::ThreadMessageDelta }

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) is completed.
        variant :"thread.message.completed", -> { OpenAI::Beta::MessageStreamEvent::ThreadMessageCompleted }

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) ends before it is completed.
        variant :"thread.message.incomplete", -> { OpenAI::Beta::MessageStreamEvent::ThreadMessageIncomplete }

        class ThreadMessageCreated < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Beta::Threads::Message]
          required :data, -> { OpenAI::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.created"]
          required :event, const: :"thread.message.created"

          # @!method initialize(data:, event: :"thread.message.created")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::MessageStreamEvent::ThreadMessageCreated} for more details.
          #
          #   Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
          #   created.
          #
          #   @param data [OpenAI::Beta::Threads::Message] Represents a message within a [thread](https://platform.openai.com/docs/api-refe
          #
          #   @param event [Symbol, :"thread.message.created"]
        end

        class ThreadMessageInProgress < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Beta::Threads::Message]
          required :data, -> { OpenAI::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.in_progress"]
          required :event, const: :"thread.message.in_progress"

          # @!method initialize(data:, event: :"thread.message.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::MessageStreamEvent::ThreadMessageInProgress} for more details.
          #
          #   Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) moves
          #   to an `in_progress` state.
          #
          #   @param data [OpenAI::Beta::Threads::Message] Represents a message within a [thread](https://platform.openai.com/docs/api-refe
          #
          #   @param event [Symbol, :"thread.message.in_progress"]
        end

        class ThreadMessageDelta < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a message delta i.e. any changed fields on a message during
          #   streaming.
          #
          #   @return [OpenAI::Beta::Threads::MessageDeltaEvent]
          required :data, -> { OpenAI::Beta::Threads::MessageDeltaEvent }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.delta"]
          required :event, const: :"thread.message.delta"

          # @!method initialize(data:, event: :"thread.message.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::MessageStreamEvent::ThreadMessageDelta} for more details.
          #
          #   Occurs when parts of a
          #   [Message](https://platform.openai.com/docs/api-reference/messages/object) are
          #   being streamed.
          #
          #   @param data [OpenAI::Beta::Threads::MessageDeltaEvent] Represents a message delta i.e. any changed fields on a message during streaming
          #
          #   @param event [Symbol, :"thread.message.delta"]
        end

        class ThreadMessageCompleted < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Beta::Threads::Message]
          required :data, -> { OpenAI::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.completed"]
          required :event, const: :"thread.message.completed"

          # @!method initialize(data:, event: :"thread.message.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::MessageStreamEvent::ThreadMessageCompleted} for more details.
          #
          #   Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
          #   completed.
          #
          #   @param data [OpenAI::Beta::Threads::Message] Represents a message within a [thread](https://platform.openai.com/docs/api-refe
          #
          #   @param event [Symbol, :"thread.message.completed"]
        end

        class ThreadMessageIncomplete < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Beta::Threads::Message]
          required :data, -> { OpenAI::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.incomplete"]
          required :event, const: :"thread.message.incomplete"

          # @!method initialize(data:, event: :"thread.message.incomplete")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::MessageStreamEvent::ThreadMessageIncomplete} for more details.
          #
          #   Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) ends
          #   before it is completed.
          #
          #   @param data [OpenAI::Beta::Threads::Message] Represents a message within a [thread](https://platform.openai.com/docs/api-refe
          #
          #   @param event [Symbol, :"thread.message.incomplete"]
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Beta::MessageStreamEvent::ThreadMessageCreated, OpenAI::Beta::MessageStreamEvent::ThreadMessageInProgress, OpenAI::Beta::MessageStreamEvent::ThreadMessageDelta, OpenAI::Beta::MessageStreamEvent::ThreadMessageCompleted, OpenAI::Beta::MessageStreamEvent::ThreadMessageIncomplete)]
      end
    end
  end
end
