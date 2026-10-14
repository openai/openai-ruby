# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class HostedSkillReference < OpenAI::Internal::Type::BaseModel
        # @!attribute description
        #   The installed skill description.
        #
        #   @return [String]
        required :description, String

        # @!attribute name
        #   The installed skill name.
        #
        #   @return [String]
        required :name, String

        # @!attribute skill_id
        #   The referenced skill ID.
        #
        #   @return [String]
        required :skill_id, String

        # @!attribute type
        #   The type of the object. Always `skill_reference`.
        #
        #   @return [Symbol, :skill_reference]
        required :type, const: :skill_reference

        # @!attribute version
        #   The concrete skill version installed for this session.
        #
        #   @return [String]
        required :version, String

        # @!method initialize(description:, name:, skill_id:, version:, type: :skill_reference)
        #   A skill installed from the Skills API.
        #
        #   @param description [String]
        #     The installed skill description.
        #
        #   @param name [String]
        #     The installed skill name.
        #
        #   @param skill_id [String]
        #     The referenced skill ID.
        #
        #   @param version [String]
        #     The concrete skill version installed for this session.
        #
        #   @param type [Symbol, :skill_reference]
        #     The type of the object. Always `skill_reference`.
      end
    end
  end
end
