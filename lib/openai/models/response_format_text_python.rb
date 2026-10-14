# frozen_string_literal: true

module OpenAI
  module Models
    class ResponseFormatTextPython < OpenAI::Internal::Type::BaseModel
      # @!attribute type
      #   The type of response format being defined. Always `python`.
      #
      #   @return [Symbol, :python]
      required :type, const: :python

      # @!method initialize(type: :python)
      #   Configure the model to generate valid Python code. See the
      #   [custom grammars guide](https://platform.openai.com/docs/guides/custom-grammars)
      #   for more details.
      #
      #   @param type [Symbol, :python] The type of response format being defined. Always `python`.
    end
  end
end
