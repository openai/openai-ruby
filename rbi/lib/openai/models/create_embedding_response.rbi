# typed: strong

module OpenAI
  module Models
    class CreateEmbeddingResponse < OpenAI::BaseModel
      # The list of embeddings generated by the model.
      sig { returns(T::Array[OpenAI::Models::Embedding]) }
      def data
      end

      sig { params(_: T::Array[OpenAI::Models::Embedding]).returns(T::Array[OpenAI::Models::Embedding]) }
      def data=(_)
      end

      # The name of the model used to generate the embedding.
      sig { returns(String) }
      def model
      end

      sig { params(_: String).returns(String) }
      def model=(_)
      end

      # The object type, which is always "list".
      sig { returns(Symbol) }
      def object
      end

      sig { params(_: Symbol).returns(Symbol) }
      def object=(_)
      end

      # The usage information for the request.
      sig { returns(OpenAI::Models::CreateEmbeddingResponse::Usage) }
      def usage
      end

      sig do
        params(_: T.any(OpenAI::Models::CreateEmbeddingResponse::Usage, OpenAI::Util::AnyHash))
          .returns(T.any(OpenAI::Models::CreateEmbeddingResponse::Usage, OpenAI::Util::AnyHash))
      end
      def usage=(_)
      end

      sig do
        params(
          data: T::Array[OpenAI::Models::Embedding],
          model: String,
          usage: OpenAI::Models::CreateEmbeddingResponse::Usage,
          object: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(data:, model:, usage:, object: :list)
      end

      sig do
        override
          .returns(
            {
              data: T::Array[OpenAI::Models::Embedding],
              model: String,
              object: Symbol,
              usage: OpenAI::Models::CreateEmbeddingResponse::Usage
            }
          )
      end
      def to_hash
      end

      class Usage < OpenAI::BaseModel
        # The number of tokens used by the prompt.
        sig { returns(Integer) }
        def prompt_tokens
        end

        sig { params(_: Integer).returns(Integer) }
        def prompt_tokens=(_)
        end

        # The total number of tokens used by the request.
        sig { returns(Integer) }
        def total_tokens
        end

        sig { params(_: Integer).returns(Integer) }
        def total_tokens=(_)
        end

        # The usage information for the request.
        sig { params(prompt_tokens: Integer, total_tokens: Integer).returns(T.attached_class) }
        def self.new(prompt_tokens:, total_tokens:)
        end

        sig { override.returns({prompt_tokens: Integer, total_tokens: Integer}) }
        def to_hash
        end
      end
    end
  end
end
