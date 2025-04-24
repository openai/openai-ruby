# typed: strong

module OpenAI
  module Models
    class ModerationCreateResponse < OpenAI::Internal::Type::BaseModel
      # The unique identifier for the moderation request.
      sig { returns(String) }
      attr_accessor :id

      # The model used to generate the moderation results.
      sig { returns(String) }
      attr_accessor :model

      # A list of moderation objects.
      sig { returns(T::Array[OpenAI::Models::Moderation]) }
      attr_accessor :results

      # Represents if a given text input is potentially harmful.
      sig do
        params(
          id: String,
          model: String,
          results: T::Array[T.any(OpenAI::Models::Moderation, OpenAI::Internal::AnyHash)]
        )
          .returns(T.attached_class)
      end
      def self.new(
        # The unique identifier for the moderation request.
        id:,
        # The model used to generate the moderation results.
        model:,
        # A list of moderation objects.
        results:
      ); end
      sig { override.returns({id: String, model: String, results: T::Array[OpenAI::Models::Moderation]}) }
      def to_hash; end
    end
  end
end
