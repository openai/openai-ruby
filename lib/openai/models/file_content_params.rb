# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Files#content
    class FileContentParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute file_id
      #
      #   @return [String]
      required :file_id, String

      # @!method initialize(file_id:, request_options: {})
      #   @param file_id [String]
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
