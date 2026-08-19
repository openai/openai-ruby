# frozen_string_literal: true

module OpenAI
  module Models
    module Skills
      # @see OpenAI::Resources::Skills::Versions#create
      class SkillVersion < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   Unique identifier for the skill version.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   Unix timestamp (seconds) for when the version was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute description
        #   Description of the skill version.
        #
        #   @return [String]
        required :description, String

        # @!attribute name
        #   Name of the skill version.
        #
        #   @return [String]
        required :name, String

        # @!attribute object
        #   The object type, which is `skill.version`.
        #
        #   @return [Symbol, :"skill.version"]
        required :object, const: :"skill.version"

        # @!attribute skill_id
        #   Identifier of the skill for this version.
        #
        #   @return [String]
        required :skill_id, String

        # @!attribute version
        #   Version number for this skill.
        #
        #   @return [String]
        required :version, String

        # @!method initialize(id:, created_at:, description:, name:, skill_id:, version:, object: :"skill.version")
        #   @param id [String] Unique identifier for the skill version.
        #
        #   @param created_at [Integer] Unix timestamp (seconds) for when the version was created.
        #
        #   @param description [String] Description of the skill version.
        #
        #   @param name [String] Name of the skill version.
        #
        #   @param skill_id [String] Identifier of the skill for this version.
        #
        #   @param version [String] Version number for this skill.
        #
        #   @param object [Symbol, :"skill.version"] The object type, which is `skill.version`.
      end
    end

    SkillVersion = Skills::SkillVersion
  end
end
