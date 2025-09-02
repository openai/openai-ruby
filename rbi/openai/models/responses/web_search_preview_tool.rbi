# typed: strong

module OpenAI
  module Models
    module Responses
      class WebSearchPreviewTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::WebSearchPreviewTool,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of the web search tool. One of `web_search_preview` or
        # `web_search_preview_2025_03_11`.
        sig { returns(OpenAI::Responses::WebSearchPreviewTool::Type::OrSymbol) }
        attr_accessor :type

        # High level guidance for the amount of context window space to use for the
        # search. One of `low`, `medium`, or `high`. `medium` is the default.
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::WebSearchPreviewTool::SearchContextSize::OrSymbol
            )
          )
        end
        attr_reader :search_context_size

        sig do
          params(
            search_context_size:
              OpenAI::Responses::WebSearchPreviewTool::SearchContextSize::OrSymbol
          ).void
        end
        attr_writer :search_context_size

        # The user's location.
        sig do
          returns(
            T.nilable(OpenAI::Responses::WebSearchPreviewTool::UserLocation)
          )
        end
        attr_reader :user_location

        sig do
          params(
            user_location:
              T.nilable(
                OpenAI::Responses::WebSearchPreviewTool::UserLocation::OrHash
              )
          ).void
        end
        attr_writer :user_location

        # This tool searches the web for relevant results to use in a response. Learn more
        # about the
        # [web search tool](https://platform.openai.com/docs/guides/tools-web-search).
        sig do
          params(
            type: OpenAI::Responses::WebSearchPreviewTool::Type::OrSymbol,
            search_context_size:
              OpenAI::Responses::WebSearchPreviewTool::SearchContextSize::OrSymbol,
            user_location:
              T.nilable(
                OpenAI::Responses::WebSearchPreviewTool::UserLocation::OrHash
              )
          ).returns(T.attached_class)
        end
        def self.new(
          # The type of the web search tool. One of `web_search_preview` or
          # `web_search_preview_2025_03_11`.
          type:,
          # High level guidance for the amount of context window space to use for the
          # search. One of `low`, `medium`, or `high`. `medium` is the default.
          search_context_size: nil,
          # The user's location.
          user_location: nil
        )
        end

        sig do
          override.returns(
            {
              type: OpenAI::Responses::WebSearchPreviewTool::Type::OrSymbol,
              search_context_size:
                OpenAI::Responses::WebSearchPreviewTool::SearchContextSize::OrSymbol,
              user_location:
                T.nilable(OpenAI::Responses::WebSearchPreviewTool::UserLocation)
            }
          )
        end
        def to_hash
        end

        # The type of the web search tool. One of `web_search_preview` or
        # `web_search_preview_2025_03_11`.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::WebSearchPreviewTool::Type)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          WEB_SEARCH_PREVIEW =
            T.let(
              :web_search_preview,
              OpenAI::Responses::WebSearchPreviewTool::Type::TaggedSymbol
            )
          WEB_SEARCH_PREVIEW_2025_03_11 =
            T.let(
              :web_search_preview_2025_03_11,
              OpenAI::Responses::WebSearchPreviewTool::Type::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::WebSearchPreviewTool::Type::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # High level guidance for the amount of context window space to use for the
        # search. One of `low`, `medium`, or `high`. `medium` is the default.
        module SearchContextSize
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Responses::WebSearchPreviewTool::SearchContextSize
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LOW =
            T.let(
              :low,
              OpenAI::Responses::WebSearchPreviewTool::SearchContextSize::TaggedSymbol
            )
          MEDIUM =
            T.let(
              :medium,
              OpenAI::Responses::WebSearchPreviewTool::SearchContextSize::TaggedSymbol
            )
          HIGH =
            T.let(
              :high,
              OpenAI::Responses::WebSearchPreviewTool::SearchContextSize::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::WebSearchPreviewTool::SearchContextSize::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        class UserLocation < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::WebSearchPreviewTool::UserLocation,
                OpenAI::Internal::AnyHash
              )
            end

          # The type of location approximation. Always `approximate`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Free text input for the city of the user, e.g. `San Francisco`.
          sig { returns(T.nilable(String)) }
          attr_accessor :city

          # The two-letter [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of
          # the user, e.g. `US`.
          sig { returns(T.nilable(String)) }
          attr_accessor :country

          # Free text input for the region of the user, e.g. `California`.
          sig { returns(T.nilable(String)) }
          attr_accessor :region

          # The [IANA timezone](https://timeapi.io/documentation/iana-timezones) of the
          # user, e.g. `America/Los_Angeles`.
          sig { returns(T.nilable(String)) }
          attr_accessor :timezone

          # The user's location.
          sig do
            params(
              city: T.nilable(String),
              country: T.nilable(String),
              region: T.nilable(String),
              timezone: T.nilable(String),
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Free text input for the city of the user, e.g. `San Francisco`.
            city: nil,
            # The two-letter [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of
            # the user, e.g. `US`.
            country: nil,
            # Free text input for the region of the user, e.g. `California`.
            region: nil,
            # The [IANA timezone](https://timeapi.io/documentation/iana-timezones) of the
            # user, e.g. `America/Los_Angeles`.
            timezone: nil,
            # The type of location approximation. Always `approximate`.
            type: :approximate
          )
          end

          sig do
            override.returns(
              {
                type: Symbol,
                city: T.nilable(String),
                country: T.nilable(String),
                region: T.nilable(String),
                timezone: T.nilable(String)
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
