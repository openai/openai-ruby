# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ContainerAuto < OpenAI::Internal::Type::BaseModel
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
        #   @return [Symbol, OpenAI::Models::Responses::ContainerAuto::MemoryLimit, nil]
        optional :memory_limit, enum: -> { OpenAI::Responses::ContainerAuto::MemoryLimit }, nil?: true

        # @!attribute network_policy
        #   Network access policy for the container.
        #
        #   @return [OpenAI::Models::Responses::ContainerNetworkPolicyDisabled, OpenAI::Models::Responses::ContainerNetworkPolicyAllowlist, nil]
        optional :network_policy, union: -> { OpenAI::Responses::ContainerAuto::NetworkPolicy }

        # @!attribute skills
        #   An optional list of skills referenced by id or inline data.
        #
        #   @return [Array<OpenAI::Models::Responses::SkillReference, OpenAI::Models::Responses::InlineSkill>, nil]
        optional :skills, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ContainerAuto::Skill] }

        # @!method initialize(file_ids: nil, memory_limit: nil, network_policy: nil, skills: nil, type: :container_auto)
        #   @param file_ids [Array<String>] An optional list of uploaded files to make available to your code.
        #
        #   @param memory_limit [Symbol, OpenAI::Models::Responses::ContainerAuto::MemoryLimit, nil] The memory limit for the container.
        #
        #   @param network_policy [OpenAI::Models::Responses::ContainerNetworkPolicyDisabled, OpenAI::Models::Responses::ContainerNetworkPolicyAllowlist] Network access policy for the container.
        #
        #   @param skills [Array<OpenAI::Models::Responses::SkillReference, OpenAI::Models::Responses::InlineSkill>] An optional list of skills referenced by id or inline data.
        #
        #   @param type [Symbol, :container_auto] Automatically creates a container for this request

        # The memory limit for the container.
        #
        # @see OpenAI::Models::Responses::ContainerAuto#memory_limit
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
        # @see OpenAI::Models::Responses::ContainerAuto#network_policy
        module NetworkPolicy
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :disabled, -> { OpenAI::Responses::ContainerNetworkPolicyDisabled }

          variant :allowlist, -> { OpenAI::Responses::ContainerNetworkPolicyAllowlist }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Responses::ContainerNetworkPolicyDisabled, OpenAI::Models::Responses::ContainerNetworkPolicyAllowlist)]
        end

        module Skill
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :skill_reference, -> { OpenAI::Responses::SkillReference }

          variant :inline, -> { OpenAI::Responses::InlineSkill }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Responses::SkillReference, OpenAI::Models::Responses::InlineSkill)]
        end
      end
    end
  end
end
