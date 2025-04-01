# frozen_string_literal: true

module OpenAI
  module Resources
    class Batches
      # Creates and executes a batch from an uploaded file of requests
      #
      # @overload create(completion_window:, endpoint:, input_file_id:, metadata: nil, request_options: {})
      #
      # @param completion_window [Symbol, OpenAI::Models::BatchCreateParams::CompletionWindow]
      # @param endpoint [Symbol, OpenAI::Models::BatchCreateParams::Endpoint]
      # @param input_file_id [String]
      # @param metadata [Hash{Symbol=>String}, nil]
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
      # @param batch_id [String]
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

      # List your organization's batches.
      #
      # @overload list(after: nil, limit: nil, request_options: {})
      #
      # @param after [String]
      # @param limit [Integer]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::CursorPage<OpenAI::Models::Batch>]
      #
      # @see OpenAI::Models::BatchListParams
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
      # @overload cancel(batch_id, request_options: {})
      #
      # @param batch_id [String]
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
