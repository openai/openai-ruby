# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class CodeInterpreterTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of tool being defined: `code_interpreter`
        #
        #   @return [Symbol, :code_interpreter]
        required :type, const: :code_interpreter

        # @!method initialize(type: :code_interpreter)
        #   @param type [Symbol, :code_interpreter]
      end
    end
  end
end
