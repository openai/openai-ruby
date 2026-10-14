# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ConversationCreatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute conversation
        #   The conversation resource.
        #
        #   @return [OpenAI::Models::Realtime::ConversationCreatedEvent::Conversation]
        required :conversation, -> { OpenAI::Realtime::ConversationCreatedEvent::Conversation }

        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute type
        #   The event type, must be `conversation.created`.
        #
        #   @return [Symbol, :"conversation.created"]
        required :type, const: :"conversation.created"

        # @!method initialize(conversation:, event_id:, type: :"conversation.created")
        #   Returned when a conversation is created. Emitted right after session creation.
        #
        #   @param conversation [OpenAI::Models::Realtime::ConversationCreatedEvent::Conversation] The conversation resource.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param type [Symbol, :"conversation.created"] The event type, must be `conversation.created`.

        # @see OpenAI::Models::Realtime::ConversationCreatedEvent#conversation
        class Conversation < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the conversation.
          #
          #   @return [String, nil]
          optional :id, String

          # @!attribute object
          #   The object type, must be `realtime.conversation`.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::ConversationCreatedEvent::Conversation::Object, nil]
          optional :object, enum: -> { OpenAI::Realtime::ConversationCreatedEvent::Conversation::Object }

          # @!method initialize(id: nil, object: nil)
          #   The conversation resource.
          #
          #   @param id [String] The unique ID of the conversation.
          #
          #   @param object [Symbol, OpenAI::Models::Realtime::ConversationCreatedEvent::Conversation::Object] The object type, must be `realtime.conversation`.

          # The object type, must be `realtime.conversation`.
          #
          # @see OpenAI::Models::Realtime::ConversationCreatedEvent::Conversation#object
          module Object
            extend OpenAI::Internal::Type::Enum

            REALTIME_CONVERSATION = :"realtime.conversation"

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
