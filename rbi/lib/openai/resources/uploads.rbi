# typed: strong

module OpenAI
  module Resources
    class Uploads
      sig { returns(OpenAI::Resources::Uploads::Parts) }
      def parts
      end

      sig do
        params(
          bytes: Integer,
          filename: String,
          mime_type: String,
          purpose: Symbol,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::Upload)
      end
      def create(bytes:, filename:, mime_type:, purpose:, request_options: {})
      end

      sig do
        params(
          upload_id: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::Upload)
      end
      def cancel(upload_id, request_options: {})
      end

      sig do
        params(
          upload_id: String,
          part_ids: T::Array[String],
          md5: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::Upload)
      end
      def complete(upload_id, part_ids:, md5: nil, request_options: {})
      end

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
