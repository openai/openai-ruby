# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Environments
          # @see OpenAI::Resources::Beta::Agents::Environments::Templates#update
          class TemplateUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute environment_template_id
            #
            #   @return [String]
            required :environment_template_id, String

            # @!attribute capability_directories
            #   Directories that expose capabilities to the agent.
            #
            #   @return [Array<String>, nil]
            optional :capability_directories, OpenAI::Internal::Type::ArrayOf[String], nil?: true

            # @!attribute env
            #   Replacement confidential environment values.
            #
            #   @return [Hash{Symbol=>String}, nil]
            optional :env, OpenAI::Internal::Type::HashOf[String], nil?: true

            # @!attribute files
            #   Replacement file configuration materialized for each new session.
            #
            #   @return [Array<OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID, OpenAI::Models::Beta::HostedEnvironmentFileParam::Inline>, nil]
            optional(
              :files,
              -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedEnvironmentFileParam] },
              nil?: true
            )

            # @!attribute name
            #   A replacement human-readable display name, or `null` to clear the name.
            #
            #   @return [String, nil]
            optional :name, String, nil?: true

            # @!attribute network
            #   Network access for an OpenAI-hosted environment.
            #
            #   @return [OpenAI::Models::Beta::Agents::Environments::TemplateUpdateParams::Network, nil]
            optional(
              :network,
              -> {
                OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network
              },
              nil?: true
            )

            # @!attribute packages
            #   Packages to install in an OpenAI-hosted environment.
            #
            #   @return [OpenAI::Models::Beta::Agents::Environments::TemplateUpdateParams::Packages, nil]
            optional(
              :packages,
              -> {
                OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Packages
              },
              nil?: true
            )

            # @!attribute plugins
            #   Replacement plugin configuration installed for each new session.
            #
            #   @return [Array<OpenAI::Models::Beta::HostedPluginParam>, nil]
            optional(
              :plugins,
              -> {
                OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::HostedPluginParam]
              },
              nil?: true
            )

            # @!attribute setup_commands
            #   Replacement confidential setup commands, never included in returned resources.
            #
            #   @return [Array<OpenAI::Models::Beta::SetupCommandParam>, nil]
            optional(
              :setup_commands,
              -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::SetupCommandParam] },
              nil?: true
            )

            # @!attribute skills
            #   Replacement skill configuration installed for each new session.
            #
            #   @return [Array<OpenAI::Models::Beta::HostedSkillParam::SkillReference, OpenAI::Models::Beta::HostedSkillParam::Inline>, nil]
            optional(
              :skills,
              -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedSkillParam] },
              nil?: true
            )

            # @!method initialize(environment_template_id:, capability_directories: nil, env: nil, files: nil, name: nil, network: nil, packages: nil, plugins: nil, setup_commands: nil, skills: nil, request_options: {})
            #   @param environment_template_id [String]
            #
            #   @param capability_directories [Array<String>, nil]
            #     Directories that expose capabilities to the agent.
            #
            #   @param env [Hash{Symbol=>String}, nil]
            #     Replacement confidential environment values.
            #
            #   @param files [Array<OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID, OpenAI::Models::Beta::HostedEnvironmentFileParam::Inline>, nil]
            #     Replacement file configuration materialized for each new session.
            #
            #   @param name [String, nil]
            #     A replacement human-readable display name, or `null` to clear the name.
            #
            #   @param network [OpenAI::Models::Beta::Agents::Environments::TemplateUpdateParams::Network, nil]
            #     Network access for an OpenAI-hosted environment.
            #
            #   @param packages [OpenAI::Models::Beta::Agents::Environments::TemplateUpdateParams::Packages, nil]
            #     Packages to install in an OpenAI-hosted environment.
            #
            #   @param plugins [Array<OpenAI::Models::Beta::HostedPluginParam>, nil]
            #     Replacement plugin configuration installed for each new session.
            #
            #   @param setup_commands [Array<OpenAI::Models::Beta::SetupCommandParam>, nil]
            #     Replacement confidential setup commands, never included in returned resources.
            #
            #   @param skills [Array<OpenAI::Models::Beta::HostedSkillParam::SkillReference, OpenAI::Models::Beta::HostedSkillParam::Inline>, nil]
            #     Replacement skill configuration installed for each new session.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            class Network < OpenAI::Internal::Type::BaseModel
              # @!attribute access
              #   The environment's network access mode.
              #
              #   @return [Symbol, OpenAI::Models::Beta::Agents::Environments::TemplateUpdateParams::Network::Access]
              required :access, enum: -> { OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network::Access }

              # @!attribute allowed_domains
              #   Domains the environment may access when network access is restricted.
              #
              #   @return [Array<String>, nil]
              optional :allowed_domains, OpenAI::Internal::Type::ArrayOf[String], nil?: true

              # @!method initialize(access:, allowed_domains: nil)
              #   Network access for an OpenAI-hosted environment.
              #
              #   @param access [Symbol, OpenAI::Models::Beta::Agents::Environments::TemplateUpdateParams::Network::Access]
              #     The environment's network access mode.
              #
              #   @param allowed_domains [Array<String>, nil]
              #     Domains the environment may access when network access is restricted.

              # The environment's network access mode.
              #
              # @see OpenAI::Models::Beta::Agents::Environments::TemplateUpdateParams::Network#access
              module Access
                extend OpenAI::Internal::Type::Enum

                # Allows unrestricted network access, matching an omitted network policy.
                ENABLED = :enabled

                # Disables network access.
                DISABLED = :disabled

                # Allows access only to configured domains.
                RESTRICTED = :restricted

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end

            class Packages < OpenAI::Internal::Type::BaseModel
              # @!attribute npm
              #   npm packages to install globally. Defaults to an empty list.
              #
              #   @return [Array<String>, nil]
              optional :npm, OpenAI::Internal::Type::ArrayOf[String], nil?: true

              # @!attribute python
              #   Python packages to install. Defaults to an empty list.
              #
              #   @return [Array<String>, nil]
              optional :python, OpenAI::Internal::Type::ArrayOf[String], nil?: true

              # @!attribute system_
              #   System packages to install. Defaults to an empty list.
              #
              #   @return [Array<String>, nil]
              optional :system_, OpenAI::Internal::Type::ArrayOf[String], api_name: :system, nil?: true

              # @!method initialize(npm: nil, python: nil, system_: nil)
              #   Packages to install in an OpenAI-hosted environment.
              #
              #   @param npm [Array<String>, nil]
              #     npm packages to install globally. Defaults to an empty list.
              #
              #   @param python [Array<String>, nil]
              #     Python packages to install. Defaults to an empty list.
              #
              #   @param system_ [Array<String>, nil]
              #     System packages to install. Defaults to an empty list.
            end
          end
        end
      end
    end
  end
end
