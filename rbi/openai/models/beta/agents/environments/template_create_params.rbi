# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Environments

          class TemplateCreateParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Environments::TemplateCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

            # Directories that contain capabilities exposed to the agent. Defaults to an empty
            # list.
            sig { returns(T.nilable(T::Array[String])) }
            attr_accessor :capability_directories

            # Environment variables made available to the agent.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_accessor :env

            # Files available before the agent starts. Defaults to an empty list.
            sig {
              returns(
                T.nilable(
                  T::Array[
                    T.any(
                      OpenAI::Beta::HostedEnvironmentFileParam::FileID,
                      OpenAI::Beta::HostedEnvironmentFileParam::Inline
                    )
                  ]
                )
              )
            }
            attr_accessor :files

            # An optional human-readable display name for the template.
            sig { returns(T.nilable(String)) }
            attr_accessor :name

            # Network access for an OpenAI-hosted environment.
            sig { returns(T.nilable(OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network)) }
            attr_reader :network

            sig {
              params(network: T.nilable(OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network::OrHash)).void
            }
            attr_writer :network

            # Packages to install in an OpenAI-hosted environment.
            sig { returns(T.nilable(OpenAI::Beta::Agents::Environments::TemplateCreateParams::Packages)) }
            attr_reader :packages

            sig {
              params(packages: T.nilable(OpenAI::Beta::Agents::Environments::TemplateCreateParams::Packages::OrHash))
                .void
            }
            attr_writer :packages

            # Plugins provided as inline ZIP archives. Defaults to an empty list.
            sig { returns(T.nilable(T::Array[OpenAI::Beta::HostedPluginParam])) }
            attr_accessor :plugins

            # Ordered, confidential setup commands. Command bodies are never returned.
            sig { returns(T.nilable(T::Array[OpenAI::Beta::SetupCommandParam])) }
            attr_accessor :setup_commands

            # Skills referenced by ID or provided as inline ZIP archives. Defaults to an empty
            # list.
            sig {
              returns(
                T.nilable(
                  T::Array[
                    T.any(OpenAI::Beta::HostedSkillParam::SkillReference, OpenAI::Beta::HostedSkillParam::Inline)
                  ]
                )
              )
            }
            attr_accessor :skills

            sig do
              params(

                capability_directories: T.nilable(T::Array[String]),

                env: T.nilable(T::Hash[Symbol, String]),

                files: T.nilable(
                  T::Array[
                    T.any(
                      OpenAI::Beta::HostedEnvironmentFileParam::FileID::OrHash,
                      OpenAI::Beta::HostedEnvironmentFileParam::Inline::OrHash
                    )
                  ]
                ),

                name: T.nilable(String),

                network: T.nilable(OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network::OrHash),

                packages: T.nilable(OpenAI::Beta::Agents::Environments::TemplateCreateParams::Packages::OrHash),

                plugins: T.nilable(T::Array[OpenAI::Beta::HostedPluginParam::OrHash]),

                setup_commands: T.nilable(T::Array[OpenAI::Beta::SetupCommandParam::OrHash]),

                skills: T.nilable(
                  T::Array[
                    T.any(
                      OpenAI::Beta::HostedSkillParam::SkillReference::OrHash,
                      OpenAI::Beta::HostedSkillParam::Inline::OrHash
                    )
                  ]
                ),

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Directories that contain capabilities exposed to the agent. Defaults to an empty
              # list.
              capability_directories: nil,

              # Environment variables made available to the agent.
              env: nil,

              # Files available before the agent starts. Defaults to an empty list.
              files: nil,

              # An optional human-readable display name for the template.
              name: nil,

              # Network access for an OpenAI-hosted environment.
              network: nil,

              # Packages to install in an OpenAI-hosted environment.
              packages: nil,

              # Plugins provided as inline ZIP archives. Defaults to an empty list.
              plugins: nil,

              # Ordered, confidential setup commands. Command bodies are never returned.
              setup_commands: nil,

              # Skills referenced by ID or provided as inline ZIP archives. Defaults to an empty
              # list.
              skills: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  capability_directories: T.nilable(T::Array[String]),
                  env: T.nilable(T::Hash[Symbol, String]),
                  files: T.nilable(
                    T::Array[
                      T.any(
                        OpenAI::Beta::HostedEnvironmentFileParam::FileID,
                        OpenAI::Beta::HostedEnvironmentFileParam::Inline
                      )
                    ]
                  ),
                  name: T.nilable(String),
                  network: T.nilable(OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network),
                  packages: T.nilable(OpenAI::Beta::Agents::Environments::TemplateCreateParams::Packages),
                  plugins: T.nilable(T::Array[OpenAI::Beta::HostedPluginParam]),
                  setup_commands: T.nilable(T::Array[OpenAI::Beta::SetupCommandParam]),
                  skills: T.nilable(
                    T::Array[
                      T.any(OpenAI::Beta::HostedSkillParam::SkillReference, OpenAI::Beta::HostedSkillParam::Inline)
                    ]
                  ),
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            class Network < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network,
                  OpenAI::Internal::AnyHash
                )
              end

              # The environment's network access mode.
              sig { returns(OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network::Access::OrSymbol) }
              attr_accessor :access

              # Domains the environment may access when network access is restricted.
              sig { returns(T.nilable(T::Array[String])) }
              attr_accessor :allowed_domains

              # Network access for an OpenAI-hosted environment.
              sig do
                params(

                  access: OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network::Access::OrSymbol,

                  allowed_domains: T.nilable(T::Array[String])
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The environment's network access mode.
                access:,

                # Domains the environment may access when network access is restricted.

                allowed_domains: nil
              )
              end

              sig do
                override.returns(
                  {
                    access: OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network::Access::OrSymbol,
                    allowed_domains: T.nilable(T::Array[String])
                  }
                )
              end
              def to_hash
              end

              # The environment's network access mode.
              module Access
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol = T.type_alias {
                  T.all(Symbol, OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network::Access)
                }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                # Allows unrestricted network access, matching an omitted network policy.
                ENABLED = T.let(
                  :enabled,
                  OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network::Access::TaggedSymbol
                )

                # Disables network access.
                DISABLED = T.let(
                  :disabled,
                  OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network::Access::TaggedSymbol
                )

                # Allows access only to configured domains.
                RESTRICTED = T.let(
                  :restricted,
                  OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network::Access::TaggedSymbol
                )

                sig {
                  override.returns(
                    T::Array[OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network::Access::TaggedSymbol]
                  )
                }
                def self.values
                end
              end
            end

            class Packages < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Environments::TemplateCreateParams::Packages,
                  OpenAI::Internal::AnyHash
                )
              end

              # npm packages to install globally. Defaults to an empty list.
              sig { returns(T.nilable(T::Array[String])) }
              attr_accessor :npm

              # Python packages to install. Defaults to an empty list.
              sig { returns(T.nilable(T::Array[String])) }
              attr_accessor :python

              # System packages to install. Defaults to an empty list.
              sig { returns(T.nilable(T::Array[String])) }
              attr_accessor :system_

              # Packages to install in an OpenAI-hosted environment.
              sig do
                params(

                  npm: T.nilable(T::Array[String]),

                  python: T.nilable(T::Array[String]),

                  system_: T.nilable(T::Array[String])
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # npm packages to install globally. Defaults to an empty list.
                npm: nil,

                # Python packages to install. Defaults to an empty list.
                python: nil,

                # System packages to install. Defaults to an empty list.

                system_: nil
              )
              end

              sig do
                override.returns(
                  {
                    npm: T.nilable(T::Array[String]),
                    python: T.nilable(T::Array[String]),
                    system_: T.nilable(T::Array[String])
                  }
                )
              end
              def to_hash
              end

            end

          end

        end

      end

    end

  end
end
