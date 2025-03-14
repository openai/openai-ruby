# typed: strong

module OpenAI
  module Models
    class ResponseFormatText < OpenAI::BaseModel
      # The type of response format being defined: `text`
      sig { returns(Symbol) }
      def type
      end

      sig { params(_: Symbol).returns(Symbol) }
      def type=(_)
      end

      sig { params(type: Symbol).returns(T.attached_class) }
      def self.new(type: :text)
      end

      sig { override.returns({type: Symbol}) }
      def to_hash
      end
    end
  end
end
