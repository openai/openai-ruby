# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseFileSearchCallInProgressEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the output item that the file search call is initiated.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the file search call is initiated.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.file_search_call.in_progress`.
        #
        #   @return [Symbol, :"response.file_search_call.in_progress"]
        required :type, const: :"response.file_search_call.in_progress"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseFileSearchCallInProgressEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseFileSearchCallInProgressEvent::Agent }, nil?: true

        # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, type: :"response.file_search_call.in_progress")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseFileSearchCallInProgressEvent} for more
        #   details.
        #
        #   Emitted when a file search call is initiated.
        #
        #   @param item_id [String] The ID of the output item that the file search call is initiated.
        #
        #   @param output_index [Integer] The index of the output item that the file search call is initiated.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseFileSearchCallInProgressEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.file_search_call.in_progress"] The type of the event. Always `response.file_search_call.in_progress`.

        # @see OpenAI::Models::Beta::BetaResponseFileSearchCallInProgressEvent#agent
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

    BetaResponseFileSearchCallInProgressEvent = Beta::BetaResponseFileSearchCallInProgressEvent
  end
end
