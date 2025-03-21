# typed: strong

module OpenAI
  module Models
    class ResponseFormatText < OpenAI::BaseModel
      # The type of response format being defined. Always `text`.
      sig { returns(Symbol) }
      attr_accessor :type

      # Default response format. Used to generate text responses.
      sig { params(type: Symbol).returns(T.attached_class) }
      def self.new(type: :text)
      end

      sig { override.returns({type: Symbol}) }
      def to_hash
      end
    end
  end
end
