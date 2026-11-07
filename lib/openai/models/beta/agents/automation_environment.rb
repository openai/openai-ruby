# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # Environment selection saved before an invocation creates its session.
        module AutomationEnvironment
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :none, -> { OpenAI::Beta::Agents::AutomationEnvironment::None }

          # Hosted environment selection with confidential setup commands and variables omitted.
          variant :openai_hosted, -> { OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted }

          variant :self_hosted, -> { OpenAI::Beta::Agents::AutomationEnvironment::SelfHosted }

          class None < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The type of the object. Always `none`.
            #
            #   @return [Symbol, :none]
            required :type, const: :none

            # @!method initialize(type: :none)
            #   @param type [Symbol, :none]
            #     The type of the object. Always `none`.
          end

          class OpenAIHosted < OpenAI::Internal::Type::BaseModel
            # @!attribute capability_directories
            #   Directory overrides, or null to inherit the template or creation default.
            #
            #   @return [Array<String>, nil]
            required :capability_directories, OpenAI::Internal::Type::ArrayOf[String], nil?: true

            # @!attribute container_size
            #   The configured container size, or null to use the creation default.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::ContainerSize, nil]
            required(
              :container_size,
              enum: -> { OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::ContainerSize },
              nil?: true
            )

            # @!attribute desktop
            #   Desktop overrides, or null to inherit the template or creation default.
            #
            #   @return [OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Desktop, nil]
            required(
              :desktop,
              -> {
                OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Desktop
              },
              nil?: true
            )

            # @!attribute environment_id
            #   An existing environment reference, or null when provisioning a new environment.
            #
            #   @return [String, nil]
            required :environment_id, String, nil?: true

            # @!attribute environment_template_id
            #   A template reference, or null when no template is selected.
            #
            #   @return [String, nil]
            required :environment_template_id, String, nil?: true

            # @!attribute files
            #   File overrides, excluding contents, or null to inherit.
            #
            #   @return [Array<OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::FileID, OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::Inline>, nil]
            required(
              :files,
              -> {
                OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::File]
              },
              nil?: true
            )

            # @!attribute network
            #   Network overrides, or null to inherit the template or creation default.
            #
            #   @return [OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network, nil]
            required(
              :network,
              -> {
                OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network
              },
              nil?: true
            )

            # @!attribute packages
            #   Package overrides, or null to inherit the template or creation default.
            #
            #   @return [OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Packages, nil]
            required(
              :packages,
              -> {
                OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Packages
              },
              nil?: true
            )

            # @!attribute plugins
            #   Plugin overrides, excluding archive contents, or null to inherit.
            #
            #   @return [Array<OpenAI::Models::Beta::HostedPlugin>, nil]
            required :plugins, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::HostedPlugin] }, nil?: true

            # @!attribute skills
            #   Skill overrides, excluding archive contents, or null to inherit.
            #
            #   @return [Array<OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::SkillReference, OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::Inline>, nil]
            required(
              :skills,
              -> {
                OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill]
              },
              nil?: true
            )

            # @!attribute type
            #   The type of the object. Always `openai_hosted`.
            #
            #   @return [Symbol, :openai_hosted]
            required :type, const: :openai_hosted

            # @!method initialize(capability_directories:, container_size:, desktop:, environment_id:, environment_template_id:, files:, network:, packages:, plugins:, skills:, type: :openai_hosted)
            #   Hosted environment selection with confidential setup commands and variables
            #   omitted.
            #
            #   @param capability_directories [Array<String>, nil]
            #     Directory overrides, or null to inherit the template or creation default.
            #
            #   @param container_size [Symbol, OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::ContainerSize, nil]
            #     The configured container size, or null to use the creation default.
            #
            #   @param desktop [OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Desktop, nil]
            #     Desktop overrides, or null to inherit the template or creation default.
            #
            #   @param environment_id [String, nil]
            #     An existing environment reference, or null when provisioning a new environment.
            #
            #   @param environment_template_id [String, nil]
            #     A template reference, or null when no template is selected.
            #
            #   @param files [Array<OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::FileID, OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::Inline>, nil]
            #     File overrides, excluding contents, or null to inherit.
            #
            #   @param network [OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network, nil]
            #     Network overrides, or null to inherit the template or creation default.
            #
            #   @param packages [OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Packages, nil]
            #     Package overrides, or null to inherit the template or creation default.
            #
            #   @param plugins [Array<OpenAI::Models::Beta::HostedPlugin>, nil]
            #     Plugin overrides, excluding archive contents, or null to inherit.
            #
            #   @param skills [Array<OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::SkillReference, OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::Inline>, nil]
            #     Skill overrides, excluding archive contents, or null to inherit.
            #
            #   @param type [Symbol, :openai_hosted]
            #     The type of the object. Always `openai_hosted`.

            # The configured container size, or null to use the creation default.
            #
            # @see OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted#container_size
            module ContainerSize
              extend OpenAI::Internal::Type::Enum

              SMALL = :small
              MEDIUM = :medium
              LARGE = :large

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # @see OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted#desktop
            class Desktop < OpenAI::Internal::Type::BaseModel
              # @!attribute enabled
              #   Whether the environment provisions a desktop and browser proxy.
              #
              #   @return [Boolean]
              required :enabled, OpenAI::Internal::Type::Boolean

              # @!method initialize(enabled:)
              #   Desktop overrides, or null to inherit the template or creation default.
              #
              #   @param enabled [Boolean]
              #     Whether the environment provisions a desktop and browser proxy.
            end

            # Safe metadata for a file configured by an environment template.
            module File
              extend OpenAI::Internal::Type::Union

              discriminator :type

              # A project-scoped Files API reference resolved separately for each session.
              variant :file_id, -> { OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::FileID }

              # Metadata for confidential inline file contents.
              variant :inline, -> { OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::Inline }

              class FileID < OpenAI::Internal::Type::BaseModel
                # @!attribute file_id
                #   The ID of the uploaded file.
                #
                #   @return [String]
                required :file_id, String

                # @!attribute path
                #   The file's absolute path inside the environment.
                #
                #   @return [String]
                required :path, String

                # @!attribute type
                #   The type of the object. Always `file_id`.
                #
                #   @return [Symbol, :file_id]
                required :type, const: :file_id

                # @!method initialize(file_id:, path:, type: :file_id)
                #   A project-scoped Files API reference resolved separately for each session.
                #
                #   @param file_id [String]
                #     The ID of the uploaded file.
                #
                #   @param path [String]
                #     The file's absolute path inside the environment.
                #
                #   @param type [Symbol, :file_id]
                #     The type of the object. Always `file_id`.
              end

              class Inline < OpenAI::Internal::Type::BaseModel
                # @!attribute path
                #   The file's absolute path inside the environment.
                #
                #   @return [String]
                required :path, String

                # @!attribute size_bytes
                #   The decoded size of the inline file in bytes.
                #
                #   @return [Integer]
                required :size_bytes, Integer

                # @!attribute type
                #   The type of the object. Always `inline`.
                #
                #   @return [Symbol, :inline]
                required :type, const: :inline

                # @!method initialize(path:, size_bytes:, type: :inline)
                #   Metadata for confidential inline file contents.
                #
                #   @param path [String]
                #     The file's absolute path inside the environment.
                #
                #   @param size_bytes [Integer]
                #     The decoded size of the inline file in bytes.
                #
                #   @param type [Symbol, :inline]
                #     The type of the object. Always `inline`.
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::FileID, OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::Inline)]
            end

            # @see OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted#network
            class Network < OpenAI::Internal::Type::BaseModel
              # @!attribute access
              #   The environment's network access mode.
              #
              #   @return [Symbol, OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network::Access]
              required :access, enum: -> { OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network::Access }

              # @!attribute allowed_domains
              #   Domains the environment may access when network access is restricted.
              #
              #   @return [Array<String>]
              required :allowed_domains, OpenAI::Internal::Type::ArrayOf[String]

              # @!method initialize(access:, allowed_domains:)
              #   Network overrides, or null to inherit the template or creation default.
              #
              #   @param access [Symbol, OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network::Access]
              #     The environment's network access mode.
              #
              #   @param allowed_domains [Array<String>]
              #     Domains the environment may access when network access is restricted.

              # The environment's network access mode.
              #
              # @see OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network#access
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

            # @see OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted#packages
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
              #   Package overrides, or null to inherit the template or creation default.
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

            # Safe metadata for a skill configured by an environment template.
            module Skill
              extend OpenAI::Internal::Type::Union

              discriminator :type

              # A skill resolved afresh from the Skills API whenever a session starts.
              variant(
                :skill_reference,
                -> { OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::SkillReference }
              )

              # Safe metadata for an inline skill archive.
              variant :inline, -> { OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::Inline }

              class SkillReference < OpenAI::Internal::Type::BaseModel
                # @!attribute skill_id
                #   The referenced skill ID.
                #
                #   @return [String]
                required :skill_id, String

                # @!attribute type
                #   The type of the object. Always `skill_reference`.
                #
                #   @return [Symbol, :skill_reference]
                required :type, const: :skill_reference

                # @!attribute version
                #   The requested version selector, including `latest`.
                #
                #   @return [String, nil]
                required :version, String, nil?: true

                # @!method initialize(skill_id:, version:, type: :skill_reference)
                #   A skill resolved afresh from the Skills API whenever a session starts.
                #
                #   @param skill_id [String]
                #     The referenced skill ID.
                #
                #   @param version [String, nil]
                #     The requested version selector, including `latest`.
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

                # @!attribute type
                #   The type of the object. Always `inline`.
                #
                #   @return [Symbol, :inline]
                required :type, const: :inline

                # @!method initialize(description:, name:, type: :inline)
                #   Safe metadata for an inline skill archive.
                #
                #   @param description [String]
                #     The skill description declared in `SKILL.md`.
                #
                #   @param name [String]
                #     The skill name declared in `SKILL.md`.
                #
                #   @param type [Symbol, :inline]
                #     The type of the object. Always `inline`.
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::SkillReference, OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::Inline)]
            end
          end

          class SelfHosted < OpenAI::Internal::Type::BaseModel
            # @!attribute capability_directories
            #   Directories that expose capabilities to the agent.
            #
            #   @return [Array<String>]
            required :capability_directories, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute environment_id
            #   An existing registration, or null to create a session-owned environment.
            #
            #   @return [String, nil]
            required :environment_id, String, nil?: true

            # @!attribute type
            #   The type of the object. Always `self_hosted`.
            #
            #   @return [Symbol, :self_hosted]
            required :type, const: :self_hosted

            # @!attribute workspace_directory
            #   The absolute project directory in the environment.
            #
            #   @return [String]
            required :workspace_directory, String

            # @!method initialize(capability_directories:, environment_id:, workspace_directory:, type: :self_hosted)
            #   @param capability_directories [Array<String>]
            #     Directories that expose capabilities to the agent.
            #
            #   @param environment_id [String, nil]
            #     An existing registration, or null to create a session-owned environment.
            #
            #   @param workspace_directory [String]
            #     The absolute project directory in the environment.
            #
            #   @param type [Symbol, :self_hosted]
            #     The type of the object. Always `self_hosted`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::Agents::AutomationEnvironment::None, OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted, OpenAI::Models::Beta::Agents::AutomationEnvironment::SelfHosted)]
        end
      end
    end
  end
end
