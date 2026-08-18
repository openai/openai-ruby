# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaToolChoiceApplyPatch < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The tool to call. Always `apply_patch`.
        #
        #   @return [Symbol, :apply_patch]
        required :type, const: :apply_patch

        # @!method initialize(type: :apply_patch)
        #   Forces the model to call the apply_patch tool when executing a tool call.
        #
        #   @param type [Symbol, :apply_patch] The tool to call. Always `apply_patch`.
      end
    end

    BetaToolChoiceApplyPatch = Beta::BetaToolChoiceApplyPatch
  end
end
