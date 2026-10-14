# typed: strong

module OpenAI
  module Models
    module Responses
      class WebSearchTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::WebSearchTool, OpenAI::Internal::AnyHash)
          end

        # The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
        sig { returns(OpenAI::Responses::WebSearchTool::Type::OrSymbol) }
        attr_accessor :type

        # Filters for the search.
        sig { returns(T.nilable(OpenAI::Responses::WebSearchTool::Filters)) }
        attr_reader :filters

        sig do
          params(
            filters:
              T.nilable(OpenAI::Responses::WebSearchTool::Filters::OrHash)
          ).void
        end
        attr_writer :filters

        # High level guidance for the amount of context window space to use for the
        # search. One of `low`, `medium`, or `high`. `medium` is the default.
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::WebSearchTool::SearchContextSize::OrSymbol
            )
          )
        end
        attr_reader :search_context_size

        sig do
          params(
            search_context_size:
              OpenAI::Responses::WebSearchTool::SearchContextSize::OrSymbol
          ).void
        end
        attr_writer :search_context_size

        # The approximate location of the user.
        sig do
          returns(T.nilable(OpenAI::Responses::WebSearchTool::UserLocation))
        end
        attr_reader :user_location

        sig do
          params(
            user_location:
              T.nilable(OpenAI::Responses::WebSearchTool::UserLocation::OrHash)
          ).void
        end
        attr_writer :user_location

        # Search the Internet for sources related to the prompt. Learn more about the
        # [web search tool](https://platform.openai.com/docs/guides/tools-web-search).
        sig do
          params(
            type: OpenAI::Responses::WebSearchTool::Type::OrSymbol,
            filters:
              T.nilable(OpenAI::Responses::WebSearchTool::Filters::OrHash),
            search_context_size:
              OpenAI::Responses::WebSearchTool::SearchContextSize::OrSymbol,
            user_location:
              T.nilable(OpenAI::Responses::WebSearchTool::UserLocation::OrHash)
          ).returns(T.attached_class)
        end
        def self.new(
          # The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
          type:,
          # Filters for the search.
          filters: nil,
          # High level guidance for the amount of context window space to use for the
          # search. One of `low`, `medium`, or `high`. `medium` is the default.
          search_context_size: nil,
          # The approximate location of the user.
          user_location: nil
        )
        end

        sig do
          override.returns(
            {
              type: OpenAI::Responses::WebSearchTool::Type::OrSymbol,
              filters: T.nilable(OpenAI::Responses::WebSearchTool::Filters),
              search_context_size:
                OpenAI::Responses::WebSearchTool::SearchContextSize::OrSymbol,
              user_location:
                T.nilable(OpenAI::Responses::WebSearchTool::UserLocation)
            }
          )
        end
        def to_hash
        end

        # The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::WebSearchTool::Type)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          WEB_SEARCH =
            T.let(
              :web_search,
              OpenAI::Responses::WebSearchTool::Type::TaggedSymbol
            )
          WEB_SEARCH_2025_08_26 =
            T.let(
              :web_search_2025_08_26,
              OpenAI::Responses::WebSearchTool::Type::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Responses::WebSearchTool::Type::TaggedSymbol]
            )
          end
          def self.values
          end
        end

        class Filters < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::WebSearchTool::Filters,
                OpenAI::Internal::AnyHash
              )
            end

          # Allowed domains for the search. If not provided, all domains are allowed.
          # Subdomains of the provided domains are allowed as well.
          #
          # Example: `["pubmed.ncbi.nlm.nih.gov"]`
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :allowed_domains

          # Filters for the search.
          sig do
            params(allowed_domains: T.nilable(T::Array[String])).returns(
              T.attached_class
            )
          end
          def self.new(
            # Allowed domains for the search. If not provided, all domains are allowed.
            # Subdomains of the provided domains are allowed as well.
            #
            # Example: `["pubmed.ncbi.nlm.nih.gov"]`
            allowed_domains: nil
          )
          end

          sig do
            override.returns({ allowed_domains: T.nilable(T::Array[String]) })
          end
          def to_hash
          end
        end

        # High level guidance for the amount of context window space to use for the
        # search. One of `low`, `medium`, or `high`. `medium` is the default.
        module SearchContextSize
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::WebSearchTool::SearchContextSize)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LOW =
            T.let(
              :low,
              OpenAI::Responses::WebSearchTool::SearchContextSize::TaggedSymbol
            )
          MEDIUM =
            T.let(
              :medium,
              OpenAI::Responses::WebSearchTool::SearchContextSize::TaggedSymbol
            )
          HIGH =
            T.let(
              :high,
              OpenAI::Responses::WebSearchTool::SearchContextSize::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::WebSearchTool::SearchContextSize::TaggedSymbol
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
                OpenAI::Responses::WebSearchTool::UserLocation,
                OpenAI::Internal::AnyHash
              )
            end

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

          # The type of location approximation. Always `approximate`.
          sig do
            returns(
              T.nilable(
                OpenAI::Responses::WebSearchTool::UserLocation::Type::OrSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Responses::WebSearchTool::UserLocation::Type::OrSymbol
            ).void
          end
          attr_writer :type

          # The approximate location of the user.
          sig do
            params(
              city: T.nilable(String),
              country: T.nilable(String),
              region: T.nilable(String),
              timezone: T.nilable(String),
              type:
                OpenAI::Responses::WebSearchTool::UserLocation::Type::OrSymbol
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
            type: nil
          )
          end

          sig do
            override.returns(
              {
                city: T.nilable(String),
                country: T.nilable(String),
                region: T.nilable(String),
                timezone: T.nilable(String),
                type:
                  OpenAI::Responses::WebSearchTool::UserLocation::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          # The type of location approximation. Always `approximate`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Responses::WebSearchTool::UserLocation::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            APPROXIMATE =
              T.let(
                :approximate,
                OpenAI::Responses::WebSearchTool::UserLocation::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::WebSearchTool::UserLocation::Type::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
