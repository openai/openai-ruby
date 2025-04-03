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
        required :status, enum: -> { OpenAI::Models::Responses::ResponseFunctionWebSearch::Status }

        # @!attribute type
        #   The type of the web search tool call. Always `web_search_call`.
        #
        #   @return [Symbol, :web_search_call]
        required :type, const: :web_search_call

        # @!parse
        #   # The results of a web search tool call. See the
        #   #   [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for
        #   #   more information.
        #   #
        #   # @param id [String]
        #   # @param status [Symbol, OpenAI::Models::Responses::ResponseFunctionWebSearch::Status]
        #   # @param type [Symbol, :web_search_call]
        #   #
        #   def initialize(id:, status:, type: :web_search_call, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        # The status of the web search tool call.
        #
        # @see OpenAI::Models::Responses::ResponseFunctionWebSearch#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          SEARCHING = :searching
          COMPLETED = :completed
          FAILED = :failed

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end
      end
    end
  end
end
