# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFunctionWebSearch < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseFunctionWebSearch,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the web search tool call.
        sig { returns(String) }
        attr_accessor :id

        # An object describing the specific action taken in this web search call. Includes
        # details on how the model used the web (search, open_page, find).
        sig do
          returns(
            T.any(
              OpenAI::Responses::ResponseFunctionWebSearch::Action::Search,
              OpenAI::Responses::ResponseFunctionWebSearch::Action::OpenPage,
              OpenAI::Responses::ResponseFunctionWebSearch::Action::Find
            )
          )
        end
        attr_accessor :action

        # The status of the web search tool call.
        sig do
          returns(
            OpenAI::Responses::ResponseFunctionWebSearch::Status::OrSymbol
          )
        end
        attr_accessor :status

        # The type of the web search tool call. Always `web_search_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The results of a web search tool call. See the
        # [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for
        # more information.
        sig do
          params(
            id: String,
            action:
              T.any(
                OpenAI::Responses::ResponseFunctionWebSearch::Action::Search::OrHash,
                OpenAI::Responses::ResponseFunctionWebSearch::Action::OpenPage::OrHash,
                OpenAI::Responses::ResponseFunctionWebSearch::Action::Find::OrHash
              ),
            status:
              OpenAI::Responses::ResponseFunctionWebSearch::Status::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the web search tool call.
          id:,
          # An object describing the specific action taken in this web search call. Includes
          # details on how the model used the web (search, open_page, find).
          action:,
          # The status of the web search tool call.
          status:,
          # The type of the web search tool call. Always `web_search_call`.
          type: :web_search_call
        )
        end

        sig do
          override.returns(
            {
              id: String,
              action:
                T.any(
                  OpenAI::Responses::ResponseFunctionWebSearch::Action::Search,
                  OpenAI::Responses::ResponseFunctionWebSearch::Action::OpenPage,
                  OpenAI::Responses::ResponseFunctionWebSearch::Action::Find
                ),
              status:
                OpenAI::Responses::ResponseFunctionWebSearch::Status::OrSymbol,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # An object describing the specific action taken in this web search call. Includes
        # details on how the model used the web (search, open_page, find).
        module Action
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseFunctionWebSearch::Action::Search,
                OpenAI::Responses::ResponseFunctionWebSearch::Action::OpenPage,
                OpenAI::Responses::ResponseFunctionWebSearch::Action::Find
              )
            end

          class Search < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseFunctionWebSearch::Action::Search,
                  OpenAI::Internal::AnyHash
                )
              end

            # The search query.
            sig { returns(String) }
            attr_accessor :query

            # The action type.
            sig { returns(Symbol) }
            attr_accessor :type

            # The sources used in the search.
            sig do
              returns(
                T.nilable(
                  T::Array[
                    OpenAI::Responses::ResponseFunctionWebSearch::Action::Search::Source
                  ]
                )
              )
            end
            attr_reader :sources

            sig do
              params(
                sources:
                  T::Array[
                    OpenAI::Responses::ResponseFunctionWebSearch::Action::Search::Source::OrHash
                  ]
              ).void
            end
            attr_writer :sources

            # Action type "search" - Performs a web search query.
            sig do
              params(
                query: String,
                sources:
                  T::Array[
                    OpenAI::Responses::ResponseFunctionWebSearch::Action::Search::Source::OrHash
                  ],
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The search query.
              query:,
              # The sources used in the search.
              sources: nil,
              # The action type.
              type: :search
            )
            end

            sig do
              override.returns(
                {
                  query: String,
                  type: Symbol,
                  sources:
                    T::Array[
                      OpenAI::Responses::ResponseFunctionWebSearch::Action::Search::Source
                    ]
                }
              )
            end
            def to_hash
            end

            class Source < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Responses::ResponseFunctionWebSearch::Action::Search::Source,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The type of source. Always `url`.
              sig { returns(Symbol) }
              attr_accessor :type

              # The URL of the source.
              sig { returns(String) }
              attr_accessor :url

              # A source used in the search.
              sig do
                params(url: String, type: Symbol).returns(T.attached_class)
              end
              def self.new(
                # The URL of the source.
                url:,
                # The type of source. Always `url`.
                type: :url
              )
              end

              sig { override.returns({ type: Symbol, url: String }) }
              def to_hash
              end
            end
          end

          class OpenPage < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseFunctionWebSearch::Action::OpenPage,
                  OpenAI::Internal::AnyHash
                )
              end

            # The action type.
            sig { returns(Symbol) }
            attr_accessor :type

            # The URL opened by the model.
            sig { returns(String) }
            attr_accessor :url

            # Action type "open_page" - Opens a specific URL from search results.
            sig { params(url: String, type: Symbol).returns(T.attached_class) }
            def self.new(
              # The URL opened by the model.
              url:,
              # The action type.
              type: :open_page
            )
            end

            sig { override.returns({ type: Symbol, url: String }) }
            def to_hash
            end
          end

          class Find < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseFunctionWebSearch::Action::Find,
                  OpenAI::Internal::AnyHash
                )
              end

            # The pattern or text to search for within the page.
            sig { returns(String) }
            attr_accessor :pattern

            # The action type.
            sig { returns(Symbol) }
            attr_accessor :type

            # The URL of the page searched for the pattern.
            sig { returns(String) }
            attr_accessor :url

            # Action type "find": Searches for a pattern within a loaded page.
            sig do
              params(pattern: String, url: String, type: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # The pattern or text to search for within the page.
              pattern:,
              # The URL of the page searched for the pattern.
              url:,
              # The action type.
              type: :find
            )
            end

            sig do
              override.returns({ pattern: String, type: Symbol, url: String })
            end
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseFunctionWebSearch::Action::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # The status of the web search tool call.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Responses::ResponseFunctionWebSearch::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol
            )
          SEARCHING =
            T.let(
              :searching,
              OpenAI::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol
            )
          FAILED =
            T.let(
              :failed,
              OpenAI::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol
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
