# typed: strong

module OpenAI
  module Models
    class ModerationTextInput < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::ModerationTextInput, OpenAI::Internal::AnyHash)
        end

      # A string of text to classify.
      sig { returns(String) }
      attr_accessor :text

      # Always `text`.
      sig { returns(Symbol) }
      attr_accessor :type

      # An object describing text to classify.
      sig { params(text: String, type: Symbol).returns(T.attached_class) }
      def self.new(
        # A string of text to classify.
        text:,
        # Always `text`.
        type: :text
      )
      end

      sig { override.returns({ text: String, type: Symbol }) }
      def to_hash
      end
    end
  end
end
