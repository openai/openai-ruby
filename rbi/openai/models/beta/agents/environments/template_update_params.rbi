# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Environments

          class TemplateUpdateParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Environments::TemplateUpdateParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :environment_template_id

            # Directories that expose capabilities to the agent.
            sig { returns(T.nilable(T::Array[String])) }
            attr_accessor :capability_directories

            # Replacement confidential environment values.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_accessor :env

            # Replacement file configuration materialized for each new session.
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

            # A replacement human-readable display name, or `null` to clear the name.
            sig { returns(T.nilable(String)) }
            attr_accessor :name

            # Network access for an OpenAI-hosted environment.
            sig { returns(T.nilable(OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network)) }
            attr_reader :network

            sig {
              params(network: T.nilable(OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network::OrHash)).void
            }
            attr_writer :network

            # Packages to install in an OpenAI-hosted environment.
            sig { returns(T.nilable(OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Packages)) }
            attr_reader :packages

            sig {
              params(packages: T.nilable(OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Packages::OrHash))
                .void
            }
            attr_writer :packages

            # Replacement plugin configuration installed for each new session.
            sig { returns(T.nilable(T::Array[OpenAI::Beta::HostedPluginParam])) }
            attr_accessor :plugins

            # Replacement confidential setup commands, never included in returned resources.
            sig { returns(T.nilable(T::Array[OpenAI::Beta::SetupCommandParam])) }
            attr_accessor :setup_commands

            # Replacement skill configuration installed for each new session.
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

                environment_template_id: String,

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

                network: T.nilable(OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network::OrHash),

                packages: T.nilable(OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Packages::OrHash),

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

              environment_template_id:,

              # Directories that expose capabilities to the agent.
              capability_directories: nil,

              # Replacement confidential environment values.
              env: nil,

              # Replacement file configuration materialized for each new session.
              files: nil,

              # A replacement human-readable display name, or `null` to clear the name.
              name: nil,

              # Network access for an OpenAI-hosted environment.
              network: nil,

              # Packages to install in an OpenAI-hosted environment.
              packages: nil,

              # Replacement plugin configuration installed for each new session.
              plugins: nil,

              # Replacement confidential setup commands, never included in returned resources.
              setup_commands: nil,

              # Replacement skill configuration installed for each new session.
              skills: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  environment_template_id: String,
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
                  network: T.nilable(OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network),
                  packages: T.nilable(OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Packages),
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
                  OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network,
                  OpenAI::Internal::AnyHash
                )
              end

              # The environment's network access mode.
              sig { returns(OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network::Access::OrSymbol) }
              attr_accessor :access

              # Domains the environment may access when network access is restricted.
              sig { returns(T.nilable(T::Array[String])) }
              attr_accessor :allowed_domains

              # Network access for an OpenAI-hosted environment.
              sig do
                params(

                  access: OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network::Access::OrSymbol,

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
                    access: OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network::Access::OrSymbol,
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
                  T.all(Symbol, OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network::Access)
                }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                # Allows unrestricted network access, matching an omitted network policy.
                ENABLED = T.let(
                  :enabled,
                  OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network::Access::TaggedSymbol
                )

                # Disables network access.
                DISABLED = T.let(
                  :disabled,
                  OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network::Access::TaggedSymbol
                )

                # Allows access only to configured domains.
                RESTRICTED = T.let(
                  :restricted,
                  OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network::Access::TaggedSymbol
                )

                sig {
                  override.returns(
                    T::Array[OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network::Access::TaggedSymbol]
                  )
                }
                def self.values
                end
              end
            end

            class Packages < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Packages,
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
