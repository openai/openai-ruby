# typed: strong

module OpenAI
  module Models
    class EmbeddingCreateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # Input text to embed, encoded as a string or array of tokens. To embed multiple
      #   inputs in a single request, pass an array of strings or array of token arrays.
      #   The input must not exceed the max input tokens for the model (8192 tokens for
      #   `text-embedding-ada-002`), cannot be an empty string, and any array must be 2048
      #   dimensions or less.
      #   [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
      #   for counting tokens. Some models may also impose a limit on total number of
      #   tokens summed across inputs.
      sig { returns(T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]])) }
      def input
      end

      sig do
        params(_: T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]]))
          .returns(T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]]))
      end
      def input=(_)
      end

      # ID of the model to use. You can use the
      #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
      #   see all of your available models, or see our
      #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
      #   them.
      sig { returns(T.any(String, Symbol)) }
      def model
      end

      sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
      def model=(_)
      end

      # The number of dimensions the resulting output embeddings should have. Only
      #   supported in `text-embedding-3` and later models.
      sig { returns(T.nilable(Integer)) }
      def dimensions
      end

      sig { params(_: Integer).returns(Integer) }
      def dimensions=(_)
      end

      # The format to return the embeddings in. Can be either `float` or
      #   [`base64`](https://pypi.org/project/pybase64/).
      sig { returns(T.nilable(Symbol)) }
      def encoding_format
      end

      sig { params(_: Symbol).returns(Symbol) }
      def encoding_format=(_)
      end

      # A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      sig { returns(T.nilable(String)) }
      def user
      end

      sig { params(_: String).returns(String) }
      def user=(_)
      end

      sig do
        params(
          input: T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]]),
          model: T.any(String, Symbol),
          dimensions: Integer,
          encoding_format: Symbol,
          user: String,
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
        )
          .returns(T.attached_class)
      end
      def self.new(input:, model:, dimensions: nil, encoding_format: nil, user: nil, request_options: {})
      end

      sig do
        override
          .returns(
            {
              input: T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]]),
              model: T.any(String, Symbol),
              dimensions: Integer,
              encoding_format: Symbol,
              user: String,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      # Input text to embed, encoded as a string or array of tokens. To embed multiple
      #   inputs in a single request, pass an array of strings or array of token arrays.
      #   The input must not exceed the max input tokens for the model (8192 tokens for
      #   `text-embedding-ada-002`), cannot be an empty string, and any array must be 2048
      #   dimensions or less.
      #   [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
      #   for counting tokens. Some models may also impose a limit on total number of
      #   tokens summed across inputs.
      class Input < OpenAI::Union
        abstract!

        StringArray = T.type_alias { T::Array[String] }

        IntegerArray = T.type_alias { T::Array[Integer] }

        ArrayOfToken2DArray = T.type_alias { T::Array[T::Array[Integer]] }

        class << self
          sig { override.returns([String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]]]) }
          def variants
          end
        end
      end

      # ID of the model to use. You can use the
      #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
      #   see all of your available models, or see our
      #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
      #   them.
      class Model < OpenAI::Union
        abstract!

        class << self
          sig { override.returns([String, Symbol]) }
          def variants
          end
        end
      end

      # The format to return the embeddings in. Can be either `float` or
      #   [`base64`](https://pypi.org/project/pybase64/).
      class EncodingFormat < OpenAI::Enum
        abstract!

        FLOAT = :float
        BASE64 = :base64

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end
    end
  end
end
