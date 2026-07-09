# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseFunctionWebSearch < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the web search tool call.
        #
        #   @return [String]
        required :id, String

        # @!attribute action
        #   An object describing the specific action taken in this web search call. Includes
        #   details on how the model used the web (search, open_page, find_in_page).
        #
        #   @return [OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::Search, OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::OpenPage, OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::FindInPage]
        required :action, union: -> { OpenAI::Beta::BetaResponseFunctionWebSearch::Action }

        # @!attribute status
        #   The status of the web search tool call.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Status]
        required :status, enum: -> { OpenAI::Beta::BetaResponseFunctionWebSearch::Status }

        # @!attribute type
        #   The type of the web search tool call. Always `web_search_call`.
        #
        #   @return [Symbol, :web_search_call]
        required :type, const: :web_search_call

        # @!attribute agent
        #   The agent that produced this item.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseFunctionWebSearch::Agent }, nil?: true

        # @!method initialize(id:, action:, status:, agent: nil, type: :web_search_call)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseFunctionWebSearch} for more details.
        #
        #   The results of a web search tool call. See the
        #   [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for
        #   more information.
        #
        #   @param id [String] The unique ID of the web search tool call.
        #
        #   @param action [OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::Search, OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::OpenPage, OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::FindInPage] An object describing the specific action taken in this web search call.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Status] The status of the web search tool call.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Agent, nil] The agent that produced this item.
        #
        #   @param type [Symbol, :web_search_call] The type of the web search tool call. Always `web_search_call`.

        # An object describing the specific action taken in this web search call. Includes
        # details on how the model used the web (search, open_page, find_in_page).
        #
        # @see OpenAI::Models::Beta::BetaResponseFunctionWebSearch#action
        module Action
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # Action type "search" - Performs a web search query.
          variant :search, -> { OpenAI::Beta::BetaResponseFunctionWebSearch::Action::Search }

          # Action type "open_page" - Opens a specific URL from search results.
          variant :open_page, -> { OpenAI::Beta::BetaResponseFunctionWebSearch::Action::OpenPage }

          # Action type "find_in_page": Searches for a pattern within a loaded page.
          variant :find_in_page, -> { OpenAI::Beta::BetaResponseFunctionWebSearch::Action::FindInPage }

          class Search < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The action type.
            #
            #   @return [Symbol, :search]
            required :type, const: :search

            # @!attribute queries
            #   The search queries.
            #
            #   @return [Array<String>, nil]
            optional :queries, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute query
            #   @deprecated
            #
            #   The search query.
            #
            #   @return [String, nil]
            optional :query, String

            # @!attribute sources
            #   The sources used in the search.
            #
            #   @return [Array<OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::Search::Source>, nil]
            optional :sources,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseFunctionWebSearch::Action::Search::Source] }

            # @!method initialize(queries: nil, query: nil, sources: nil, type: :search)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::Search} for more
            #   details.
            #
            #   Action type "search" - Performs a web search query.
            #
            #   @param queries [Array<String>] The search queries.
            #
            #   @param query [String] The search query.
            #
            #   @param sources [Array<OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::Search::Source>] The sources used in the search.
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
              #   {OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::Search::Source}
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
            #   @return [String, nil]
            optional :url, String, nil?: true

            # @!method initialize(url: nil, type: :open_page)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::OpenPage} for more
            #   details.
            #
            #   Action type "open_page" - Opens a specific URL from search results.
            #
            #   @param url [String, nil] The URL opened by the model.
            #
            #   @param type [Symbol, :open_page] The action type.
          end

          class FindInPage < OpenAI::Internal::Type::BaseModel
            # @!attribute pattern
            #   The pattern or text to search for within the page.
            #
            #   @return [String]
            required :pattern, String

            # @!attribute type
            #   The action type.
            #
            #   @return [Symbol, :find_in_page]
            required :type, const: :find_in_page

            # @!attribute url
            #   The URL of the page searched for the pattern.
            #
            #   @return [String]
            required :url, String

            # @!method initialize(pattern:, url:, type: :find_in_page)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::FindInPage} for
            #   more details.
            #
            #   Action type "find_in_page": Searches for a pattern within a loaded page.
            #
            #   @param pattern [String] The pattern or text to search for within the page.
            #
            #   @param url [String] The URL of the page searched for the pattern.
            #
            #   @param type [Symbol, :find_in_page] The action type.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::Search, OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::OpenPage, OpenAI::Models::Beta::BetaResponseFunctionWebSearch::Action::FindInPage)]
        end

        # The status of the web search tool call.
        #
        # @see OpenAI::Models::Beta::BetaResponseFunctionWebSearch#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          SEARCHING = :searching
          COMPLETED = :completed
          FAILED = :failed

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Beta::BetaResponseFunctionWebSearch#agent
        class Agent < OpenAI::Internal::Type::BaseModel
          # @!attribute agent_name
          #   The canonical name of the agent that produced this item.
          #
          #   @return [String]
          required :agent_name, String

          # @!method initialize(agent_name:)
          #   The agent that produced this item.
          #
          #   @param agent_name [String] The canonical name of the agent that produced this item.
        end
      end
    end

    BetaResponseFunctionWebSearch = Beta::BetaResponseFunctionWebSearch
  end
end
