# typed: strong

module OpenAI
  module Resources
    class Files
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

      sig do
        params(
          file_id: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::FileObject)
      end
      def retrieve(file_id, request_options: {})
      end

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

      sig do
        params(
          file_id: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::FileDeleted)
      end
      def delete(file_id, request_options: {})
      end

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
