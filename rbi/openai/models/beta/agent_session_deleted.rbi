# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionDeleted < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionDeleted,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the deleted session.
        sig { returns(String) }
        attr_accessor :id

        # Whether the session has been removed from the public API. Always `true`.
        # Physical cleanup may still be in progress.
        sig { returns(T::Boolean) }
        attr_accessor :deleted

        # The object type. Always `agent.session.deleted`.
        sig { returns(Symbol) }
        attr_accessor :object

        # A Managed Agents session removed from the public API. Physical cleanup may
        # continue asynchronously.
        sig do
          params(

            id: String,

            deleted: T::Boolean,

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the deleted session.
          id:,

          # Whether the session has been removed from the public API. Always `true`.
          # Physical cleanup may still be in progress.
          deleted:,

          # The object type. Always `agent.session.deleted`.

          object: :"agent.session.deleted"
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
