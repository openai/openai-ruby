# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Videos#edit
    class VideoEditParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute prompt
      #   Text prompt that describes how to edit the source video.
      #
      #   @return [String]
      required :prompt, String

      # @!attribute video
      #   Reference to the completed video to edit.
      #
      #   @return [Pathname, StringIO, IO, String, OpenAI::FilePart, OpenAI::Models::VideoEditParams::Video::VideoReferenceInputParam]
      required :video, union: -> { OpenAI::VideoEditParams::Video }

      # @!method initialize(prompt:, video:, request_options: {})
      #   @param prompt [String] Text prompt that describes how to edit the source video.
      #
      #   @param video [Pathname, StringIO, IO, String, OpenAI::FilePart, OpenAI::Models::VideoEditParams::Video::VideoReferenceInputParam] Reference to the completed video to edit.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # Reference to the completed video to edit.
      module Video
        extend OpenAI::Internal::Type::Union

        # Reference to the completed video to edit.
        variant OpenAI::Internal::Type::FileInput

        # Reference to the completed video.
        variant -> { OpenAI::VideoEditParams::Video::VideoReferenceInputParam }

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
        #   @return [Array(StringIO, OpenAI::Models::VideoEditParams::Video::VideoReferenceInputParam)]
      end
    end
  end
end
