# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # The execution environment and optional reusable template for a session.
      module EnvironmentParam
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Runs the agent without an execution environment.
        variant :none, -> { OpenAI::Beta::EnvironmentParam::None }

        # An OpenAI-hosted environment, optionally based on a reusable template.
        variant :openai_hosted, -> { OpenAI::Beta::EnvironmentParam::OpenAIHosted }

        # An application-hosted environment configured inline.
        variant :self_hosted, -> { OpenAI::Beta::EnvironmentParam::SelfHosted }

        class None < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of the object. Always `none`.
          #
          #   @return [Symbol, :none]
          required :type, const: :none

          # @!method initialize(type: :none)
          #   Runs the agent without an execution environment.
          #
          #   @param type [Symbol, :none]
          #     The type of the object. Always `none`.
        end

        class OpenAIHosted < OpenAI::Internal::Type::BaseModel
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

          # @!attribute env
          #   Environment variables made available to the agent.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :env, OpenAI::Internal::Type::HashOf[String], nil?: true

          # @!attribute environment_template_id
          #   A reusable hosted template applied before inline session configuration. Omitted
          #   fields inherit the template; network overrides cannot broaden its policy.
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
          #   Network access for an OpenAI-hosted environment.
          #
          #   @return [OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted::Network, nil]
          optional :network, -> { OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network }, nil?: true

          # @!attribute packages
          #   Packages to install in an OpenAI-hosted environment.
          #
          #   @return [OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted::Packages, nil]
          optional :packages, -> { OpenAI::Beta::EnvironmentParam::OpenAIHosted::Packages }, nil?: true

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

          # @!method initialize(capability_directories: nil, env: nil, environment_template_id: nil, files: nil, network: nil, packages: nil, plugins: nil, setup_commands: nil, skills: nil, type: :openai_hosted)
          #   An OpenAI-hosted environment, optionally based on a reusable template.
          #
          #   @param capability_directories [Array<String>, nil]
          #     Directories that contain capabilities exposed to the agent. Defaults to an empty
          #     list.
          #
          #   @param env [Hash{Symbol=>String}, nil]
          #     Environment variables made available to the agent.
          #
          #   @param environment_template_id [String]
          #     A reusable hosted template applied before inline session configuration. Omitted
          #     fields inherit the template; network overrides cannot broaden its policy.
          #
          #   @param files [Array<OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID, OpenAI::Models::Beta::HostedEnvironmentFileParam::Inline>, nil]
          #     Files available before the agent starts. Defaults to an empty list.
          #
          #   @param network [OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted::Network, nil]
          #     Network access for an OpenAI-hosted environment.
          #
          #   @param packages [OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted::Packages, nil]
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
          #   @param type [Symbol, :openai_hosted]
          #     The type of the object. Always `openai_hosted`.

          # @see OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted#network
          class Network < OpenAI::Internal::Type::BaseModel
            # @!attribute access
            #   The environment's network access mode.
            #
            #   @return [Symbol, OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted::Network::Access]
            required :access, enum: -> { OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network::Access }

            # @!attribute allowed_domains
            #   Domains the environment may access when network access is restricted.
            #
            #   @return [Array<String>, nil]
            optional :allowed_domains, OpenAI::Internal::Type::ArrayOf[String], nil?: true

            # @!method initialize(access:, allowed_domains: nil)
            #   Network access for an OpenAI-hosted environment.
            #
            #   @param access [Symbol, OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted::Network::Access]
            #     The environment's network access mode.
            #
            #   @param allowed_domains [Array<String>, nil]
            #     Domains the environment may access when network access is restricted.

            # The environment's network access mode.
            #
            # @see OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted::Network#access
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

          # @see OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted#packages
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

        class SelfHosted < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of the object. Always `self_hosted`.
          #
          #   @return [Symbol, :self_hosted]
          required :type, const: :self_hosted

          # @!attribute workspace_directory
          #   Absolute project directory inside the self-hosted environment.
          #
          #   @return [String]
          required :workspace_directory, String

          # @!attribute capability_directories
          #   Directories that contain capabilities exposed to the agent. Defaults to an empty
          #   list.
          #
          #   @return [Array<String>, nil]
          optional :capability_directories, OpenAI::Internal::Type::ArrayOf[String], nil?: true

          # @!method initialize(workspace_directory:, capability_directories: nil, type: :self_hosted)
          #   An application-hosted environment configured inline.
          #
          #   @param workspace_directory [String]
          #     Absolute project directory inside the self-hosted environment.
          #
          #   @param capability_directories [Array<String>, nil]
          #     Directories that contain capabilities exposed to the agent. Defaults to an empty
          #     list.
          #
          #   @param type [Symbol, :self_hosted]
          #     The type of the object. Always `self_hosted`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::EnvironmentParam::None, OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted, OpenAI::Models::Beta::EnvironmentParam::SelfHosted)]
      end
    end
  end
end
