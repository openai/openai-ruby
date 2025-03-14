# typed: strong

module OpenAI
  module Resources
    class Moderations
      # Classifies if text and/or image inputs are potentially harmful. Learn more in
      #   the [moderation guide](https://platform.openai.com/docs/guides/moderation).
      sig do
        params(
          input: T.any(
            String,
            T::Array[String],
            T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]
          ),
          model: T.any(String, Symbol),
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::ModerationCreateResponse)
      end
      def create(input:, model: nil, request_options: {})
      end

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
