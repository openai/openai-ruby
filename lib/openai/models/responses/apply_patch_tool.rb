# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ApplyPatchTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the tool. Always `apply_patch`.
        #
        #   @return [Symbol, :apply_patch]
        required :type, const: :apply_patch

        # @!method initialize(type: :apply_patch)
        #   Allows the assistant to create, delete, or update files using unified diffs.
        #
        #   @param type [Symbol, :apply_patch] The type of the tool. Always `apply_patch`.
      end
    end
  end
end
