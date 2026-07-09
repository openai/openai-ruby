# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseReasoningSummaryPartDoneEvent < OpenAI::Internal::Type::BaseModel
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
        #   The completed summary part.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent::Part]
        required :part, -> { OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Part }

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
        #   The type of the event. Always `response.reasoning_summary_part.done`.
        #
        #   @return [Symbol, :"response.reasoning_summary_part.done"]
        required :type, const: :"response.reasoning_summary_part.done"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Agent }, nil?: true

        # @!attribute status
        #   The completion status of the summary part. Omitted when the part completed
        #   normally and set to `incomplete` when generation was interrupted.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent::Status, nil]
        optional :status, enum: -> { OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Status }

        # @!method initialize(item_id:, output_index:, part:, sequence_number:, summary_index:, agent: nil, status: nil, type: :"response.reasoning_summary_part.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent} for more
        #   details.
        #
        #   Emitted when a reasoning summary part is completed.
        #
        #   @param item_id [String] The ID of the item this summary part is associated with.
        #
        #   @param output_index [Integer] The index of the output item this summary part is associated with.
        #
        #   @param part [OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent::Part] The completed summary part.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param summary_index [Integer] The index of the summary part within the reasoning summary.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent::Status] The completion status of the summary part. Omitted when the part completed
        #
        #   @param type [Symbol, :"response.reasoning_summary_part.done"] The type of the event. Always `response.reasoning_summary_part.done`.

        # @see OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent#part
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
          #   The completed summary part.
          #
          #   @param text [String] The text of the summary part.
          #
          #   @param type [Symbol, :summary_text] The type of the summary part. Always `summary_text`.
        end

        # @see OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent#agent
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

        # The completion status of the summary part. Omitted when the part completed
        # normally and set to `incomplete` when generation was interrupted.
        #
        # @see OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent#status
        module Status
          extend OpenAI::Internal::Type::Enum

          INCOMPLETE = :incomplete

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    BetaResponseReasoningSummaryPartDoneEvent = Beta::BetaResponseReasoningSummaryPartDoneEvent
  end
end
