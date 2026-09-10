# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # The execution environment for a session.
      module Environment
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # The session talks to CCA without selecting or provisioning an execution environment.
        variant :none, -> { OpenAI::Beta::Environment::None }

        # An environment hosted by OpenAI.
        variant :openai_hosted, -> { OpenAI::Beta::Environment::OpenAIHosted }

        # An environment hosted by the application.
        variant :self_hosted, -> { OpenAI::Beta::Environment::SelfHosted }

        class None < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of the object. Always `none`.
          #
          #   @return [Symbol, :none]
          required :type, const: :none

          # @!method initialize(type: :none)
          #   The session talks to CCA without selecting or provisioning an execution
          #   environment.
          #
          #   @param type [Symbol, :none]
          #     The type of the object. Always `none`.
        end

        class OpenAIHosted < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The public ID of the environment.
          #
          #   @return [String]
          required :id, String

          # @!attribute capability_directories
          #   Directories that contain capabilities exposed to the agent.
          #
          #   @return [Array<String>]
          required :capability_directories, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute files
          #   Files available in the environment, excluding their contents.
          #
          #   @return [Array<OpenAI::Models::Beta::HostedEnvironmentFileID, OpenAI::Models::Beta::HostedEnvironmentFile::Inline>]
          required :files, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedEnvironmentFile] }

          # @!attribute network
          #   The effective network access policy for the environment.
          #
          #   @return [OpenAI::Models::Beta::Environment::OpenAIHosted::Network]
          required :network, -> { OpenAI::Beta::Environment::OpenAIHosted::Network }

          # @!attribute packages
          #   Packages installed in the environment.
          #
          #   @return [OpenAI::Models::Beta::Environment::OpenAIHosted::Packages]
          required :packages, -> { OpenAI::Beta::Environment::OpenAIHosted::Packages }

          # @!attribute plugins
          #   Plugins installed in the environment, excluding their archive contents.
          #
          #   @return [Array<OpenAI::Models::Beta::HostedPlugin>]
          required :plugins, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::HostedPlugin] }

          # @!attribute skills
          #   Skills installed in the environment, excluding their archive contents.
          #
          #   @return [Array<OpenAI::Models::Beta::HostedSkillReference, OpenAI::Models::Beta::HostedSkill::Inline>]
          required :skills, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedSkill] }

          # @!attribute type
          #   The type of the object. Always `openai_hosted`.
          #
          #   @return [Symbol, :openai_hosted]
          required :type, const: :openai_hosted

          # @!method initialize(id:, capability_directories:, files:, network:, packages:, plugins:, skills:, type: :openai_hosted)
          #   An environment hosted by OpenAI.
          #
          #   @param id [String]
          #     The public ID of the environment.
          #
          #   @param capability_directories [Array<String>]
          #     Directories that contain capabilities exposed to the agent.
          #
          #   @param files [Array<OpenAI::Models::Beta::HostedEnvironmentFileID, OpenAI::Models::Beta::HostedEnvironmentFile::Inline>]
          #     Files available in the environment, excluding their contents.
          #
          #   @param network [OpenAI::Models::Beta::Environment::OpenAIHosted::Network]
          #     The effective network access policy for the environment.
          #
          #   @param packages [OpenAI::Models::Beta::Environment::OpenAIHosted::Packages]
          #     Packages installed in the environment.
          #
          #   @param plugins [Array<OpenAI::Models::Beta::HostedPlugin>]
          #     Plugins installed in the environment, excluding their archive contents.
          #
          #   @param skills [Array<OpenAI::Models::Beta::HostedSkillReference, OpenAI::Models::Beta::HostedSkill::Inline>]
          #     Skills installed in the environment, excluding their archive contents.
          #
          #   @param type [Symbol, :openai_hosted]
          #     The type of the object. Always `openai_hosted`.

          # @see OpenAI::Models::Beta::Environment::OpenAIHosted#network
          class Network < OpenAI::Internal::Type::BaseModel
            # @!attribute access
            #   The environment's network access mode.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Environment::OpenAIHosted::Network::Access]
            required :access, enum: -> { OpenAI::Beta::Environment::OpenAIHosted::Network::Access }

            # @!attribute allowed_domains
            #   Domains the environment may access when network access is restricted.
            #
            #   @return [Array<String>]
            required :allowed_domains, OpenAI::Internal::Type::ArrayOf[String]

            # @!method initialize(access:, allowed_domains:)
            #   The effective network access policy for the environment.
            #
            #   @param access [Symbol, OpenAI::Models::Beta::Environment::OpenAIHosted::Network::Access]
            #     The environment's network access mode.
            #
            #   @param allowed_domains [Array<String>]
            #     Domains the environment may access when network access is restricted.

            # The environment's network access mode.
            #
            # @see OpenAI::Models::Beta::Environment::OpenAIHosted::Network#access
            module Access
              extend OpenAI::Internal::Type::Enum

              # Allows unrestricted network access.
              ENABLED = :enabled

              # Disables network access.
              DISABLED = :disabled

              # Allows access only to configured domains.
              RESTRICTED = :restricted

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # @see OpenAI::Models::Beta::Environment::OpenAIHosted#packages
          class Packages < OpenAI::Internal::Type::BaseModel
            # @!attribute npm
            #   npm packages installed globally in the environment.
            #
            #   @return [Array<String>]
            required :npm, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute python
            #   Python packages installed in the environment.
            #
            #   @return [Array<String>]
            required :python, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute system_
            #   System packages installed in the environment.
            #
            #   @return [Array<String>]
            required :system_, OpenAI::Internal::Type::ArrayOf[String], api_name: :system

            # @!method initialize(npm:, python:, system_:)
            #   Packages installed in the environment.
            #
            #   @param npm [Array<String>]
            #     npm packages installed globally in the environment.
            #
            #   @param python [Array<String>]
            #     Python packages installed in the environment.
            #
            #   @param system_ [Array<String>]
            #     System packages installed in the environment.
          end
        end

        class SelfHosted < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The public ID of the environment.
          #
          #   @return [String]
          required :id, String

          # @!attribute capability_directories
          #   Directories that contain capabilities exposed to the agent.
          #
          #   @return [Array<String>]
          required :capability_directories, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute remote_url
          #   Pass this URL unchanged to `codex exec-server --remote` when connecting this
          #   environment.
          #
          #   @return [String]
          required :remote_url, String

          # @!attribute type
          #   The type of the object. Always `self_hosted`.
          #
          #   @return [Symbol, :self_hosted]
          required :type, const: :self_hosted

          # @!attribute workspace_directory
          #   The absolute project directory inside the environment. Defaults to `/workspace`.
          #
          #   @return [String]
          required :workspace_directory, String

          # @!method initialize(id:, capability_directories:, remote_url:, workspace_directory:, type: :self_hosted)
          #   An environment hosted by the application.
          #
          #   @param id [String]
          #     The public ID of the environment.
          #
          #   @param capability_directories [Array<String>]
          #     Directories that contain capabilities exposed to the agent.
          #
          #   @param remote_url [String]
          #     Pass this URL unchanged to `codex exec-server --remote` when connecting this
          #     environment.
          #
          #   @param workspace_directory [String]
          #     The absolute project directory inside the environment. Defaults to `/workspace`.
          #
          #   @param type [Symbol, :self_hosted]
          #     The type of the object. Always `self_hosted`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::Environment::None, OpenAI::Models::Beta::Environment::OpenAIHosted, OpenAI::Models::Beta::Environment::SelfHosted)]
      end
    end
  end
end
