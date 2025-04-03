# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Files#delete
    class FileDeleteParams < OpenAI::Internal::Type::BaseModel
      # @!parse
      #   extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!parse
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(request_options: {}, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
    end
  end
end
