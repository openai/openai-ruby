# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        EnvironmentFile = Environments::EnvironmentFile

        module Environments

          class EnvironmentFile < OpenAI::Internal::Type::BaseModel

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Environments::EnvironmentFile,
                OpenAI::Internal::AnyHash
              )
            end

            # The ID of the environment containing this file.
            sig { returns(String) }
            attr_accessor :environment_id

            # The object type. Always `agent.environment.file`.
            sig { returns(Symbol) }
            attr_accessor :object

            # The absolute file path inside the environment's workspace.
            sig { returns(String) }
            attr_accessor :path

            # The file size in bytes.
            sig { returns(Integer) }
            attr_accessor :size_bytes

            # A live file in an execution environment.
            sig do
              params(

                environment_id: String,

                path: String,

                size_bytes: Integer,

                object: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The ID of the environment containing this file.
              environment_id:,

              # The absolute file path inside the environment's workspace.
              path:,

              # The file size in bytes.
              size_bytes:,

              # The object type. Always `agent.environment.file`.

              object: :"agent.environment.file"
            )
            end

            sig do
              override.returns(
                {environment_id: String, object: Symbol, path: String, size_bytes: Integer}
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
