# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaToolChoiceShell < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The tool to call. Always `shell`.
        #
        #   @return [Symbol, :shell]
        required :type, const: :shell

        # @!method initialize(type: :shell)
        #   Forces the model to call the shell tool when a tool call is required.
        #
        #   @param type [Symbol, :shell] The tool to call. Always `shell`.
      end
    end

    BetaToolChoiceShell = Beta::BetaToolChoiceShell
  end
end
