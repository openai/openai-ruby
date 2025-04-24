# frozen_string_literal: true

module OpenAI
  module Models
    module Uploads
      # @see OpenAI::Resources::Uploads::Parts#create
      class PartCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute data
        #   The chunk of bytes for this Part.
        #
        #   @return [Pathname, StringIO]
        required :data, OpenAI::Internal::Type::IOLike

        # @!method initialize(data:, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Uploads::PartCreateParams} for more details.
        #
        #   @param data [Pathname, StringIO] The chunk of bytes for this Part. ...
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
