# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConversationItemDone < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationItemDone,
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

        # The event type, must be `conversation.item.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The ID of the item that precedes this one, if any. This is used to maintain
        # ordering when items are inserted.
        sig { returns(T.nilable(String)) }
        attr_accessor :previous_item_id

        # Returned when a conversation item is finalized.
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
          # The ID of the item that precedes this one, if any. This is used to maintain
          # ordering when items are inserted.
          previous_item_id: nil,
          # The event type, must be `conversation.item.done`.
          type: :"conversation.item.done"
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
