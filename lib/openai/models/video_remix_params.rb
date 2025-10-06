# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Videos#remix
    class VideoRemixParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute prompt
      #   Updated text prompt that directs the remix generation.
      #
      #   @return [String]
      required :prompt, String

      # @!method initialize(prompt:, request_options: {})
      #   @param prompt [String] Updated text prompt that directs the remix generation.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
