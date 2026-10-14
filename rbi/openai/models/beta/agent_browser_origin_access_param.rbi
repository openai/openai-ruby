# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentBrowserOriginAccessParam < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentBrowserOriginAccessParam,
            OpenAI::Internal::AnyHash
          )
        end

        # Whether to allow, deny, or cancel the requested origin access.
        sig { returns(OpenAI::Beta::AgentBrowserOriginAccessParam::Decision::OrSymbol) }
        attr_accessor :decision

        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(

            decision: OpenAI::Beta::AgentBrowserOriginAccessParam::Decision::OrSymbol,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Whether to allow, deny, or cancel the requested origin access.
          decision:,

          type: :browser_origin_access
        )
        end

        sig do
          override.returns(
            {decision: OpenAI::Beta::AgentBrowserOriginAccessParam::Decision::OrSymbol, type: Symbol}
          )
        end
        def to_hash
        end

        # Whether to allow, deny, or cancel the requested origin access.
        module Decision
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentBrowserOriginAccessParam::Decision) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          # Allow the browser to access this origin.
          APPROVE = T.let(:approve, OpenAI::Beta::AgentBrowserOriginAccessParam::Decision::TaggedSymbol)

          # Deny access to this origin.
          DENY = T.let(:deny, OpenAI::Beta::AgentBrowserOriginAccessParam::Decision::TaggedSymbol)

          # Dismiss this request without approving access.
          CANCEL = T.let(:cancel, OpenAI::Beta::AgentBrowserOriginAccessParam::Decision::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::AgentBrowserOriginAccessParam::Decision::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
