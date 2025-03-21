# typed: strong

module OpenAI
  module Models
    class Completion < OpenAI::BaseModel
      # A unique identifier for the completion.
      sig { returns(String) }
      def id
      end

      sig { params(_: String).returns(String) }
      def id=(_)
      end

      # The list of completion choices the model generated for the input prompt.
      sig { returns(T::Array[OpenAI::Models::CompletionChoice]) }
      def choices
      end

      sig { params(_: T::Array[OpenAI::Models::CompletionChoice]).returns(T::Array[OpenAI::Models::CompletionChoice]) }
      def choices=(_)
      end

      # The Unix timestamp (in seconds) of when the completion was created.
      sig { returns(Integer) }
      def created
      end

      sig { params(_: Integer).returns(Integer) }
      def created=(_)
      end

      # The model used for completion.
      sig { returns(String) }
      def model
      end

      sig { params(_: String).returns(String) }
      def model=(_)
      end

      # The object type, which is always "text_completion"
      sig { returns(Symbol) }
      def object
      end

      sig { params(_: Symbol).returns(Symbol) }
      def object=(_)
      end

      # This fingerprint represents the backend configuration that the model runs with.
      #
      #   Can be used in conjunction with the `seed` request parameter to understand when
      #   backend changes have been made that might impact determinism.
      sig { returns(T.nilable(String)) }
      def system_fingerprint
      end

      sig { params(_: String).returns(String) }
      def system_fingerprint=(_)
      end

      # Usage statistics for the completion request.
      sig { returns(T.nilable(OpenAI::Models::CompletionUsage)) }
      def usage
      end

      sig do
        params(_: T.any(OpenAI::Models::CompletionUsage, OpenAI::Util::AnyHash))
          .returns(T.any(OpenAI::Models::CompletionUsage, OpenAI::Util::AnyHash))
      end
      def usage=(_)
      end

      # Represents a completion response from the API. Note: both the streamed and
      #   non-streamed response objects share the same shape (unlike the chat endpoint).
      sig do
        params(
          id: String,
          choices: T::Array[T.any(OpenAI::Models::CompletionChoice, OpenAI::Util::AnyHash)],
          created: Integer,
          model: String,
          system_fingerprint: String,
          usage: T.any(OpenAI::Models::CompletionUsage, OpenAI::Util::AnyHash),
          object: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(id:, choices:, created:, model:, system_fingerprint: nil, usage: nil, object: :text_completion)
      end

      sig do
        override
          .returns(
            {
              id: String,
              choices: T::Array[OpenAI::Models::CompletionChoice],
              created: Integer,
              model: String,
              object: Symbol,
              system_fingerprint: String,
              usage: OpenAI::Models::CompletionUsage
            }
          )
      end
      def to_hash
      end
    end
  end
end
