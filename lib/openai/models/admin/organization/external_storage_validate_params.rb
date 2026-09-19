# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::ExternalStorage#validate
        class ExternalStorageValidateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute external_storage_id
          #
          #   @return [String]
          required :external_storage_id, String

          # @!method initialize(external_storage_id:, request_options: {})
          #   @param external_storage_id [String]
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
