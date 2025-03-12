# typed: strong

module OpenAI
  module Models
    class Completion < OpenAI::BaseModel
      sig { returns(String) }
      def id
      end

      sig { params(_: String).returns(String) }
      def id=(_)
      end

      sig { returns(T::Array[OpenAI::Models::CompletionChoice]) }
      def choices
      end

      sig { params(_: T::Array[OpenAI::Models::CompletionChoice]).returns(T::Array[OpenAI::Models::CompletionChoice]) }
      def choices=(_)
      end

      sig { returns(Integer) }
      def created
      end

      sig { params(_: Integer).returns(Integer) }
      def created=(_)
      end

      sig { returns(String) }
      def model
      end

      sig { params(_: String).returns(String) }
      def model=(_)
      end

      sig { returns(Symbol) }
      def object
      end

      sig { params(_: Symbol).returns(Symbol) }
      def object=(_)
      end

      sig { returns(T.nilable(String)) }
      def system_fingerprint
      end

      sig { params(_: String).returns(String) }
      def system_fingerprint=(_)
      end

      sig { returns(T.nilable(OpenAI::Models::CompletionUsage)) }
      def usage
      end

      sig { params(_: OpenAI::Models::CompletionUsage).returns(OpenAI::Models::CompletionUsage) }
      def usage=(_)
      end

      sig do
        params(
          id: String,
          choices: T::Array[OpenAI::Models::CompletionChoice],
          created: Integer,
          model: String,
          system_fingerprint: String,
          usage: OpenAI::Models::CompletionUsage,
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
