# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionTurnReasoningSummaryTextDoneEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionTurnReasoningSummaryTextDoneEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the reasoning item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the item in the turn output.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The ID of the session associated with the event.
        sig { returns(String) }
        attr_accessor :session_id

        # The index of the summary content part.
        sig { returns(Integer) }
        attr_accessor :summary_index

        # The complete reasoning summary text.
        sig { returns(String) }
        attr_accessor :text

        # The ID of the turn associated with the event, when applicable.
        sig { returns(T.nilable(String)) }
        attr_accessor :turn_id

        # The type of the object. Always `agent.session.turn.reasoning_summary_text.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a reasoning summary content part is complete.
        sig do
          params(

            event_id: String,

            item_id: String,

            output_index: Integer,

            session_id: String,

            summary_index: Integer,

            text: String,

            turn_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the event.
          event_id:,

          # The ID of the reasoning item.
          item_id:,

          # The index of the item in the turn output.
          output_index:,

          # The ID of the session associated with the event.
          session_id:,

          # The index of the summary content part.
          summary_index:,

          # The complete reasoning summary text.
          text:,

          # The ID of the turn associated with the event, when applicable.
          turn_id:,

          # The type of the object. Always `agent.session.turn.reasoning_summary_text.done`.

          type: :"agent.session.turn.reasoning_summary_text.done"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              item_id: String,
              output_index: Integer,
              session_id: String,
              summary_index: Integer,
              text: String,
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
