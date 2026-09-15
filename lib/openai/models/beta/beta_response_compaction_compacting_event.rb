# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseCompactionCompactingEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the compaction output item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the compaction output item.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of the event that was emitted.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event, always `response.compaction.compacting`.
        #
        #   @return [Symbol, :"response.compaction.compacting"]
        required :type, const: :"response.compaction.compacting"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseCompactionCompactingEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseCompactionCompactingEvent::Agent }

        # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, type: :"response.compaction.compacting")
        #   Emitted when new summary content is sampled for a compaction trigger. Contains
        #   no summary content.
        #
        #   @param item_id [String]
        #     The ID of the compaction output item.
        #
        #   @param output_index [Integer]
        #     The index of the compaction output item.
        #
        #   @param sequence_number [Integer]
        #     The sequence number of the event that was emitted.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseCompactionCompactingEvent::Agent]
        #     The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.compaction.compacting"]
        #     The type of the event, always `response.compaction.compacting`.

        # @see OpenAI::Models::Beta::BetaResponseCompactionCompactingEvent#agent
        class Agent < OpenAI::Internal::Type::BaseModel
          # @!attribute agent_name
          #   The canonical name of the agent that produced this item.
          #
          #   @return [String]
          required :agent_name, String

          # @!method initialize(agent_name:)
          #   The agent that owns this multi-agent streaming event.
          #
          #   @param agent_name [String]
          #     The canonical name of the agent that produced this item.
        end
      end
    end

    BetaResponseCompactionCompactingEvent = Beta::BetaResponseCompactionCompactingEvent
  end
end
