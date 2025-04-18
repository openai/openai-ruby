# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class WebSearchTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the web search tool. One of:
        #
        #   - `web_search_preview`
        #   - `web_search_preview_2025_03_11`
        #
        #   @return [Symbol, OpenAI::Models::Responses::WebSearchTool::Type]
        required :type, enum: -> { OpenAI::Models::Responses::WebSearchTool::Type }

        # @!attribute [r] search_context_size
        #   High level guidance for the amount of context window space to use for the
        #   search. One of `low`, `medium`, or `high`. `medium` is the default.
        #
        #   @return [Symbol, OpenAI::Models::Responses::WebSearchTool::SearchContextSize, nil]
        optional :search_context_size, enum: -> { OpenAI::Models::Responses::WebSearchTool::SearchContextSize }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::Responses::WebSearchTool::SearchContextSize]
        #   attr_writer :search_context_size

        # @!attribute user_location
        #
        #   @return [OpenAI::Models::Responses::WebSearchTool::UserLocation, nil]
        optional :user_location, -> { OpenAI::Models::Responses::WebSearchTool::UserLocation }, nil?: true

        # @!method initialize(type:, search_context_size: nil, user_location: nil)
        #   This tool searches the web for relevant results to use in a response. Learn more
        #   about the
        #   [web search tool](https://platform.openai.com/docs/guides/tools-web-search).
        #
        #   @param type [Symbol, OpenAI::Models::Responses::WebSearchTool::Type]
        #   @param search_context_size [Symbol, OpenAI::Models::Responses::WebSearchTool::SearchContextSize]
        #   @param user_location [OpenAI::Models::Responses::WebSearchTool::UserLocation, nil]

        # The type of the web search tool. One of:
        #
        # - `web_search_preview`
        # - `web_search_preview_2025_03_11`
        #
        # @see OpenAI::Models::Responses::WebSearchTool#type
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
          # @!attribute type
          #   The type of location approximation. Always `approximate`.
          #
          #   @return [Symbol, :approximate]
          required :type, const: :approximate

          # @!attribute [r] city
          #   Free text input for the city of the user, e.g. `San Francisco`.
          #
          #   @return [String, nil]
          optional :city, String

          # @!parse
          #   # @return [String]
          #   attr_writer :city

          # @!attribute [r] country
          #   The two-letter [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of
          #   the user, e.g. `US`.
          #
          #   @return [String, nil]
          optional :country, String

          # @!parse
          #   # @return [String]
          #   attr_writer :country

          # @!attribute [r] region
          #   Free text input for the region of the user, e.g. `California`.
          #
          #   @return [String, nil]
          optional :region, String

          # @!parse
          #   # @return [String]
          #   attr_writer :region

          # @!attribute [r] timezone
          #   The [IANA timezone](https://timeapi.io/documentation/iana-timezones) of the
          #   user, e.g. `America/Los_Angeles`.
          #
          #   @return [String, nil]
          optional :timezone, String

          # @!parse
          #   # @return [String]
          #   attr_writer :timezone

          # @!method initialize(city: nil, country: nil, region: nil, timezone: nil, type: :approximate)
          #   @param city [String]
          #   @param country [String]
          #   @param region [String]
          #   @param timezone [String]
          #   @param type [Symbol, :approximate]
        end
      end
    end
  end
end
