# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeConversationItemFunctionCallOutput < OpenAI::Internal::Type::BaseModel
        # @!attribute call_id
        #   The ID of the function call this output is for.
        #
        #   @return [String]
        required :call_id, String

        # @!attribute output
        #   The output of the function call.
        #
        #   @return [String]
        required :output, String

        # @!attribute type
        #   The type of the item. Always `function_call_output`.
        #
        #   @return [Symbol, :function_call_output]
        required :type, const: :function_call_output

        # @!attribute id
        #   The unique ID of the item.
        #
        #   @return [String, nil]
        optional :id, String

        # @!attribute object
        #   Identifier for the API object being returned - always `realtime.item`.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput::Object, nil]
        optional :object, enum: -> { OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Object }

        # @!attribute status
        #   The status of the item. Has no effect on the conversation.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput::Status, nil]
        optional :status, enum: -> { OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Status }

        # @!method initialize(call_id:, output:, id: nil, object: nil, status: nil, type: :function_call_output)
        #   A function call output item in a Realtime conversation.
        #
        #   @param call_id [String] The ID of the function call this output is for.
        #
        #   @param output [String] The output of the function call.
        #
        #   @param id [String] The unique ID of the item.
        #
        #   @param object [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput::Object] Identifier for the API object being returned - always `realtime.item`.
        #
        #   @param status [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput::Status] The status of the item. Has no effect on the conversation.
        #
        #   @param type [Symbol, :function_call_output] The type of the item. Always `function_call_output`.

        # Identifier for the API object being returned - always `realtime.item`.
        #
        # @see OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput#object
        module Object
          extend OpenAI::Internal::Type::Enum

          REALTIME_ITEM = :"realtime.item"

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The status of the item. Has no effect on the conversation.
        #
        # @see OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput#status
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
