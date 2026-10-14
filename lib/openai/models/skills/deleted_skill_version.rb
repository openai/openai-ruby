# frozen_string_literal: true

module OpenAI
  module Models
    module Skills
      # @see OpenAI::Resources::Skills::Versions#delete
      class DeletedSkillVersion < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #
        #   @return [String]
        required :id, String

        # @!attribute deleted
        #
        #   @return [Boolean]
        required :deleted, OpenAI::Internal::Type::Boolean

        # @!attribute object
        #
        #   @return [Symbol, :"skill.version.deleted"]
        required :object, const: :"skill.version.deleted"

        # @!attribute version
        #   The deleted skill version.
        #
        #   @return [String]
        required :version, String

        # @!method initialize(id:, deleted:, version:, object: :"skill.version.deleted")
        #   @param id [String]
        #
        #   @param deleted [Boolean]
        #
        #   @param version [String] The deleted skill version.
        #
        #   @param object [Symbol, :"skill.version.deleted"]
      end
    end
  end
end
