# typed: strong

module OpenAI
  module Internal
    # @api private
    class VectorStoreFileUploader
      sig do
        params(
          client: OpenAI::Client,
          max_concurrency: Integer,
          request_options: T.nilable(OpenAI::RequestOptions::OrHash)
        ).returns(T.attached_class)
      end
      def self.new(client:, max_concurrency:, request_options:)
      end

      sig do
        params(files: T::Enumerable[OpenAI::Internal::FileInput])
          .returns(T::Array[OpenAI::Models::FileObject])
      end
      def upload(files)
      end
    end
  end
end
