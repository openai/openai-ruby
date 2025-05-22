# frozen_string_literal: true

module OpenAI
  module Resources
    class Files
      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::FileCreateParams} for more details.
      #
      # Upload a file that can be used across various endpoints. Individual files can be
      # up to 512 MB, and the size of all files uploaded by one organization can be up
      # to 100 GB.
      #
      # The Assistants API supports files up to 2 million tokens and of specific file
      # types. See the
      # [Assistants Tools guide](https://platform.openai.com/docs/assistants/tools) for
      # details.
      #
      # The Fine-tuning API only supports `.jsonl` files. The input also has certain
      # required formats for fine-tuning
      # [chat](https://platform.openai.com/docs/api-reference/fine-tuning/chat-input) or
      # [completions](https://platform.openai.com/docs/api-reference/fine-tuning/completions-input)
      # models.
      #
      # The Batch API only supports `.jsonl` files up to 200 MB in size. The input also
      # has a specific required
      # [format](https://platform.openai.com/docs/api-reference/batch/request-input).
      #
      # Please [contact us](https://help.openai.com/) if you need to increase these
      # storage limits.
      #
      # @overload create(file:, purpose:, request_options: {})
      #
      # @param file [Pathname, StringIO, IO, String, OpenAI::FilePart] The File object (not file name) to be uploaded.
      #
      # @param purpose [Symbol, OpenAI::Models::FilePurpose] The intended purpose of the uploaded file. One of: - `assistants`: Used in the A
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
          options: options
        )
      end

      # Returns information about a specific file.
      #
      # @overload retrieve(file_id, request_options: {})
      #
      # @param file_id [String] The ID of the file to use for this request.
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
          options: params[:request_options]
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::FileListParams} for more details.
      #
      # Returns a list of files.
      #
      # @overload list(after: nil, limit: nil, order: nil, purpose: nil, request_options: {})
      #
      # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
      #
      # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
      #
      # @param order [Symbol, OpenAI::Models::FileListParams::Order] Sort order by the `created_at` timestamp of the objects. `asc` for ascending ord
      #
      # @param purpose [String] Only return files with the given purpose.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::CursorPage<OpenAI::Models::FileObject>]
      #
      # @see OpenAI::Models::FileListParams
      def list(params = {})
        parsed, options = OpenAI::FileListParams.dump_request(params)
        @client.request(
          method: :get,
          path: "files",
          query: parsed,
          page: OpenAI::Internal::CursorPage,
          model: OpenAI::FileObject,
          options: options
        )
      end

      # Delete a file.
      #
      # @overload delete(file_id, request_options: {})
      #
      # @param file_id [String] The ID of the file to use for this request.
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
          options: params[:request_options]
        )
      end

      # Returns the contents of the specified file.
      #
      # @overload content(file_id, request_options: {})
      #
      # @param file_id [String] The ID of the file to use for this request.
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
