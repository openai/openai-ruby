# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class WebSearchTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the web search tool. One of `web_search_preview` or
        #   `web_search_preview_2025_03_11`.
        #
        #   @return [Symbol, OpenAI::Responses::WebSearchTool::Type]
        required :type, enum: -> { OpenAI::Responses::WebSearchTool::Type }

        # @!attribute search_context_size
        #   High level guidance for the amount of context window space to use for the
        #   search. One of `low`, `medium`, or `high`. `medium` is the default.
        #
        #   @return [Symbol, OpenAI::Responses::WebSearchTool::SearchContextSize, nil]
        optional :search_context_size, enum: -> { OpenAI::Responses::WebSearchTool::SearchContextSize }

        # @!attribute user_location
        #   The user's location.
        #
        #   @return [OpenAI::Responses::WebSearchTool::UserLocation, nil]
        optional :user_location, -> { OpenAI::Responses::WebSearchTool::UserLocation }, nil?: true

        # @!method initialize(type:, search_context_size: nil, user_location: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::WebSearchTool} for more details.
        #
        #   This tool searches the web for relevant results to use in a response. Learn more
        #   about the
        #   [web search tool](https://platform.openai.com/docs/guides/tools-web-search).
        #
        #   @param type [Symbol, OpenAI::Responses::WebSearchTool::Type] The type of the web search tool. One of `web_search_preview` or `web_search_prev
        #
        #   @param search_context_size [Symbol, OpenAI::Responses::WebSearchTool::SearchContextSize] High level guidance for the amount of context window space to use for the search
        #
        #   @param user_location [OpenAI::Responses::WebSearchTool::UserLocation, nil] The user's location.

        # The type of the web search tool. One of `web_search_preview` or
        # `web_search_preview_2025_03_11`.
        #
        # @see OpenAI::Responses::WebSearchTool#type
        module Type
          extend OpenAI::Internal::Type::Enum

          WEB_SEARCH_PREVIEW = :web_search_preview
          WEB_SEARCH_PREVIEW_2025_03_11 = :web_search_preview_2025_03_11

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # High level guidance for the amount of context window space to use for the
        # search. One of `low`, `medium`, or `high`. `medium` is the default.
        #
        # @see OpenAI::Responses::WebSearchTool#search_context_size
        module SearchContextSize
          extend OpenAI::Internal::Type::Enum

          LOW = :low
          MEDIUM = :medium
          HIGH = :high

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Responses::WebSearchTool#user_location
        class UserLocation < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of location approximation. Always `approximate`.
          #
          #   @return [Symbol, :approximate]
          required :type, const: :approximate

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

          # @!method initialize(city: nil, country: nil, region: nil, timezone: nil, type: :approximate)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Responses::WebSearchTool::UserLocation} for more details.
          #
          #   The user's location.
          #
          #   @param city [String, nil] Free text input for the city of the user, e.g. `San Francisco`.
          #
          #   @param country [String, nil] The two-letter [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of t
          #
          #   @param region [String, nil] Free text input for the region of the user, e.g. `California`.
          #
          #   @param timezone [String, nil] The [IANA timezone](https://timeapi.io/documentation/iana-timezones) of the user
          #
          #   @param type [Symbol, :approximate] The type of location approximation. Always `approximate`.
        end
      end
    end
  end
end
