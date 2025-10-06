# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Videos#retrieve
    class VideoRetrieveParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!method initialize(request_options: {})
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
