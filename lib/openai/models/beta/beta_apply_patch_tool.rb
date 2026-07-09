# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaApplyPatchTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the tool. Always `apply_patch`.
        #
        #   @return [Symbol, :apply_patch]
        required :type, const: :apply_patch

        # @!attribute allowed_callers
        #   The tool invocation context(s).
        #
        #   @return [Array<Symbol, OpenAI::Models::Beta::BetaApplyPatchTool::AllowedCaller>, nil]
        optional :allowed_callers,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::BetaApplyPatchTool::AllowedCaller]
                 },
                 nil?: true

        # @!method initialize(allowed_callers: nil, type: :apply_patch)
        #   Allows the assistant to create, delete, or update files using unified diffs.
        #
        #   @param allowed_callers [Array<Symbol, OpenAI::Models::Beta::BetaApplyPatchTool::AllowedCaller>, nil] The tool invocation context(s).
        #
        #   @param type [Symbol, :apply_patch] The type of the tool. Always `apply_patch`.

        module AllowedCaller
          extend OpenAI::Internal::Type::Enum

          DIRECT = :direct
          PROGRAMMATIC = :programmatic

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    BetaApplyPatchTool = Beta::BetaApplyPatchTool
  end
end
