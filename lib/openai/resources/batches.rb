# frozen_string_literal: true

module OpenAI
  module Resources
    # Create large batches of API requests to run asynchronously.
    class Batches
      # Creates and executes a batch from an uploaded file of requests
      #
      # @overload create(completion_window:, endpoint:, input_file_id:, metadata: nil, output_expires_after: nil, request_options: {})
      #
      # @param completion_window [Symbol, OpenAI::Models::BatchCreateParams::CompletionWindow]
      #   The time frame within which the batch should be processed. Currently only `24h`
      #   is supported.
      #
      # @param endpoint [Symbol, OpenAI::Models::BatchCreateParams::Endpoint]
      #   The endpoint to be used for all requests in the batch. Currently
      #   `/v1/responses`, `/v1/chat/completions`, `/v1/embeddings`, `/v1/completions`,
      #   `/v1/moderations`, `/v1/images/generations`, `/v1/images/edits`, and
      #   `/v1/videos` are supported. Note that `/v1/embeddings` batches are also
      #   restricted to a maximum of 50,000 embedding inputs across all requests in the
      #   batch.
      #
      # @param input_file_id [String]
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
      # @param metadata [Hash{Symbol=>String}, nil]
      #   Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      #
      # @param output_expires_after [OpenAI::Models::BatchCreateParams::OutputExpiresAfter]
      #   The expiration policy for the output and/or error file that are generated for a
      #   batch.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Batch]
      #
      # @see OpenAI::Models::BatchCreateParams
      def create(params)
        parsed, options = OpenAI::BatchCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "batches",
          body: parsed,
          model: OpenAI::Batch,
          security: {bearer_auth: true},
          options: options
        )
      end

      # Retrieves a batch.
      #
      # @overload retrieve(batch_id, request_options: {})
      #
      # @param batch_id [String]
      #   The ID of the batch to retrieve.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Batch]
      #
      # @see OpenAI::Models::BatchRetrieveParams
      def retrieve(batch_id, params = {})
        @client.request(
          method: :get,
          path: ["batches/%1$s", batch_id],
          model: OpenAI::Batch,
          security: {bearer_auth: true},
          options: params[:request_options]
        )
      end

      # List your organization's batches.
      #
      # @overload list(after: nil, limit: nil, request_options: {})
      #
      # @param after [String]
      #   A cursor for use in pagination. `after` is an object ID that defines your place
      #   in the list. For instance, if you make a list request and receive 100 objects,
      #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
      #   fetch the next page of the list.
      #
      # @param limit [Integer]
      #   A limit on the number of objects to be returned. Limit can range between 1 and
      #   100, and the default is 20.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Batch>]
      #
      # @see OpenAI::Models::BatchListParams
      def list(params = {})
        parsed, options = OpenAI::BatchListParams.dump_request(params)
        query = OpenAI::Internal::Util.encode_query_params(parsed)
        @client.request(
          method: :get,
          path: "batches",
          query: query,
          page: OpenAI::Internal::CursorPage,
          model: OpenAI::Batch,
          security: {bearer_auth: true},
          options: options
        )
      end

      # Cancels an in-progress batch. The batch will be in status `cancelling` for up to
      # 10 minutes, before changing to `cancelled`, where it will have partial results
      # (if any) available in the output file.
      #
      # @overload cancel(batch_id, request_options: {})
      #
      # @param batch_id [String]
      #   The ID of the batch to cancel.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Batch]
      #
      # @see OpenAI::Models::BatchCancelParams
      def cancel(batch_id, params = {})
        @client.request(
          method: :post,
          path: ["batches/%1$s/cancel", batch_id],
          model: OpenAI::Batch,
          security: {bearer_auth: true},
          options: params[:request_options]
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
      end
    end
  end
end
