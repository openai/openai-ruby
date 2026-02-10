# frozen_string_literal: true

module OpenAI
  module Models
    module Skills
      # @see OpenAI::Resources::Skills::Versions#retrieve
      class VersionRetrieveParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute skill_id
        #
        #   @return [String]
        required :skill_id, String

        # @!method initialize(skill_id:, request_options: {})
        #   @param skill_id [String]
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
