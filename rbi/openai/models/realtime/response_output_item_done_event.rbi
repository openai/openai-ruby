# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseOutputItemDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseOutputItemDoneEvent,
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

        # The index of the output item in the Response.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The ID of the Response to which the item belongs.
        sig { returns(String) }
        attr_accessor :response_id

        # The event type, must be `response.output_item.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when an Item is done streaming. Also emitted when a Response is
        # interrupted, incomplete, or cancelled.
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
            output_index: Integer,
            response_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # A single item within a Realtime conversation.
          item:,
          # The index of the output item in the Response.
          output_index:,
          # The ID of the Response to which the item belongs.
          response_id:,
          # The event type, must be `response.output_item.done`.
          type: :"response.output_item.done"
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
              output_index: Integer,
              response_id: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
