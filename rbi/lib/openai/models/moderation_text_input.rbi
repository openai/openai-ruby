# typed: strong

module OpenAI
  module Models
    class ModerationTextInput < OpenAI::Internal::Type::BaseModel
      # A string of text to classify.
      sig { returns(String) }
      attr_accessor :text

      # Always `text`.
      sig { returns(Symbol) }
      attr_accessor :type

      # An object describing text to classify.
      sig { params(text: String, type: Symbol).returns(T.attached_class) }
      def self.new(text:, type: :text); end

      sig { override.returns({text: String, type: Symbol}) }
      def to_hash; end
    end
  end
end
