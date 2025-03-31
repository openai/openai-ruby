# frozen_string_literal: true

module OpenAI
  module Models
    class BatchCreateParams < OpenAI::BaseModel
      # @!parse
      #   extend OpenAI::Type::RequestParameters::Converter
      include OpenAI::RequestParameters

      # @!attribute completion_window
      #   The time frame within which the batch should be processed. Currently only `24h`
      #     is supported.
      #
      #   @return [Symbol, OpenAI::Models::BatchCreateParams::CompletionWindow]
      required :completion_window, enum: -> { OpenAI::Models::BatchCreateParams::CompletionWindow }

      # @!attribute endpoint
      #   The endpoint to be used for all requests in the batch. Currently
      #     `/v1/responses`, `/v1/chat/completions`, `/v1/embeddings`, and `/v1/completions`
      #     are supported. Note that `/v1/embeddings` batches are also restricted to a
      #     maximum of 50,000 embedding inputs across all requests in the batch.
      #
      #   @return [Symbol, OpenAI::Models::BatchCreateParams::Endpoint]
      required :endpoint, enum: -> { OpenAI::Models::BatchCreateParams::Endpoint }

      # @!attribute input_file_id
      #   The ID of an uploaded file that contains requests for the new batch.
      #
      #     See [upload file](https://platform.openai.com/docs/api-reference/files/create)
      #     for how to upload a file.
      #
      #     Your input file must be formatted as a
      #     [JSONL file](https://platform.openai.com/docs/api-reference/batch/request-input),
      #     and must be uploaded with the purpose `batch`. The file can contain up to 50,000
      #     requests, and can be up to 200 MB in size.
      #
      #   @return [String]
      required :input_file_id, String

      # @!attribute metadata
      #   Set of 16 key-value pairs that can be attached to an object. This can be useful
      #     for storing additional information about the object in a structured format, and
      #     querying for objects via API or the dashboard.
      #
      #     Keys are strings with a maximum length of 64 characters. Values are strings with
      #     a maximum length of 512 characters.
      #
      #   @return [Hash{Symbol=>String}, nil]
      optional :metadata, OpenAI::HashOf[String], nil?: true

      # @!parse
      #   # @param completion_window [Symbol, OpenAI::Models::BatchCreateParams::CompletionWindow]
      #   # @param endpoint [Symbol, OpenAI::Models::BatchCreateParams::Endpoint]
      #   # @param input_file_id [String]
      #   # @param metadata [Hash{Symbol=>String}, nil]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(completion_window:, endpoint:, input_file_id:, metadata: nil, request_options: {}, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void

      # The time frame within which the batch should be processed. Currently only `24h`
      #   is supported.
      module CompletionWindow
        extend OpenAI::Enum

        NUMBER_24H = :"24h"

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end

      # The endpoint to be used for all requests in the batch. Currently
      #   `/v1/responses`, `/v1/chat/completions`, `/v1/embeddings`, and `/v1/completions`
      #   are supported. Note that `/v1/embeddings` batches are also restricted to a
      #   maximum of 50,000 embedding inputs across all requests in the batch.
      module Endpoint
        extend OpenAI::Enum

        V1_RESPONSES = :"/v1/responses"
        V1_CHAT_COMPLETIONS = :"/v1/chat/completions"
        V1_EMBEDDINGS = :"/v1/embeddings"
        V1_COMPLETIONS = :"/v1/completions"

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end
    end
  end
end
