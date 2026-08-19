# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ConversationItemCreatedEvent < OpenAI::Internal::Type::BaseModel
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
        #   The event type, must be `conversation.item.created`.
        #
        #   @return [Symbol, :"conversation.item.created"]
        required :type, const: :"conversation.item.created"

        # @!attribute previous_item_id
        #   The ID of the preceding item in the Conversation context, allows the client to
        #   understand the order of the conversation. Can be `null` if the item has no
        #   predecessor.
        #
        #   @return [String, nil]
        optional :previous_item_id, String, nil?: true

        # @!method initialize(event_id:, item:, previous_item_id: nil, type: :"conversation.item.created")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::ConversationItemCreatedEvent} for more details.
        #
        #   Returned when a conversation item is created. There are several scenarios that
        #   produce this event:
        #
        #   - The server is generating a Response, which if successful will produce either
        #     one or two Items, which will be of type `message` (role `assistant`) or type
        #     `function_call`.
        #   - The input audio buffer has been committed, either by the client or the server
        #     (in `server_vad` mode). The server will take the content of the input audio
        #     buffer and add it to a new user message Item.
        #   - The client has sent a `conversation.item.create` event to add a new Item to
        #     the Conversation.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item [OpenAI::Models::Realtime::RealtimeConversationItemSystemMessage, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput, OpenAI::Models::Realtime::RealtimeMcpApprovalResponse, OpenAI::Models::Realtime::RealtimeMcpListTools, OpenAI::Models::Realtime::RealtimeMcpToolCall, OpenAI::Models::Realtime::RealtimeMcpApprovalRequest] A single item within a Realtime conversation.
        #
        #   @param previous_item_id [String, nil] The ID of the preceding item in the Conversation context, allows the
        #
        #   @param type [Symbol, :"conversation.item.created"] The event type, must be `conversation.item.created`.
      end
    end
  end
end
