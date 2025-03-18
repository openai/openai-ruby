# typed: strong

module OpenAI
  module Models
    class BatchCreateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # The time frame within which the batch should be processed. Currently only `24h`
      #   is supported.
      sig { returns(Symbol) }
      def completion_window
      end

      sig { params(_: Symbol).returns(Symbol) }
      def completion_window=(_)
      end

      # The endpoint to be used for all requests in the batch. Currently
      #   `/v1/responses`, `/v1/chat/completions`, `/v1/embeddings`, and `/v1/completions`
      #   are supported. Note that `/v1/embeddings` batches are also restricted to a
      #   maximum of 50,000 embedding inputs across all requests in the batch.
      sig { returns(Symbol) }
      def endpoint
      end

      sig { params(_: Symbol).returns(Symbol) }
      def endpoint=(_)
      end

      # The ID of an uploaded file that contains requests for the new batch.
      #
      #   See [upload file](https://platform.openai.com/docs/api-reference/files/create)
      #   for how to upload a file.
      #
      #   Your input file must be formatted as a
      #   [JSONL file](https://platform.openai.com/docs/api-reference/batch/request-input),
      #   and must be uploaded with the purpose `batch`. The file can contain up to 50,000
      #   requests, and can be up to 200 MB in size.
      sig { returns(String) }
      def input_file_id
      end

      sig { params(_: String).returns(String) }
      def input_file_id=(_)
      end

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      sig { returns(T.nilable(OpenAI::Models::Metadata)) }
      def metadata
      end

      sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
      def metadata=(_)
      end

      sig do
        params(
          completion_window: Symbol,
          endpoint: Symbol,
          input_file_id: String,
          metadata: T.nilable(OpenAI::Models::Metadata),
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
        )
          .returns(T.attached_class)
      end
      def self.new(completion_window:, endpoint:, input_file_id:, metadata: nil, request_options: {})
      end

      sig do
        override
          .returns(
            {
              completion_window: Symbol,
              endpoint: Symbol,
              input_file_id: String,
              metadata: T.nilable(OpenAI::Models::Metadata),
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      # The time frame within which the batch should be processed. Currently only `24h`
      #   is supported.
      class CompletionWindow < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        NUMBER_24H = :"24h"
      end

      # The endpoint to be used for all requests in the batch. Currently
      #   `/v1/responses`, `/v1/chat/completions`, `/v1/embeddings`, and `/v1/completions`
      #   are supported. Note that `/v1/embeddings` batches are also restricted to a
      #   maximum of 50,000 embedding inputs across all requests in the batch.
      class Endpoint < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        V1_RESPONSES = :"/v1/responses"
        V1_CHAT_COMPLETIONS = :"/v1/chat/completions"
        V1_EMBEDDINGS = :"/v1/embeddings"
        V1_COMPLETIONS = :"/v1/completions"
      end
    end
  end
end
