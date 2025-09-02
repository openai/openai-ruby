# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeConversationItemFunctionCall < OpenAI::Internal::Type::BaseModel
        # @!attribute arguments
        #   The arguments of the function call.
        #
        #   @return [String]
        required :arguments, String

        # @!attribute name
        #   The name of the function being called.
        #
        #   @return [String]
        required :name, String

        # @!attribute type
        #   The type of the item. Always `function_call`.
        #
        #   @return [Symbol, :function_call]
        required :type, const: :function_call

        # @!attribute id
        #   The unique ID of the item.
        #
        #   @return [String, nil]
        optional :id, String

        # @!attribute call_id
        #   The ID of the function call.
        #
        #   @return [String, nil]
        optional :call_id, String

        # @!attribute object
        #   Identifier for the API object being returned - always `realtime.item`.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall::Object, nil]
        optional :object, enum: -> { OpenAI::Realtime::RealtimeConversationItemFunctionCall::Object }

        # @!attribute status
        #   The status of the item. Has no effect on the conversation.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall::Status, nil]
        optional :status, enum: -> { OpenAI::Realtime::RealtimeConversationItemFunctionCall::Status }

        # @!method initialize(arguments:, name:, id: nil, call_id: nil, object: nil, status: nil, type: :function_call)
        #   A function call item in a Realtime conversation.
        #
        #   @param arguments [String] The arguments of the function call.
        #
        #   @param name [String] The name of the function being called.
        #
        #   @param id [String] The unique ID of the item.
        #
        #   @param call_id [String] The ID of the function call.
        #
        #   @param object [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall::Object] Identifier for the API object being returned - always `realtime.item`.
        #
        #   @param status [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall::Status] The status of the item. Has no effect on the conversation.
        #
        #   @param type [Symbol, :function_call] The type of the item. Always `function_call`.

        # Identifier for the API object being returned - always `realtime.item`.
        #
        # @see OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall#object
        module Object
          extend OpenAI::Internal::Type::Enum

          REALTIME_ITEM = :"realtime.item"

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The status of the item. Has no effect on the conversation.
        #
        # @see OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall#status
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
