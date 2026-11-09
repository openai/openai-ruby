# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        # Environment selection saved before an invocation creates its session.
        module AutomationEnvironment
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::AutomationEnvironment::None,
              OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted,
              OpenAI::Beta::Agents::AutomationEnvironment::SelfHosted
            )
          end

          class None < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::AutomationEnvironment::None,
                OpenAI::Internal::AnyHash
              )
            end

            # The type of the object. Always `none`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The type of the object. Always `none`.

              type: :none
            )
            end

            sig do
              override.returns(
                {type: Symbol}
              )
            end
            def to_hash
            end

          end

          class OpenAIHosted < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted,
                OpenAI::Internal::AnyHash
              )
            end

            # Directory overrides, or null to inherit the template or creation default.
            sig { returns(T.nilable(T::Array[String])) }
            attr_accessor :capability_directories

            # The configured container size, or null to use the creation default.
            sig {
              returns(T.nilable(OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::ContainerSize::TaggedSymbol))
            }
            attr_accessor :container_size

            # Desktop overrides, or null to inherit the template or creation default.
            sig { returns(T.nilable(OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Desktop)) }
            attr_reader :desktop

            sig {
              params(desktop: T.nilable(OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Desktop::OrHash))
                .void
            }
            attr_writer :desktop

            # An existing environment reference, or null when provisioning a new environment.
            sig { returns(T.nilable(String)) }
            attr_accessor :environment_id

            # A template reference, or null when no template is selected.
            sig { returns(T.nilable(String)) }
            attr_accessor :environment_template_id

            # File overrides, excluding contents, or null to inherit.
            sig {
              returns(T.nilable(T::Array[OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::Variants]))
            }
            attr_accessor :files

            # Network overrides, or null to inherit the template or creation default.
            sig { returns(T.nilable(OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network)) }
            attr_reader :network

            sig {
              params(network: T.nilable(OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network::OrHash))
                .void
            }
            attr_writer :network

            # Package overrides, or null to inherit the template or creation default.
            sig { returns(T.nilable(OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Packages)) }
            attr_reader :packages

            sig {
              params(packages: T.nilable(OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Packages::OrHash))
                .void
            }
            attr_writer :packages

            # Plugin overrides, excluding archive contents, or null to inherit.
            sig { returns(T.nilable(T::Array[OpenAI::Beta::HostedPlugin])) }
            attr_accessor :plugins

            # Skill overrides, excluding archive contents, or null to inherit.
            sig {
              returns(T.nilable(T::Array[OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::Variants]))
            }
            attr_accessor :skills

            # The type of the object. Always `openai_hosted`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Hosted environment selection with confidential setup commands and variables
            # omitted.
            sig do
              params(

                capability_directories: T.nilable(T::Array[String]),

                container_size: T.nilable(
                  OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::ContainerSize::OrSymbol
                ),

                desktop: T.nilable(OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Desktop::OrHash),

                environment_id: T.nilable(String),

                environment_template_id: T.nilable(String),

                files: T.nilable(
                  T::Array[
                    T.any(
                      OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::FileID::OrHash,
                      OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::Inline::OrHash
                    )
                  ]
                ),

                network: T.nilable(OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network::OrHash),

                packages: T.nilable(OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Packages::OrHash),

                plugins: T.nilable(T::Array[OpenAI::Beta::HostedPlugin::OrHash]),

                skills: T.nilable(
                  T::Array[
                    T.any(
                      OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::SkillReference::OrHash,
                      OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::Inline::OrHash
                    )
                  ]
                ),

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Directory overrides, or null to inherit the template or creation default.
              capability_directories:,

              # The configured container size, or null to use the creation default.
              container_size:,

              # Desktop overrides, or null to inherit the template or creation default.
              desktop:,

              # An existing environment reference, or null when provisioning a new environment.
              environment_id:,

              # A template reference, or null when no template is selected.
              environment_template_id:,

              # File overrides, excluding contents, or null to inherit.
              files:,

              # Network overrides, or null to inherit the template or creation default.
              network:,

              # Package overrides, or null to inherit the template or creation default.
              packages:,

              # Plugin overrides, excluding archive contents, or null to inherit.
              plugins:,

              # Skill overrides, excluding archive contents, or null to inherit.
              skills:,

              # The type of the object. Always `openai_hosted`.

              type: :openai_hosted
            )
            end

            sig do
              override.returns(
                {
                  capability_directories: T.nilable(T::Array[String]),
                  container_size: T.nilable(
                    OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::ContainerSize::TaggedSymbol
                  ),
                  desktop: T.nilable(OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Desktop),
                  environment_id: T.nilable(String),
                  environment_template_id: T.nilable(String),
                  files: T.nilable(T::Array[OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::Variants]),
                  network: T.nilable(OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network),
                  packages: T.nilable(OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Packages),
                  plugins: T.nilable(T::Array[OpenAI::Beta::HostedPlugin]),
                  skills: T.nilable(
                    T::Array[OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::Variants]
                  ),
                  type: Symbol
                }
              )
            end
            def to_hash
            end

            # The configured container size, or null to use the creation default.
            module ContainerSize
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::ContainerSize)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              SMALL = T.let(
                :small,
                OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::ContainerSize::TaggedSymbol
              )
              MEDIUM = T.let(
                :medium,
                OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::ContainerSize::TaggedSymbol
              )
              LARGE = T.let(
                :large,
                OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::ContainerSize::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::ContainerSize::TaggedSymbol]
                )
              }
              def self.values
              end
            end

            class Desktop < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Desktop,
                  OpenAI::Internal::AnyHash
                )
              end

              # Whether the environment provisions a desktop and browser proxy.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # Desktop overrides, or null to inherit the template or creation default.
              sig do
                params(

                  enabled: T::Boolean
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Whether the environment provisions a desktop and browser proxy.

                enabled:
              )
              end

              sig do
                override.returns(
                  {enabled: T::Boolean}
                )
              end
              def to_hash
              end

            end

            # Safe metadata for a file configured by an environment template.
            module File
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(
                  OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::FileID,
                  OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::Inline
                )
              }

              class FileID < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::FileID,
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
                    OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::Inline,
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
                override.returns(T::Array[OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::File::Variants])
              }
              def self.variants
              end

            end

            class Network < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network,
                  OpenAI::Internal::AnyHash
                )
              end

              # The environment's network access mode.
              sig { returns(OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network::Access::TaggedSymbol) }
              attr_accessor :access

              # Domains the environment may access when network access is restricted.
              sig { returns(T::Array[String]) }
              attr_accessor :allowed_domains

              # Network overrides, or null to inherit the template or creation default.
              sig do
                params(

                  access: OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network::Access::OrSymbol,

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
                    access: OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network::Access::TaggedSymbol,
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
                  T.all(Symbol, OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network::Access)
                }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                # Allows unrestricted network access.
                ENABLED = T.let(
                  :enabled,
                  OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network::Access::TaggedSymbol
                )

                # Disables network access.
                DISABLED = T.let(
                  :disabled,
                  OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network::Access::TaggedSymbol
                )

                # Applies the configured domain restrictions.
                RESTRICTED = T.let(
                  :restricted,
                  OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network::Access::TaggedSymbol
                )

                sig {
                  override.returns(
                    T::Array[OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Network::Access::TaggedSymbol]
                  )
                }
                def self.values
                end
              end
            end

            class Packages < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Packages,
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

              # Package overrides, or null to inherit the template or creation default.
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
                  OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::SkillReference,
                  OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::Inline
                )
              }

              class SkillReference < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::SkillReference,
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
                    OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::Inline,
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
                override.returns(T::Array[OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::Skill::Variants])
              }
              def self.variants
              end

            end
          end

          class SelfHosted < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::AutomationEnvironment::SelfHosted,
                OpenAI::Internal::AnyHash
              )
            end

            # Directories that expose capabilities to the agent.
            sig { returns(T::Array[String]) }
            attr_accessor :capability_directories

            # An existing registration, or null to create a session-owned environment.
            sig { returns(T.nilable(String)) }
            attr_accessor :environment_id

            # The type of the object. Always `self_hosted`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The absolute project directory in the environment.
            sig { returns(String) }
            attr_accessor :workspace_directory

            sig do
              params(

                capability_directories: T::Array[String],

                environment_id: T.nilable(String),

                workspace_directory: String,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Directories that expose capabilities to the agent.
              capability_directories:,

              # An existing registration, or null to create a session-owned environment.
              environment_id:,

              # The absolute project directory in the environment.
              workspace_directory:,

              # The type of the object. Always `self_hosted`.

              type: :self_hosted
            )
            end

            sig do
              override.returns(
                {
                  capability_directories: T::Array[String],
                  environment_id: T.nilable(String),
                  type: Symbol,
                  workspace_directory: String
                }
              )
            end
            def to_hash
            end

          end

          sig { override.returns(T::Array[OpenAI::Beta::Agents::AutomationEnvironment::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
