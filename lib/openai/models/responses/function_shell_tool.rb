# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class FunctionShellTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the shell tool. Always `shell`.
        #
        #   @return [Symbol, :shell]
        required :type, const: :shell

        # @!method initialize(type: :shell)
        #   A tool that allows the model to execute shell commands.
        #
        #   @param type [Symbol, :shell] The type of the shell tool. Always `shell`.
      end
    end
  end
end
