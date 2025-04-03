# typed: strong

module OpenAI
  module Models
    class ImagesResponse < OpenAI::Internal::Type::BaseModel
      sig { returns(Integer) }
      attr_accessor :created

      sig { returns(T::Array[OpenAI::Models::Image]) }
      attr_accessor :data

      sig do
        params(created: Integer, data: T::Array[T.any(OpenAI::Models::Image, OpenAI::Internal::AnyHash)])
          .returns(T.attached_class)
      end
      def self.new(created:, data:)
      end

      sig { override.returns({created: Integer, data: T::Array[OpenAI::Models::Image]}) }
      def to_hash
      end
    end
  end
end
