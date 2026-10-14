# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseWebSearchCallInProgressEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   Unique ID for the output item associated with the web search call.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the web search call is associated with.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of the web search call being processed.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.web_search_call.in_progress`.
        #
        #   @return [Symbol, :"response.web_search_call.in_progress"]
        required :type, const: :"response.web_search_call.in_progress"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseWebSearchCallInProgressEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseWebSearchCallInProgressEvent::Agent }, nil?: true

        # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, type: :"response.web_search_call.in_progress")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseWebSearchCallInProgressEvent} for more
        #   details.
        #
        #   Emitted when a web search call is initiated.
        #
        #   @param item_id [String] Unique ID for the output item associated with the web search call.
        #
        #   @param output_index [Integer] The index of the output item that the web search call is associated with.
        #
        #   @param sequence_number [Integer] The sequence number of the web search call being processed.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseWebSearchCallInProgressEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.web_search_call.in_progress"] The type of the event. Always `response.web_search_call.in_progress`.

        # @see OpenAI::Models::Beta::BetaResponseWebSearchCallInProgressEvent#agent
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

    BetaResponseWebSearchCallInProgressEvent = Beta::BetaResponseWebSearchCallInProgressEvent
  end
end
