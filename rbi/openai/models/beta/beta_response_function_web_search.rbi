# typed: strong

module OpenAI
  module Models
    BetaResponseFunctionWebSearch = Beta::BetaResponseFunctionWebSearch

    module Beta
      class BetaResponseFunctionWebSearch < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseFunctionWebSearch,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the web search tool call.
        sig { returns(String) }
        attr_accessor :id

        # An object describing the specific action taken in this web search call. Includes
        # details on how the model used the web (search, open_page, find_in_page).
        sig do
          returns(
            T.any(
              OpenAI::Beta::BetaResponseFunctionWebSearch::Action::Search,
              OpenAI::Beta::BetaResponseFunctionWebSearch::Action::OpenPage,
              OpenAI::Beta::BetaResponseFunctionWebSearch::Action::FindInPage
            )
          )
        end
        attr_accessor :action

        # The status of the web search tool call.
        sig do
          returns(OpenAI::Beta::BetaResponseFunctionWebSearch::Status::OrSymbol)
        end
        attr_accessor :status

        # The type of the web search tool call. Always `web_search_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that produced this item.
        sig do
          returns(T.nilable(OpenAI::Beta::BetaResponseFunctionWebSearch::Agent))
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseFunctionWebSearch::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # The results of a web search tool call. See the
        # [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for
        # more information.
        sig do
          params(
            id: String,
            action:
              T.any(
                OpenAI::Beta::BetaResponseFunctionWebSearch::Action::Search::OrHash,
                OpenAI::Beta::BetaResponseFunctionWebSearch::Action::OpenPage::OrHash,
                OpenAI::Beta::BetaResponseFunctionWebSearch::Action::FindInPage::OrHash
              ),
            status:
              OpenAI::Beta::BetaResponseFunctionWebSearch::Status::OrSymbol,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseFunctionWebSearch::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the web search tool call.
          id:,
          # An object describing the specific action taken in this web search call. Includes
          # details on how the model used the web (search, open_page, find_in_page).
          action:,
          # The status of the web search tool call.
          status:,
          # The agent that produced this item.
          agent: nil,
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
                  OpenAI::Beta::BetaResponseFunctionWebSearch::Action::Search,
                  OpenAI::Beta::BetaResponseFunctionWebSearch::Action::OpenPage,
                  OpenAI::Beta::BetaResponseFunctionWebSearch::Action::FindInPage
                ),
              status:
                OpenAI::Beta::BetaResponseFunctionWebSearch::Status::OrSymbol,
              type: Symbol,
              agent:
                T.nilable(OpenAI::Beta::BetaResponseFunctionWebSearch::Agent)
            }
          )
        end
        def to_hash
        end

        # An object describing the specific action taken in this web search call. Includes
        # details on how the model used the web (search, open_page, find_in_page).
        module Action
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseFunctionWebSearch::Action::Search,
                OpenAI::Beta::BetaResponseFunctionWebSearch::Action::OpenPage,
                OpenAI::Beta::BetaResponseFunctionWebSearch::Action::FindInPage
              )
            end

          class Search < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseFunctionWebSearch::Action::Search,
                  OpenAI::Internal::AnyHash
                )
              end

            # The action type.
            sig { returns(Symbol) }
            attr_accessor :type

            # The search queries.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :queries

            sig { params(queries: T::Array[String]).void }
            attr_writer :queries

            # The search query.
            sig { returns(T.nilable(String)) }
            attr_reader :query

            sig { params(query: String).void }
            attr_writer :query

            # The sources used in the search.
            sig do
              returns(
                T.nilable(
                  T::Array[
                    OpenAI::Beta::BetaResponseFunctionWebSearch::Action::Search::Source
                  ]
                )
              )
            end
            attr_reader :sources

            sig do
              params(
                sources:
                  T::Array[
                    OpenAI::Beta::BetaResponseFunctionWebSearch::Action::Search::Source::OrHash
                  ]
              ).void
            end
            attr_writer :sources

            # Action type "search" - Performs a web search query.
            sig do
              params(
                queries: T::Array[String],
                query: String,
                sources:
                  T::Array[
                    OpenAI::Beta::BetaResponseFunctionWebSearch::Action::Search::Source::OrHash
                  ],
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The search queries.
              queries: nil,
              # The search query.
              query: nil,
              # The sources used in the search.
              sources: nil,
              # The action type.
              type: :search
            )
            end

            sig do
              override.returns(
                {
                  type: Symbol,
                  queries: T::Array[String],
                  query: String,
                  sources:
                    T::Array[
                      OpenAI::Beta::BetaResponseFunctionWebSearch::Action::Search::Source
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
                    OpenAI::Beta::BetaResponseFunctionWebSearch::Action::Search::Source,
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
                  OpenAI::Beta::BetaResponseFunctionWebSearch::Action::OpenPage,
                  OpenAI::Internal::AnyHash
                )
              end

            # The action type.
            sig { returns(Symbol) }
            attr_accessor :type

            # The URL opened by the model.
            sig { returns(T.nilable(String)) }
            attr_accessor :url

            # Action type "open_page" - Opens a specific URL from search results.
            sig do
              params(url: T.nilable(String), type: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # The URL opened by the model.
              url: nil,
              # The action type.
              type: :open_page
            )
            end

            sig { override.returns({ type: Symbol, url: T.nilable(String) }) }
            def to_hash
            end
          end

          class FindInPage < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseFunctionWebSearch::Action::FindInPage,
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

            # Action type "find_in_page": Searches for a pattern within a loaded page.
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
              type: :find_in_page
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
                OpenAI::Beta::BetaResponseFunctionWebSearch::Action::Variants
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
              T.all(Symbol, OpenAI::Beta::BetaResponseFunctionWebSearch::Status)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Beta::BetaResponseFunctionWebSearch::Status::TaggedSymbol
            )
          SEARCHING =
            T.let(
              :searching,
              OpenAI::Beta::BetaResponseFunctionWebSearch::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Beta::BetaResponseFunctionWebSearch::Status::TaggedSymbol
            )
          FAILED =
            T.let(
              :failed,
              OpenAI::Beta::BetaResponseFunctionWebSearch::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaResponseFunctionWebSearch::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseFunctionWebSearch::Agent,
                OpenAI::Internal::AnyHash
              )
            end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that produced this item.
          sig { params(agent_name: String).returns(T.attached_class) }
          def self.new(
            # The canonical name of the agent that produced this item.
            agent_name:
          )
          end

          sig { override.returns({ agent_name: String }) }
          def to_hash
          end
        end
      end
    end
  end
end
