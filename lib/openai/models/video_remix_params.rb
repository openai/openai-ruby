# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Videos#remix
    class VideoRemixParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute video_id
      #
      #   @return [String]
      required :video_id, String

      # @!attribute prompt
      #   Updated text prompt that directs the remix generation.
      #
      #   @return [String]
      required :prompt, String

      # @!method initialize(video_id:, prompt:, request_options: {})
      #   @param video_id [String]
      #
      #   @param prompt [String] Updated text prompt that directs the remix generation.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
