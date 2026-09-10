# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Environments
          # @see OpenAI::Resources::Beta::Agents::Environments::Templates#create
          class TemplateCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute capability_directories
            #   Directories that contain capabilities exposed to the agent. Defaults to an empty
            #   list.
            #
            #   @return [Array<String>, nil]
            optional :capability_directories, OpenAI::Internal::Type::ArrayOf[String], nil?: true

            # @!attribute env
            #   Environment variables made available to the agent.
            #
            #   @return [Hash{Symbol=>String}, nil]
            optional :env, OpenAI::Internal::Type::HashOf[String], nil?: true

            # @!attribute files
            #   Files available before the agent starts. Defaults to an empty list.
            #
            #   @return [Array<OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID, OpenAI::Models::Beta::HostedEnvironmentFileParam::Inline>, nil]
            optional(
              :files,
              -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedEnvironmentFileParam] },
              nil?: true
            )

            # @!attribute name
            #   An optional human-readable display name for the template.
            #
            #   @return [String, nil]
            optional :name, String, nil?: true

            # @!attribute network
            #   Network access for an OpenAI-hosted environment.
            #
            #   @return [OpenAI::Models::Beta::Agents::Environments::TemplateCreateParams::Network, nil]
            optional(
              :network,
              -> {
                OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network
              },
              nil?: true
            )

            # @!attribute packages
            #   Packages to install in an OpenAI-hosted environment.
            #
            #   @return [OpenAI::Models::Beta::Agents::Environments::TemplateCreateParams::Packages, nil]
            optional(
              :packages,
              -> {
                OpenAI::Beta::Agents::Environments::TemplateCreateParams::Packages
              },
              nil?: true
            )

            # @!attribute plugins
            #   Plugins provided as inline ZIP archives. Defaults to an empty list.
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
            #   Ordered, confidential setup commands. Command bodies are never returned.
            #
            #   @return [Array<OpenAI::Models::Beta::SetupCommandParam>, nil]
            optional(
              :setup_commands,
              -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::SetupCommandParam] },
              nil?: true
            )

            # @!attribute skills
            #   Skills referenced by ID or provided as inline ZIP archives. Defaults to an empty
            #   list.
            #
            #   @return [Array<OpenAI::Models::Beta::HostedSkillParam::SkillReference, OpenAI::Models::Beta::HostedSkillParam::Inline>, nil]
            optional(
              :skills,
              -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedSkillParam] },
              nil?: true
            )

            # @!method initialize(capability_directories: nil, env: nil, files: nil, name: nil, network: nil, packages: nil, plugins: nil, setup_commands: nil, skills: nil, request_options: {})
            #   @param capability_directories [Array<String>, nil]
            #     Directories that contain capabilities exposed to the agent. Defaults to an empty
            #     list.
            #
            #   @param env [Hash{Symbol=>String}, nil]
            #     Environment variables made available to the agent.
            #
            #   @param files [Array<OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID, OpenAI::Models::Beta::HostedEnvironmentFileParam::Inline>, nil]
            #     Files available before the agent starts. Defaults to an empty list.
            #
            #   @param name [String, nil]
            #     An optional human-readable display name for the template.
            #
            #   @param network [OpenAI::Models::Beta::Agents::Environments::TemplateCreateParams::Network, nil]
            #     Network access for an OpenAI-hosted environment.
            #
            #   @param packages [OpenAI::Models::Beta::Agents::Environments::TemplateCreateParams::Packages, nil]
            #     Packages to install in an OpenAI-hosted environment.
            #
            #   @param plugins [Array<OpenAI::Models::Beta::HostedPluginParam>, nil]
            #     Plugins provided as inline ZIP archives. Defaults to an empty list.
            #
            #   @param setup_commands [Array<OpenAI::Models::Beta::SetupCommandParam>, nil]
            #     Ordered, confidential setup commands. Command bodies are never returned.
            #
            #   @param skills [Array<OpenAI::Models::Beta::HostedSkillParam::SkillReference, OpenAI::Models::Beta::HostedSkillParam::Inline>, nil]
            #     Skills referenced by ID or provided as inline ZIP archives. Defaults to an empty
            #     list.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            class Network < OpenAI::Internal::Type::BaseModel
              # @!attribute access
              #   The environment's network access mode.
              #
              #   @return [Symbol, OpenAI::Models::Beta::Agents::Environments::TemplateCreateParams::Network::Access]
              required :access, enum: -> { OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network::Access }

              # @!attribute allowed_domains
              #   Domains the environment may access when network access is restricted.
              #
              #   @return [Array<String>, nil]
              optional :allowed_domains, OpenAI::Internal::Type::ArrayOf[String], nil?: true

              # @!method initialize(access:, allowed_domains: nil)
              #   Network access for an OpenAI-hosted environment.
              #
              #   @param access [Symbol, OpenAI::Models::Beta::Agents::Environments::TemplateCreateParams::Network::Access]
              #     The environment's network access mode.
              #
              #   @param allowed_domains [Array<String>, nil]
              #     Domains the environment may access when network access is restricted.

              # The environment's network access mode.
              #
              # @see OpenAI::Models::Beta::Agents::Environments::TemplateCreateParams::Network#access
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
