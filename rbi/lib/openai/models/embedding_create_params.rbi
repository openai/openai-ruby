# typed: strong

module OpenAI
  module Models
    class EmbeddingCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # Input text to embed, encoded as a string or array of tokens. To embed multiple
      #   inputs in a single request, pass an array of strings or array of token arrays.
      #   The input must not exceed the max input tokens for the model (8192 tokens for
      #   `text-embedding-ada-002`), cannot be an empty string, and any array must be 2048
      #   dimensions or less.
      #   [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
      #   for counting tokens. Some models may also impose a limit on total number of
      #   tokens summed across inputs.
      sig { returns(T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]])) }
      attr_accessor :input

      # ID of the model to use. You can use the
      #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
      #   see all of your available models, or see our
      #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
      #   them.
      sig { returns(T.any(String, OpenAI::Models::EmbeddingModel::OrSymbol)) }
      attr_accessor :model

      # The number of dimensions the resulting output embeddings should have. Only
      #   supported in `text-embedding-3` and later models.
      sig { returns(T.nilable(Integer)) }
      attr_reader :dimensions

      sig { params(dimensions: Integer).void }
      attr_writer :dimensions

      # The format to return the embeddings in. Can be either `float` or
      #   [`base64`](https://pypi.org/project/pybase64/).
      sig { returns(T.nilable(OpenAI::Models::EmbeddingCreateParams::EncodingFormat::OrSymbol)) }
      attr_reader :encoding_format

      sig { params(encoding_format: OpenAI::Models::EmbeddingCreateParams::EncodingFormat::OrSymbol).void }
      attr_writer :encoding_format

      # A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      sig { returns(T.nilable(String)) }
      attr_reader :user

      sig { params(user: String).void }
      attr_writer :user

      sig do
        params(
          input: T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]]),
          model: T.any(String, OpenAI::Models::EmbeddingModel::OrSymbol),
          dimensions: Integer,
          encoding_format: OpenAI::Models::EmbeddingCreateParams::EncodingFormat::OrSymbol,
          user: String,
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(input:, model:, dimensions: nil, encoding_format: nil, user: nil, request_options: {}); end

      sig do
        override
          .returns(
            {
              input: T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]]),
              model: T.any(String, OpenAI::Models::EmbeddingModel::OrSymbol),
              dimensions: Integer,
              encoding_format: OpenAI::Models::EmbeddingCreateParams::EncodingFormat::OrSymbol,
              user: String,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash; end

      # Input text to embed, encoded as a string or array of tokens. To embed multiple
      #   inputs in a single request, pass an array of strings or array of token arrays.
      #   The input must not exceed the max input tokens for the model (8192 tokens for
      #   `text-embedding-ada-002`), cannot be an empty string, and any array must be 2048
      #   dimensions or less.
      #   [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
      #   for counting tokens. Some models may also impose a limit on total number of
      #   tokens summed across inputs.
      module Input
        extend OpenAI::Internal::Type::Union

        sig { override.returns([String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]]]) }
        def self.variants; end

        StringArray = T.let(OpenAI::Internal::Type::ArrayOf[String], OpenAI::Internal::Type::Converter)

        IntegerArray = T.let(OpenAI::Internal::Type::ArrayOf[Integer], OpenAI::Internal::Type::Converter)

        ArrayOfToken2DArray =
          T.let(
            OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::ArrayOf[Integer]],
            OpenAI::Internal::Type::Converter
          )
      end

      # ID of the model to use. You can use the
      #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
      #   see all of your available models, or see our
      #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
      #   them.
      module Model
        extend OpenAI::Internal::Type::Union

        sig { override.returns([String, OpenAI::Models::EmbeddingModel::OrSymbol]) }
        def self.variants; end
      end

      # The format to return the embeddings in. Can be either `float` or
      #   [`base64`](https://pypi.org/project/pybase64/).
      module EncodingFormat
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::EmbeddingCreateParams::EncodingFormat) }
        OrSymbol =
          T.type_alias { T.any(Symbol, String, OpenAI::Models::EmbeddingCreateParams::EncodingFormat::TaggedSymbol) }

        FLOAT = T.let(:float, OpenAI::Models::EmbeddingCreateParams::EncodingFormat::TaggedSymbol)
        BASE64 = T.let(:base64, OpenAI::Models::EmbeddingCreateParams::EncodingFormat::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::EmbeddingCreateParams::EncodingFormat::TaggedSymbol]) }
        def self.values; end
      end
    end
  end
end
