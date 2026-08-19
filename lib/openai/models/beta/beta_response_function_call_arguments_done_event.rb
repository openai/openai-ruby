# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseFunctionCallArgumentsDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute arguments
        #   The function-call arguments.
        #
        #   @return [String]
        required :arguments, String

        # @!attribute item_id
        #   The ID of the item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute name
        #   The name of the function that was called.
        #
        #   @return [String]
        required :name, String

        # @!attribute output_index
        #   The index of the output item.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #
        #   @return [Symbol, :"response.function_call_arguments.done"]
        required :type, const: :"response.function_call_arguments.done"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDoneEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseFunctionCallArgumentsDoneEvent::Agent }, nil?: true

        # @!method initialize(arguments:, item_id:, name:, output_index:, sequence_number:, agent: nil, type: :"response.function_call_arguments.done")
        #   Emitted when function-call arguments are finalized.
        #
        #   @param arguments [String] The function-call arguments.
        #
        #   @param item_id [String] The ID of the item.
        #
        #   @param name [String] The name of the function that was called.
        #
        #   @param output_index [Integer] The index of the output item.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.function_call_arguments.done"]

        # @see OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDoneEvent#agent
        class Agent < OpenAI::Internal::Type::BaseModel
          # @!attribute agent_name
          #   The canonical name of the agent that produced this item.
          #
          #   @return [String]
          required :agent_name, String

          # @!method initialize(agent_name:)
          #   The agent that owns this multi-agent streaming event.
          #
          #   @param agent_name [String] The canonical name of the agent that produced this item.
        end
      end
    end

    BetaResponseFunctionCallArgumentsDoneEvent = Beta::BetaResponseFunctionCallArgumentsDoneEvent
  end
end
