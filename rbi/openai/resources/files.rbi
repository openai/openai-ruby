# typed: strong

module OpenAI
  module Resources
    class Files
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
      sig do
        params(
          file: T.any(Pathname, StringIO, IO, OpenAI::FilePart),
          purpose: OpenAI::FilePurpose::OrSymbol,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::FileObject)
      end
      def create(
        # The File object (not file name) to be uploaded.
        file:,
        # The intended purpose of the uploaded file. One of: - `assistants`: Used in the
        # Assistants API - `batch`: Used in the Batch API - `fine-tune`: Used for
        # fine-tuning - `vision`: Images used for vision fine-tuning - `user_data`:
        # Flexible file type for any purpose - `evals`: Used for eval data sets
        purpose:,
        request_options: {}
      )
      end

      # Returns information about a specific file.
      sig do
        params(
          file_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::FileObject)
      end
      def retrieve(
        # The ID of the file to use for this request.
        file_id,
        request_options: {}
      )
      end

      # Returns a list of files.
      sig do
        params(
          after: String,
          limit: Integer,
          order: OpenAI::FileListParams::Order::OrSymbol,
          purpose: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Internal::CursorPage[OpenAI::FileObject])
      end
      def list(
        # A cursor for use in pagination. `after` is an object ID that defines your place
        # in the list. For instance, if you make a list request and receive 100 objects,
        # ending with obj_foo, your subsequent call can include after=obj_foo in order to
        # fetch the next page of the list.
        after: nil,
        # A limit on the number of objects to be returned. Limit can range between 1 and
        # 10,000, and the default is 10,000.
        limit: nil,
        # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
        # order and `desc` for descending order.
        order: nil,
        # Only return files with the given purpose.
        purpose: nil,
        request_options: {}
      )
      end

      # Delete a file.
      sig do
        params(
          file_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::FileDeleted)
      end
      def delete(
        # The ID of the file to use for this request.
        file_id,
        request_options: {}
      )
      end

      # Returns the contents of the specified file.
      sig do
        params(
          file_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(StringIO)
      end
      def content(
        # The ID of the file to use for this request.
        file_id,
        request_options: {}
      )
      end

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
