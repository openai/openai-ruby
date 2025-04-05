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
        #   @return [Hash{Symbol=>Object}]
        required :parameters, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

        # @!attribute strict
        #   Whether to enforce strict parameter validation. Default `true`.
        #
        #   @return [Boolean]
        required :strict, OpenAI::Internal::Type::Boolean

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

        # @!parse
        #   # Defines a function in your own code the model can choose to call. Learn more
        #   # about
        #   # [function calling](https://platform.openai.com/docs/guides/function-calling).
        #   #
        #   # @param name [String]
        #   # @param parameters [Hash{Symbol=>Object}]
        #   # @param strict [Boolean]
        #   # @param description [String, nil]
        #   # @param type [Symbol, :function]
        #   #
        #   def initialize(name:, parameters:, strict:, description: nil, type: :function, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
