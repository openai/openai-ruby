# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class CodeInterpreterTool < OpenAI::BaseModel
        # @!attribute type
        #   The type of tool being defined: `code_interpreter`
        #
        #   @return [Symbol, :code_interpreter]
        required :type, const: :code_interpreter

        # @!parse
        #   # @param type [Symbol, :code_interpreter]
        #   #
        #   def initialize(type: :code_interpreter, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
