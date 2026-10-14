# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConversationItemCreatedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationItemCreatedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # A single item within a Realtime conversation.
        sig do
          returns(
            T.any(
              OpenAI::Realtime::RealtimeConversationItemSystemMessage,
              OpenAI::Realtime::RealtimeConversationItemUserMessage,
              OpenAI::Realtime::RealtimeConversationItemAssistantMessage,
              OpenAI::Realtime::RealtimeConversationItemFunctionCall,
              OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput,
              OpenAI::Realtime::RealtimeMcpApprovalResponse,
              OpenAI::Realtime::RealtimeMcpListTools,
              OpenAI::Realtime::RealtimeMcpToolCall,
              OpenAI::Realtime::RealtimeMcpApprovalRequest
            )
          )
        end
        attr_accessor :item

        # The event type, must be `conversation.item.created`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The ID of the preceding item in the Conversation context, allows the client to
        # understand the order of the conversation. Can be `null` if the item has no
        # predecessor.
        sig { returns(T.nilable(String)) }
        attr_accessor :previous_item_id

        # Returned when a conversation item is created. There are several scenarios that
        # produce this event:
        #
        # - The server is generating a Response, which if successful will produce either
        #   one or two Items, which will be of type `message` (role `assistant`) or type
        #   `function_call`.
        # - The input audio buffer has been committed, either by the client or the server
        #   (in `server_vad` mode). The server will take the content of the input audio
        #   buffer and add it to a new user message Item.
        # - The client has sent a `conversation.item.create` event to add a new Item to
        #   the Conversation.
        sig do
          params(
            event_id: String,
            item:
              T.any(
                OpenAI::Realtime::RealtimeConversationItemSystemMessage::OrHash,
                OpenAI::Realtime::RealtimeConversationItemUserMessage::OrHash,
                OpenAI::Realtime::RealtimeConversationItemAssistantMessage::OrHash,
                OpenAI::Realtime::RealtimeConversationItemFunctionCall::OrHash,
                OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::OrHash,
                OpenAI::Realtime::RealtimeMcpApprovalResponse::OrHash,
                OpenAI::Realtime::RealtimeMcpListTools::OrHash,
                OpenAI::Realtime::RealtimeMcpToolCall::OrHash,
                OpenAI::Realtime::RealtimeMcpApprovalRequest::OrHash
              ),
            previous_item_id: T.nilable(String),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # A single item within a Realtime conversation.
          item:,
          # The ID of the preceding item in the Conversation context, allows the client to
          # understand the order of the conversation. Can be `null` if the item has no
          # predecessor.
          previous_item_id: nil,
          # The event type, must be `conversation.item.created`.
          type: :"conversation.item.created"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              item:
                T.any(
                  OpenAI::Realtime::RealtimeConversationItemSystemMessage,
                  OpenAI::Realtime::RealtimeConversationItemUserMessage,
                  OpenAI::Realtime::RealtimeConversationItemAssistantMessage,
                  OpenAI::Realtime::RealtimeConversationItemFunctionCall,
                  OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput,
                  OpenAI::Realtime::RealtimeMcpApprovalResponse,
                  OpenAI::Realtime::RealtimeMcpListTools,
                  OpenAI::Realtime::RealtimeMcpToolCall,
                  OpenAI::Realtime::RealtimeMcpApprovalRequest
                ),
              type: Symbol,
              previous_item_id: T.nilable(String)
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
