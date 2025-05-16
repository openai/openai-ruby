# typed: strong

module OpenAI
  module Models
    class BatchCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::BatchCreateParams, OpenAI::Internal::AnyHash)
        end

      # The time frame within which the batch should be processed. Currently only `24h`
      # is supported.
      sig { returns(OpenAI::BatchCreateParams::CompletionWindow::OrSymbol) }
      attr_accessor :completion_window

      # The endpoint to be used for all requests in the batch. Currently
      # `/v1/responses`, `/v1/chat/completions`, `/v1/embeddings`, and `/v1/completions`
      # are supported. Note that `/v1/embeddings` batches are also restricted to a
      # maximum of 50,000 embedding inputs across all requests in the batch.
      sig { returns(OpenAI::BatchCreateParams::Endpoint::OrSymbol) }
      attr_accessor :endpoint

      # The ID of an uploaded file that contains requests for the new batch.
      #
      # See [upload file](https://platform.openai.com/docs/api-reference/files/create)
      # for how to upload a file.
      #
      # Your input file must be formatted as a
      # [JSONL file](https://platform.openai.com/docs/api-reference/batch/request-input),
      # and must be uploaded with the purpose `batch`. The file can contain up to 50,000
      # requests, and can be up to 200 MB in size.
      sig { returns(String) }
      attr_accessor :input_file_id

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      # for storing additional information about the object in a structured format, and
      # querying for objects via API or the dashboard.
      #
      # Keys are strings with a maximum length of 64 characters. Values are strings with
      # a maximum length of 512 characters.
      sig { returns(T.nilable(T::Hash[Symbol, String])) }
      attr_accessor :metadata

      sig do
        params(
          completion_window:
            OpenAI::BatchCreateParams::CompletionWindow::OrSymbol,
          endpoint: OpenAI::BatchCreateParams::Endpoint::OrSymbol,
          input_file_id: String,
          metadata: T.nilable(T::Hash[Symbol, String]),
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # The time frame within which the batch should be processed. Currently only `24h`
        # is supported.
        completion_window:,
        # The endpoint to be used for all requests in the batch. Currently
        # `/v1/responses`, `/v1/chat/completions`, `/v1/embeddings`, and `/v1/completions`
        # are supported. Note that `/v1/embeddings` batches are also restricted to a
        # maximum of 50,000 embedding inputs across all requests in the batch.
        endpoint:,
        # The ID of an uploaded file that contains requests for the new batch.
        #
        # See [upload file](https://platform.openai.com/docs/api-reference/files/create)
        # for how to upload a file.
        #
        # Your input file must be formatted as a
        # [JSONL file](https://platform.openai.com/docs/api-reference/batch/request-input),
        # and must be uploaded with the purpose `batch`. The file can contain up to 50,000
        # requests, and can be up to 200 MB in size.
        input_file_id:,
        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        metadata: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            completion_window:
              OpenAI::BatchCreateParams::CompletionWindow::OrSymbol,
            endpoint: OpenAI::BatchCreateParams::Endpoint::OrSymbol,
            input_file_id: String,
            metadata: T.nilable(T::Hash[Symbol, String]),
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # The time frame within which the batch should be processed. Currently only `24h`
      # is supported.
      module CompletionWindow
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::BatchCreateParams::CompletionWindow)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        COMPLETION_WINDOW_24H =
          T.let(
            :"24h",
            OpenAI::BatchCreateParams::CompletionWindow::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[OpenAI::BatchCreateParams::CompletionWindow::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The endpoint to be used for all requests in the batch. Currently
      # `/v1/responses`, `/v1/chat/completions`, `/v1/embeddings`, and `/v1/completions`
      # are supported. Note that `/v1/embeddings` batches are also restricted to a
      # maximum of 50,000 embedding inputs across all requests in the batch.
      module Endpoint
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::BatchCreateParams::Endpoint) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        V1_RESPONSES =
          T.let(
            :"/v1/responses",
            OpenAI::BatchCreateParams::Endpoint::TaggedSymbol
          )
        V1_CHAT_COMPLETIONS =
          T.let(
            :"/v1/chat/completions",
            OpenAI::BatchCreateParams::Endpoint::TaggedSymbol
          )
        V1_EMBEDDINGS =
          T.let(
            :"/v1/embeddings",
            OpenAI::BatchCreateParams::Endpoint::TaggedSymbol
          )
        V1_COMPLETIONS =
          T.let(
            :"/v1/completions",
            OpenAI::BatchCreateParams::Endpoint::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[OpenAI::BatchCreateParams::Endpoint::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end
