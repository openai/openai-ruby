# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseReasoningTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the reasoning content part this delta is associated with.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute delta
        #   The text delta that was added to the reasoning content.
        #
        #   @return [String]
        required :delta, String

        # @!attribute item_id
        #   The ID of the item this reasoning text delta is associated with.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item this reasoning text delta is associated with.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.reasoning_text.delta`.
        #
        #   @return [Symbol, :"response.reasoning_text.delta"]
        required :type, const: :"response.reasoning_text.delta"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseReasoningTextDeltaEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseReasoningTextDeltaEvent::Agent }, nil?: true

        # @!method initialize(content_index:, delta:, item_id:, output_index:, sequence_number:, agent: nil, type: :"response.reasoning_text.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseReasoningTextDeltaEvent} for more details.
        #
        #   Emitted when a delta is added to a reasoning text.
        #
        #   @param content_index [Integer] The index of the reasoning content part this delta is associated with.
        #
        #   @param delta [String] The text delta that was added to the reasoning content.
        #
        #   @param item_id [String] The ID of the item this reasoning text delta is associated with.
        #
        #   @param output_index [Integer] The index of the output item this reasoning text delta is associated with.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseReasoningTextDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.reasoning_text.delta"] The type of the event. Always `response.reasoning_text.delta`.

        # @see OpenAI::Models::Beta::BetaResponseReasoningTextDeltaEvent#agent
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

    BetaResponseReasoningTextDeltaEvent = Beta::BetaResponseReasoningTextDeltaEvent
  end
end
