# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @see OpenAI::Resources::Responses#retrieve
      class ResponseRetrieveParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute include
        #   Additional fields to include in the response. See the `include` parameter for
        #   Response creation above for more information.
        #
        #   @return [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil]
        optional :include,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Models::Responses::ResponseIncludable] }

        # @!method initialize(include: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseRetrieveParams} for more details.
        #
        #   @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>] Additional fields to include in the response. See the `include` ...
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
