# typed: strong

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
      sig do
        params(
          file: T.any(IO, StringIO),
          purpose: Symbol,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::FileObject)
      end
      def create(file:, purpose:, request_options: {})
      end

      # Returns information about a specific file.
      sig do
        params(
          file_id: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::FileObject)
      end
      def retrieve(file_id, request_options: {})
      end

      # Returns a list of files.
      sig do
        params(
          after: String,
          limit: Integer,
          order: Symbol,
          purpose: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::CursorPage[OpenAI::Models::FileObject])
      end
      def list(after: nil, limit: nil, order: nil, purpose: nil, request_options: {})
      end

      # Delete a file.
      sig do
        params(
          file_id: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::FileDeleted)
      end
      def delete(file_id, request_options: {})
      end

      # Returns the contents of the specified file.
      sig do
        params(
          file_id: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(T.anything)
      end
      def content(file_id, request_options: {})
      end

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
