# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentWebSearchCallItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the web search call.
        #
        #   @return [String]
        required :id, String

        # @!attribute action
        #   An action performed by the web search tool.
        #
        #   @return [OpenAI::Models::Beta::WebSearchAction::Search, OpenAI::Models::Beta::WebSearchAction::OpenPage, OpenAI::Models::Beta::WebSearchAction::FindInPage, OpenAI::Models::Beta::WebSearchAction::Other, nil]
        required :action, union: -> { OpenAI::Beta::WebSearchAction }, nil?: true

        # @!attribute status
        #   The status of the web search call.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentOutputItemStatus]
        required :status, enum: -> { OpenAI::Beta::AgentOutputItemStatus }

        # @!attribute turn_id
        #   The ID of the turn that contains this item.
        #
        #   @return [String]
        required :turn_id, String

        # @!attribute type
        #   The item type. Always `web_search_call`.
        #
        #   @return [Symbol, :web_search_call]
        required :type, const: :web_search_call

        # @!method initialize(id:, action:, status:, turn_id:, type: :web_search_call)
        #   A web search call produced by the agent.
        #
        #   @param id [String]
        #     The ID of the web search call.
        #
        #   @param action [OpenAI::Models::Beta::WebSearchAction::Search, OpenAI::Models::Beta::WebSearchAction::OpenPage, OpenAI::Models::Beta::WebSearchAction::FindInPage, OpenAI::Models::Beta::WebSearchAction::Other, nil]
        #     An action performed by the web search tool.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::AgentOutputItemStatus]
        #     The status of the web search call.
        #
        #   @param turn_id [String]
        #     The ID of the turn that contains this item.
        #
        #   @param type [Symbol, :web_search_call]
        #     The item type. Always `web_search_call`.
      end
    end
  end
end
