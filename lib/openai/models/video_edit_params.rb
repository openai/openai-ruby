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
      #   @return [OpenAI::Models::VideoEditParams::Video]
      required :video, -> { OpenAI::VideoEditParams::Video }

      # @!method initialize(prompt:, video:, request_options: {})
      #   @param prompt [String] Text prompt that describes how to edit the source video.
      #
      #   @param video [OpenAI::Models::VideoEditParams::Video] Reference to the completed video to edit.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      class Video < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The identifier of the completed video.
        #
        #   @return [String]
        required :id, String

        # @!method initialize(id:)
        #   Reference to the completed video to edit.
        #
        #   @param id [String] The identifier of the completed video.
      end
    end
  end
end
