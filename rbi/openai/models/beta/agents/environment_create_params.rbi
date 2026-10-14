# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class EnvironmentCreateParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::EnvironmentCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

          # The required hosting type and its configuration.
          sig { returns(OpenAI::Beta::Agents::EnvironmentCreateParams::Environment) }
          attr_reader :environment

          sig { params(environment: OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::OrHash).void }
          attr_writer :environment

          # The IDs of up to 10 vaults made available to an OpenAI-hosted environment.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :vault_ids

          sig { returns(T.nilable(String)) }
          attr_reader :idempotency_key

          sig { params(idempotency_key: String).void }
          attr_writer :idempotency_key

          sig do
            params(

              environment: OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::OrHash,

              vault_ids: T.nilable(T::Array[String]),

              idempotency_key: String,

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The required hosting type and its configuration.
            environment:,

            # The IDs of up to 10 vaults made available to an OpenAI-hosted environment.
            vault_ids: nil,

            idempotency_key: nil,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                environment: OpenAI::Beta::Agents::EnvironmentCreateParams::Environment,
                vault_ids: T.nilable(T::Array[String]),
                idempotency_key: String,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          class Environment < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::EnvironmentCreateParams::Environment,
                OpenAI::Internal::AnyHash
              )
            end

            # The type of the object. Always `openai_hosted`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Directories that contain capabilities exposed to the agent. Defaults to an empty
            # list.
            sig { returns(T.nilable(T::Array[String])) }
            attr_accessor :capability_directories

            # Desktop provisioning. Omission or null inherits the template setting, or
            # defaults to disabled.
            sig { returns(T.nilable(OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Desktop)) }
            attr_reader :desktop

            sig {
              params(desktop: T.nilable(OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Desktop::OrHash))
                .void
            }
            attr_writer :desktop

            # Environment variables made available to the agent.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_accessor :env

            # A reusable hosted template applied before inline configuration. Omitted fields
            # inherit the template; network overrides cannot broaden its policy.
            sig { returns(T.nilable(String)) }
            attr_reader :environment_template_id

            sig { params(environment_template_id: String).void }
            attr_writer :environment_template_id

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

            # Network access policy for the environment. If omitted, the API version
            # determines whether network access is enabled or disabled.
            sig { returns(T.nilable(OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network)) }
            attr_reader :network

            sig {
              params(network: T.nilable(OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network::OrHash))
                .void
            }
            attr_writer :network

            # Packages to install in the environment. Defaults to empty package lists.
            sig { returns(T.nilable(OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Packages)) }
            attr_reader :packages

            sig {
              params(packages: T.nilable(OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Packages::OrHash))
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

            # The required hosting type and its configuration.
            sig do
              params(

                capability_directories: T.nilable(T::Array[String]),

                desktop: T.nilable(OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Desktop::OrHash),

                env: T.nilable(T::Hash[Symbol, String]),

                environment_template_id: String,

                files: T.nilable(
                  T::Array[
                    T.any(
                      OpenAI::Beta::HostedEnvironmentFileParam::FileID::OrHash,
                      OpenAI::Beta::HostedEnvironmentFileParam::Inline::OrHash
                    )
                  ]
                ),

                network: T.nilable(OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network::OrHash),

                packages: T.nilable(OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Packages::OrHash),

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

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Directories that contain capabilities exposed to the agent. Defaults to an empty
              # list.
              capability_directories: nil,

              # Desktop provisioning. Omission or null inherits the template setting, or
              # defaults to disabled.
              desktop: nil,

              # Environment variables made available to the agent.
              env: nil,

              # A reusable hosted template applied before inline configuration. Omitted fields
              # inherit the template; network overrides cannot broaden its policy.
              environment_template_id: nil,

              # Files available before the agent starts. Defaults to an empty list.
              files: nil,

              # Network access policy for the environment. If omitted, the API version
              # determines whether network access is enabled or disabled.
              network: nil,

              # Packages to install in the environment. Defaults to empty package lists.
              packages: nil,

              # Plugins provided as inline ZIP archives. Defaults to an empty list.
              plugins: nil,

              # Ordered, confidential setup commands. Command bodies are never returned.
              setup_commands: nil,

              # Skills referenced by ID or provided as inline ZIP archives. Defaults to an empty
              # list.
              skills: nil,

              # The type of the object. Always `openai_hosted`.

              type: :openai_hosted
            )
            end

            sig do
              override.returns(
                {
                  type: Symbol,
                  capability_directories: T.nilable(T::Array[String]),
                  desktop: T.nilable(OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Desktop),
                  env: T.nilable(T::Hash[Symbol, String]),
                  environment_template_id: String,
                  files: T.nilable(
                    T::Array[
                      T.any(
                        OpenAI::Beta::HostedEnvironmentFileParam::FileID,
                        OpenAI::Beta::HostedEnvironmentFileParam::Inline
                      )
                    ]
                  ),
                  network: T.nilable(OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network),
                  packages: T.nilable(OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Packages),
                  plugins: T.nilable(T::Array[OpenAI::Beta::HostedPluginParam]),
                  setup_commands: T.nilable(T::Array[OpenAI::Beta::SetupCommandParam]),
                  skills: T.nilable(
                    T::Array[
                      T.any(OpenAI::Beta::HostedSkillParam::SkillReference, OpenAI::Beta::HostedSkillParam::Inline)
                    ]
                  )
                }
              )
            end
            def to_hash
            end

            class Desktop < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Desktop,
                  OpenAI::Internal::AnyHash
                )
              end

              # Whether to provision the desktop and its browser proxy.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # Desktop provisioning. Omission or null inherits the template setting, or
              # defaults to disabled.
              sig do
                params(

                  enabled: T::Boolean
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Whether to provision the desktop and its browser proxy.

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

            class Network < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network,
                  OpenAI::Internal::AnyHash
                )
              end

              # The environment's network access mode.
              sig { returns(OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network::Access::OrSymbol) }
              attr_accessor :access

              # Domains the environment may access when network access is restricted.
              sig { returns(T.nilable(T::Array[String])) }
              attr_accessor :allowed_domains

              # Domains blocked for both executor and browser when access is restricted. A
              # nonempty list requires `access: restricted` and cannot be combined with nonempty
              # `allowed_domains`. Wildcard domains are not supported.
              sig { returns(T.nilable(T::Array[String])) }
              attr_accessor :blocked_domains

              # Network access policy for the environment. If omitted, the API version
              # determines whether network access is enabled or disabled.
              sig do
                params(

                  access: OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network::Access::OrSymbol,

                  allowed_domains: T.nilable(T::Array[String]),

                  blocked_domains: T.nilable(T::Array[String])
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The environment's network access mode.
                access:,

                # Domains the environment may access when network access is restricted.
                allowed_domains: nil,

                # Domains blocked for both executor and browser when access is restricted. A
                # nonempty list requires `access: restricted` and cannot be combined with nonempty
                # `allowed_domains`. Wildcard domains are not supported.

                blocked_domains: nil
              )
              end

              sig do
                override.returns(
                  {
                    access: OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network::Access::OrSymbol,
                    allowed_domains: T.nilable(T::Array[String]),
                    blocked_domains: T.nilable(T::Array[String])
                  }
                )
              end
              def to_hash
              end

              # The environment's network access mode.
              module Access
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol = T.type_alias {
                  T.all(Symbol, OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network::Access)
                }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                # Allows unrestricted network access.
                ENABLED = T.let(
                  :enabled,
                  OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network::Access::TaggedSymbol
                )

                # Disables network access.
                DISABLED = T.let(
                  :disabled,
                  OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network::Access::TaggedSymbol
                )

                # Applies the configured domain restrictions.
                RESTRICTED = T.let(
                  :restricted,
                  OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network::Access::TaggedSymbol
                )

                sig {
                  override.returns(
                    T::Array[OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Network::Access::TaggedSymbol]
                  )
                }
                def self.values
                end
              end
            end

            class Packages < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::Packages,
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

              # Packages to install in the environment. Defaults to empty package lists.
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
