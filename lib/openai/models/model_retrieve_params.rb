# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Models#retrieve
    class ModelRetrieveParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute model
      #
      #   @return [String]
      required :model, String

      # @!method initialize(model:, request_options: {})
      #   @param model [String]
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
