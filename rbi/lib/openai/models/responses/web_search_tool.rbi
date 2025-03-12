# typed: strong

module OpenAI
  module Models
    module Responses
      class WebSearchTool < OpenAI::BaseModel
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

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

        class Type < OpenAI::Enum
          abstract!

          WEB_SEARCH_PREVIEW = :web_search_preview
          WEB_SEARCH_PREVIEW_2025_03_11 = :web_search_preview_2025_03_11

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class SearchContextSize < OpenAI::Enum
          abstract!

          LOW = :low
          MEDIUM = :medium
          HIGH = :high

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class UserLocation < OpenAI::BaseModel
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          sig { returns(T.nilable(String)) }
          def city
          end

          sig { params(_: String).returns(String) }
          def city=(_)
          end

          sig { returns(T.nilable(String)) }
          def country
          end

          sig { params(_: String).returns(String) }
          def country=(_)
          end

          sig { returns(T.nilable(String)) }
          def region
          end

          sig { params(_: String).returns(String) }
          def region=(_)
          end

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
