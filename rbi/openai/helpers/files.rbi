# typed: strong

module OpenAI
  module Resources
    class Files
      # Wait for an uploaded file to finish processing.
      sig do
        params(
          file_id: String,
          poll_interval: T.nilable(T.any(Integer, Float)),
          timeout: T.nilable(T.any(Integer, Float)),
          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(OpenAI::FileObject)
      end
      def wait_for_processing(
        file_id,
        poll_interval: nil,
        timeout: OpenAI::Internal::Poller::DEFAULT_TIMEOUT,
        request_options: {}
      )
      end
    end
  end
end
