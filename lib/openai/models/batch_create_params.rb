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
      #   `/v1/responses`, `/v1/chat/completions`, `/v1/embeddings`, `/v1/completions`,
      #   `/v1/moderations`, `/v1/images/generations`, `/v1/images/edits`, and
      #   `/v1/videos` are supported. Note that `/v1/embeddings` batches are also
      #   restricted to a maximum of 50,000 embedding inputs across all requests in the
      #   batch.
      #
      #   @return [Symbol, OpenAI::Models::BatchCreateParams::Endpoint]
      required :endpoint, enum: -> { OpenAI::BatchCreateParams::Endpoint }

      # @!attribute input_file_id
      #   The ID of an uploaded file that contains requests for the new batch.
      #
      #   See
      #   [upload file](https://developers.openai.com/api/reference/resources/files/methods/create)
      #   for how to upload a file.
      #
      #   Your input file must be formatted as a
      #   [JSONL file](https://developers.openai.com/api/docs/guides/batch#1-prepare-your-batch-file),
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

      # @!attribute output_expires_after
      #   The expiration policy for the output and/or error file that are generated for a
      #   batch.
      #
      #   @return [OpenAI::Models::BatchCreateParams::OutputExpiresAfter, nil]
      optional :output_expires_after, -> { OpenAI::BatchCreateParams::OutputExpiresAfter }

      # @!method initialize(completion_window:, endpoint:, input_file_id:, metadata: nil, output_expires_after: nil, request_options: {})
      #   @param completion_window [Symbol, OpenAI::Models::BatchCreateParams::CompletionWindow]
      #     The time frame within which the batch should be processed. Currently only `24h`
      #     is supported.
      #
      #   @param endpoint [Symbol, OpenAI::Models::BatchCreateParams::Endpoint]
      #     The endpoint to be used for all requests in the batch. Currently
      #     `/v1/responses`, `/v1/chat/completions`, `/v1/embeddings`, `/v1/completions`,
      #     `/v1/moderations`, `/v1/images/generations`, `/v1/images/edits`, and
      #     `/v1/videos` are supported. Note that `/v1/embeddings` batches are also
      #     restricted to a maximum of 50,000 embedding inputs across all requests in the
      #     batch.
      #
      #   @param input_file_id [String]
      #     The ID of an uploaded file that contains requests for the new batch.
      #
      #     See
      #     [upload file](https://developers.openai.com/api/reference/resources/files/methods/create)
      #     for how to upload a file.
      #
      #     Your input file must be formatted as a
      #     [JSONL file](https://developers.openai.com/api/docs/guides/batch#1-prepare-your-batch-file),
      #     and must be uploaded with the purpose `batch`. The file can contain up to 50,000
      #     requests, and can be up to 200 MB in size.
      #
      #   @param metadata [Hash{Symbol=>String}, nil]
      #     Set of 16 key-value pairs that can be attached to an object. This can be useful
      #     for storing additional information about the object in a structured format, and
      #     querying for objects via API or the dashboard.
      #
      #     Keys are strings with a maximum length of 64 characters. Values are strings with
      #     a maximum length of 512 characters.
      #
      #   @param output_expires_after [OpenAI::Models::BatchCreateParams::OutputExpiresAfter]
      #     The expiration policy for the output and/or error file that are generated for a
      #     batch.
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
      # `/v1/responses`, `/v1/chat/completions`, `/v1/embeddings`, `/v1/completions`,
      # `/v1/moderations`, `/v1/images/generations`, `/v1/images/edits`, and
      # `/v1/videos` are supported. Note that `/v1/embeddings` batches are also
      # restricted to a maximum of 50,000 embedding inputs across all requests in the
      # batch.
      module Endpoint
        extend OpenAI::Internal::Type::Enum

        V1_RESPONSES = :"/v1/responses"
        V1_CHAT_COMPLETIONS = :"/v1/chat/completions"
        V1_EMBEDDINGS = :"/v1/embeddings"
        V1_COMPLETIONS = :"/v1/completions"
        V1_MODERATIONS = :"/v1/moderations"
        V1_IMAGES_GENERATIONS = :"/v1/images/generations"
        V1_IMAGES_EDITS = :"/v1/images/edits"
        V1_VIDEOS = :"/v1/videos"

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      class OutputExpiresAfter < OpenAI::Internal::Type::BaseModel
        # @!attribute anchor
        #   Anchor timestamp after which the expiration policy applies. Supported anchors:
        #   `created_at`. Note that the anchor is the file creation time, not the time the
        #   batch is created.
        #
        #   @return [Symbol, :created_at]
        required :anchor, const: :created_at

        # @!attribute seconds
        #   The number of seconds after the anchor time that the file will expire. Must be
        #   between 3600 (1 hour) and 2592000 (30 days).
        #
        #   @return [Integer]
        required :seconds, Integer

        # @!method initialize(seconds:, anchor: :created_at)
        #   The expiration policy for the output and/or error file that are generated for a
        #   batch.
        #
        #   @param seconds [Integer]
        #     The number of seconds after the anchor time that the file will expire. Must be
        #     between 3600 (1 hour) and 2592000 (30 days).
        #
        #   @param anchor [Symbol, :created_at]
        #     Anchor timestamp after which the expiration policy applies. Supported anchors:
        #     `created_at`. Note that the anchor is the file creation time, not the time the
        #     batch is created.
      end
    end
  end
end
