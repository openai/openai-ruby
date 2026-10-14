# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # An action performed by the web search tool.
      module WebSearchAction
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A search query or group of search queries.
        variant :search, -> { OpenAI::Beta::WebSearchAction::Search }

        # Opens a web page.
        variant :open_page, -> { OpenAI::Beta::WebSearchAction::OpenPage }

        # Finds text within a web page.
        variant :find_in_page, -> { OpenAI::Beta::WebSearchAction::FindInPage }

        # Another web search action.
        variant :other, -> { OpenAI::Beta::WebSearchAction::Other }

        class Search < OpenAI::Internal::Type::BaseModel
          # @!attribute queries
          #   The search queries, when multiple queries were used.
          #
          #   @return [Array<String>, nil]
          required :queries, OpenAI::Internal::Type::ArrayOf[String], nil?: true

          # @!attribute query
          #   The search query, when a single query was used.
          #
          #   @return [String, nil]
          required :query, String, nil?: true

          # @!attribute type
          #   The type of the object. Always `search`.
          #
          #   @return [Symbol, :search]
          required :type, const: :search

          # @!method initialize(queries:, query:, type: :search)
          #   A search query or group of search queries.
          #
          #   @param queries [Array<String>, nil]
          #     The search queries, when multiple queries were used.
          #
          #   @param query [String, nil]
          #     The search query, when a single query was used.
          #
          #   @param type [Symbol, :search]
          #     The type of the object. Always `search`.
        end

        class OpenPage < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of the object. Always `open_page`.
          #
          #   @return [Symbol, :open_page]
          required :type, const: :open_page

          # @!attribute url
          #   The URL of the page that was opened.
          #
          #   @return [String, nil]
          required :url, String, nil?: true

          # @!method initialize(url:, type: :open_page)
          #   Opens a web page.
          #
          #   @param url [String, nil]
          #     The URL of the page that was opened.
          #
          #   @param type [Symbol, :open_page]
          #     The type of the object. Always `open_page`.
        end

        class FindInPage < OpenAI::Internal::Type::BaseModel
          # @!attribute pattern
          #   The text pattern that was searched for.
          #
          #   @return [String, nil]
          required :pattern, String, nil?: true

          # @!attribute type
          #   The type of the object. Always `find_in_page`.
          #
          #   @return [Symbol, :find_in_page]
          required :type, const: :find_in_page

          # @!attribute url
          #   The URL of the page that was searched.
          #
          #   @return [String, nil]
          required :url, String, nil?: true

          # @!method initialize(pattern:, url:, type: :find_in_page)
          #   Finds text within a web page.
          #
          #   @param pattern [String, nil]
          #     The text pattern that was searched for.
          #
          #   @param url [String, nil]
          #     The URL of the page that was searched.
          #
          #   @param type [Symbol, :find_in_page]
          #     The type of the object. Always `find_in_page`.
        end

        class Other < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of the object. Always `other`.
          #
          #   @return [Symbol, :other]
          required :type, const: :other

          # @!method initialize(type: :other)
          #   Another web search action.
          #
          #   @param type [Symbol, :other]
          #     The type of the object. Always `other`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::WebSearchAction::Search, OpenAI::Models::Beta::WebSearchAction::OpenPage, OpenAI::Models::Beta::WebSearchAction::FindInPage, OpenAI::Models::Beta::WebSearchAction::Other)]
      end
    end
  end
end
