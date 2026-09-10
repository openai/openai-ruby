# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentFunctionCallItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the function call item.
        #
        #   @return [String]
        required :id, String

        # @!attribute arguments
        #   The arguments to pass to the function.
        #
        #   @return [Object]
        required :arguments, OpenAI::Internal::Type::Unknown

        # @!attribute call_id
        #   The ID used to submit the function result.
        #
        #   @return [String]
        required :call_id, String

        # @!attribute name
        #   The name of the function to call.
        #
        #   @return [String]
        required :name, String

        # @!attribute status
        #   The status of the function call.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
        required :status, enum: -> { OpenAI::Beta::AgentFunctionCallStatus }

        # @!attribute turn_id
        #   The ID of the turn that contains this item.
        #
        #   @return [String]
        required :turn_id, String

        # @!attribute type
        #   The item type. Always `function_call`.
        #
        #   @return [Symbol, :function_call]
        required :type, const: :function_call

        # @!method initialize(id:, arguments:, call_id:, name:, status:, turn_id:, type: :function_call)
        #   A function call produced by the agent.
        #
        #   @param id [String]
        #     The ID of the function call item.
        #
        #   @param arguments [Object]
        #     The arguments to pass to the function.
        #
        #   @param call_id [String]
        #     The ID used to submit the function result.
        #
        #   @param name [String]
        #     The name of the function to call.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
        #     The status of the function call.
        #
        #   @param turn_id [String]
        #     The ID of the turn that contains this item.
        #
        #   @param type [Symbol, :function_call]
        #     The item type. Always `function_call`.
      end
    end
  end
end
