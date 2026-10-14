# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentDeleted < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentDeleted,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the deleted agent.
        sig { returns(String) }
        attr_accessor :id

        # Whether the agent was deleted. Always `true`.
        sig { returns(T::Boolean) }
        attr_accessor :deleted

        # The object type. Always `agent.deleted`.
        sig { returns(Symbol) }
        attr_accessor :object

        # A deleted reusable agent.
        sig do
          params(

            id: String,

            deleted: T::Boolean,

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the deleted agent.
          id:,

          # Whether the agent was deleted. Always `true`.
          deleted:,

          # The object type. Always `agent.deleted`.

          object: :"agent.deleted"
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
