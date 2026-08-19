# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Uploads#cancel
    class UploadCancelParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute upload_id
      #
      #   @return [String]
      required :upload_id, String

      # @!method initialize(upload_id:, request_options: {})
      #   @param upload_id [String]
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
