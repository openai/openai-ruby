# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaContainerAuto < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   Automatically creates a container for this request
        #
        #   @return [Symbol, :container_auto]
        required :type, const: :container_auto

        # @!attribute file_ids
        #   An optional list of uploaded files to make available to your code.
        #
        #   @return [Array<String>, nil]
        optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute memory_limit
        #   The memory limit for the container.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaContainerAuto::MemoryLimit, nil]
        optional :memory_limit, enum: -> { OpenAI::Beta::BetaContainerAuto::MemoryLimit }, nil?: true

        # @!attribute network_policy
        #   Network access policy for the container.
        #
        #   @return [OpenAI::Models::Beta::BetaContainerNetworkPolicyDisabled, OpenAI::Models::Beta::BetaContainerNetworkPolicyAllowlist, nil]
        optional :network_policy, union: -> { OpenAI::Beta::BetaContainerAuto::NetworkPolicy }

        # @!attribute skills
        #   An optional list of skills referenced by id or inline data.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaSkillReference, OpenAI::Models::Beta::BetaInlineSkill>, nil]
        optional :skills, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaContainerAuto::Skill] }

        # @!method initialize(file_ids: nil, memory_limit: nil, network_policy: nil, skills: nil, type: :container_auto)
        #   @param file_ids [Array<String>] An optional list of uploaded files to make available to your code.
        #
        #   @param memory_limit [Symbol, OpenAI::Models::Beta::BetaContainerAuto::MemoryLimit, nil] The memory limit for the container.
        #
        #   @param network_policy [OpenAI::Models::Beta::BetaContainerNetworkPolicyDisabled, OpenAI::Models::Beta::BetaContainerNetworkPolicyAllowlist] Network access policy for the container.
        #
        #   @param skills [Array<OpenAI::Models::Beta::BetaSkillReference, OpenAI::Models::Beta::BetaInlineSkill>] An optional list of skills referenced by id or inline data.
        #
        #   @param type [Symbol, :container_auto] Automatically creates a container for this request

        # The memory limit for the container.
        #
        # @see OpenAI::Models::Beta::BetaContainerAuto#memory_limit
        module MemoryLimit
          extend OpenAI::Internal::Type::Enum

          MEMORY_LIMIT_1G = :"1g"
          MEMORY_LIMIT_4G = :"4g"
          MEMORY_LIMIT_16G = :"16g"
          MEMORY_LIMIT_64G = :"64g"

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # Network access policy for the container.
        #
        # @see OpenAI::Models::Beta::BetaContainerAuto#network_policy
        module NetworkPolicy
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :disabled, -> { OpenAI::Beta::BetaContainerNetworkPolicyDisabled }

          variant :allowlist, -> { OpenAI::Beta::BetaContainerNetworkPolicyAllowlist }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::BetaContainerNetworkPolicyDisabled, OpenAI::Models::Beta::BetaContainerNetworkPolicyAllowlist)]
        end

        module Skill
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :skill_reference, -> { OpenAI::Beta::BetaSkillReference }

          variant :inline, -> { OpenAI::Beta::BetaInlineSkill }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::BetaSkillReference, OpenAI::Models::Beta::BetaInlineSkill)]
        end
      end
    end

    BetaContainerAuto = Beta::BetaContainerAuto
  end
end
