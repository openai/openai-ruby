# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaInlineSkill < OpenAI::Internal::Type::BaseModel
        # @!attribute description
        #   The description of the skill.
        #
        #   @return [String]
        required :description, String

        # @!attribute name
        #   The name of the skill.
        #
        #   @return [String]
        required :name, String

        # @!attribute source
        #   Inline skill payload
        #
        #   @return [OpenAI::Models::Beta::BetaInlineSkillSource]
        required :source, -> { OpenAI::Beta::BetaInlineSkillSource }

        # @!attribute type
        #   Defines an inline skill for this request.
        #
        #   @return [Symbol, :inline]
        required :type, const: :inline

        # @!method initialize(description:, name:, source:, type: :inline)
        #   @param description [String] The description of the skill.
        #
        #   @param name [String] The name of the skill.
        #
        #   @param source [OpenAI::Models::Beta::BetaInlineSkillSource] Inline skill payload
        #
        #   @param type [Symbol, :inline] Defines an inline skill for this request.
      end
    end

    BetaInlineSkill = Beta::BetaInlineSkill
  end
end
