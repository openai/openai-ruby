# typed: strong

module OpenAI
  module Models
    class ModerationCreateResponse < OpenAI::BaseModel
      # The unique identifier for the moderation request.
      sig { returns(String) }
      def id
      end

      sig { params(_: String).returns(String) }
      def id=(_)
      end

      # The model used to generate the moderation results.
      sig { returns(String) }
      def model
      end

      sig { params(_: String).returns(String) }
      def model=(_)
      end

      # A list of moderation objects.
      sig { returns(T::Array[OpenAI::Models::Moderation]) }
      def results
      end

      sig { params(_: T::Array[OpenAI::Models::Moderation]).returns(T::Array[OpenAI::Models::Moderation]) }
      def results=(_)
      end

      # Represents if a given text input is potentially harmful.
      sig do
        params(
          id: String,
          model: String,
          results: T::Array[T.any(OpenAI::Models::Moderation, OpenAI::Util::AnyHash)]
        )
          .returns(T.attached_class)
      end
      def self.new(id:, model:, results:)
      end

      sig { override.returns({id: String, model: String, results: T::Array[OpenAI::Models::Moderation]}) }
      def to_hash
      end
    end
  end
end
