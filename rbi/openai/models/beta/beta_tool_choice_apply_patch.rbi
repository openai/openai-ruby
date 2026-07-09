# typed: strong

module OpenAI
  module Models
    BetaToolChoiceApplyPatch = Beta::BetaToolChoiceApplyPatch

    module Beta
      class BetaToolChoiceApplyPatch < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaToolChoiceApplyPatch,
              OpenAI::Internal::AnyHash
            )
          end

        # The tool to call. Always `apply_patch`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Forces the model to call the apply_patch tool when executing a tool call.
        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(
          # The tool to call. Always `apply_patch`.
          type: :apply_patch
        )
        end

        sig { override.returns({ type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
