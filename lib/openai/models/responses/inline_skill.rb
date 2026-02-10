# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class InlineSkill < OpenAI::Internal::Type::BaseModel
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
        #   @return [OpenAI::Models::Responses::InlineSkillSource]
        required :source, -> { OpenAI::Responses::InlineSkillSource }

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
        #   @param source [OpenAI::Models::Responses::InlineSkillSource] Inline skill payload
        #
        #   @param type [Symbol, :inline] Defines an inline skill for this request.
      end
    end
  end
end
