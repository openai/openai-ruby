# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConversationItemCreateEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationItemCreateEvent,
              OpenAI::Internal::AnyHash
            )
          end

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

        # The event type, must be `conversation.item.create`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # The ID of the preceding item after which the new item will be inserted. If not
        # set, the new item will be appended to the end of the conversation. If set to
        # `root`, the new item will be added to the beginning of the conversation. If set
        # to an existing ID, it allows an item to be inserted mid-conversation. If the ID
        # cannot be found, an error will be returned and the item will not be added.
        sig { returns(T.nilable(String)) }
        attr_reader :previous_item_id

        sig { params(previous_item_id: String).void }
        attr_writer :previous_item_id

        # Add a new Item to the Conversation's context, including messages, function
        # calls, and function call responses. This event can be used both to populate a
        # "history" of the conversation and to add new items mid-stream, but has the
        # current limitation that it cannot populate assistant audio messages.
        #
        # If successful, the server will respond with a `conversation.item.created` event,
        # otherwise an `error` event will be sent.
        sig do
          params(
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
            event_id: String,
            previous_item_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # A single item within a Realtime conversation.
          item:,
          # Optional client-generated ID used to identify this event.
          event_id: nil,
          # The ID of the preceding item after which the new item will be inserted. If not
          # set, the new item will be appended to the end of the conversation. If set to
          # `root`, the new item will be added to the beginning of the conversation. If set
          # to an existing ID, it allows an item to be inserted mid-conversation. If the ID
          # cannot be found, an error will be returned and the item will not be added.
          previous_item_id: nil,
          # The event type, must be `conversation.item.create`.
          type: :"conversation.item.create"
        )
        end

        sig do
          override.returns(
            {
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
              event_id: String,
              previous_item_id: String
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
