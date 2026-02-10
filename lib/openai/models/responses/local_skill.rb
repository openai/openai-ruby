# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class LocalSkill < OpenAI::Internal::Type::BaseModel
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

        # @!attribute path
        #   The path to the directory containing the skill.
        #
        #   @return [String]
        required :path, String

        # @!method initialize(description:, name:, path:)
        #   @param description [String] The description of the skill.
        #
        #   @param name [String] The name of the skill.
        #
        #   @param path [String] The path to the directory containing the skill.
      end
    end
  end
end
