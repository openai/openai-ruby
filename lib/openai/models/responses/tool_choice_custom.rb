# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ToolChoiceCustom < OpenAI::Internal::Type::BaseModel
        # @!attribute name
        #   The name of the custom tool to call.
        #
        #   @return [String]
        required :name, String

        # @!attribute type
        #   For custom tool calling, the type is always `custom`.
        #
        #   @return [Symbol, :custom]
        required :type, const: :custom

        # @!method initialize(name:, type: :custom)
        #   Use this option to force the model to call a specific custom tool.
        #
        #   @param name [String] The name of the custom tool to call.
        #
        #   @param type [Symbol, :custom] For custom tool calling, the type is always `custom`.
      end
    end
  end
end
