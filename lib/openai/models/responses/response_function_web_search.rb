# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFunctionWebSearch < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the web search tool call.
        #
        #   @return [String]
        required :id, String

        # @!attribute status
        #   The status of the web search tool call.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseFunctionWebSearch::Status]
        required :status, enum: -> { OpenAI::Responses::ResponseFunctionWebSearch::Status }

        # @!attribute type
        #   The type of the web search tool call. Always `web_search_call`.
        #
        #   @return [Symbol, :web_search_call]
        required :type, const: :web_search_call

        # @!method initialize(id:, status:, type: :web_search_call)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseFunctionWebSearch} for more details.
        #
        #   The results of a web search tool call. See the
        #   [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for
        #   more information.
        #
        #   @param id [String] The unique ID of the web search tool call.
        #
        #   @param status [Symbol, OpenAI::Models::Responses::ResponseFunctionWebSearch::Status] The status of the web search tool call.
        #
        #   @param type [Symbol, :web_search_call] The type of the web search tool call. Always `web_search_call`.

        # The status of the web search tool call.
        #
        # @see OpenAI::Models::Responses::ResponseFunctionWebSearch#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          SEARCHING = :searching
          COMPLETED = :completed
          FAILED = :failed

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
