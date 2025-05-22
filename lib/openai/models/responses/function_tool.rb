# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class FunctionTool < OpenAI::Internal::Type::BaseModel
        # @!attribute name
        #   The name of the function to call.
        #
        #   @return [String]
        required :name, String

        # @!attribute parameters
        #   A JSON schema object describing the parameters of the function.
        #
        #   @return [Hash{Symbol=>Object}, nil]
        required :parameters, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown], nil?: true

        # @!attribute strict
        #   Whether to enforce strict parameter validation. Default `true`.
        #
        #   @return [Boolean, nil]
        required :strict, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute type
        #   The type of the function tool. Always `function`.
        #
        #   @return [Symbol, :function]
        required :type, const: :function

        # @!attribute description
        #   A description of the function. Used by the model to determine whether or not to
        #   call the function.
        #
        #   @return [String, nil]
        optional :description, String, nil?: true

        # @!method initialize(name:, parameters:, strict:, description: nil, type: :function)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::FunctionTool} for more details.
        #
        #   Defines a function in your own code the model can choose to call. Learn more
        #   about
        #   [function calling](https://platform.openai.com/docs/guides/function-calling).
        #
        #   @param name [String] The name of the function to call.
        #
        #   @param parameters [Hash{Symbol=>Object}, nil] A JSON schema object describing the parameters of the function.
        #
        #   @param strict [Boolean, nil] Whether to enforce strict parameter validation. Default `true`.
        #
        #   @param description [String, nil] A description of the function. Used by the model to determine whether or not to
        #
        #   @param type [Symbol, :function] The type of the function tool. Always `function`.
      end
    end
  end
end
