# typed: strong

module OpenAI
  module Resources
    class Videos
      # Create a new video generation job from a prompt and optional reference assets.
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
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Video)
      end
      def create(
        # Text prompt that describes the video to generate.
        prompt:,
        # Optional reference asset upload or reference object that guides generation.
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

      # Fetch the latest metadata for a generated video.
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

      # List recently generated videos for the current project.
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

      # Permanently delete a completed or failed video and its stored assets.
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

      # Create a character from an uploaded video.
      sig do
        params(
          name: String,
          video: OpenAI::Internal::FileInput,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Models::VideoCreateCharacterResponse)
      end
      def create_character(
        # Display name for this API character.
        name:,
        # Video file used to create a character.
        video:,
        request_options: {}
      )
      end

      # Download the generated video bytes or a derived preview asset.
      #
      # Streams the rendered video content for the specified video job.
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

      # Create a new video generation job by editing a source video or existing
      # generated video.
      sig do
        params(
          prompt: String,
          video:
            T.any(
              OpenAI::Internal::FileInput,
              OpenAI::VideoEditParams::Video::VideoReferenceInputParam::OrHash
            ),
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Video)
      end
      def edit(
        # Text prompt that describes how to edit the source video.
        prompt:,
        # Reference to the completed video to edit.
        video:,
        request_options: {}
      )
      end

      # Create an extension of a completed video.
      sig do
        params(
          prompt: String,
          seconds: OpenAI::VideoSeconds::OrSymbol,
          video:
            T.any(
              OpenAI::Internal::FileInput,
              OpenAI::VideoExtendParams::Video::VideoReferenceInputParam::OrHash
            ),
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Video)
      end
      def extend_(
        # Updated text prompt that directs the extension generation.
        prompt:,
        # Length of the newly generated extension segment in seconds (allowed values: 4,
        # 8, 12, 16, 20).
        seconds:,
        # Reference to the completed video to extend.
        video:,
        request_options: {}
      )
      end

      # Fetch a character.
      sig do
        params(
          character_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Models::VideoGetCharacterResponse)
      end
      def get_character(
        # The identifier of the character to retrieve.
        character_id,
        request_options: {}
      )
      end

      # Create a remix of a completed video using a refreshed prompt.
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
