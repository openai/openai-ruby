# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::AdminAPIKeys#create
        class AdminAPIKeyCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute name
          #
          #   @return [String]
          required :name, String

          # @!method initialize(name:, request_options: {})
          #   @param name [String]
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
