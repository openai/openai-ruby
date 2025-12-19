# typed: strong

module OpenAI
  module Resources
    class Videos
      # Create a video
      sig do
        params(
          prompt: String,
          input_reference: OpenAI::Internal::FileInput,
          model: T.any(String, OpenAI::VideoModel::OrSymbol),
          seconds: OpenAI::VideoSeconds::OrSymbol,
          size: OpenAI::VideoSize::OrSymbol,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Video)
      end
      def create(
        # Text prompt that describes the video to generate.
        prompt:,
        # Optional image reference that guides generation.
        input_reference: nil,
        # The video generation model to use (allowed values: sora-2, sora-2-pro). Defaults
        # to `sora-2`.
        model: nil,
        # Clip duration in seconds (allowed values: 4, 8, 12). Defaults to 4 seconds.
        seconds: nil,
        # Output resolution formatted as width x height (allowed values: 720x1280,
        # 1280x720, 1024x1792, 1792x1024). Defaults to 720x1280.
        size: nil,
        request_options: {}
      )
      end

      # Retrieve a video
      sig do
        params(
          video_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Video)
      end
      def retrieve(
        # The identifier of the video to retrieve.
        video_id,
        request_options: {}
      )
      end

      # List videos
      sig do
        params(
          after: String,
          limit: Integer,
          order: OpenAI::VideoListParams::Order::OrSymbol,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Internal::ConversationCursorPage[OpenAI::Video])
      end
      def list(
        # Identifier for the last item from the previous pagination request
        after: nil,
        # Number of items to retrieve
        limit: nil,
        # Sort order of results by timestamp. Use `asc` for ascending order or `desc` for
        # descending order.
        order: nil,
        request_options: {}
      )
      end

      # Delete a video
      sig do
        params(
          video_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Models::VideoDeleteResponse)
      end
      def delete(
        # The identifier of the video to delete.
        video_id,
        request_options: {}
      )
      end

      # Download video content
      sig do
        params(
          video_id: String,
          variant: OpenAI::VideoDownloadContentParams::Variant::OrSymbol,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(StringIO)
      end
      def download_content(
        # The identifier of the video whose media to download.
        video_id,
        # Which downloadable asset to return. Defaults to the MP4 video.
        variant: nil,
        request_options: {}
      )
      end

      # Create a video remix
      sig do
        params(
          video_id: String,
          prompt: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Video)
      end
      def remix(
        # The identifier of the completed video to remix.
        video_id,
        # Updated text prompt that directs the remix generation.
        prompt:,
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
