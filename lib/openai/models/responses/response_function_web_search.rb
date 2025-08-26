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

        # @!attribute action
        #   An object describing the specific action taken in this web search call. Includes
        #   details on how the model used the web (search, open_page, find).
        #
        #   @return [OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::Search, OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::OpenPage, OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::Find]
        required :action, union: -> { OpenAI::Responses::ResponseFunctionWebSearch::Action }

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

        # @!method initialize(id:, action:, status:, type: :web_search_call)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseFunctionWebSearch} for more details.
        #
        #   The results of a web search tool call. See the
        #   [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for
        #   more information.
        #
        #   @param id [String] The unique ID of the web search tool call.
        #
        #   @param action [OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::Search, OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::OpenPage, OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::Find] An object describing the specific action taken in this web search call.
        #
        #   @param status [Symbol, OpenAI::Models::Responses::ResponseFunctionWebSearch::Status] The status of the web search tool call.
        #
        #   @param type [Symbol, :web_search_call] The type of the web search tool call. Always `web_search_call`.

        # An object describing the specific action taken in this web search call. Includes
        # details on how the model used the web (search, open_page, find).
        #
        # @see OpenAI::Models::Responses::ResponseFunctionWebSearch#action
        module Action
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # Action type "search" - Performs a web search query.
          variant :search, -> { OpenAI::Responses::ResponseFunctionWebSearch::Action::Search }

          # Action type "open_page" - Opens a specific URL from search results.
          variant :open_page, -> { OpenAI::Responses::ResponseFunctionWebSearch::Action::OpenPage }

          # Action type "find": Searches for a pattern within a loaded page.
          variant :find, -> { OpenAI::Responses::ResponseFunctionWebSearch::Action::Find }

          class Search < OpenAI::Internal::Type::BaseModel
            # @!attribute query
            #   The search query.
            #
            #   @return [String]
            required :query, String

            # @!attribute type
            #   The action type.
            #
            #   @return [Symbol, :search]
            required :type, const: :search

            # @!attribute sources
            #   The sources used in the search.
            #
            #   @return [Array<OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::Search::Source>, nil]
            optional :sources,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseFunctionWebSearch::Action::Search::Source] }

            # @!method initialize(query:, sources: nil, type: :search)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::Search} for more
            #   details.
            #
            #   Action type "search" - Performs a web search query.
            #
            #   @param query [String] The search query.
            #
            #   @param sources [Array<OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::Search::Source>] The sources used in the search.
            #
            #   @param type [Symbol, :search] The action type.

            class Source < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   The type of source. Always `url`.
              #
              #   @return [Symbol, :url]
              required :type, const: :url

              # @!attribute url
              #   The URL of the source.
              #
              #   @return [String]
              required :url, String

              # @!method initialize(url:, type: :url)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::Search::Source}
              #   for more details.
              #
              #   A source used in the search.
              #
              #   @param url [String] The URL of the source.
              #
              #   @param type [Symbol, :url] The type of source. Always `url`.
            end
          end

          class OpenPage < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The action type.
            #
            #   @return [Symbol, :open_page]
            required :type, const: :open_page

            # @!attribute url
            #   The URL opened by the model.
            #
            #   @return [String]
            required :url, String

            # @!method initialize(url:, type: :open_page)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::OpenPage} for
            #   more details.
            #
            #   Action type "open_page" - Opens a specific URL from search results.
            #
            #   @param url [String] The URL opened by the model.
            #
            #   @param type [Symbol, :open_page] The action type.
          end

          class Find < OpenAI::Internal::Type::BaseModel
            # @!attribute pattern
            #   The pattern or text to search for within the page.
            #
            #   @return [String]
            required :pattern, String

            # @!attribute type
            #   The action type.
            #
            #   @return [Symbol, :find]
            required :type, const: :find

            # @!attribute url
            #   The URL of the page searched for the pattern.
            #
            #   @return [String]
            required :url, String

            # @!method initialize(pattern:, url:, type: :find)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::Find} for more
            #   details.
            #
            #   Action type "find": Searches for a pattern within a loaded page.
            #
            #   @param pattern [String] The pattern or text to search for within the page.
            #
            #   @param url [String] The URL of the page searched for the pattern.
            #
            #   @param type [Symbol, :find] The action type.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::Search, OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::OpenPage, OpenAI::Models::Responses::ResponseFunctionWebSearch::Action::Find)]
        end

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
