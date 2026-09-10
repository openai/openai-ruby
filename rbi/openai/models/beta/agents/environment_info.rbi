# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class EnvironmentInfo < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::EnvironmentInfo,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the environment.
          sig { returns(String) }
          attr_accessor :id

          # Files installed in the environment, without their contents.
          sig { returns(T::Array[OpenAI::Beta::HostedEnvironmentFile::Variants]) }
          attr_accessor :files

          # The object type. Always `agent.environment`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Plugins installed in the environment, without their archive contents.
          sig { returns(T::Array[OpenAI::Beta::HostedPlugin]) }
          attr_accessor :plugins

          # Skills installed in the environment, without their archive contents.
          sig { returns(T::Array[OpenAI::Beta::HostedSkill::Variants]) }
          attr_accessor :skills

          # The current environment connection status.
          sig { returns(OpenAI::Beta::Agents::EnvironmentInfo::Status::TaggedSymbol) }
          attr_accessor :status

          # Whether the environment is hosted by OpenAI or by the application.
          sig { returns(OpenAI::Beta::Agents::EnvironmentInfo::Type::TaggedSymbol) }
          attr_accessor :type

          # Safe metadata for a first-class execution environment.
          sig do
            params(

              id: String,

              files: T::Array[
                T.any(
                  OpenAI::Beta::HostedEnvironmentFileID::OrHash,
                  OpenAI::Beta::HostedEnvironmentFile::Inline::OrHash
                )
              ],

              plugins: T::Array[OpenAI::Beta::HostedPlugin::OrHash],

              skills: T::Array[
                T.any(OpenAI::Beta::HostedSkillReference::OrHash, OpenAI::Beta::HostedSkill::Inline::OrHash)
              ],

              status: OpenAI::Beta::Agents::EnvironmentInfo::Status::OrSymbol,

              type: OpenAI::Beta::Agents::EnvironmentInfo::Type::OrSymbol,

              object: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the environment.
            id:,

            # Files installed in the environment, without their contents.
            files:,

            # Plugins installed in the environment, without their archive contents.
            plugins:,

            # Skills installed in the environment, without their archive contents.
            skills:,

            # The current environment connection status.
            status:,

            # Whether the environment is hosted by OpenAI or by the application.
            type:,

            # The object type. Always `agent.environment`.

            object: :"agent.environment"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                files: T::Array[OpenAI::Beta::HostedEnvironmentFile::Variants],
                object: Symbol,
                plugins: T::Array[OpenAI::Beta::HostedPlugin],
                skills: T::Array[OpenAI::Beta::HostedSkill::Variants],
                status: OpenAI::Beta::Agents::EnvironmentInfo::Status::TaggedSymbol,
                type: OpenAI::Beta::Agents::EnvironmentInfo::Type::TaggedSymbol
              }
            )
          end
          def to_hash
          end

          # The current environment connection status.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Agents::EnvironmentInfo::Status) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            PENDING = T.let(:pending, OpenAI::Beta::Agents::EnvironmentInfo::Status::TaggedSymbol)
            CONNECTED = T.let(:connected, OpenAI::Beta::Agents::EnvironmentInfo::Status::TaggedSymbol)
            DISCONNECTED = T.let(:disconnected, OpenAI::Beta::Agents::EnvironmentInfo::Status::TaggedSymbol)
            EXPIRED = T.let(:expired, OpenAI::Beta::Agents::EnvironmentInfo::Status::TaggedSymbol)
            FAILED = T.let(:failed, OpenAI::Beta::Agents::EnvironmentInfo::Status::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Beta::Agents::EnvironmentInfo::Status::TaggedSymbol]) }
            def self.values
            end
          end

          # Whether the environment is hosted by OpenAI or by the application.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Agents::EnvironmentInfo::Type) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            OPENAI_HOSTED = T.let(:openai_hosted, OpenAI::Beta::Agents::EnvironmentInfo::Type::TaggedSymbol)
            SELF_HOSTED = T.let(:self_hosted, OpenAI::Beta::Agents::EnvironmentInfo::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Beta::Agents::EnvironmentInfo::Type::TaggedSymbol]) }
            def self.values
            end
          end

        end

      end

    end

  end
end
