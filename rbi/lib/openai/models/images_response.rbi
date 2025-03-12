# typed: strong

module OpenAI
  module Models
    class ImagesResponse < OpenAI::BaseModel
      sig { returns(Integer) }
      def created
      end

      sig { params(_: Integer).returns(Integer) }
      def created=(_)
      end

      sig { returns(T::Array[OpenAI::Models::Image]) }
      def data
      end

      sig { params(_: T::Array[OpenAI::Models::Image]).returns(T::Array[OpenAI::Models::Image]) }
      def data=(_)
      end

      sig { params(created: Integer, data: T::Array[OpenAI::Models::Image]).returns(T.attached_class) }
      def self.new(created:, data:)
      end

      sig { override.returns({created: Integer, data: T::Array[OpenAI::Models::Image]}) }
      def to_hash
      end
    end
  end
end
