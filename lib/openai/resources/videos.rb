# frozen_string_literal: true

module OpenAI
  module Resources
    class Videos
      # @return [OpenAI::Resources::Videos::Character]
      attr_reader :character

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::VideoCreateParams} for more details.
      #
      # Create a new video generation job from a prompt and optional reference assets.
      #
      # @overload create(prompt:, input_reference: nil, model: nil, seconds: nil, size: nil, request_options: {})
      #
      # @param prompt [String] Text prompt that describes the video to generate.
      #
      # @param input_reference [Pathname, StringIO, IO, String, OpenAI::FilePart, OpenAI::Models::VideoCreateParams::InputReference::ImageRefParam2] Optional reference asset upload or reference object that guides generation.
      #
      # @param model [String, Symbol, OpenAI::Models::VideoModel] The video generation model to use (allowed values: sora-2, sora-2-pro). Defaults
      #
      # @param seconds [Symbol, OpenAI::Models::VideoSeconds] Clip duration in seconds (allowed values: 4, 8, 12). Defaults to 4 seconds.
      #
      # @param size [Symbol, OpenAI::Models::VideoSize] Output resolution formatted as width x height (allowed values: 720x1280, 1280x72
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Video]
      #
      # @see OpenAI::Models::VideoCreateParams
      def create(params)
        parsed, options = OpenAI::VideoCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "videos",
          headers: {"content-type" => "multipart/form-data"},
          body: parsed,
          model: OpenAI::Video,
          options: options
        )
      end

      # Fetch the latest metadata for a generated video.
      #
      # @overload retrieve(video_id, request_options: {})
      #
      # @param video_id [String] The identifier of the video to retrieve.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Video]
      #
      # @see OpenAI::Models::VideoRetrieveParams
      def retrieve(video_id, params = {})
        @client.request(
          method: :get,
          path: ["videos/%1$s", video_id],
          model: OpenAI::Video,
          options: params[:request_options]
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::VideoListParams} for more details.
      #
      # List recently generated videos for the current project.
      #
      # @overload list(after: nil, limit: nil, order: nil, request_options: {})
      #
      # @param after [String] Identifier for the last item from the previous pagination request
      #
      # @param limit [Integer] Number of items to retrieve
      #
      # @param order [Symbol, OpenAI::Models::VideoListParams::Order] Sort order of results by timestamp. Use `asc` for ascending order or `desc` for
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Video>]
      #
      # @see OpenAI::Models::VideoListParams
      def list(params = {})
        parsed, options = OpenAI::VideoListParams.dump_request(params)
        query = OpenAI::Internal::Util.encode_query_params(parsed)
        @client.request(
          method: :get,
          path: "videos",
          query: query,
          page: OpenAI::Internal::ConversationCursorPage,
          model: OpenAI::Video,
          options: options
        )
      end

      # Permanently delete a completed or failed video and its stored assets.
      #
      # @overload delete(video_id, request_options: {})
      #
      # @param video_id [String] The identifier of the video to delete.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::VideoDeleteResponse]
      #
      # @see OpenAI::Models::VideoDeleteParams
      def delete(video_id, params = {})
        @client.request(
          method: :delete,
          path: ["videos/%1$s", video_id],
          model: OpenAI::Models::VideoDeleteResponse,
          options: params[:request_options]
        )
      end

      # Download the generated video bytes or a derived preview asset.
      #
      # Streams the rendered video content for the specified video job.
      #
      # @overload download_content(video_id, variant: nil, request_options: {})
      #
      # @param video_id [String] The identifier of the video whose media to download.
      #
      # @param variant [Symbol, OpenAI::Models::VideoDownloadContentParams::Variant] Which downloadable asset to return. Defaults to the MP4 video.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [StringIO]
      #
      # @see OpenAI::Models::VideoDownloadContentParams
      def download_content(video_id, params = {})
        parsed, options = OpenAI::VideoDownloadContentParams.dump_request(params)
        query = OpenAI::Internal::Util.encode_query_params(parsed)
        @client.request(
          method: :get,
          path: ["videos/%1$s/content", video_id],
          query: query,
          headers: {"accept" => "application/binary"},
          model: StringIO,
          options: options
        )
      end

      # Create a new video generation job by editing a source video or existing
      # generated video.
      #
      # @overload edit(prompt:, video:, request_options: {})
      #
      # @param prompt [String] Text prompt that describes how to edit the source video.
      #
      # @param video [Pathname, StringIO, IO, String, OpenAI::FilePart, OpenAI::Models::VideoEditParams::Video::VideoReferenceInputParam] Reference to the completed video to edit.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Video]
      #
      # @see OpenAI::Models::VideoEditParams
      def edit(params)
        parsed, options = OpenAI::VideoEditParams.dump_request(params)
        @client.request(
          method: :post,
          path: "videos/edits",
          headers: {"content-type" => "multipart/form-data"},
          body: parsed,
          model: OpenAI::Video,
          options: options
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::VideoExtendParams} for more details.
      #
      # Create an extension of a completed video.
      #
      # @overload extend_(prompt:, seconds:, video:, request_options: {})
      #
      # @param prompt [String] Updated text prompt that directs the extension generation.
      #
      # @param seconds [Symbol, OpenAI::Models::VideoSeconds] Length of the newly generated extension segment in seconds (allowed values: 4, 8
      #
      # @param video [OpenAI::Models::VideoExtendParams::Video::VideoReferenceInputParam, Pathname, StringIO, IO, String, OpenAI::FilePart] Reference to the completed video.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Video]
      #
      # @see OpenAI::Models::VideoExtendParams
      def extend_(params)
        parsed, options = OpenAI::VideoExtendParams.dump_request(params)
        @client.request(
          method: :post,
          path: "videos/extensions",
          headers: {"content-type" => "multipart/form-data"},
          body: parsed,
          model: OpenAI::Video,
          options: options
        )
      end

      # Create a remix of a completed video using a refreshed prompt.
      #
      # @overload remix(video_id, prompt:, request_options: {})
      #
      # @param video_id [String] The identifier of the completed video to remix.
      #
      # @param prompt [String] Updated text prompt that directs the remix generation.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Video]
      #
      # @see OpenAI::Models::VideoRemixParams
      def remix(video_id, params)
        parsed, options = OpenAI::VideoRemixParams.dump_request(params)
        @client.request(
          method: :post,
          path: ["videos/%1$s/remix", video_id],
          headers: {"content-type" => "multipart/form-data"},
          body: parsed,
          model: OpenAI::Video,
          options: options
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @character = OpenAI::Resources::Videos::Character.new(client: client)
      end
    end
  end
end
