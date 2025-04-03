# typed: strong

module OpenAI
  module Models
    module Responses
      class WebSearchTool < OpenAI::BaseModel
        # The type of the web search tool. One of:
        #
        #   - `web_search_preview`
        #   - `web_search_preview_2025_03_11`
        sig { returns(OpenAI::Models::Responses::WebSearchTool::Type::OrSymbol) }
        attr_accessor :type

        # High level guidance for the amount of context window space to use for the
        #   search. One of `low`, `medium`, or `high`. `medium` is the default.
        sig { returns(T.nilable(OpenAI::Models::Responses::WebSearchTool::SearchContextSize::OrSymbol)) }
        attr_reader :search_context_size

        sig { params(search_context_size: OpenAI::Models::Responses::WebSearchTool::SearchContextSize::OrSymbol).void }
        attr_writer :search_context_size

        sig { returns(T.nilable(OpenAI::Models::Responses::WebSearchTool::UserLocation)) }
        attr_reader :user_location

        sig do
          params(
            user_location: T.nilable(T.any(OpenAI::Models::Responses::WebSearchTool::UserLocation, OpenAI::Internal::Util::AnyHash))
          )
            .void
        end
        attr_writer :user_location

        # This tool searches the web for relevant results to use in a response. Learn more
        #   about the
        #   [web search tool](https://platform.openai.com/docs/guides/tools-web-search).
        sig do
          params(
            type: OpenAI::Models::Responses::WebSearchTool::Type::OrSymbol,
            search_context_size: OpenAI::Models::Responses::WebSearchTool::SearchContextSize::OrSymbol,
            user_location: T.nilable(T.any(OpenAI::Models::Responses::WebSearchTool::UserLocation, OpenAI::Internal::Util::AnyHash))
          )
            .returns(T.attached_class)
        end
        def self.new(type:, search_context_size: nil, user_location: nil)
        end

        sig do
          override
            .returns(
              {
                type: OpenAI::Models::Responses::WebSearchTool::Type::OrSymbol,
                search_context_size: OpenAI::Models::Responses::WebSearchTool::SearchContextSize::OrSymbol,
                user_location: T.nilable(OpenAI::Models::Responses::WebSearchTool::UserLocation)
              }
            )
        end
        def to_hash
        end

        # The type of the web search tool. One of:
        #
        #   - `web_search_preview`
        #   - `web_search_preview_2025_03_11`
        module Type
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::WebSearchTool::Type) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::WebSearchTool::Type::TaggedSymbol) }

          WEB_SEARCH_PREVIEW =
            T.let(:web_search_preview, OpenAI::Models::Responses::WebSearchTool::Type::TaggedSymbol)
          WEB_SEARCH_PREVIEW_2025_03_11 =
            T.let(:web_search_preview_2025_03_11, OpenAI::Models::Responses::WebSearchTool::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::WebSearchTool::Type::TaggedSymbol]) }
          def self.values
          end
        end

        # High level guidance for the amount of context window space to use for the
        #   search. One of `low`, `medium`, or `high`. `medium` is the default.
        module SearchContextSize
          extend OpenAI::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Responses::WebSearchTool::SearchContextSize) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::WebSearchTool::SearchContextSize::TaggedSymbol) }

          LOW = T.let(:low, OpenAI::Models::Responses::WebSearchTool::SearchContextSize::TaggedSymbol)
          MEDIUM = T.let(:medium, OpenAI::Models::Responses::WebSearchTool::SearchContextSize::TaggedSymbol)
          HIGH = T.let(:high, OpenAI::Models::Responses::WebSearchTool::SearchContextSize::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::WebSearchTool::SearchContextSize::TaggedSymbol]) }
          def self.values
          end
        end

        class UserLocation < OpenAI::BaseModel
          # The type of location approximation. Always `approximate`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Free text input for the city of the user, e.g. `San Francisco`.
          sig { returns(T.nilable(String)) }
          attr_reader :city

          sig { params(city: String).void }
          attr_writer :city

          # The two-letter [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of
          #   the user, e.g. `US`.
          sig { returns(T.nilable(String)) }
          attr_reader :country

          sig { params(country: String).void }
          attr_writer :country

          # Free text input for the region of the user, e.g. `California`.
          sig { returns(T.nilable(String)) }
          attr_reader :region

          sig { params(region: String).void }
          attr_writer :region

          # The [IANA timezone](https://timeapi.io/documentation/iana-timezones) of the
          #   user, e.g. `America/Los_Angeles`.
          sig { returns(T.nilable(String)) }
          attr_reader :timezone

          sig { params(timezone: String).void }
          attr_writer :timezone

          sig do
            params(city: String, country: String, region: String, timezone: String, type: Symbol)
              .returns(T.attached_class)
          end
          def self.new(city: nil, country: nil, region: nil, timezone: nil, type: :approximate)
          end

          sig do
            override.returns({type: Symbol, city: String, country: String, region: String, timezone: String})
          end
          def to_hash
          end
        end
      end
    end
  end
end
