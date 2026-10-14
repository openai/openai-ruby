# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseCodeInterpreterCallInterpretingEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The unique identifier of the code interpreter tool call item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response for which the code interpreter is
        #   interpreting code.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event, used to order streaming events.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.code_interpreter_call.interpreting`.
        #
        #   @return [Symbol, :"response.code_interpreter_call.interpreting"]
        required :type, const: :"response.code_interpreter_call.interpreting"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInterpretingEvent::Agent, nil]
        optional :agent,
                 -> {
                   OpenAI::Beta::BetaResponseCodeInterpreterCallInterpretingEvent::Agent
                 },
                 nil?: true

        # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, type: :"response.code_interpreter_call.interpreting")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInterpretingEvent} for
        #   more details.
        #
        #   Emitted when the code interpreter is actively interpreting the code snippet.
        #
        #   @param item_id [String] The unique identifier of the code interpreter tool call item.
        #
        #   @param output_index [Integer] The index of the output item in the response for which the code interpreter is i
        #
        #   @param sequence_number [Integer] The sequence number of this event, used to order streaming events.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInterpretingEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.code_interpreter_call.interpreting"] The type of the event. Always `response.code_interpreter_call.interpreting`.

        # @see OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInterpretingEvent#agent
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

    BetaResponseCodeInterpreterCallInterpretingEvent = Beta::BetaResponseCodeInterpreterCallInterpretingEvent
  end
end
