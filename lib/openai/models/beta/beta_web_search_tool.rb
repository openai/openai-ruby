# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaWebSearchTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaWebSearchTool::Type]
        required :type, enum: -> { OpenAI::Beta::BetaWebSearchTool::Type }

        # @!attribute filters
        #   Filters for the search.
        #
        #   @return [OpenAI::Models::Beta::BetaWebSearchTool::Filters, nil]
        optional :filters, -> { OpenAI::Beta::BetaWebSearchTool::Filters }, nil?: true

        # @!attribute search_context_size
        #   High level guidance for the amount of context window space to use for the
        #   search. One of `low`, `medium`, or `high`. `medium` is the default.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaWebSearchTool::SearchContextSize, nil]
        optional :search_context_size, enum: -> { OpenAI::Beta::BetaWebSearchTool::SearchContextSize }

        # @!attribute user_location
        #   The approximate location of the user.
        #
        #   @return [OpenAI::Models::Beta::BetaWebSearchTool::UserLocation, nil]
        optional :user_location, -> { OpenAI::Beta::BetaWebSearchTool::UserLocation }, nil?: true

        # @!method initialize(type:, filters: nil, search_context_size: nil, user_location: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaWebSearchTool} for more details.
        #
        #   Search the Internet for sources related to the prompt. Learn more about the
        #   [web search tool](https://platform.openai.com/docs/guides/tools-web-search).
        #
        #   @param type [Symbol, OpenAI::Models::Beta::BetaWebSearchTool::Type] The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
        #
        #   @param filters [OpenAI::Models::Beta::BetaWebSearchTool::Filters, nil] Filters for the search.
        #
        #   @param search_context_size [Symbol, OpenAI::Models::Beta::BetaWebSearchTool::SearchContextSize] High level guidance for the amount of context window space to use for the search
        #
        #   @param user_location [OpenAI::Models::Beta::BetaWebSearchTool::UserLocation, nil] The approximate location of the user.

        # The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
        #
        # @see OpenAI::Models::Beta::BetaWebSearchTool#type
        module Type
          extend OpenAI::Internal::Type::Enum

          WEB_SEARCH = :web_search
          WEB_SEARCH_2025_08_26 = :web_search_2025_08_26

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Beta::BetaWebSearchTool#filters
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
          #   {OpenAI::Models::Beta::BetaWebSearchTool::Filters} for more details.
          #
          #   Filters for the search.
          #
          #   @param allowed_domains [Array<String>, nil] Allowed domains for the search. If not provided, all domains are allowed.
        end

        # High level guidance for the amount of context window space to use for the
        # search. One of `low`, `medium`, or `high`. `medium` is the default.
        #
        # @see OpenAI::Models::Beta::BetaWebSearchTool#search_context_size
        module SearchContextSize
          extend OpenAI::Internal::Type::Enum

          LOW = :low
          MEDIUM = :medium
          HIGH = :high

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Beta::BetaWebSearchTool#user_location
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
          #   @return [Symbol, OpenAI::Models::Beta::BetaWebSearchTool::UserLocation::Type, nil]
          optional :type, enum: -> { OpenAI::Beta::BetaWebSearchTool::UserLocation::Type }

          # @!method initialize(city: nil, country: nil, region: nil, timezone: nil, type: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaWebSearchTool::UserLocation} for more details.
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
          #   @param type [Symbol, OpenAI::Models::Beta::BetaWebSearchTool::UserLocation::Type] The type of location approximation. Always `approximate`.

          # The type of location approximation. Always `approximate`.
          #
          # @see OpenAI::Models::Beta::BetaWebSearchTool::UserLocation#type
          module Type
            extend OpenAI::Internal::Type::Enum

            APPROXIMATE = :approximate

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end

    BetaWebSearchTool = Beta::BetaWebSearchTool
  end
end
