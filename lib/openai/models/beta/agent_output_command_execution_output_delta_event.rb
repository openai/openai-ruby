# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentOutputCommandExecutionOutputDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The output text that was appended.
        #
        #   @return [String]
        required :delta, String

        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the command execution item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the item in the turn output.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute session_id
        #   The ID of the session associated with the event.
        #
        #   @return [String]
        required :session_id, String

        # @!attribute turn_id
        #   The ID of the turn associated with the event, when applicable.
        #
        #   @return [String, nil]
        required :turn_id, String, nil?: true

        # @!attribute type
        #   The type of the object. Always `agent.output.command_execution_output.delta`.
        #
        #   @return [Symbol, :"agent.output.command_execution_output.delta"]
        required :type, const: :"agent.output.command_execution_output.delta"

        # @!method initialize(delta:, event_id:, item_id:, output_index:, session_id:, turn_id:, type: :"agent.output.command_execution_output.delta")
        #   Emitted when command execution produces an output delta.
        #
        #   @param delta [String]
        #     The output text that was appended.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param item_id [String]
        #     The ID of the command execution item.
        #
        #   @param output_index [Integer]
        #     The index of the item in the turn output.
        #
        #   @param session_id [String]
        #     The ID of the session associated with the event.
        #
        #   @param turn_id [String, nil]
        #     The ID of the turn associated with the event, when applicable.
        #
        #   @param type [Symbol, :"agent.output.command_execution_output.delta"]
        #     The type of the object. Always `agent.output.command_execution_output.delta`.
      end
    end
  end
end
