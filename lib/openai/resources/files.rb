# frozen_string_literal: true

module OpenAI
  module Resources
    class Files
      # Upload a file that can be used across various endpoints. Individual files can be
      #   up to 512 MB, and the size of all files uploaded by one organization can be up
      #   to 100 GB.
      #
      #   The Assistants API supports files up to 2 million tokens and of specific file
      #   types. See the
      #   [Assistants Tools guide](https://platform.openai.com/docs/assistants/tools) for
      #   details.
      #
      #   The Fine-tuning API only supports `.jsonl` files. The input also has certain
      #   required formats for fine-tuning
      #   [chat](https://platform.openai.com/docs/api-reference/fine-tuning/chat-input) or
      #   [completions](https://platform.openai.com/docs/api-reference/fine-tuning/completions-input)
      #   models.
      #
      #   The Batch API only supports `.jsonl` files up to 200 MB in size. The input also
      #   has a specific required
      #   [format](https://platform.openai.com/docs/api-reference/batch/request-input).
      #
      #   Please [contact us](https://help.openai.com/) if you need to increase these
      #   storage limits.
      #
      # @param params [OpenAI::Models::FileCreateParams, Hash{Symbol=>Object}] .
      #
      #   @option params [IO, StringIO] :file The File object (not file name) to be uploaded.
      #
      #   @option params [Symbol, OpenAI::Models::FilePurpose] :purpose The intended purpose of the uploaded file. One of: - `assistants`: Used in the
      #     Assistants API - `batch`: Used in the Batch API - `fine-tune`: Used for
      #     fine-tuning - `vision`: Images used for vision fine-tuning - `user_data`:
      #     Flexible file type for any purpose - `evals`: Used for eval data sets
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::FileObject]
      def create(params)
        parsed, options = OpenAI::Models::FileCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "files",
          headers: {"content-type" => "multipart/form-data"},
          body: parsed,
          model: OpenAI::Models::FileObject,
          options: options
        )
      end

      # Returns information about a specific file.
      #
      # @param file_id [String] The ID of the file to use for this request.
      #
      # @param params [OpenAI::Models::FileRetrieveParams, Hash{Symbol=>Object}] .
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::FileObject]
      def retrieve(file_id, params = {})
        @client.request(
          method: :get,
          path: ["files/%1$s", file_id],
          model: OpenAI::Models::FileObject,
          options: params[:request_options]
        )
      end

      # Returns a list of files.
      #
      # @param params [OpenAI::Models::FileListParams, Hash{Symbol=>Object}] .
      #
      #   @option params [String] :after A cursor for use in pagination. `after` is an object ID that defines your place
      #     in the list. For instance, if you make a list request and receive 100 objects,
      #     ending with obj_foo, your subsequent call can include after=obj_foo in order to
      #     fetch the next page of the list.
      #
      #   @option params [Integer] :limit A limit on the number of objects to be returned. Limit can range between 1 and
      #     10,000, and the default is 10,000.
      #
      #   @option params [Symbol, OpenAI::Models::FileListParams::Order] :order Sort order by the `created_at` timestamp of the objects. `asc` for ascending
      #     order and `desc` for descending order.
      #
      #   @option params [String] :purpose Only return files with the given purpose.
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::CursorPage<OpenAI::Models::FileObject>]
      def list(params = {})
        parsed, options = OpenAI::Models::FileListParams.dump_request(params)
        @client.request(
          method: :get,
          path: "files",
          query: parsed,
          page: OpenAI::CursorPage,
          model: OpenAI::Models::FileObject,
          options: options
        )
      end

      # Delete a file.
      #
      # @param file_id [String] The ID of the file to use for this request.
      #
      # @param params [OpenAI::Models::FileDeleteParams, Hash{Symbol=>Object}] .
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::FileDeleted]
      def delete(file_id, params = {})
        @client.request(
          method: :delete,
          path: ["files/%1$s", file_id],
          model: OpenAI::Models::FileDeleted,
          options: params[:request_options]
        )
      end

      # Returns the contents of the specified file.
      #
      # @param file_id [String] The ID of the file to use for this request.
      #
      # @param params [OpenAI::Models::FileContentParams, Hash{Symbol=>Object}] .
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [StringIO]
      def content(file_id, params = {})
        @client.request(
          method: :get,
          path: ["files/%1$s/content", file_id],
          headers: {"accept" => "application/binary"},
          model: StringIO,
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
