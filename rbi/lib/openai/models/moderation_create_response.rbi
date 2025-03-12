# typed: strong

module OpenAI
  module Models
    class ModerationCreateResponse < OpenAI::BaseModel
      sig { returns(String) }
      def id
      end

      sig { params(_: String).returns(String) }
      def id=(_)
      end

      sig { returns(String) }
      def model
      end

      sig { params(_: String).returns(String) }
      def model=(_)
      end

      sig { returns(T::Array[OpenAI::Models::Moderation]) }
      def results
      end

      sig { params(_: T::Array[OpenAI::Models::Moderation]).returns(T::Array[OpenAI::Models::Moderation]) }
      def results=(_)
      end

      sig { params(id: String, model: String, results: T::Array[OpenAI::Models::Moderation]).returns(T.attached_class) }
      def self.new(id:, model:, results:)
      end

      sig { override.returns({id: String, model: String, results: T::Array[OpenAI::Models::Moderation]}) }
      def to_hash
      end
    end
  end
end
