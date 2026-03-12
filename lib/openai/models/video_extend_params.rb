# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Videos#extend_
    class VideoExtendParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute prompt
      #   Updated text prompt that directs the extension generation.
      #
      #   @return [String]
      required :prompt, String

      # @!attribute seconds
      #   Length of the newly generated extension segment in seconds (allowed values: 4,
      #   8, 12, 16, 20).
      #
      #   @return [Symbol, OpenAI::Models::VideoSeconds]
      required :seconds, enum: -> { OpenAI::VideoSeconds }

      # @!attribute video
      #   Reference to the completed video.
      #
      #   @return [OpenAI::Models::VideoExtendParams::Video::VideoReferenceInputParam, Pathname, StringIO, IO, String, OpenAI::FilePart]
      required :video, union: -> { OpenAI::VideoExtendParams::Video }

      # @!method initialize(prompt:, seconds:, video:, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::VideoExtendParams} for more details.
      #
      #   @param prompt [String] Updated text prompt that directs the extension generation.
      #
      #   @param seconds [Symbol, OpenAI::Models::VideoSeconds] Length of the newly generated extension segment in seconds (allowed values: 4, 8
      #
      #   @param video [OpenAI::Models::VideoExtendParams::Video::VideoReferenceInputParam, Pathname, StringIO, IO, String, OpenAI::FilePart] Reference to the completed video.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # Reference to the completed video.
      module Video
        extend OpenAI::Internal::Type::Union

        # Reference to the completed video.
        variant -> { OpenAI::VideoExtendParams::Video::VideoReferenceInputParam }

        # Reference to the completed video to extend.
        variant OpenAI::Internal::Type::FileInput

        class VideoReferenceInputParam < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The identifier of the completed video.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   Reference to the completed video.
          #
          #   @param id [String] The identifier of the completed video.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::VideoExtendParams::Video::VideoReferenceInputParam, StringIO)]
      end
    end
  end
end
