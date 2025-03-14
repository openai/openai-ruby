# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ToolChoiceFunction < OpenAI::BaseModel
        # @!attribute name
        #   The name of the function to call.
        #
        #   @return [String]
        required :name, String

        # @!attribute type
        #   For function calling, the type is always `function`.
        #
        #   @return [Symbol, :function]
        required :type, const: :function

        # @!parse
        #   # Use this option to force the model to call a specific function.
        #   #
        #   # @param name [String]
        #   # @param type [Symbol, :function]
        #   #
        #   def initialize(name:, type: :function, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
