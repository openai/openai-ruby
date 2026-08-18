# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Videos#download_content
    class VideoDownloadContentParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute video_id
      #
      #   @return [String]
      required :video_id, String

      # @!attribute variant
      #   Which downloadable asset to return. Defaults to the MP4 video.
      #
      #   @return [Symbol, OpenAI::Models::VideoDownloadContentParams::Variant, nil]
      optional :variant, enum: -> { OpenAI::VideoDownloadContentParams::Variant }

      # @!method initialize(video_id:, variant: nil, request_options: {})
      #   @param video_id [String]
      #
      #   @param variant [Symbol, OpenAI::Models::VideoDownloadContentParams::Variant] Which downloadable asset to return. Defaults to the MP4 video.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # Which downloadable asset to return. Defaults to the MP4 video.
      module Variant
        extend OpenAI::Internal::Type::Enum

        VIDEO = :video
        THUMBNAIL = :thumbnail
        SPRITESHEET = :spritesheet

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
