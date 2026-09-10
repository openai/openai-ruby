# typed: strong

module OpenAI
  module Models

    module Beta

      class Subagent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::Subagent,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the subagent.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp, in seconds, when the subagent was closed. Null while active,
        # including after resume.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :closed_at

        # Initial task content, or null when unavailable. Text may contain placeholders
        # for images or audio when only a preview is available.
        sig { returns(T.nilable(T::Array[OpenAI::Beta::AgentContent::Variants])) }
        attr_accessor :instructions

        # The runner-assigned nickname, or null when unavailable.
        sig { returns(T.nilable(String)) }
        attr_accessor :name

        # The object type. Always `agent.session.subagent`.
        sig { returns(Symbol) }
        attr_accessor :object

        # The Unix timestamp, in seconds, when the subagent was first opened. Resuming
        # does not change it.
        sig { returns(Integer) }
        attr_accessor :opened_at

        # The ID of the agent that created this subagent.
        sig { returns(String) }
        attr_accessor :parent_agent_id

        # The ID of the session that owns the subagent.
        sig { returns(String) }
        attr_accessor :session_id

        # The current status of the subagent.
        sig { returns(OpenAI::Beta::Subagent::Status::TaggedSymbol) }
        attr_accessor :status

        # A subagent created within a session.
        sig do
          params(

            id: String,

            closed_at: T.nilable(Integer),

            instructions: T.nilable(
              T::Array[T.any(OpenAI::Beta::OutputText::OrHash, OpenAI::Beta::AgentContent::EncryptedContent::OrHash)]
            ),

            name: T.nilable(String),

            opened_at: Integer,

            parent_agent_id: String,

            session_id: String,

            status: OpenAI::Beta::Subagent::Status::OrSymbol,

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the subagent.
          id:,

          # The Unix timestamp, in seconds, when the subagent was closed. Null while active,
          # including after resume.
          closed_at:,

          # Initial task content, or null when unavailable. Text may contain placeholders
          # for images or audio when only a preview is available.
          instructions:,

          # The runner-assigned nickname, or null when unavailable.
          name:,

          # The Unix timestamp, in seconds, when the subagent was first opened. Resuming
          # does not change it.
          opened_at:,

          # The ID of the agent that created this subagent.
          parent_agent_id:,

          # The ID of the session that owns the subagent.
          session_id:,

          # The current status of the subagent.
          status:,

          # The object type. Always `agent.session.subagent`.

          object: :"agent.session.subagent"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              closed_at: T.nilable(Integer),
              instructions: T.nilable(T::Array[OpenAI::Beta::AgentContent::Variants]),
              name: T.nilable(String),
              object: Symbol,
              opened_at: Integer,
              parent_agent_id: String,
              session_id: String,
              status: OpenAI::Beta::Subagent::Status::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        # The current status of the subagent.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Subagent::Status) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          # The subagent remains available, including while idle between turns.
          ACTIVE = T.let(:active, OpenAI::Beta::Subagent::Status::TaggedSymbol)

          # The subagent is closed.
          CLOSED = T.let(:closed, OpenAI::Beta::Subagent::Status::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::Subagent::Status::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
