# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseRetrieveParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::Type::RequestParameters::Converter
        include OpenAI::RequestParameters

        # @!attribute [r] include
        #   Additional fields to include in the response. See the `include` parameter for
        #     Response creation above for more information.
        #
        #   @return [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil]
        optional :include, -> { OpenAI::ArrayOf[enum: OpenAI::Models::Responses::ResponseIncludable] }

        # @!parse
        #   # @return [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>]
        #   attr_writer :include

        # @!parse
        #   # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(include: nil, request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
