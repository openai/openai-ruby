# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionTurnContentPartDoneEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionTurnContentPartDoneEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The index of the content part in the message.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the message item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the item in the turn output.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The completed content part.
        sig { returns(OpenAI::Beta::OutputText) }
        attr_reader :part

        sig { params(part: OpenAI::Beta::OutputText::OrHash).void }
        attr_writer :part

        # The ID of the session associated with the event.
        sig { returns(String) }
        attr_accessor :session_id

        # The ID of the turn associated with the event, when applicable.
        sig { returns(T.nilable(String)) }
        attr_accessor :turn_id

        # The type of the object. Always `agent.session.turn.content_part.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when an output content part is complete.
        sig do
          params(

            content_index: Integer,

            event_id: String,

            item_id: String,

            output_index: Integer,

            part: OpenAI::Beta::OutputText::OrHash,

            session_id: String,

            turn_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The index of the content part in the message.
          content_index:,

          # The unique ID of the event.
          event_id:,

          # The ID of the message item.
          item_id:,

          # The index of the item in the turn output.
          output_index:,

          # The completed content part.
          part:,

          # The ID of the session associated with the event.
          session_id:,

          # The ID of the turn associated with the event, when applicable.
          turn_id:,

          # The type of the object. Always `agent.session.turn.content_part.done`.

          type: :"agent.session.turn.content_part.done"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              event_id: String,
              item_id: String,
              output_index: Integer,
              part: OpenAI::Beta::OutputText,
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
