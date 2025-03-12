# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class FunctionTool < OpenAI::BaseModel
        # @!attribute function
        #
        #   @return [OpenAI::Models::FunctionDefinition]
        required :function, -> { OpenAI::Models::FunctionDefinition }

        # @!attribute type
        #   The type of tool being defined: `function`
        #
        #   @return [Symbol, :function]
        required :type, const: :function

        # @!parse
        #   # @param function [OpenAI::Models::FunctionDefinition]
        #   # @param type [Symbol, :function]
        #   #
        #   def initialize(function:, type: :function, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
