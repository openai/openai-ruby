# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        EnvironmentTemplate = Environments::EnvironmentTemplate

        module Environments

          class EnvironmentTemplate < OpenAI::Internal::Type::BaseModel

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Environments::EnvironmentTemplate,
                OpenAI::Internal::AnyHash
              )
            end

            # The ID of the reusable environment template.
            sig { returns(String) }
            attr_accessor :id

            # Directories that expose capabilities to the agent.
            sig { returns(T::Array[String]) }
            attr_accessor :capability_directories

            # The Unix timestamp, in seconds, when the template was created.
            sig { returns(Integer) }
            attr_accessor :created_at

            # Safe file metadata, excluding contents and session-scoped file IDs.
            sig { returns(T::Array[OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File::Variants]) }
            attr_accessor :files

            # An optional human-readable display name for the template.
            sig { returns(T.nilable(String)) }
            attr_accessor :name

            # Runtime network access for each OpenAI-hosted environment.
            sig { returns(OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network) }
            attr_reader :network

            sig { params(network: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network::OrHash).void }
            attr_writer :network

            # The object type. Always `agent.environment.template`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Packages installed in each fresh OpenAI-hosted environment.
            sig { returns(OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Packages) }
            attr_reader :packages

            sig { params(packages: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Packages::OrHash).void }
            attr_writer :packages

            # Safe plugin metadata, excluding inline archive contents.
            sig { returns(T::Array[OpenAI::Beta::HostedPlugin]) }
            attr_accessor :plugins

            # Safe skill metadata, preserving unresolved version selectors.
            sig { returns(T::Array[OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill::Variants]) }
            attr_accessor :skills

            # The Unix timestamp, in seconds, when the template was last updated.
            sig { returns(Integer) }
            attr_accessor :updated_at

            # Reusable configuration that provisions a fresh OpenAI-hosted environment for
            # each session.
            sig do
              params(

                id: String,

                capability_directories: T::Array[String],

                created_at: Integer,

                files: T::Array[
                  T.any(
                    OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File::FileID::OrHash,
                    OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File::Inline::OrHash
                  )
                ],

                name: T.nilable(String),

                network: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network::OrHash,

                packages: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Packages::OrHash,

                plugins: T::Array[OpenAI::Beta::HostedPlugin::OrHash],

                skills: T::Array[
                  T.any(
                    OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill::SkillReference::OrHash,
                    OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill::Inline::OrHash
                  )
                ],

                updated_at: Integer,

                object: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The ID of the reusable environment template.
              id:,

              # Directories that expose capabilities to the agent.
              capability_directories:,

              # The Unix timestamp, in seconds, when the template was created.
              created_at:,

              # Safe file metadata, excluding contents and session-scoped file IDs.
              files:,

              # An optional human-readable display name for the template.
              name:,

              # Runtime network access for each OpenAI-hosted environment.
              network:,

              # Packages installed in each fresh OpenAI-hosted environment.
              packages:,

              # Safe plugin metadata, excluding inline archive contents.
              plugins:,

              # Safe skill metadata, preserving unresolved version selectors.
              skills:,

              # The Unix timestamp, in seconds, when the template was last updated.
              updated_at:,

              # The object type. Always `agent.environment.template`.

              object: :"agent.environment.template"
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  capability_directories: T::Array[String],
                  created_at: Integer,
                  files: T::Array[OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File::Variants],
                  name: T.nilable(String),
                  network: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network,
                  object: Symbol,
                  packages: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Packages,
                  plugins: T::Array[OpenAI::Beta::HostedPlugin],
                  skills: T::Array[OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill::Variants],
                  updated_at: Integer
                }
              )
            end
            def to_hash
            end

            # Safe metadata for a file configured by an environment template.
            module File
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(
                  OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File::FileID,
                  OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File::Inline
                )
              }

              class FileID < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File::FileID,
                    OpenAI::Internal::AnyHash
                  )
                end

                # The ID of the uploaded file.
                sig { returns(String) }
                attr_accessor :file_id

                # The file's absolute path inside the environment.
                sig { returns(String) }
                attr_accessor :path

                # The type of the object. Always `file_id`.
                sig { returns(Symbol) }
                attr_accessor :type

                # A project-scoped Files API reference resolved separately for each session.
                sig do
                  params(

                    file_id: String,

                    path: String,

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # The ID of the uploaded file.
                  file_id:,

                  # The file's absolute path inside the environment.
                  path:,

                  # The type of the object. Always `file_id`.

                  type: :file_id
                )
                end

                sig do
                  override.returns(
                    {file_id: String, path: String, type: Symbol}
                  )
                end
                def to_hash
                end

              end

              class Inline < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File::Inline,
                    OpenAI::Internal::AnyHash
                  )
                end

                # The file's absolute path inside the environment.
                sig { returns(String) }
                attr_accessor :path

                # The decoded size of the inline file in bytes.
                sig { returns(Integer) }
                attr_accessor :size_bytes

                # The type of the object. Always `inline`.
                sig { returns(Symbol) }
                attr_accessor :type

                # Metadata for confidential inline file contents.
                sig do
                  params(

                    path: String,

                    size_bytes: Integer,

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # The file's absolute path inside the environment.
                  path:,

                  # The decoded size of the inline file in bytes.
                  size_bytes:,

                  # The type of the object. Always `inline`.

                  type: :inline
                )
                end

                sig do
                  override.returns(
                    {path: String, size_bytes: Integer, type: Symbol}
                  )
                end
                def to_hash
                end

              end

              sig {
                override.returns(T::Array[OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File::Variants])
              }
              def self.variants
              end

            end

            class Network < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network,
                  OpenAI::Internal::AnyHash
                )
              end

              # The environment's network access mode.
              sig { returns(OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network::Access::TaggedSymbol) }
              attr_accessor :access

              # Domains the environment may access when network access is restricted.
              sig { returns(T::Array[String]) }
              attr_accessor :allowed_domains

              # Runtime network access for each OpenAI-hosted environment.
              sig do
                params(

                  access: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network::Access::OrSymbol,

                  allowed_domains: T::Array[String]
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The environment's network access mode.
                access:,

                # Domains the environment may access when network access is restricted.

                allowed_domains:
              )
              end

              sig do
                override.returns(
                  {
                    access: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network::Access::TaggedSymbol,
                    allowed_domains: T::Array[String]
                  }
                )
              end
              def to_hash
              end

              # The environment's network access mode.
              module Access
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol = T.type_alias {
                  T.all(Symbol, OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network::Access)
                }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                # Allows unrestricted network access.
                ENABLED = T.let(
                  :enabled,
                  OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network::Access::TaggedSymbol
                )

                # Disables network access.
                DISABLED = T.let(
                  :disabled,
                  OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network::Access::TaggedSymbol
                )

                # Allows access only to configured domains.
                RESTRICTED = T.let(
                  :restricted,
                  OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network::Access::TaggedSymbol
                )

                sig {
                  override.returns(
                    T::Array[OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network::Access::TaggedSymbol]
                  )
                }
                def self.values
                end
              end
            end

            class Packages < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Packages,
                  OpenAI::Internal::AnyHash
                )
              end

              # npm packages installed globally in the environment.
              sig { returns(T::Array[String]) }
              attr_accessor :npm

              # Python packages installed in the environment.
              sig { returns(T::Array[String]) }
              attr_accessor :python

              # System packages installed in the environment.
              sig { returns(T::Array[String]) }
              attr_accessor :system_

              # Packages installed in each fresh OpenAI-hosted environment.
              sig do
                params(

                  npm: T::Array[String],

                  python: T::Array[String],

                  system_: T::Array[String]
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # npm packages installed globally in the environment.
                npm:,

                # Python packages installed in the environment.
                python:,

                # System packages installed in the environment.

                system_:
              )
              end

              sig do
                override.returns(
                  {npm: T::Array[String], python: T::Array[String], system_: T::Array[String]}
                )
              end
              def to_hash
              end

            end

            # Safe metadata for a skill configured by an environment template.
            module Skill
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(
                  OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill::SkillReference,
                  OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill::Inline
                )
              }

              class SkillReference < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill::SkillReference,
                    OpenAI::Internal::AnyHash
                  )
                end

                # The referenced skill ID.
                sig { returns(String) }
                attr_accessor :skill_id

                # The type of the object. Always `skill_reference`.
                sig { returns(Symbol) }
                attr_accessor :type

                # The requested version selector, including `latest`.
                sig { returns(T.nilable(String)) }
                attr_accessor :version

                # A skill resolved afresh from the Skills API whenever a session starts.
                sig do
                  params(

                    skill_id: String,

                    version: T.nilable(String),

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # The referenced skill ID.
                  skill_id:,

                  # The requested version selector, including `latest`.
                  version:,

                  # The type of the object. Always `skill_reference`.

                  type: :skill_reference
                )
                end

                sig do
                  override.returns(
                    {skill_id: String, type: Symbol, version: T.nilable(String)}
                  )
                end
                def to_hash
                end

              end

              class Inline < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill::Inline,
                    OpenAI::Internal::AnyHash
                  )
                end

                # The skill description declared in `SKILL.md`.
                sig { returns(String) }
                attr_accessor :description

                # The skill name declared in `SKILL.md`.
                sig { returns(String) }
                attr_accessor :name

                # The type of the object. Always `inline`.
                sig { returns(Symbol) }
                attr_accessor :type

                # Safe metadata for an inline skill archive.
                sig do
                  params(

                    description: String,

                    name: String,

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # The skill description declared in `SKILL.md`.
                  description:,

                  # The skill name declared in `SKILL.md`.
                  name:,

                  # The type of the object. Always `inline`.

                  type: :inline
                )
                end

                sig do
                  override.returns(
                    {description: String, name: String, type: Symbol}
                  )
                end
                def to_hash
                end

              end

              sig {
                override.returns(T::Array[OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill::Variants])
              }
              def self.variants
              end

            end

          end

        end

      end

    end

  end
end
