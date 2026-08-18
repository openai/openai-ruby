# typed: strong

module OpenAI
  module Models
    class ResponseFormatTextPython < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::ResponseFormatTextPython, OpenAI::Internal::AnyHash)
        end

      # The type of response format being defined. Always `python`.
      sig { returns(Symbol) }
      attr_accessor :type

      # Configure the model to generate valid Python code. See the
      # [custom grammars guide](https://platform.openai.com/docs/guides/custom-grammars)
      # for more details.
      sig { params(type: Symbol).returns(T.attached_class) }
      def self.new(
        # The type of response format being defined. Always `python`.
        type: :python
      )
      end

      sig { override.returns({ type: Symbol }) }
      def to_hash
      end
    end
  end
end
