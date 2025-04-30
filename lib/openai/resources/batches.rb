# frozen_string_literal: true

module OpenAI
  module Resources
    class Batches
      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::BatchCreateParams} for more details.
      #
      # Creates and executes a batch from an uploaded file of requests
      #
      # @overload create(completion_window:, endpoint:, input_file_id:, metadata: nil, request_options: {})
      #
      # @param completion_window [Symbol, OpenAI::Models::BatchCreateParams::CompletionWindow] The time frame within which the batch should be processed. Currently only `24h`
      # ...
      #
      # @param endpoint [Symbol, OpenAI::Models::BatchCreateParams::Endpoint] The endpoint to be used for all requests in the batch. Currently `/v1/responses`
      # ...
      #
      # @param input_file_id [String] The ID of an uploaded file that contains requests for the new batch. ...
      #
      # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be ...
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Batch]
      #
      # @see OpenAI::Models::BatchCreateParams
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
      # @overload retrieve(batch_id, request_options: {})
      #
      # @param batch_id [String] The ID of the batch to retrieve.
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
          model: OpenAI::Models::Batch,
          options: params[:request_options]
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::BatchListParams} for more details.
      #
      # List your organization's batches.
      #
      # @overload list(after: nil, limit: nil, request_options: {})
      #
      # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
      # ...
      #
      # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
      # ...
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Batch>]
      #
      # @see OpenAI::Models::BatchListParams
      def list(params = {})
        parsed, options = OpenAI::Models::BatchListParams.dump_request(params)
        @client.request(
          method: :get,
          path: "batches",
          query: parsed,
          page: OpenAI::Internal::CursorPage,
          model: OpenAI::Models::Batch,
          options: options
        )
      end

      # Cancels an in-progress batch. The batch will be in status `cancelling` for up to
      # 10 minutes, before changing to `cancelled`, where it will have partial results
      # (if any) available in the output file.
      #
      # @overload cancel(batch_id, request_options: {})
      #
      # @param batch_id [String] The ID of the batch to cancel.
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
          model: OpenAI::Models::Batch,
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
