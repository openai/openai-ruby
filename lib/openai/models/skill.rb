# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Skills#create
    class Skill < OpenAI::Internal::Type::BaseModel
      # @!attribute id
      #   Unique identifier for the skill.
      #
      #   @return [String]
      required :id, String

      # @!attribute created_at
      #   Unix timestamp (seconds) for when the skill was created.
      #
      #   @return [Integer]
      required :created_at, Integer

      # @!attribute default_version
      #   Default version for the skill.
      #
      #   @return [String]
      required :default_version, String

      # @!attribute description
      #   Description of the skill.
      #
      #   @return [String]
      required :description, String

      # @!attribute latest_version
      #   Latest version for the skill.
      #
      #   @return [String]
      required :latest_version, String

      # @!attribute name
      #   Name of the skill.
      #
      #   @return [String]
      required :name, String

      # @!attribute object
      #   The object type, which is `skill`.
      #
      #   @return [Symbol, :skill]
      required :object, const: :skill

      # @!method initialize(id:, created_at:, default_version:, description:, latest_version:, name:, object: :skill)
      #   @param id [String] Unique identifier for the skill.
      #
      #   @param created_at [Integer] Unix timestamp (seconds) for when the skill was created.
      #
      #   @param default_version [String] Default version for the skill.
      #
      #   @param description [String] Description of the skill.
      #
      #   @param latest_version [String] Latest version for the skill.
      #
      #   @param name [String] Name of the skill.
      #
      #   @param object [Symbol, :skill] The object type, which is `skill`.
    end
  end
end
