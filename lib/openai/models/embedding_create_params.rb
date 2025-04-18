# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Embeddings#create
    class EmbeddingCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute input
      #   Input text to embed, encoded as a string or array of tokens. To embed multiple
      #   inputs in a single request, pass an array of strings or array of token arrays.
      #   The input must not exceed the max input tokens for the model (8192 tokens for
      #   `text-embedding-ada-002`), cannot be an empty string, and any array must be 2048
      #   dimensions or less.
      #   [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
      #   for counting tokens. Some models may also impose a limit on total number of
      #   tokens summed across inputs.
      #
      #   @return [String, Array<String>, Array<Integer>, Array<Array<Integer>>]
      required :input, union: -> { OpenAI::Models::EmbeddingCreateParams::Input }

      # @!attribute model
      #   ID of the model to use. You can use the
      #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
      #   see all of your available models, or see our
      #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
      #   them.
      #
      #   @return [String, Symbol, OpenAI::Models::EmbeddingModel]
      required :model, union: -> { OpenAI::Models::EmbeddingCreateParams::Model }

      # @!attribute dimensions
      #   The number of dimensions the resulting output embeddings should have. Only
      #   supported in `text-embedding-3` and later models.
      #
      #   @return [Integer, nil]
      optional :dimensions, Integer

      # @!attribute encoding_format
      #   The format to return the embeddings in. Can be either `float` or
      #   [`base64`](https://pypi.org/project/pybase64/).
      #
      #   @return [Symbol, OpenAI::Models::EmbeddingCreateParams::EncodingFormat, nil]
      optional :encoding_format, enum: -> { OpenAI::Models::EmbeddingCreateParams::EncodingFormat }

      # @!attribute user
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      #
      #   @return [String, nil]
      optional :user, String

      # @!method initialize(input:, model:, dimensions: nil, encoding_format: nil, user: nil, request_options: {})
      #   @param input [String, Array<String>, Array<Integer>, Array<Array<Integer>>]
      #   @param model [String, Symbol, OpenAI::Models::EmbeddingModel]
      #   @param dimensions [Integer]
      #   @param encoding_format [Symbol, OpenAI::Models::EmbeddingCreateParams::EncodingFormat]
      #   @param user [String]
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # Input text to embed, encoded as a string or array of tokens. To embed multiple
      # inputs in a single request, pass an array of strings or array of token arrays.
      # The input must not exceed the max input tokens for the model (8192 tokens for
      # `text-embedding-ada-002`), cannot be an empty string, and any array must be 2048
      # dimensions or less.
      # [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
      # for counting tokens. Some models may also impose a limit on total number of
      # tokens summed across inputs.
      module Input
        extend OpenAI::Internal::Type::Union

        # The string that will be turned into an embedding.
        variant String

        # The array of strings that will be turned into an embedding.
        variant -> { OpenAI::Models::EmbeddingCreateParams::Input::StringArray }

        # The array of integers that will be turned into an embedding.
        variant -> { OpenAI::Models::EmbeddingCreateParams::Input::IntegerArray }

        # The array of arrays containing integers that will be turned into an embedding.
        variant -> { OpenAI::Models::EmbeddingCreateParams::Input::ArrayOfToken2DArray }

        # @!method self.variants
        #   @return [Array(String, Array<String>, Array<Integer>, Array<Array<Integer>>)]

        StringArray = OpenAI::Internal::Type::ArrayOf[String]

        IntegerArray = OpenAI::Internal::Type::ArrayOf[Integer]

        ArrayOfToken2DArray = OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::ArrayOf[Integer]]
      end

      # ID of the model to use. You can use the
      # [List models](https://platform.openai.com/docs/api-reference/models/list) API to
      # see all of your available models, or see our
      # [Model overview](https://platform.openai.com/docs/models) for descriptions of
      # them.
      module Model
        extend OpenAI::Internal::Type::Union

        variant String

        # ID of the model to use. You can use the [List models](https://platform.openai.com/docs/api-reference/models/list) API to see all of your available models, or see our [Model overview](https://platform.openai.com/docs/models) for descriptions of them.
        variant enum: -> { OpenAI::Models::EmbeddingModel }

        # @!method self.variants
        #   @return [Array(String, Symbol, OpenAI::Models::EmbeddingModel)]
      end

      # The format to return the embeddings in. Can be either `float` or
      # [`base64`](https://pypi.org/project/pybase64/).
      module EncodingFormat
        extend OpenAI::Internal::Type::Enum

        FLOAT = :float
        BASE64 = :base64

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
