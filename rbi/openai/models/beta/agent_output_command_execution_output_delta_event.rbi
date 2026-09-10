# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentOutputCommandExecutionOutputDeltaEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentOutputCommandExecutionOutputDeltaEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The output text that was appended.
        sig { returns(String) }
        attr_accessor :delta

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the command execution item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the item in the turn output.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The ID of the session associated with the event.
        sig { returns(String) }
        attr_accessor :session_id

        # The ID of the turn associated with the event, when applicable.
        sig { returns(T.nilable(String)) }
        attr_accessor :turn_id

        # The type of the object. Always `agent.output.command_execution_output.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when command execution produces an output delta.
        sig do
          params(

            delta: String,

            event_id: String,

            item_id: String,

            output_index: Integer,

            session_id: String,

            turn_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The output text that was appended.
          delta:,

          # The unique ID of the event.
          event_id:,

          # The ID of the command execution item.
          item_id:,

          # The index of the item in the turn output.
          output_index:,

          # The ID of the session associated with the event.
          session_id:,

          # The ID of the turn associated with the event, when applicable.
          turn_id:,

          # The type of the object. Always `agent.output.command_execution_output.delta`.

          type: :"agent.output.command_execution_output.delta"
        )
        end

        sig do
          override.returns(
            {
              delta: String,
              event_id: String,
              item_id: String,
              output_index: Integer,
              session_id: String,
              turn_id: T.nilable(String),
              type: Symbol
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
