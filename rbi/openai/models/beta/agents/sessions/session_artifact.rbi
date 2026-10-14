# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        SessionArtifact = Sessions::SessionArtifact

        module Sessions

          class SessionArtifact < OpenAI::Internal::Type::BaseModel

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Sessions::SessionArtifact,
                OpenAI::Internal::AnyHash
              )
            end

            # The immutable artifact ID.
            sig { returns(String) }
            attr_accessor :id

            # The Unix timestamp, in seconds, when the artifact was published.
            sig { returns(Integer) }
            attr_accessor :created_at

            # The ID of the environment that produced the artifact.
            sig { returns(String) }
            attr_accessor :environment_id

            # The object type. Always `agent.session.artifact`.
            sig { returns(Symbol) }
            attr_accessor :object

            # The original absolute file path in the execution environment.
            sig { returns(String) }
            attr_accessor :path

            # The ID of the session that owns the artifact.
            sig { returns(String) }
            attr_accessor :session_id

            # The immutable artifact size in bytes.
            sig { returns(Integer) }
            attr_accessor :size_bytes

            # The ID of the completed turn that published the artifact.
            sig { returns(String) }
            attr_accessor :turn_id

            # An immutable file published by a completed hosted session turn.
            sig do
              params(

                id: String,

                created_at: Integer,

                environment_id: String,

                path: String,

                session_id: String,

                size_bytes: Integer,

                turn_id: String,

                object: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The immutable artifact ID.
              id:,

              # The Unix timestamp, in seconds, when the artifact was published.
              created_at:,

              # The ID of the environment that produced the artifact.
              environment_id:,

              # The original absolute file path in the execution environment.
              path:,

              # The ID of the session that owns the artifact.
              session_id:,

              # The immutable artifact size in bytes.
              size_bytes:,

              # The ID of the completed turn that published the artifact.
              turn_id:,

              # The object type. Always `agent.session.artifact`.

              object: :"agent.session.artifact"
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  created_at: Integer,
                  environment_id: String,
                  object: Symbol,
                  path: String,
                  session_id: String,
                  size_bytes: Integer,
                  turn_id: String
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
