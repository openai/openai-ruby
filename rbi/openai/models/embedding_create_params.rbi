# typed: strong

module OpenAI
  module Models
    class EmbeddingCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::EmbeddingCreateParams, OpenAI::Internal::AnyHash)
        end

      # Input text to embed, encoded as a string or array of tokens. To embed multiple
      # inputs in a single request, pass an array of strings or array of token arrays.
      # The input must not exceed the max input tokens for the model (8192 tokens for
      # all embedding models), cannot be an empty string, and any array must be 2048
      # dimensions or less.
      # [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
      # for counting tokens. In addition to the per-input token limit, all embedding
      # models enforce a maximum of 300,000 tokens summed across all inputs in a single
      # request.
      sig { returns(OpenAI::EmbeddingCreateParams::Input::Variants) }
      attr_accessor :input

      # ID of the model to use. You can use the
      # [List models](https://platform.openai.com/docs/api-reference/models/list) API to
      # see all of your available models, or see our
      # [Model overview](https://platform.openai.com/docs/models) for descriptions of
      # them.
      sig { returns(OpenAI::EmbeddingCreateParams::Model::Variants) }
      attr_accessor :model

      # The number of dimensions the resulting output embeddings should have. Only
      # supported in `text-embedding-3` and later models.
      sig { returns(T.nilable(Integer)) }
      attr_reader :dimensions

      sig { params(dimensions: Integer).void }
      attr_writer :dimensions

      # The format to return the embeddings in. Can be either `float` or
      # [`base64`](https://pypi.org/project/pybase64/).
      sig do
        returns(
          T.nilable(OpenAI::EmbeddingCreateParams::EncodingFormat::OrSymbol)
        )
      end
      attr_reader :encoding_format

      sig do
        params(
          encoding_format:
            OpenAI::EmbeddingCreateParams::EncodingFormat::OrSymbol
        ).void
      end
      attr_writer :encoding_format

      # A unique identifier representing your end-user, which can help OpenAI to monitor
      # and detect abuse.
      # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      sig { returns(T.nilable(String)) }
      attr_reader :user

      sig { params(user: String).void }
      attr_writer :user

      sig do
        params(
          input: OpenAI::EmbeddingCreateParams::Input::Variants,
          model: OpenAI::EmbeddingCreateParams::Model::Variants,
          dimensions: Integer,
          encoding_format:
            OpenAI::EmbeddingCreateParams::EncodingFormat::OrSymbol,
          user: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # Input text to embed, encoded as a string or array of tokens. To embed multiple
        # inputs in a single request, pass an array of strings or array of token arrays.
        # The input must not exceed the max input tokens for the model (8192 tokens for
        # all embedding models), cannot be an empty string, and any array must be 2048
        # dimensions or less.
        # [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
        # for counting tokens. In addition to the per-input token limit, all embedding
        # models enforce a maximum of 300,000 tokens summed across all inputs in a single
        # request.
        input:,
        # ID of the model to use. You can use the
        # [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        # see all of your available models, or see our
        # [Model overview](https://platform.openai.com/docs/models) for descriptions of
        # them.
        model:,
        # The number of dimensions the resulting output embeddings should have. Only
        # supported in `text-embedding-3` and later models.
        dimensions: nil,
        # The format to return the embeddings in. Can be either `float` or
        # [`base64`](https://pypi.org/project/pybase64/).
        encoding_format: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        # and detect abuse.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            input: OpenAI::EmbeddingCreateParams::Input::Variants,
            model: OpenAI::EmbeddingCreateParams::Model::Variants,
            dimensions: Integer,
            encoding_format:
              OpenAI::EmbeddingCreateParams::EncodingFormat::OrSymbol,
            user: String,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # Input text to embed, encoded as a string or array of tokens. To embed multiple
      # inputs in a single request, pass an array of strings or array of token arrays.
      # The input must not exceed the max input tokens for the model (8192 tokens for
      # all embedding models), cannot be an empty string, and any array must be 2048
      # dimensions or less.
      # [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
      # for counting tokens. In addition to the per-input token limit, all embedding
      # models enforce a maximum of 300,000 tokens summed across all inputs in a single
      # request.
      module Input
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              String,
              T::Array[String],
              T::Array[Integer],
              T::Array[T::Array[Integer]]
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::EmbeddingCreateParams::Input::Variants]
          )
        end
        def self.variants
        end

        StringArray =
          T.let(
            OpenAI::Internal::Type::ArrayOf[String],
            OpenAI::Internal::Type::Converter
          )

        IntegerArray =
          T.let(
            OpenAI::Internal::Type::ArrayOf[Integer],
            OpenAI::Internal::Type::Converter
          )

        ArrayOfToken2DArray =
          T.let(
            OpenAI::Internal::Type::ArrayOf[
              OpenAI::Internal::Type::ArrayOf[Integer]
            ],
            OpenAI::Internal::Type::Converter
          )
      end

      # ID of the model to use. You can use the
      # [List models](https://platform.openai.com/docs/api-reference/models/list) API to
      # see all of your available models, or see our
      # [Model overview](https://platform.openai.com/docs/models) for descriptions of
      # them.
      module Model
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias { T.any(String, OpenAI::EmbeddingModel::TaggedSymbol) }

        sig do
          override.returns(
            T::Array[OpenAI::EmbeddingCreateParams::Model::Variants]
          )
        end
        def self.variants
        end
      end

      # The format to return the embeddings in. Can be either `float` or
      # [`base64`](https://pypi.org/project/pybase64/).
      module EncodingFormat
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::EmbeddingCreateParams::EncodingFormat)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        FLOAT =
          T.let(
            :float,
            OpenAI::EmbeddingCreateParams::EncodingFormat::TaggedSymbol
          )
        BASE64 =
          T.let(
            :base64,
            OpenAI::EmbeddingCreateParams::EncodingFormat::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[
              OpenAI::EmbeddingCreateParams::EncodingFormat::TaggedSymbol
            ]
          )
        end
        def self.values
        end
      end
    end
  end
end
