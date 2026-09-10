# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Environments#retrieve
        class EnvironmentInfo < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the environment.
          #
          #   @return [String]
          required :id, String

          # @!attribute files
          #   Files installed in the environment, without their contents.
          #
          #   @return [Array<OpenAI::Models::Beta::HostedEnvironmentFileID, OpenAI::Models::Beta::HostedEnvironmentFile::Inline>]
          required :files, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedEnvironmentFile] }

          # @!attribute object
          #   The object type. Always `agent.environment`.
          #
          #   @return [Symbol, :"agent.environment"]
          required :object, const: :"agent.environment"

          # @!attribute plugins
          #   Plugins installed in the environment, without their archive contents.
          #
          #   @return [Array<OpenAI::Models::Beta::HostedPlugin>]
          required :plugins, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::HostedPlugin] }

          # @!attribute skills
          #   Skills installed in the environment, without their archive contents.
          #
          #   @return [Array<OpenAI::Models::Beta::HostedSkillReference, OpenAI::Models::Beta::HostedSkill::Inline>]
          required :skills, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedSkill] }

          # @!attribute status
          #   The current environment connection status.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Agents::EnvironmentInfo::Status]
          required :status, enum: -> { OpenAI::Beta::Agents::EnvironmentInfo::Status }

          # @!attribute type
          #   Whether the environment is hosted by OpenAI or by the application.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Agents::EnvironmentInfo::Type]
          required :type, enum: -> { OpenAI::Beta::Agents::EnvironmentInfo::Type }

          # @!method initialize(id:, files:, plugins:, skills:, status:, type:, object: :"agent.environment")
          #   Safe metadata for a first-class execution environment.
          #
          #   @param id [String]
          #     The ID of the environment.
          #
          #   @param files [Array<OpenAI::Models::Beta::HostedEnvironmentFileID, OpenAI::Models::Beta::HostedEnvironmentFile::Inline>]
          #     Files installed in the environment, without their contents.
          #
          #   @param plugins [Array<OpenAI::Models::Beta::HostedPlugin>]
          #     Plugins installed in the environment, without their archive contents.
          #
          #   @param skills [Array<OpenAI::Models::Beta::HostedSkillReference, OpenAI::Models::Beta::HostedSkill::Inline>]
          #     Skills installed in the environment, without their archive contents.
          #
          #   @param status [Symbol, OpenAI::Models::Beta::Agents::EnvironmentInfo::Status]
          #     The current environment connection status.
          #
          #   @param type [Symbol, OpenAI::Models::Beta::Agents::EnvironmentInfo::Type]
          #     Whether the environment is hosted by OpenAI or by the application.
          #
          #   @param object [Symbol, :"agent.environment"]
          #     The object type. Always `agent.environment`.

          # The current environment connection status.
          #
          # @see OpenAI::Models::Beta::Agents::EnvironmentInfo#status
          module Status
            extend OpenAI::Internal::Type::Enum

            PENDING = :pending
            CONNECTED = :connected
            DISCONNECTED = :disconnected
            EXPIRED = :expired
            FAILED = :failed

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # Whether the environment is hosted by OpenAI or by the application.
          #
          # @see OpenAI::Models::Beta::Agents::EnvironmentInfo#type
          module Type
            extend OpenAI::Internal::Type::Enum

            OPENAI_HOSTED = :openai_hosted
            SELF_HOSTED = :self_hosted

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
