# frozen_string_literal: true

module OpenAI
  module Models
    class FunctionDefinition < OpenAI::Internal::Type::BaseModel
      # @!attribute name
      #   The name of the function to be called. Must be a-z, A-Z, 0-9, or contain
      #   underscores and dashes, with a maximum length of 64.
      #
      #   @return [String]
      required :name, String

      # @!attribute description
      #   A description of what the function does, used by the model to choose when and
      #   how to call the function.
      #
      #   @return [String, nil]
      optional :description, String

      # @!attribute parameters
      #   The parameters the functions accepts, described as a JSON Schema object. See the
      #   [guide](https://platform.openai.com/docs/guides/function-calling) for examples,
      #   and the
      #   [JSON Schema reference](https://json-schema.org/understanding-json-schema/) for
      #   documentation about the format.
      #
      #   Omitting `parameters` defines a function with an empty parameter list.
      #
      #   @return [Hash{Symbol=>Object}, nil]
      optional :parameters, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

      # @!attribute strict
      #   Whether to enable strict schema adherence when generating the function call. If
      #   set to true, the model will follow the exact schema defined in the `parameters`
      #   field. Only a subset of JSON Schema is supported when `strict` is `true`. Learn
      #   more about Structured Outputs in the
      #   [function calling guide](docs/guides/function-calling).
      #
      #   @return [Boolean, nil]
      optional :strict, OpenAI::Internal::Type::Boolean, nil?: true

      # @!method initialize(name:, description: nil, parameters: nil, strict: nil)
      #   @param name [String]
      #   @param description [String]
      #   @param parameters [Hash{Symbol=>Object}]
      #   @param strict [Boolean, nil]
    end
  end
end
