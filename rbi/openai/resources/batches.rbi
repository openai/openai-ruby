# typed: strong

module OpenAI
  module Resources
    class Batches
      # Creates and executes a batch from an uploaded file of requests
      sig do
        params(
          completion_window: OpenAI::Models::BatchCreateParams::CompletionWindow::OrSymbol,
          endpoint: OpenAI::Models::BatchCreateParams::Endpoint::OrSymbol,
          input_file_id: String,
          metadata: T.nilable(T::Hash[Symbol, String]),
          request_options: OpenAI::RequestOpts
        )
          .returns(OpenAI::Models::Batch)
      end
      def create(
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
      ); end
      # Retrieves a batch.
      sig { params(batch_id: String, request_options: OpenAI::RequestOpts).returns(OpenAI::Models::Batch) }
      def retrieve(
        # The ID of the batch to retrieve.
        batch_id,
        request_options: {}
      ); end
      # List your organization's batches.
      sig do
        params(after: String, limit: Integer, request_options: OpenAI::RequestOpts)
          .returns(OpenAI::Internal::CursorPage[OpenAI::Models::Batch])
      end
      def list(
        # A cursor for use in pagination. `after` is an object ID that defines your place
        # in the list. For instance, if you make a list request and receive 100 objects,
        # ending with obj_foo, your subsequent call can include after=obj_foo in order to
        # fetch the next page of the list.
        after: nil,
        # A limit on the number of objects to be returned. Limit can range between 1 and
        # 100, and the default is 20.
        limit: nil,
        request_options: {}
      ); end
      # Cancels an in-progress batch. The batch will be in status `cancelling` for up to
      # 10 minutes, before changing to `cancelled`, where it will have partial results
      # (if any) available in the output file.
      sig { params(batch_id: String, request_options: OpenAI::RequestOpts).returns(OpenAI::Models::Batch) }
      def cancel(
        # The ID of the batch to cancel.
        batch_id,
        request_options: {}
      ); end
      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:); end
    end
  end
end
