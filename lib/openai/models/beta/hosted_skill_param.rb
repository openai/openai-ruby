# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # A skill installed in an OpenAI-hosted environment.
      module HostedSkillParam
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # References a skill uploaded through the Skills API.
        variant :skill_reference, -> { OpenAI::Beta::HostedSkillParam::SkillReference }

        # Supplies a skill ZIP directly in the session request.
        variant :inline, -> { OpenAI::Beta::HostedSkillParam::Inline }

        class SkillReference < OpenAI::Internal::Type::BaseModel
          # @!attribute skill_id
          #   The ID of the skill created through `/v1/skills`.
          #
          #   @return [String]
          required :skill_id, String

          # @!attribute type
          #   The type of the object. Always `skill_reference`.
          #
          #   @return [Symbol, :skill_reference]
          required :type, const: :skill_reference

          # @!attribute version
          #   The skill version, a positive integer or `latest`; omission selects the default.
          #
          #   @return [String, nil]
          optional :version, String, nil?: true

          # @!method initialize(skill_id:, version: nil, type: :skill_reference)
          #   References a skill uploaded through the Skills API.
          #
          #   @param skill_id [String]
          #     The ID of the skill created through `/v1/skills`.
          #
          #   @param version [String, nil]
          #     The skill version, a positive integer or `latest`; omission selects the default.
          #
          #   @param type [Symbol, :skill_reference]
          #     The type of the object. Always `skill_reference`.
        end

        class Inline < OpenAI::Internal::Type::BaseModel
          # @!attribute description
          #   The skill description declared in `SKILL.md`.
          #
          #   @return [String]
          required :description, String

          # @!attribute name
          #   The skill name declared in `SKILL.md`.
          #
          #   @return [String]
          required :name, String

          # @!attribute source
          #   Provides ZIP bytes encoded with standard base64.
          #
          #   @return [OpenAI::Models::Beta::InlineCapabilitySourceParam]
          required :source, -> { OpenAI::Beta::InlineCapabilitySourceParam }

          # @!attribute type
          #   The type of the object. Always `inline`.
          #
          #   @return [Symbol, :inline]
          required :type, const: :inline

          # @!method initialize(description:, name:, source:, type: :inline)
          #   Supplies a skill ZIP directly in the session request.
          #
          #   @param description [String]
          #     The skill description declared in `SKILL.md`.
          #
          #   @param name [String]
          #     The skill name declared in `SKILL.md`.
          #
          #   @param source [OpenAI::Models::Beta::InlineCapabilitySourceParam]
          #     Provides ZIP bytes encoded with standard base64.
          #
          #   @param type [Symbol, :inline]
          #     The type of the object. Always `inline`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::HostedSkillParam::SkillReference, OpenAI::Models::Beta::HostedSkillParam::Inline)]
      end
    end
  end
end
