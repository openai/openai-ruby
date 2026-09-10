# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class FunctionTool < OpenAI::Internal::Type::BaseModel
        # @!attribute name
        #   The name the delegated Responses model uses when calling this function.
        #
        #   @return [String]
        required :name, String

        # @!attribute type
        #   The tool type. Always `function`.
        #
        #   @return [Symbol, :function]
        required :type, const: :function

        # @!attribute description
        #   What the function does and when the delegated Responses model should call it.
        #
        #   @return [String, nil]
        optional :description, String, nil?: true

        # @!attribute parameters
        #   A JSON Schema object describing the arguments accepted by the function.
        #
        #   @return [Hash{Symbol=>Object}, nil]
        optional :parameters, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown], nil?: true

        # @!attribute strict
        #   Whether the delegated Responses model must follow the function’s parameter
        #   schema exactly.
        #
        #   @return [Boolean, nil]
        optional :strict, OpenAI::Internal::Type::Boolean, nil?: true

        # @!method initialize(name:, description: nil, parameters: nil, strict: nil, type: :function)
        #   A function tool available to the Responses backend when the Live model delegates
        #   a task.
        #
        #   @param name [String]
        #     The name the delegated Responses model uses when calling this function.
        #
        #   @param description [String, nil]
        #     What the function does and when the delegated Responses model should call it.
        #
        #   @param parameters [Hash{Symbol=>Object}, nil]
        #     A JSON Schema object describing the arguments accepted by the function.
        #
        #   @param strict [Boolean, nil]
        #     Whether the delegated Responses model must follow the function’s parameter
        #     schema exactly.
        #
        #   @param type [Symbol, :function]
        #     The tool type. Always `function`.
      end
    end
  end
end
