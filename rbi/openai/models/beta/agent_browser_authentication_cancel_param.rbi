# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentBrowserAuthenticationCancelParam < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentBrowserAuthenticationCancelParam,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(Symbol) }
        attr_accessor :action

        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(

            action: Symbol,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          action: :cancel,

          type: :browser_authentication
        )
        end

        sig do
          override.returns(
            {action: Symbol, type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
