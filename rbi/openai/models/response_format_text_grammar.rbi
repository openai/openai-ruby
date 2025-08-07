# typed: strong

module OpenAI
  module Models
    class ResponseFormatTextGrammar < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::ResponseFormatTextGrammar, OpenAI::Internal::AnyHash)
        end

      # The custom grammar for the model to follow.
      sig { returns(String) }
      attr_accessor :grammar

      # The type of response format being defined. Always `grammar`.
      sig { returns(Symbol) }
      attr_accessor :type

      # A custom grammar for the model to follow when generating text. Learn more in the
      # [custom grammars guide](https://platform.openai.com/docs/guides/custom-grammars).
      sig { params(grammar: String, type: Symbol).returns(T.attached_class) }
      def self.new(
        # The custom grammar for the model to follow.
        grammar:,
        # The type of response format being defined. Always `grammar`.
        type: :grammar
      )
      end

      sig { override.returns({ grammar: String, type: Symbol }) }
      def to_hash
      end
    end
  end
end
