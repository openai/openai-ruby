# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # A skill installed in an OpenAI-hosted environment.
      module HostedSkill
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A skill installed from the Skills API.
        variant :skill_reference, -> { OpenAI::Beta::HostedSkillReference }

        # A skill installed from an inline ZIP archive.
        variant :inline, -> { OpenAI::Beta::HostedSkill::Inline }

        class Inline < OpenAI::Internal::Type::BaseModel
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

          # @!attribute type
          #   The type of the object. Always `inline`.
          #
          #   @return [Symbol, :inline]
          required :type, const: :inline

          # @!method initialize(description:, name:, type: :inline)
          #   A skill installed from an inline ZIP archive.
          #
          #   @param description [String]
          #     The installed skill description.
          #
          #   @param name [String]
          #     The installed skill name.
          #
          #   @param type [Symbol, :inline]
          #     The type of the object. Always `inline`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::HostedSkillReference, OpenAI::Models::Beta::HostedSkill::Inline)]
      end
    end
  end
end
