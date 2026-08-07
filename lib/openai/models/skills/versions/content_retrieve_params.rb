# frozen_string_literal: true

module OpenAI
  module Models
    module Skills
      module Versions
        # @see OpenAI::Resources::Skills::Versions::Content#retrieve
        class ContentRetrieveParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute skill_id
          #
          #   @return [String]
          required :skill_id, String

          # @!attribute version
          #   The skill version number.
          #
          #   @return [String]
          required :version, String

          # @!method initialize(skill_id:, version:, request_options: {})
          #   @param skill_id [String]
          #
          #   @param version [String] The skill version number.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
