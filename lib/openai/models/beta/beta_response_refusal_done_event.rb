# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseRefusalDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part that the refusal text is finalized.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute item_id
        #   The ID of the output item that the refusal text is finalized.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the refusal text is finalized.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute refusal
        #   The refusal text that is finalized.
        #
        #   @return [String]
        required :refusal, String

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.refusal.done`.
        #
        #   @return [Symbol, :"response.refusal.done"]
        required :type, const: :"response.refusal.done"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseRefusalDoneEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseRefusalDoneEvent::Agent }, nil?: true

        # @!method initialize(content_index:, item_id:, output_index:, refusal:, sequence_number:, agent: nil, type: :"response.refusal.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseRefusalDoneEvent} for more details.
        #
        #   Emitted when refusal text is finalized.
        #
        #   @param content_index [Integer] The index of the content part that the refusal text is finalized.
        #
        #   @param item_id [String] The ID of the output item that the refusal text is finalized.
        #
        #   @param output_index [Integer] The index of the output item that the refusal text is finalized.
        #
        #   @param refusal [String] The refusal text that is finalized.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseRefusalDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.refusal.done"] The type of the event. Always `response.refusal.done`.

        # @see OpenAI::Models::Beta::BetaResponseRefusalDoneEvent#agent
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

    BetaResponseRefusalDoneEvent = Beta::BetaResponseRefusalDoneEvent
  end
end
