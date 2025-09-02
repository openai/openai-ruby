# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeConversationItemAssistantMessage < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The content of the message.
        #
        #   @return [Array<OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage::Content>]
        required :content,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Realtime::RealtimeConversationItemAssistantMessage::Content] }

        # @!attribute role
        #   The role of the message sender. Always `assistant`.
        #
        #   @return [Symbol, :assistant]
        required :role, const: :assistant

        # @!attribute type
        #   The type of the item. Always `message`.
        #
        #   @return [Symbol, :message]
        required :type, const: :message

        # @!attribute id
        #   The unique ID of the item.
        #
        #   @return [String, nil]
        optional :id, String

        # @!attribute object
        #   Identifier for the API object being returned - always `realtime.item`.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage::Object, nil]
        optional :object, enum: -> { OpenAI::Realtime::RealtimeConversationItemAssistantMessage::Object }

        # @!attribute status
        #   The status of the item. Has no effect on the conversation.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage::Status, nil]
        optional :status, enum: -> { OpenAI::Realtime::RealtimeConversationItemAssistantMessage::Status }

        # @!method initialize(content:, id: nil, object: nil, status: nil, role: :assistant, type: :message)
        #   An assistant message item in a Realtime conversation.
        #
        #   @param content [Array<OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage::Content>] The content of the message.
        #
        #   @param id [String] The unique ID of the item.
        #
        #   @param object [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage::Object] Identifier for the API object being returned - always `realtime.item`.
        #
        #   @param status [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage::Status] The status of the item. Has no effect on the conversation.
        #
        #   @param role [Symbol, :assistant] The role of the message sender. Always `assistant`.
        #
        #   @param type [Symbol, :message] The type of the item. Always `message`.

        class Content < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   The text content.
          #
          #   @return [String, nil]
          optional :text, String

          # @!attribute type
          #   The content type. Always `text` for assistant messages.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage::Content::Type, nil]
          optional :type, enum: -> { OpenAI::Realtime::RealtimeConversationItemAssistantMessage::Content::Type }

          # @!method initialize(text: nil, type: nil)
          #   @param text [String] The text content.
          #
          #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage::Content::Type] The content type. Always `text` for assistant messages.

          # The content type. Always `text` for assistant messages.
          #
          # @see OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage::Content#type
          module Type
            extend OpenAI::Internal::Type::Enum

            TEXT = :text

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # Identifier for the API object being returned - always `realtime.item`.
        #
        # @see OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage#object
        module Object
          extend OpenAI::Internal::Type::Enum

          REALTIME_ITEM = :"realtime.item"

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The status of the item. Has no effect on the conversation.
        #
        # @see OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage#status
        module Status
          extend OpenAI::Internal::Type::Enum

          COMPLETED = :completed
          INCOMPLETE = :incomplete
          IN_PROGRESS = :in_progress

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
