# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseRefusalDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part that the refusal text is added to.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute delta
        #   The refusal text that is added.
        #
        #   @return [String]
        required :delta, String

        # @!attribute item_id
        #   The ID of the output item that the refusal text is added to.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the refusal text is added to.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.refusal.delta`.
        #
        #   @return [Symbol, :"response.refusal.delta"]
        required :type, const: :"response.refusal.delta"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseRefusalDeltaEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseRefusalDeltaEvent::Agent }, nil?: true

        # @!method initialize(content_index:, delta:, item_id:, output_index:, sequence_number:, agent: nil, type: :"response.refusal.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseRefusalDeltaEvent} for more details.
        #
        #   Emitted when there is a partial refusal text.
        #
        #   @param content_index [Integer] The index of the content part that the refusal text is added to.
        #
        #   @param delta [String] The refusal text that is added.
        #
        #   @param item_id [String] The ID of the output item that the refusal text is added to.
        #
        #   @param output_index [Integer] The index of the output item that the refusal text is added to.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseRefusalDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.refusal.delta"] The type of the event. Always `response.refusal.delta`.

        # @see OpenAI::Models::Beta::BetaResponseRefusalDeltaEvent#agent
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

    BetaResponseRefusalDeltaEvent = Beta::BetaResponseRefusalDeltaEvent
  end
end
