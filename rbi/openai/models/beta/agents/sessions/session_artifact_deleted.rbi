# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        SessionArtifactDeleted = Sessions::SessionArtifactDeleted

        module Sessions

          class SessionArtifactDeleted < OpenAI::Internal::Type::BaseModel

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Sessions::SessionArtifactDeleted,
                OpenAI::Internal::AnyHash
              )
            end

            # The ID of the deleted session artifact.
            sig { returns(String) }
            attr_accessor :id

            # Whether the session artifact was deleted. Always `true`.
            sig { returns(T::Boolean) }
            attr_accessor :deleted

            # The object type. Always `agent.session.artifact.deleted`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Confirmation that an immutable session artifact was deleted.
            sig do
              params(

                id: String,

                deleted: T::Boolean,

                object: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The ID of the deleted session artifact.
              id:,

              # Whether the session artifact was deleted. Always `true`.
              deleted:,

              # The object type. Always `agent.session.artifact.deleted`.

              object: :"agent.session.artifact.deleted"
            )
            end

            sig do
              override.returns(
                {id: String, deleted: T::Boolean, object: Symbol}
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
