# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ToolChoiceShell < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The tool to call. Always `shell`.
        #
        #   @return [Symbol, :shell]
        required :type, const: :shell

        # @!method initialize(type: :shell)
        #   Forces the model to call the function shell tool when a tool call is required.
        #
        #   @param type [Symbol, :shell] The tool to call. Always `shell`.
      end
    end
  end
end
