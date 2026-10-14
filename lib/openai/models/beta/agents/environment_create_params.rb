# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Environments#create
        class EnvironmentCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute environment
          #   The required hosting type and its configuration.
          #
          #   @return [OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment]
          required :environment, -> { OpenAI::Beta::Agents::EnvironmentCreateParams::Environment }

          # @!attribute vault_ids
          #   The IDs of up to 10 vaults made available to an OpenAI-hosted environment.
          #
          #   @return [Array<String>, nil]
          optional :vault_ids, OpenAI::Internal::Type::ArrayOf[String], nil?: true

          # @!attribute idempotency_key
          #
          #   @return [String, nil]
          optional :idempotency_key, String

          # @!method initialize(environment:, vault_ids: nil, idempotency_key: nil, request_options: {})
          #   @param environment [OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment]
          #     The required hosting type and its configuration.
          #
          #   @param vault_ids [Array<String>, nil]
          #     The IDs of up to 10 vaults made available to an OpenAI-hosted environment.
          #
          #   @param idempotency_key [String]
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          class Environment < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The type of the object. Always `openai_hosted`.
            #
            #   @return [Symbol, :openai_hosted]
            required :type, const: :openai_hosted

            # @!attribute capability_directories
            #   Directories that contain capabilities exposed to the agent. Defaults to an empty
            #   list.
            #
            #   @return [Array<String>, nil]
            optional :capability_directories, OpenAI::Internal::Type::ArrayOf[String], nil?: true

            # @!attribute desktop
            #   Desktop provisioning. Omission or null inherits the template setting, or
            #   defaults to disabled.
            #
            #   @return [OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment::Desktop, nil]
            optional(
              :desktop,
              -> {
                OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Desktop
              },
              nil?: true
            )

            # @!attribute env
            #   Environment variables made available to the agent.
            #
            #   @return [Hash{Symbol=>String}, nil]
            optional :env, OpenAI::Internal::Type::HashOf[String], nil?: true

            # @!attribute environment_template_id
            #   A reusable hosted template applied before inline configuration. Omitted fields
            #   inherit the template; network overrides cannot broaden its policy.
            #
            #   @return [String, nil]
            optional :environment_template_id, String

            # @!attribute files
            #   Files available before the agent starts. Defaults to an empty list.
            #
            #   @return [Array<OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID, OpenAI::Models::Beta::HostedEnvironmentFileParam::Inline>, nil]
            optional(
              :files,
              -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedEnvironmentFileParam] },
              nil?: true
            )

            # @!attribute network
            #   Network access policy for the environment. If omitted, the API version
            #   determines whether network access is enabled or disabled.
            #
            #   @return [OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment::Network, nil]
            optional(
              :network,
              -> {
                OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network
              },
              nil?: true
            )

            # @!attribute packages
            #   Packages to install in the environment. Defaults to empty package lists.
            #
            #   @return [OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment::Packages, nil]
            optional(
              :packages,
              -> { OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Packages },
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

            # @!method initialize(capability_directories: nil, desktop: nil, env: nil, environment_template_id: nil, files: nil, network: nil, packages: nil, plugins: nil, setup_commands: nil, skills: nil, type: :openai_hosted)
            #   The required hosting type and its configuration.
            #
            #   @param capability_directories [Array<String>, nil]
            #     Directories that contain capabilities exposed to the agent. Defaults to an empty
            #     list.
            #
            #   @param desktop [OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment::Desktop, nil]
            #     Desktop provisioning. Omission or null inherits the template setting, or
            #     defaults to disabled.
            #
            #   @param env [Hash{Symbol=>String}, nil]
            #     Environment variables made available to the agent.
            #
            #   @param environment_template_id [String]
            #     A reusable hosted template applied before inline configuration. Omitted fields
            #     inherit the template; network overrides cannot broaden its policy.
            #
            #   @param files [Array<OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID, OpenAI::Models::Beta::HostedEnvironmentFileParam::Inline>, nil]
            #     Files available before the agent starts. Defaults to an empty list.
            #
            #   @param network [OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment::Network, nil]
            #     Network access policy for the environment. If omitted, the API version
            #     determines whether network access is enabled or disabled.
            #
            #   @param packages [OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment::Packages, nil]
            #     Packages to install in the environment. Defaults to empty package lists.
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
            #   @param type [Symbol, :openai_hosted]
            #     The type of the object. Always `openai_hosted`.

            # @see OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment#desktop
            class Desktop < OpenAI::Internal::Type::BaseModel
              # @!attribute enabled
              #   Whether to provision the desktop and its browser proxy.
              #
              #   @return [Boolean]
              required :enabled, OpenAI::Internal::Type::Boolean

              # @!method initialize(enabled:)
              #   Desktop provisioning. Omission or null inherits the template setting, or
              #   defaults to disabled.
              #
              #   @param enabled [Boolean]
              #     Whether to provision the desktop and its browser proxy.
            end

            # @see OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment#network
            class Network < OpenAI::Internal::Type::BaseModel
              # @!attribute access
              #   The environment's network access mode.
              #
              #   @return [Symbol, OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment::Network::Access]
              required(
                :access,
                enum: -> { OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network::Access }
              )

              # @!attribute allowed_domains
              #   Domains the environment may access when network access is restricted.
              #
              #   @return [Array<String>, nil]
              optional :allowed_domains, OpenAI::Internal::Type::ArrayOf[String], nil?: true

              # @!attribute blocked_domains
              #   Domains blocked for both executor and browser when access is restricted. A
              #   nonempty list requires `access: restricted` and cannot be combined with nonempty
              #   `allowed_domains`. Wildcard domains are not supported.
              #
              #   @return [Array<String>, nil]
              optional :blocked_domains, OpenAI::Internal::Type::ArrayOf[String], nil?: true

              # @!method initialize(access:, allowed_domains: nil, blocked_domains: nil)
              #   Network access policy for the environment. If omitted, the API version
              #   determines whether network access is enabled or disabled.
              #
              #   @param access [Symbol, OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment::Network::Access]
              #     The environment's network access mode.
              #
              #   @param allowed_domains [Array<String>, nil]
              #     Domains the environment may access when network access is restricted.
              #
              #   @param blocked_domains [Array<String>, nil]
              #     Domains blocked for both executor and browser when access is restricted. A
              #     nonempty list requires `access: restricted` and cannot be combined with nonempty
              #     `allowed_domains`. Wildcard domains are not supported.

              # The environment's network access mode.
              #
              # @see OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment::Network#access
              module Access
                extend OpenAI::Internal::Type::Enum

                # Allows unrestricted network access.
                ENABLED = :enabled

                # Disables network access.
                DISABLED = :disabled

                # Applies the configured domain restrictions.
                RESTRICTED = :restricted

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end

            # @see OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment#packages
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
              #   Packages to install in the environment. Defaults to empty package lists.
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
