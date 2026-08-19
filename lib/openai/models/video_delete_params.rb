# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Videos#delete
    class VideoDeleteParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute video_id
      #
      #   @return [String]
      required :video_id, String

      # @!method initialize(video_id:, request_options: {})
      #   @param video_id [String]
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
