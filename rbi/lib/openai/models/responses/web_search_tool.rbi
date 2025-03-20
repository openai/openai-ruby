# typed: strong

module OpenAI
  module Models
    module Responses
      class WebSearchTool < OpenAI::BaseModel
        # The type of the web search tool. One of:
        #
        #   - `web_search_preview`
        #   - `web_search_preview_2025_03_11`
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # High level guidance for the amount of context window space to use for the
        #   search. One of `low`, `medium`, or `high`. `medium` is the default.
        sig { returns(T.nilable(Symbol)) }
        def search_context_size
        end

        sig { params(_: Symbol).returns(Symbol) }
        def search_context_size=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Responses::WebSearchTool::UserLocation)) }
        def user_location
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Responses::WebSearchTool::UserLocation))
            .returns(T.nilable(OpenAI::Models::Responses::WebSearchTool::UserLocation))
        end
        def user_location=(_)
        end

        # This tool searches the web for relevant results to use in a response. Learn more
        #   about the
        #   [web search tool](https://platform.openai.com/docs/guides/tools-web-search).
        sig do
          params(
            type: Symbol,
            search_context_size: Symbol,
            user_location: T.nilable(OpenAI::Models::Responses::WebSearchTool::UserLocation)
          )
            .returns(T.attached_class)
        end
        def self.new(type:, search_context_size: nil, user_location: nil)
        end

        sig do
          override
            .returns(
              {
                type: Symbol,
                search_context_size: Symbol,
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
        class Type < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          WEB_SEARCH_PREVIEW = :web_search_preview
          WEB_SEARCH_PREVIEW_2025_03_11 = :web_search_preview_2025_03_11
        end

        # High level guidance for the amount of context window space to use for the
        #   search. One of `low`, `medium`, or `high`. `medium` is the default.
        class SearchContextSize < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          LOW = :low
          MEDIUM = :medium
          HIGH = :high
        end

        class UserLocation < OpenAI::BaseModel
          # The type of location approximation. Always `approximate`.
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          # Free text input for the city of the user, e.g. `San Francisco`.
          sig { returns(T.nilable(String)) }
          def city
          end

          sig { params(_: String).returns(String) }
          def city=(_)
          end

          # The two-letter [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of
          #   the user, e.g. `US`.
          sig { returns(T.nilable(String)) }
          def country
          end

          sig { params(_: String).returns(String) }
          def country=(_)
          end

          # Free text input for the region of the user, e.g. `California`.
          sig { returns(T.nilable(String)) }
          def region
          end

          sig { params(_: String).returns(String) }
          def region=(_)
          end

          # The [IANA timezone](https://timeapi.io/documentation/iana-timezones) of the
          #   user, e.g. `America/Los_Angeles`.
          sig { returns(T.nilable(String)) }
          def timezone
          end

          sig { params(_: String).returns(String) }
          def timezone=(_)
          end

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
