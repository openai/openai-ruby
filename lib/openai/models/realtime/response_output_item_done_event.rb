# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseOutputItemDoneEvent < OpenAI::Internal::Type::BaseModel
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

        # @!attribute output_index
        #   The index of the output item in the Response.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute response_id
        #   The ID of the Response to which the item belongs.
        #
        #   @return [String]
        required :response_id, String

        # @!attribute type
        #   The event type, must be `response.output_item.done`.
        #
        #   @return [Symbol, :"response.output_item.done"]
        required :type, const: :"response.output_item.done"

        # @!method initialize(event_id:, item:, output_index:, response_id:, type: :"response.output_item.done")
        #   Returned when an Item is done streaming. Also emitted when a Response is
        #   interrupted, incomplete, or cancelled.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item [OpenAI::Models::Realtime::RealtimeConversationItemSystemMessage, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput, OpenAI::Models::Realtime::RealtimeMcpApprovalResponse, OpenAI::Models::Realtime::RealtimeMcpListTools, OpenAI::Models::Realtime::RealtimeMcpToolCall, OpenAI::Models::Realtime::RealtimeMcpApprovalRequest] A single item within a Realtime conversation.
        #
        #   @param output_index [Integer] The index of the output item in the Response.
        #
        #   @param response_id [String] The ID of the Response to which the item belongs.
        #
        #   @param type [Symbol, :"response.output_item.done"] The event type, must be `response.output_item.done`.
      end
    end
  end
end
