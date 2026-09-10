# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Environments
          # @see OpenAI::Resources::Beta::Agents::Environments::Templates#create
          class EnvironmentTemplate < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the reusable environment template.
            #
            #   @return [String]
            required :id, String

            # @!attribute capability_directories
            #   Directories that expose capabilities to the agent.
            #
            #   @return [Array<String>]
            required :capability_directories, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute created_at
            #   The Unix timestamp, in seconds, when the template was created.
            #
            #   @return [Integer]
            required :created_at, Integer

            # @!attribute files
            #   Safe file metadata, excluding contents and session-scoped file IDs.
            #
            #   @return [Array<OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::File::FileID, OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::File::Inline>]
            required(
              :files,
              -> {
                OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File]
              }
            )

            # @!attribute name
            #   An optional human-readable display name for the template.
            #
            #   @return [String, nil]
            required :name, String, nil?: true

            # @!attribute network
            #   Runtime network access for each OpenAI-hosted environment.
            #
            #   @return [OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::Network]
            required :network, -> { OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network }

            # @!attribute object
            #   The object type. Always `agent.environment.template`.
            #
            #   @return [Symbol, :"agent.environment.template"]
            required :object, const: :"agent.environment.template"

            # @!attribute packages
            #   Packages installed in each fresh OpenAI-hosted environment.
            #
            #   @return [OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::Packages]
            required :packages, -> { OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Packages }

            # @!attribute plugins
            #   Safe plugin metadata, excluding inline archive contents.
            #
            #   @return [Array<OpenAI::Models::Beta::HostedPlugin>]
            required :plugins, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::HostedPlugin] }

            # @!attribute skills
            #   Safe skill metadata, preserving unresolved version selectors.
            #
            #   @return [Array<OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::Skill::SkillReference, OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::Skill::Inline>]
            required(
              :skills,
              -> {
                OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill]
              }
            )

            # @!attribute updated_at
            #   The Unix timestamp, in seconds, when the template was last updated.
            #
            #   @return [Integer]
            required :updated_at, Integer

            # @!method initialize(id:, capability_directories:, created_at:, files:, name:, network:, packages:, plugins:, skills:, updated_at:, object: :"agent.environment.template")
            #   Reusable configuration that provisions a fresh OpenAI-hosted environment for
            #   each session.
            #
            #   @param id [String]
            #     The ID of the reusable environment template.
            #
            #   @param capability_directories [Array<String>]
            #     Directories that expose capabilities to the agent.
            #
            #   @param created_at [Integer]
            #     The Unix timestamp, in seconds, when the template was created.
            #
            #   @param files [Array<OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::File::FileID, OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::File::Inline>]
            #     Safe file metadata, excluding contents and session-scoped file IDs.
            #
            #   @param name [String, nil]
            #     An optional human-readable display name for the template.
            #
            #   @param network [OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::Network]
            #     Runtime network access for each OpenAI-hosted environment.
            #
            #   @param packages [OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::Packages]
            #     Packages installed in each fresh OpenAI-hosted environment.
            #
            #   @param plugins [Array<OpenAI::Models::Beta::HostedPlugin>]
            #     Safe plugin metadata, excluding inline archive contents.
            #
            #   @param skills [Array<OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::Skill::SkillReference, OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::Skill::Inline>]
            #     Safe skill metadata, preserving unresolved version selectors.
            #
            #   @param updated_at [Integer]
            #     The Unix timestamp, in seconds, when the template was last updated.
            #
            #   @param object [Symbol, :"agent.environment.template"]
            #     The object type. Always `agent.environment.template`.

            # Safe metadata for a file configured by an environment template.
            module File
              extend OpenAI::Internal::Type::Union

              discriminator :type

              # A project-scoped Files API reference resolved separately for each session.
              variant :file_id, -> { OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File::FileID }

              # Metadata for confidential inline file contents.
              variant :inline, -> { OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File::Inline }

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
              #   @return [Array(OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::File::FileID, OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::File::Inline)]
            end

            # @see OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate#network
            class Network < OpenAI::Internal::Type::BaseModel
              # @!attribute access
              #   The environment's network access mode.
              #
              #   @return [Symbol, OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::Network::Access]
              required :access, enum: -> { OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network::Access }

              # @!attribute allowed_domains
              #   Domains the environment may access when network access is restricted.
              #
              #   @return [Array<String>]
              required :allowed_domains, OpenAI::Internal::Type::ArrayOf[String]

              # @!method initialize(access:, allowed_domains:)
              #   Runtime network access for each OpenAI-hosted environment.
              #
              #   @param access [Symbol, OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::Network::Access]
              #     The environment's network access mode.
              #
              #   @param allowed_domains [Array<String>]
              #     Domains the environment may access when network access is restricted.

              # The environment's network access mode.
              #
              # @see OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::Network#access
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

            # @see OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate#packages
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
              #   Packages installed in each fresh OpenAI-hosted environment.
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
                -> { OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill::SkillReference }
              )

              # Safe metadata for an inline skill archive.
              variant :inline, -> { OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill::Inline }

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
              #   @return [Array(OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::Skill::SkillReference, OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate::Skill::Inline)]
            end
          end
        end

        EnvironmentTemplate = Environments::EnvironmentTemplate
      end
    end
  end
end
