# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ConversationItemCreateEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item
        #   A single item within a Realtime conversation.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeConversationItemSystemMessage, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput, OpenAI::Models::Realtime::RealtimeMcpApprovalResponse, OpenAI::Models::Realtime::RealtimeMcpListTools, OpenAI::Models::Realtime::RealtimeMcpToolCall, OpenAI::Models::Realtime::RealtimeMcpApprovalRequest]
        required :item, union: -> { OpenAI::Realtime::ConversationItem }

        # @!attribute type
        #   The event type, must be `conversation.item.create`.
        #
        #   @return [Symbol, :"conversation.item.create"]
        required :type, const: :"conversation.item.create"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!attribute previous_item_id
        #   The ID of the preceding item after which the new item will be inserted. If not
        #   set, the new item will be appended to the end of the conversation. If set to
        #   `root`, the new item will be added to the beginning of the conversation. If set
        #   to an existing ID, it allows an item to be inserted mid-conversation. If the ID
        #   cannot be found, an error will be returned and the item will not be added.
        #
        #   @return [String, nil]
        optional :previous_item_id, String

        # @!method initialize(item:, event_id: nil, previous_item_id: nil, type: :"conversation.item.create")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::ConversationItemCreateEvent} for more details.
        #
        #   Add a new Item to the Conversation's context, including messages, function
        #   calls, and function call responses. This event can be used both to populate a
        #   "history" of the conversation and to add new items mid-stream, but has the
        #   current limitation that it cannot populate assistant audio messages.
        #
        #   If successful, the server will respond with a `conversation.item.created` event,
        #   otherwise an `error` event will be sent.
        #
        #   @param item [OpenAI::Models::Realtime::RealtimeConversationItemSystemMessage, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput, OpenAI::Models::Realtime::RealtimeMcpApprovalResponse, OpenAI::Models::Realtime::RealtimeMcpListTools, OpenAI::Models::Realtime::RealtimeMcpToolCall, OpenAI::Models::Realtime::RealtimeMcpApprovalRequest] A single item within a Realtime conversation.
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param previous_item_id [String] The ID of the preceding item after which the new item will be inserted.
        #
        #   @param type [Symbol, :"conversation.item.create"] The event type, must be `conversation.item.create`.
      end
    end
  end
end
