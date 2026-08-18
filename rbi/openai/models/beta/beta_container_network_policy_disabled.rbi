# typed: strong

module OpenAI
  module Models

    BetaContainerNetworkPolicyDisabled = Beta::BetaContainerNetworkPolicyDisabled

    module Beta

      class BetaContainerNetworkPolicyDisabled < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::BetaContainerNetworkPolicyDisabled,
            OpenAI::Internal::AnyHash
          )
        end

        # Disable outbound network access. Always `disabled`.
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Disable outbound network access. Always `disabled`.

          type: :disabled
        )
        end

        sig do
          override.returns(
            {type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
