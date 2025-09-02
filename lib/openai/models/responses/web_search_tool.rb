# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class WebSearchTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::WebSearchTool::Type]
        required :type, enum: -> { OpenAI::Responses::WebSearchTool::Type }

        # @!attribute filters
        #   Filters for the search.
        #
        #   @return [OpenAI::Models::Responses::WebSearchTool::Filters, nil]
        optional :filters, -> { OpenAI::Responses::WebSearchTool::Filters }, nil?: true

        # @!attribute search_context_size
        #   High level guidance for the amount of context window space to use for the
        #   search. One of `low`, `medium`, or `high`. `medium` is the default.
        #
        #   @return [Symbol, OpenAI::Models::Responses::WebSearchTool::SearchContextSize, nil]
        optional :search_context_size, enum: -> { OpenAI::Responses::WebSearchTool::SearchContextSize }

        # @!attribute user_location
        #   The approximate location of the user.
        #
        #   @return [OpenAI::Models::Responses::WebSearchTool::UserLocation, nil]
        optional :user_location, -> { OpenAI::Responses::WebSearchTool::UserLocation }, nil?: true

        # @!method initialize(type:, filters: nil, search_context_size: nil, user_location: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::WebSearchTool} for more details.
        #
        #   Search the Internet for sources related to the prompt. Learn more about the
        #   [web search tool](https://platform.openai.com/docs/guides/tools-web-search).
        #
        #   @param type [Symbol, OpenAI::Models::Responses::WebSearchTool::Type] The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
        #
        #   @param filters [OpenAI::Models::Responses::WebSearchTool::Filters, nil] Filters for the search.
        #
        #   @param search_context_size [Symbol, OpenAI::Models::Responses::WebSearchTool::SearchContextSize] High level guidance for the amount of context window space to use for the search
        #
        #   @param user_location [OpenAI::Models::Responses::WebSearchTool::UserLocation, nil] The approximate location of the user.

        # The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
        #
        # @see OpenAI::Models::Responses::WebSearchTool#type
        module Type
          extend OpenAI::Internal::Type::Enum

          WEB_SEARCH = :web_search
          WEB_SEARCH_2025_08_26 = :web_search_2025_08_26

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Responses::WebSearchTool#filters
        class Filters < OpenAI::Internal::Type::BaseModel
          # @!attribute allowed_domains
          #   Allowed domains for the search. If not provided, all domains are allowed.
          #   Subdomains of the provided domains are allowed as well.
          #
          #   Example: `["pubmed.ncbi.nlm.nih.gov"]`
          #
          #   @return [Array<String>, nil]
          optional :allowed_domains, OpenAI::Internal::Type::ArrayOf[String], nil?: true

          # @!method initialize(allowed_domains: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::WebSearchTool::Filters} for more details.
          #
          #   Filters for the search.
          #
          #   @param allowed_domains [Array<String>, nil] Allowed domains for the search. If not provided, all domains are allowed.
        end

        # High level guidance for the amount of context window space to use for the
        # search. One of `low`, `medium`, or `high`. `medium` is the default.
        #
        # @see OpenAI::Models::Responses::WebSearchTool#search_context_size
        module SearchContextSize
          extend OpenAI::Internal::Type::Enum

          LOW = :low
          MEDIUM = :medium
          HIGH = :high

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Responses::WebSearchTool#user_location
        class UserLocation < OpenAI::Internal::Type::BaseModel
          # @!attribute city
          #   Free text input for the city of the user, e.g. `San Francisco`.
          #
          #   @return [String, nil]
          optional :city, String, nil?: true

          # @!attribute country
          #   The two-letter [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of
          #   the user, e.g. `US`.
          #
          #   @return [String, nil]
          optional :country, String, nil?: true

          # @!attribute region
          #   Free text input for the region of the user, e.g. `California`.
          #
          #   @return [String, nil]
          optional :region, String, nil?: true

          # @!attribute timezone
          #   The [IANA timezone](https://timeapi.io/documentation/iana-timezones) of the
          #   user, e.g. `America/Los_Angeles`.
          #
          #   @return [String, nil]
          optional :timezone, String, nil?: true

          # @!attribute type
          #   The type of location approximation. Always `approximate`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::WebSearchTool::UserLocation::Type, nil]
          optional :type, enum: -> { OpenAI::Responses::WebSearchTool::UserLocation::Type }

          # @!method initialize(city: nil, country: nil, region: nil, timezone: nil, type: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::WebSearchTool::UserLocation} for more details.
          #
          #   The approximate location of the user.
          #
          #   @param city [String, nil] Free text input for the city of the user, e.g. `San Francisco`.
          #
          #   @param country [String, nil] The two-letter [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of t
          #
          #   @param region [String, nil] Free text input for the region of the user, e.g. `California`.
          #
          #   @param timezone [String, nil] The [IANA timezone](https://timeapi.io/documentation/iana-timezones) of the user
          #
          #   @param type [Symbol, OpenAI::Models::Responses::WebSearchTool::UserLocation::Type] The type of location approximation. Always `approximate`.

          # The type of location approximation. Always `approximate`.
          #
          # @see OpenAI::Models::Responses::WebSearchTool::UserLocation#type
          module Type
            extend OpenAI::Internal::Type::Enum

            APPROXIMATE = :approximate

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
