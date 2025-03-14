# typed: strong

module OpenAI
  module Models
    class ModerationTextInput < OpenAI::BaseModel
      # A string of text to classify.
      sig { returns(String) }
      def text
      end

      sig { params(_: String).returns(String) }
      def text=(_)
      end

      # Always `text`.
      sig { returns(Symbol) }
      def type
      end

      sig { params(_: Symbol).returns(Symbol) }
      def type=(_)
      end

      # An object describing text to classify.
      sig { params(text: String, type: Symbol).returns(T.attached_class) }
      def self.new(text:, type: :text)
      end

      sig { override.returns({text: String, type: Symbol}) }
      def to_hash
      end
    end
  end
end
