# frozen_string_literal: true

module OpenAI
  module Resources
    class Batches
      # Creates and executes a batch from an uploaded file of requests
      #
      # @param params [OpenAI::Models::BatchCreateParams, Hash{Symbol=>Object}] .
      #
      #   @option params [Symbol, OpenAI::Models::BatchCreateParams::CompletionWindow] :completion_window The time frame within which the batch should be processed. Currently only `24h`
      #     is supported.
      #
      #   @option params [Symbol, OpenAI::Models::BatchCreateParams::Endpoint] :endpoint The endpoint to be used for all requests in the batch. Currently
      #     `/v1/responses`, `/v1/chat/completions`, `/v1/embeddings`, and `/v1/completions`
      #     are supported. Note that `/v1/embeddings` batches are also restricted to a
      #     maximum of 50,000 embedding inputs across all requests in the batch.
      #
      #   @option params [String] :input_file_id The ID of an uploaded file that contains requests for the new batch.
      #
      #     See [upload file](https://platform.openai.com/docs/api-reference/files/create)
      #     for how to upload a file.
      #
      #     Your input file must be formatted as a
      #     [JSONL file](https://platform.openai.com/docs/api-reference/batch/request-input),
      #     and must be uploaded with the purpose `batch`. The file can contain up to 50,000
      #     requests, and can be up to 200 MB in size.
      #
      #   @option params [Hash{Symbol=>String}, nil] :metadata Set of 16 key-value pairs that can be attached to an object. This can be useful
      #     for storing additional information about the object in a structured format, and
      #     querying for objects via API or the dashboard.
      #
      #     Keys are strings with a maximum length of 64 characters. Values are strings with
      #     a maximum length of 512 characters.
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::Batch]
      def create(params)
        parsed, options = OpenAI::Models::BatchCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "batches",
          body: parsed,
          model: OpenAI::Models::Batch,
          options: options
        )
      end

      # Retrieves a batch.
      #
      # @param batch_id [String] The ID of the batch to retrieve.
      #
      # @param params [OpenAI::Models::BatchRetrieveParams, Hash{Symbol=>Object}] .
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::Batch]
      def retrieve(batch_id, params = {})
        @client.request(
          method: :get,
          path: ["batches/%0s", batch_id],
          model: OpenAI::Models::Batch,
          options: params[:request_options]
        )
      end

      # List your organization's batches.
      #
      # @param params [OpenAI::Models::BatchListParams, Hash{Symbol=>Object}] .
      #
      #   @option params [String] :after A cursor for use in pagination. `after` is an object ID that defines your place
      #     in the list. For instance, if you make a list request and receive 100 objects,
      #     ending with obj_foo, your subsequent call can include after=obj_foo in order to
      #     fetch the next page of the list.
      #
      #   @option params [Integer] :limit A limit on the number of objects to be returned. Limit can range between 1 and
      #     100, and the default is 20.
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::CursorPage<OpenAI::Models::Batch>]
      def list(params = {})
        parsed, options = OpenAI::Models::BatchListParams.dump_request(params)
        @client.request(
          method: :get,
          path: "batches",
          query: parsed,
          page: OpenAI::CursorPage,
          model: OpenAI::Models::Batch,
          options: options
        )
      end

      # Cancels an in-progress batch. The batch will be in status `cancelling` for up to
      #   10 minutes, before changing to `cancelled`, where it will have partial results
      #   (if any) available in the output file.
      #
      # @param batch_id [String] The ID of the batch to cancel.
      #
      # @param params [OpenAI::Models::BatchCancelParams, Hash{Symbol=>Object}] .
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::Batch]
      def cancel(batch_id, params = {})
        @client.request(
          method: :post,
          path: ["batches/%0s/cancel", batch_id],
          model: OpenAI::Models::Batch,
          options: params[:request_options]
        )
      end

      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
      end
    end
  end
end
