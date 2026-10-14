# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class FunctionTool < OpenAI::Internal::Type::BaseModel
        # @!attribute function
        #
        #   @return [OpenAI::Models::FunctionDefinition]
        required :function, -> { OpenAI::FunctionDefinition }

        # @!attribute type
        #   The type of tool being defined: `function`
        #
        #   @return [Symbol, :function]
        required :type, const: :function

        # @!method initialize(function:, type: :function)
        #   @param function [OpenAI::Models::FunctionDefinition]
        #
        #   @param type [Symbol, :function] The type of tool being defined: `function`
      end
    end
  end
end
