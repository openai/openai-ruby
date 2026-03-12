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
      #   Reference to the completed video to extend.
      #
      #   @return [OpenAI::Models::VideoExtendParams::Video]
      required :video, -> { OpenAI::VideoExtendParams::Video }

      # @!method initialize(prompt:, seconds:, video:, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::VideoExtendParams} for more details.
      #
      #   @param prompt [String] Updated text prompt that directs the extension generation.
      #
      #   @param seconds [Symbol, OpenAI::Models::VideoSeconds] Length of the newly generated extension segment in seconds (allowed values: 4, 8
      #
      #   @param video [OpenAI::Models::VideoExtendParams::Video] Reference to the completed video to extend.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      class Video < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The identifier of the completed video.
        #
        #   @return [String]
        required :id, String

        # @!method initialize(id:)
        #   Reference to the completed video to extend.
        #
        #   @param id [String] The identifier of the completed video.
      end
    end
  end
end
