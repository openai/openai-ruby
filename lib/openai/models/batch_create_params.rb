# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Batches#create
    class BatchCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute completion_window
      #   The time frame within which the batch should be processed. Currently only `24h`
      #   is supported.
      #
      #   @return [Symbol, OpenAI::Models::BatchCreateParams::CompletionWindow]
      required :completion_window, enum: -> { OpenAI::BatchCreateParams::CompletionWindow }

      # @!attribute endpoint
      #   The endpoint to be used for all requests in the batch. Currently
      #   `/v1/responses`, `/v1/chat/completions`, `/v1/embeddings`, and `/v1/completions`
      #   are supported. Note that `/v1/embeddings` batches are also restricted to a
      #   maximum of 50,000 embedding inputs across all requests in the batch.
      #
      #   @return [Symbol, OpenAI::Models::BatchCreateParams::Endpoint]
      required :endpoint, enum: -> { OpenAI::BatchCreateParams::Endpoint }

      # @!attribute input_file_id
      #   The ID of an uploaded file that contains requests for the new batch.
      #
      #   See [upload file](https://platform.openai.com/docs/api-reference/files/create)
      #   for how to upload a file.
      #
      #   Your input file must be formatted as a
      #   [JSONL file](https://platform.openai.com/docs/api-reference/batch/request-input),
      #   and must be uploaded with the purpose `batch`. The file can contain up to 50,000
      #   requests, and can be up to 200 MB in size.
      #
      #   @return [String]
      required :input_file_id, String

      # @!attribute metadata
      #   Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      #
      #   @return [Hash{Symbol=>String}, nil]
      optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

      # @!method initialize(completion_window:, endpoint:, input_file_id:, metadata: nil, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::BatchCreateParams} for more details.
      #
      #   @param completion_window [Symbol, OpenAI::Models::BatchCreateParams::CompletionWindow] The time frame within which the batch should be processed. Currently only `24h`
      #
      #   @param endpoint [Symbol, OpenAI::Models::BatchCreateParams::Endpoint] The endpoint to be used for all requests in the batch. Currently `/v1/responses`
      #
      #   @param input_file_id [String] The ID of an uploaded file that contains requests for the new batch.
      #
      #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # The time frame within which the batch should be processed. Currently only `24h`
      # is supported.
      module CompletionWindow
        extend OpenAI::Internal::Type::Enum

        COMPLETION_WINDOW_24H = :"24h"

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The endpoint to be used for all requests in the batch. Currently
      # `/v1/responses`, `/v1/chat/completions`, `/v1/embeddings`, and `/v1/completions`
      # are supported. Note that `/v1/embeddings` batches are also restricted to a
      # maximum of 50,000 embedding inputs across all requests in the batch.
      module Endpoint
        extend OpenAI::Internal::Type::Enum

        V1_RESPONSES = :"/v1/responses"
        V1_CHAT_COMPLETIONS = :"/v1/chat/completions"
        V1_EMBEDDINGS = :"/v1/embeddings"
        V1_COMPLETIONS = :"/v1/completions"

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
