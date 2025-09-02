# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ConversationItemDone < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item
        #   A single item within a Realtime conversation.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeConversationItemSystemMessage, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput, OpenAI::Models::Realtime::RealtimeMcpApprovalResponse, OpenAI::Models::Realtime::RealtimeMcpListTools, OpenAI::Models::Realtime::RealtimeMcpToolCall, OpenAI::Models::Realtime::RealtimeMcpApprovalRequest]
        required :item, union: -> { OpenAI::Realtime::ConversationItem }

        # @!attribute type
        #   The event type, must be `conversation.item.done`.
        #
        #   @return [Symbol, :"conversation.item.done"]
        required :type, const: :"conversation.item.done"

        # @!attribute previous_item_id
        #   The ID of the item that precedes this one, if any. This is used to maintain
        #   ordering when items are inserted.
        #
        #   @return [String, nil]
        optional :previous_item_id, String, nil?: true

        # @!method initialize(event_id:, item:, previous_item_id: nil, type: :"conversation.item.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::ConversationItemDone} for more details.
        #
        #   Returned when a conversation item is finalized.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item [OpenAI::Models::Realtime::RealtimeConversationItemSystemMessage, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput, OpenAI::Models::Realtime::RealtimeMcpApprovalResponse, OpenAI::Models::Realtime::RealtimeMcpListTools, OpenAI::Models::Realtime::RealtimeMcpToolCall, OpenAI::Models::Realtime::RealtimeMcpApprovalRequest] A single item within a Realtime conversation.
        #
        #   @param previous_item_id [String, nil] The ID of the item that precedes this one, if any. This is used to
        #
        #   @param type [Symbol, :"conversation.item.done"] The event type, must be `conversation.item.done`.
      end
    end
  end
end
