# typed: strong

module OpenAI
  module Resources
    class Batches
      sig do
        params(
          completion_window: Symbol,
          endpoint: Symbol,
          input_file_id: String,
          metadata: T.nilable(OpenAI::Models::Metadata),
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::Batch)
      end
      def create(completion_window:, endpoint:, input_file_id:, metadata: nil, request_options: {})
      end

      sig do
        params(
          batch_id: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::Batch)
      end
      def retrieve(batch_id, request_options: {})
      end

      sig do
        params(
          after: String,
          limit: Integer,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::CursorPage[OpenAI::Models::Batch])
      end
      def list(after: nil, limit: nil, request_options: {})
      end

      sig do
        params(
          batch_id: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::Batch)
      end
      def cancel(batch_id, request_options: {})
      end

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
