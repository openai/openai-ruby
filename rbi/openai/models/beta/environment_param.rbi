# typed: strong

module OpenAI
  module Models

    module Beta

      # The execution environment and optional reusable template for a session.
      module EnvironmentParam
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::EnvironmentParam::None,
            OpenAI::Beta::EnvironmentParam::OpenAIHosted,
            OpenAI::Beta::EnvironmentParam::SelfHosted
          )
        end

        class None < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::EnvironmentParam::None,
              OpenAI::Internal::AnyHash
            )
          end

          # The type of the object. Always `none`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Runs the agent without an execution environment.
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
              OpenAI::Beta::EnvironmentParam::OpenAIHosted,
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

          # Environment variables made available to the agent.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :env

          # A reusable hosted template applied before inline session configuration. Omitted
          # fields inherit the template; network overrides cannot broaden its policy.
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

          # Network access for an OpenAI-hosted environment.
          sig { returns(T.nilable(OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network)) }
          attr_reader :network

          sig { params(network: T.nilable(OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network::OrHash)).void }
          attr_writer :network

          # Packages to install in an OpenAI-hosted environment.
          sig { returns(T.nilable(OpenAI::Beta::EnvironmentParam::OpenAIHosted::Packages)) }
          attr_reader :packages

          sig { params(packages: T.nilable(OpenAI::Beta::EnvironmentParam::OpenAIHosted::Packages::OrHash)).void }
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
                T::Array[T.any(OpenAI::Beta::HostedSkillParam::SkillReference, OpenAI::Beta::HostedSkillParam::Inline)]
              )
            )
          }
          attr_accessor :skills

          # An OpenAI-hosted environment, optionally based on a reusable template.
          sig do
            params(

              capability_directories: T.nilable(T::Array[String]),

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

              network: T.nilable(OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network::OrHash),

              packages: T.nilable(OpenAI::Beta::EnvironmentParam::OpenAIHosted::Packages::OrHash),

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

            # Environment variables made available to the agent.
            env: nil,

            # A reusable hosted template applied before inline session configuration. Omitted
            # fields inherit the template; network overrides cannot broaden its policy.
            environment_template_id: nil,

            # Files available before the agent starts. Defaults to an empty list.
            files: nil,

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

            # The type of the object. Always `openai_hosted`.

            type: :openai_hosted
          )
          end

          sig do
            override.returns(
              {
                type: Symbol,
                capability_directories: T.nilable(T::Array[String]),
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
                network: T.nilable(OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network),
                packages: T.nilable(OpenAI::Beta::EnvironmentParam::OpenAIHosted::Packages),
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

          class Network < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network,
                OpenAI::Internal::AnyHash
              )
            end

            # The environment's network access mode.
            sig { returns(OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network::Access::OrSymbol) }
            attr_accessor :access

            # Domains the environment may access when network access is restricted.
            sig { returns(T.nilable(T::Array[String])) }
            attr_accessor :allowed_domains

            # Network access for an OpenAI-hosted environment.
            sig do
              params(

                access: OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network::Access::OrSymbol,

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
                  access: OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network::Access::OrSymbol,
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
                T.all(Symbol, OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network::Access)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              # Allows unrestricted network access, matching an omitted network policy.
              ENABLED = T.let(:enabled, OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network::Access::TaggedSymbol)

              # Disables network access.
              DISABLED = T.let(:disabled, OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network::Access::TaggedSymbol)

              # Allows access only to configured domains.
              RESTRICTED = T.let(
                :restricted,
                OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network::Access::TaggedSymbol
              )

              sig {
                override.returns(T::Array[OpenAI::Beta::EnvironmentParam::OpenAIHosted::Network::Access::TaggedSymbol])
              }
              def self.values
              end
            end
          end

          class Packages < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::EnvironmentParam::OpenAIHosted::Packages,
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

        class SelfHosted < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::EnvironmentParam::SelfHosted,
              OpenAI::Internal::AnyHash
            )
          end

          # The type of the object. Always `self_hosted`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Absolute project directory inside the self-hosted environment.
          sig { returns(String) }
          attr_accessor :workspace_directory

          # Directories that contain capabilities exposed to the agent. Defaults to an empty
          # list.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :capability_directories

          # An application-hosted environment configured inline.
          sig do
            params(

              workspace_directory: String,

              capability_directories: T.nilable(T::Array[String]),

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Absolute project directory inside the self-hosted environment.
            workspace_directory:,

            # Directories that contain capabilities exposed to the agent. Defaults to an empty
            # list.
            capability_directories: nil,

            # The type of the object. Always `self_hosted`.

            type: :self_hosted
          )
          end

          sig do
            override.returns(
              {type: Symbol, workspace_directory: String, capability_directories: T.nilable(T::Array[String])}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::EnvironmentParam::Variants]) }
        def self.variants
        end

      end

    end

  end
end
