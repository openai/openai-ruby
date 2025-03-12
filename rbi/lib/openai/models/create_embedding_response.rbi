# typed: strong

module OpenAI
  module Models
    class CreateEmbeddingResponse < OpenAI::BaseModel
      sig { returns(T::Array[OpenAI::Models::Embedding]) }
      def data
      end

      sig { params(_: T::Array[OpenAI::Models::Embedding]).returns(T::Array[OpenAI::Models::Embedding]) }
      def data=(_)
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

      sig { returns(OpenAI::Models::CreateEmbeddingResponse::Usage) }
      def usage
      end

      sig do
        params(_: OpenAI::Models::CreateEmbeddingResponse::Usage)
          .returns(OpenAI::Models::CreateEmbeddingResponse::Usage)
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
        sig { returns(Integer) }
        def prompt_tokens
        end

        sig { params(_: Integer).returns(Integer) }
        def prompt_tokens=(_)
        end

        sig { returns(Integer) }
        def total_tokens
        end

        sig { params(_: Integer).returns(Integer) }
        def total_tokens=(_)
        end

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
