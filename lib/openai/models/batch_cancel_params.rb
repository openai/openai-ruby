# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Batches#cancel
    class BatchCancelParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute batch_id
      #
      #   @return [String]
      required :batch_id, String

      # @!method initialize(batch_id:, request_options: {})
      #   @param batch_id [String]
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
