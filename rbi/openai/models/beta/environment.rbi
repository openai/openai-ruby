# typed: strong

module OpenAI
  module Models

    module Beta

      # The execution environment for a session.
      module Environment
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::Environment::None,
            OpenAI::Beta::Environment::OpenAIHosted,
            OpenAI::Beta::Environment::SelfHosted
          )
        end

        class None < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Environment::None,
              OpenAI::Internal::AnyHash
            )
          end

          # The type of the object. Always `none`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The session talks to CCA without selecting or provisioning an execution
          # environment.
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
              OpenAI::Beta::Environment::OpenAIHosted,
              OpenAI::Internal::AnyHash
            )
          end

          # The public ID of the environment.
          sig { returns(String) }
          attr_accessor :id

          # Directories that contain capabilities exposed to the agent.
          sig { returns(T::Array[String]) }
          attr_accessor :capability_directories

          # Files available in the environment, excluding their contents.
          sig { returns(T::Array[OpenAI::Beta::HostedEnvironmentFile::Variants]) }
          attr_accessor :files

          # The effective network access policy for the environment.
          sig { returns(OpenAI::Beta::Environment::OpenAIHosted::Network) }
          attr_reader :network

          sig { params(network: OpenAI::Beta::Environment::OpenAIHosted::Network::OrHash).void }
          attr_writer :network

          # Packages installed in the environment.
          sig { returns(OpenAI::Beta::Environment::OpenAIHosted::Packages) }
          attr_reader :packages

          sig { params(packages: OpenAI::Beta::Environment::OpenAIHosted::Packages::OrHash).void }
          attr_writer :packages

          # Plugins installed in the environment, excluding their archive contents.
          sig { returns(T::Array[OpenAI::Beta::HostedPlugin]) }
          attr_accessor :plugins

          # Skills installed in the environment, excluding their archive contents.
          sig { returns(T::Array[OpenAI::Beta::HostedSkill::Variants]) }
          attr_accessor :skills

          # The type of the object. Always `openai_hosted`.
          sig { returns(Symbol) }
          attr_accessor :type

          # An environment hosted by OpenAI.
          sig do
            params(

              id: String,

              capability_directories: T::Array[String],

              files: T::Array[
                T.any(
                  OpenAI::Beta::HostedEnvironmentFileID::OrHash,
                  OpenAI::Beta::HostedEnvironmentFile::Inline::OrHash
                )
              ],

              network: OpenAI::Beta::Environment::OpenAIHosted::Network::OrHash,

              packages: OpenAI::Beta::Environment::OpenAIHosted::Packages::OrHash,

              plugins: T::Array[OpenAI::Beta::HostedPlugin::OrHash],

              skills: T::Array[
                T.any(OpenAI::Beta::HostedSkillReference::OrHash, OpenAI::Beta::HostedSkill::Inline::OrHash)
              ],

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The public ID of the environment.
            id:,

            # Directories that contain capabilities exposed to the agent.
            capability_directories:,

            # Files available in the environment, excluding their contents.
            files:,

            # The effective network access policy for the environment.
            network:,

            # Packages installed in the environment.
            packages:,

            # Plugins installed in the environment, excluding their archive contents.
            plugins:,

            # Skills installed in the environment, excluding their archive contents.
            skills:,

            # The type of the object. Always `openai_hosted`.

            type: :openai_hosted
          )
          end

          sig do
            override.returns(
              {
                id: String,
                capability_directories: T::Array[String],
                files: T::Array[OpenAI::Beta::HostedEnvironmentFile::Variants],
                network: OpenAI::Beta::Environment::OpenAIHosted::Network,
                packages: OpenAI::Beta::Environment::OpenAIHosted::Packages,
                plugins: T::Array[OpenAI::Beta::HostedPlugin],
                skills: T::Array[OpenAI::Beta::HostedSkill::Variants],
                type: Symbol
              }
            )
          end
          def to_hash
          end

          class Network < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Environment::OpenAIHosted::Network,
                OpenAI::Internal::AnyHash
              )
            end

            # The environment's network access mode.
            sig { returns(OpenAI::Beta::Environment::OpenAIHosted::Network::Access::TaggedSymbol) }
            attr_accessor :access

            # Domains the environment may access when network access is restricted.
            sig { returns(T::Array[String]) }
            attr_accessor :allowed_domains

            # The effective network access policy for the environment.
            sig do
              params(

                access: OpenAI::Beta::Environment::OpenAIHosted::Network::Access::OrSymbol,

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
                  access: OpenAI::Beta::Environment::OpenAIHosted::Network::Access::TaggedSymbol,
                  allowed_domains: T::Array[String]
                }
              )
            end
            def to_hash
            end

            # The environment's network access mode.
            module Access
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Environment::OpenAIHosted::Network::Access) }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              # Allows unrestricted network access.
              ENABLED = T.let(:enabled, OpenAI::Beta::Environment::OpenAIHosted::Network::Access::TaggedSymbol)

              # Disables network access.
              DISABLED = T.let(:disabled, OpenAI::Beta::Environment::OpenAIHosted::Network::Access::TaggedSymbol)

              # Allows access only to configured domains.
              RESTRICTED = T.let(:restricted, OpenAI::Beta::Environment::OpenAIHosted::Network::Access::TaggedSymbol)

              sig {
                override.returns(T::Array[OpenAI::Beta::Environment::OpenAIHosted::Network::Access::TaggedSymbol])
              }
              def self.values
              end
            end
          end

          class Packages < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Environment::OpenAIHosted::Packages,
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

            # Packages installed in the environment.
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
        end

        class SelfHosted < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Environment::SelfHosted,
              OpenAI::Internal::AnyHash
            )
          end

          # The public ID of the environment.
          sig { returns(String) }
          attr_accessor :id

          # Directories that contain capabilities exposed to the agent.
          sig { returns(T::Array[String]) }
          attr_accessor :capability_directories

          # Pass this URL unchanged to `codex exec-server --remote` when connecting this
          # environment.
          sig { returns(String) }
          attr_accessor :remote_url

          # The type of the object. Always `self_hosted`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The absolute project directory inside the environment. Defaults to `/workspace`.
          sig { returns(String) }
          attr_accessor :workspace_directory

          # An environment hosted by the application.
          sig do
            params(

              id: String,

              capability_directories: T::Array[String],

              remote_url: String,

              workspace_directory: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The public ID of the environment.
            id:,

            # Directories that contain capabilities exposed to the agent.
            capability_directories:,

            # Pass this URL unchanged to `codex exec-server --remote` when connecting this
            # environment.
            remote_url:,

            # The absolute project directory inside the environment. Defaults to `/workspace`.
            workspace_directory:,

            # The type of the object. Always `self_hosted`.

            type: :self_hosted
          )
          end

          sig do
            override.returns(
              {
                id: String,
                capability_directories: T::Array[String],
                remote_url: String,
                type: Symbol,
                workspace_directory: String
              }
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::Environment::Variants]) }
        def self.variants
        end

      end

    end

  end
end
