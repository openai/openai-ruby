# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentWebSearchCallItem < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentWebSearchCallItem,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the web search call.
        sig { returns(String) }
        attr_accessor :id

        # An action performed by the web search tool.
        sig { returns(T.nilable(OpenAI::Beta::WebSearchAction::Variants)) }
        attr_accessor :action

        # The status of the web search call.
        sig { returns(OpenAI::Beta::AgentOutputItemStatus::TaggedSymbol) }
        attr_accessor :status

        # The ID of the turn that contains this item.
        sig { returns(String) }
        attr_accessor :turn_id

        # The item type. Always `web_search_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A web search call produced by the agent.
        sig do
          params(

            id: String,

            action: T.nilable(
              T.any(
                OpenAI::Beta::WebSearchAction::Search::OrHash,
                OpenAI::Beta::WebSearchAction::OpenPage::OrHash,
                OpenAI::Beta::WebSearchAction::FindInPage::OrHash,
                OpenAI::Beta::WebSearchAction::Other::OrHash
              )
            ),

            status: OpenAI::Beta::AgentOutputItemStatus::OrSymbol,

            turn_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the web search call.
          id:,

          # An action performed by the web search tool.
          action:,

          # The status of the web search call.
          status:,

          # The ID of the turn that contains this item.
          turn_id:,

          # The item type. Always `web_search_call`.

          type: :web_search_call
        )
        end

        sig do
          override.returns(
            {
              id: String,
              action: T.nilable(OpenAI::Beta::WebSearchAction::Variants),
              status: OpenAI::Beta::AgentOutputItemStatus::TaggedSymbol,
              turn_id: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
