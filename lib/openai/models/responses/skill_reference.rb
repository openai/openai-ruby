# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class SkillReference < OpenAI::Internal::Type::BaseModel
        # @!attribute skill_id
        #   The ID of the referenced skill.
        #
        #   @return [String]
        required :skill_id, String

        # @!attribute type
        #   References a skill created with the /v1/skills endpoint.
        #
        #   @return [Symbol, :skill_reference]
        required :type, const: :skill_reference

        # @!attribute version
        #   Optional skill version. Use a positive integer or 'latest'. Omit for default.
        #
        #   @return [String, nil]
        optional :version, String

        # @!method initialize(skill_id:, version: nil, type: :skill_reference)
        #   @param skill_id [String] The ID of the referenced skill.
        #
        #   @param version [String] Optional skill version. Use a positive integer or 'latest'. Omit for default.
        #
        #   @param type [Symbol, :skill_reference] References a skill created with the /v1/skills endpoint.
      end
    end
  end
end
