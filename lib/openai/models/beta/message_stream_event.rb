# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @abstract
      #
      # Occurs when a
      #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
      #   created.
      class MessageStreamEvent < OpenAI::Union
        discriminator :event

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) is created.
        variant :"thread.message.created", -> { OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageCreated }

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) moves to an `in_progress` state.
        variant :"thread.message.in_progress",
                -> { OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageInProgress }

        # Occurs when parts of a [Message](https://platform.openai.com/docs/api-reference/messages/object) are being streamed.
        variant :"thread.message.delta", -> { OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageDelta }

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) is completed.
        variant :"thread.message.completed",
                -> { OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageCompleted }

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) ends before it is completed.
        variant :"thread.message.incomplete",
                -> { OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageIncomplete }

        class ThreadMessageCreated < OpenAI::BaseModel
          # @!attribute data
          #   Represents a message within a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Message]
          required :data, -> { OpenAI::Models::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.created"]
          required :event, const: :"thread.message.created"

          # @!parse
          #   # Occurs when a
          #   #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
          #   #   created.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Message]
          #   # @param event [Symbol, :"thread.message.created"]
          #   #
          #   def initialize(data:, event: :"thread.message.created", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadMessageInProgress < OpenAI::BaseModel
          # @!attribute data
          #   Represents a message within a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Message]
          required :data, -> { OpenAI::Models::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.in_progress"]
          required :event, const: :"thread.message.in_progress"

          # @!parse
          #   # Occurs when a
          #   #   [message](https://platform.openai.com/docs/api-reference/messages/object) moves
          #   #   to an `in_progress` state.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Message]
          #   # @param event [Symbol, :"thread.message.in_progress"]
          #   #
          #   def initialize(data:, event: :"thread.message.in_progress", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadMessageDelta < OpenAI::BaseModel
          # @!attribute data
          #   Represents a message delta i.e. any changed fields on a message during
          #     streaming.
          #
          #   @return [OpenAI::Models::Beta::Threads::MessageDeltaEvent]
          required :data, -> { OpenAI::Models::Beta::Threads::MessageDeltaEvent }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.delta"]
          required :event, const: :"thread.message.delta"

          # @!parse
          #   # Occurs when parts of a
          #   #   [Message](https://platform.openai.com/docs/api-reference/messages/object) are
          #   #   being streamed.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::MessageDeltaEvent]
          #   # @param event [Symbol, :"thread.message.delta"]
          #   #
          #   def initialize(data:, event: :"thread.message.delta", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadMessageCompleted < OpenAI::BaseModel
          # @!attribute data
          #   Represents a message within a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Message]
          required :data, -> { OpenAI::Models::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.completed"]
          required :event, const: :"thread.message.completed"

          # @!parse
          #   # Occurs when a
          #   #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
          #   #   completed.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Message]
          #   # @param event [Symbol, :"thread.message.completed"]
          #   #
          #   def initialize(data:, event: :"thread.message.completed", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadMessageIncomplete < OpenAI::BaseModel
          # @!attribute data
          #   Represents a message within a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Message]
          required :data, -> { OpenAI::Models::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.incomplete"]
          required :event, const: :"thread.message.incomplete"

          # @!parse
          #   # Occurs when a
          #   #   [message](https://platform.openai.com/docs/api-reference/messages/object) ends
          #   #   before it is completed.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Message]
          #   # @param event [Symbol, :"thread.message.incomplete"]
          #   #
          #   def initialize(data:, event: :"thread.message.incomplete", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        # @!parse
        #   class << self
        #     # @return [Array(OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageCreated, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageInProgress, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageDelta, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageCompleted, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageIncomplete)]
        #     def variants; end
        #   end
      end
    end
  end
end
