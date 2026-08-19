# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseReasoningSummaryPartAddedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the item this summary part is associated with.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item this summary part is associated with.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute part
        #   The summary part that was added.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent::Part]
        required :part, -> { OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Part }

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute summary_index
        #   The index of the summary part within the reasoning summary.
        #
        #   @return [Integer]
        required :summary_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.reasoning_summary_part.added`.
        #
        #   @return [Symbol, :"response.reasoning_summary_part.added"]
        required :type, const: :"response.reasoning_summary_part.added"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Agent }, nil?: true

        # @!method initialize(item_id:, output_index:, part:, sequence_number:, summary_index:, agent: nil, type: :"response.reasoning_summary_part.added")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent} for more
        #   details.
        #
        #   Emitted when a new reasoning summary part is added.
        #
        #   @param item_id [String] The ID of the item this summary part is associated with.
        #
        #   @param output_index [Integer] The index of the output item this summary part is associated with.
        #
        #   @param part [OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent::Part] The summary part that was added.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param summary_index [Integer] The index of the summary part within the reasoning summary.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.reasoning_summary_part.added"] The type of the event. Always `response.reasoning_summary_part.added`.

        # @see OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent#part
        class Part < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   The text of the summary part.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   The type of the summary part. Always `summary_text`.
          #
          #   @return [Symbol, :summary_text]
          required :type, const: :summary_text

          # @!method initialize(text:, type: :summary_text)
          #   The summary part that was added.
          #
          #   @param text [String] The text of the summary part.
          #
          #   @param type [Symbol, :summary_text] The type of the summary part. Always `summary_text`.
        end

        # @see OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent#agent
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

    BetaResponseReasoningSummaryPartAddedEvent = Beta::BetaResponseReasoningSummaryPartAddedEvent
  end
end
