# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Skills#update
    class SkillUpdateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute skill_id
      #
      #   @return [String]
      required :skill_id, String

      # @!attribute default_version
      #   The skill version number to set as default.
      #
      #   @return [String]
      required :default_version, String

      # @!method initialize(skill_id:, default_version:, request_options: {})
      #   @param skill_id [String]
      #
      #   @param default_version [String] The skill version number to set as default.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
