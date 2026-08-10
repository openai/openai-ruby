# typed: strong

module OpenAI
  module Resources
    class Videos
      # Create a video and wait for it to reach a terminal state.
      sig do
        params(
          prompt: String,
          input_reference:
            T.any(
              OpenAI::Internal::FileInput,
              OpenAI::ImageInputReferenceParam::OrHash
            ),
          model: T.any(String, OpenAI::VideoModel::OrSymbol),
          seconds: OpenAI::VideoSeconds::OrSymbol,
          size: OpenAI::VideoSize::OrSymbol,
          poll_interval: T.nilable(Numeric),
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Video)
      end
      def create_and_poll(
        prompt:,
        input_reference: nil,
        model: nil,
        seconds: nil,
        size: nil,
        poll_interval: nil,
        request_options: {}
      )
      end

      # Wait for a video to reach a terminal state.
      sig do
        params(
          video_id: String,
          poll_interval: T.nilable(Numeric),
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Video)
      end
      def poll(video_id, poll_interval: nil, request_options: {})
      end
    end
  end
end
