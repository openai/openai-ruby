# frozen_string_literal: true

module OpenAI
  module Resources
    # Files are used to upload documents that can be used with features like
    # Assistants and Fine-tuning.
    class Files
      # Upload a file that can be used across various endpoints. Individual files can be
      # up to 512 MB, and each project can store up to 2.5 TB of files in total. There
      # is no organization-wide storage limit. Uploads to this endpoint are rate-limited
      # to 1,000 requests per minute per authenticated user.
      #
      # - The Assistants API supports files up to 2 million tokens and of specific file
      #   types. See the
      #   [Assistants Tools guide](https://developers.openai.com/api/docs/guides/tools)
      #   for details.
      # - The Fine-tuning API only supports `.jsonl` files. The input also has certain
      #   required formats for fine-tuning
      #   [chat](https://developers.openai.com/api/docs/guides/supervised-fine-tuning#formatting-your-data)
      #   or
      #   [completions](https://developers.openai.com/api/docs/guides/supervised-fine-tuning#formatting-your-data)
      #   models.
      # - The Batch API only supports `.jsonl` files up to 200 MB in size. The input
      #   also has a specific required
      #   [format](https://developers.openai.com/api/docs/guides/batch#1-prepare-your-batch-file).
      # - For Retrieval or `file_search` ingestion, upload files here first. If you need
      #   to attach multiple uploaded files to the same vector store, use
      #   [`/vector_stores/{vector_store_id}/file_batches`](https://developers.openai.com/api/reference/resources/vector_stores/subresources/file_batches/methods/create)
      #   instead of attaching them one by one. Vector store attachment has separate
      #   limits from file upload, including 2,000 attached files per minute per
      #   organization.
      #
      # Please [contact us](https://help.openai.com/) if you need to increase these
      # storage limits.
      #
      # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      # metadata. Use `OpenAI::FilePart` when you need to override the filename or
      # content type.
      #
      # @overload create(file:, purpose:, expires_after: nil, request_options: {})
      #
      # @param file [Pathname, StringIO, IO, String, OpenAI::FilePart]
      #   The File object (not file name) to be uploaded.
      #
      #   `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      #   metadata. Use `OpenAI::FilePart` when you need to override the filename or
      #   content type.
      #
      # @param purpose [Symbol, OpenAI::Models::FilePurpose]
      #   The intended purpose of the uploaded file. One of:
      #
      #   - `assistants`: Used in the Assistants API
      #   - `batch`: Used in the Batch API
      #   - `fine-tune`: Used for fine-tuning
      #   - `vision`: Images used for vision fine-tuning
      #   - `user_data`: Flexible file type for any purpose
      #   - `evals`: Used for eval data sets
      #
      # @param expires_after [OpenAI::Models::FileCreateParams::ExpiresAfter]
      #   The expiration policy for a file. By default, files with `purpose=batch` expire
      #   after 30 days and all other files are persisted until they are manually deleted.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::FileObject]
      #
      # @see OpenAI::Models::FileCreateParams
      def create(params)
        parsed, options = OpenAI::FileCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "files",
          headers: {"content-type" => "multipart/form-data"},
          body: parsed,
          model: OpenAI::FileObject,
          security: {bearer_auth: true},
          options: options
        )
      end

      # Returns information about a specific file.
      #
      # @overload retrieve(file_id, request_options: {})
      #
      # @param file_id [String]
      #   The ID of the file to use for this request.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::FileObject]
      #
      # @see OpenAI::Models::FileRetrieveParams
      def retrieve(file_id, params = {})
        @client.request(
          method: :get,
          path: ["files/%1$s", file_id],
          model: OpenAI::FileObject,
          security: {bearer_auth: true},
          options: params[:request_options]
        )
      end

      # Returns a list of files.
      #
      # @overload list(after: nil, limit: nil, order: nil, purpose: nil, request_options: {})
      #
      # @param after [String]
      #   A cursor for use in pagination. `after` is an object ID that defines your place
      #   in the list. For instance, if you make a list request and receive 100 objects,
      #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
      #   fetch the next page of the list.
      #
      # @param limit [Integer]
      #   A limit on the number of objects to be returned. Limit can range between 1 and
      #   10,000, and the default is 10,000.
      #
      # @param order [Symbol, OpenAI::Models::FileListParams::Order]
      #   Sort order by the `created_at` timestamp of the objects. `asc` for ascending
      #   order and `desc` for descending order.
      #
      # @param purpose [String]
      #   Only return files with the given purpose.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::CursorPage<OpenAI::Models::FileObject>]
      #
      # @see OpenAI::Models::FileListParams
      def list(params = {})
        parsed, options = OpenAI::FileListParams.dump_request(params)
        query = OpenAI::Internal::Util.encode_query_params(parsed)
        @client.request(
          method: :get,
          path: "files",
          query: query,
          page: OpenAI::Internal::CursorPage,
          model: OpenAI::FileObject,
          security: {bearer_auth: true},
          options: options
        )
      end

      # Delete a file and remove it from all vector stores.
      #
      # @overload delete(file_id, request_options: {})
      #
      # @param file_id [String]
      #   The ID of the file to use for this request.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::FileDeleted]
      #
      # @see OpenAI::Models::FileDeleteParams
      def delete(file_id, params = {})
        @client.request(
          method: :delete,
          path: ["files/%1$s", file_id],
          model: OpenAI::FileDeleted,
          security: {bearer_auth: true},
          options: params[:request_options]
        )
      end

      # Returns a response containing the contents of the specified file.
      #
      # @overload content(file_id, request_options: {})
      #
      # @param file_id [String]
      #   The ID of the file to use for this request.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [StringIO]
      #
      # @see OpenAI::Models::FileContentParams
      def content(file_id, params = {})
        @client.request(
          method: :get,
          path: ["files/%1$s/content", file_id],
          headers: {"accept" => "application/binary"},
          model: StringIO,
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
