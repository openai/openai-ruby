# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseFunctionCallArgumentsDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The function-call arguments delta that is added.
        #
        #   @return [String]
        required :delta, String

        # @!attribute item_id
        #   The ID of the output item that the function-call arguments delta is added to.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the function-call arguments delta is added to.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.function_call_arguments.delta`.
        #
        #   @return [Symbol, :"response.function_call_arguments.delta"]
        required :type, const: :"response.function_call_arguments.delta"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDeltaEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseFunctionCallArgumentsDeltaEvent::Agent }, nil?: true

        # @!method initialize(delta:, item_id:, output_index:, sequence_number:, agent: nil, type: :"response.function_call_arguments.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDeltaEvent} for more
        #   details.
        #
        #   Emitted when there is a partial function-call arguments delta.
        #
        #   @param delta [String] The function-call arguments delta that is added.
        #
        #   @param item_id [String] The ID of the output item that the function-call arguments delta is added to.
        #
        #   @param output_index [Integer] The index of the output item that the function-call arguments delta is added to.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.function_call_arguments.delta"] The type of the event. Always `response.function_call_arguments.delta`.

        # @see OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDeltaEvent#agent
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

    BetaResponseFunctionCallArgumentsDeltaEvent = Beta::BetaResponseFunctionCallArgumentsDeltaEvent
  end
end
