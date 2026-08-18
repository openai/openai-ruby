# typed: strong

module OpenAI
  module Models
    module Realtime
      # A single item within a Realtime conversation.
      module ConversationItem
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
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
          end

        sig do
          override.returns(
            T::Array[OpenAI::Realtime::ConversationItem::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
